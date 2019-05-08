
struct TlbEntry
	property tagMask, tag_offset, ppn, valid

	def initialize(@tagMask : UInt64, @tag_offset : UInt64, @ppn : UInt64, @valid : Bool)

	end

end

class Tlb
	getter length, missCounter : UInt64

	def initialize(@length : UInt64)
		@tlb = [] of TlbEntry
		@length.times.each{|i| @tlb << TlbEntry.new(0,0,0, false) }
		@pt = [] of TlbEntry
		@missCounter = 0
	end

	def insertTlb(newEntryTlb : TlbEntry)
		rand =  Random.new.rand(@length)
		@tlb[rand] = newEntryTlb
	end

	def translate(virtualAddress : UInt64)
		# Search address in TLB
		@tlb.each do |entry|
			if (entry.valid) && ((entry.tagMask & entry.tag_offset) == (entry.tagMask & virtualAddress) ) # HIT
				return (~entry.tagMask & entry.tag_offset) + entry.ppn
			end
		end
		# If address is not in TLB, search in PT
		@missCounter += 1
		@pt.each do |entry|
			if (entry.tagMask & entry.tag_offset) == (entry.tagMask & virtualAddress) # HIT
				insertTlb(entry) # Insert address in TLB
				return (~entry.tagMask & entry.tag_offset) + entry.ppn
			end
		end
		return -1;
	end

	def fillPt(path_file_pt)
		File.each_line path_file_pt do |line|
			aux = line.split
			@pt << TlbEntry.new(aux[1].to_u64(16), aux[0].to_u64(16), aux[2].to_u64(16), true)
		end
	end

	def printTlb()
		print  "#{@tlb}\n\n"
	end

end


