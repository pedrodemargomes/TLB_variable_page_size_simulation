
struct TlbEntry
	property tagMask, tag_offset, ppn

	def initialize(@tagMask : UInt32, @tag_offset : UInt32, @ppn : UInt32)
	
	end

end

class Tlb
	getter length : UInt32

	def initialize(@length : UInt32)
		@tlb = [] of TlbEntry
		@pt = [] of TlbEntry
	end

	def insertTlb(newEntryTlb : TlbEntry)
		rand =  Random.new.rand(@length)
		@tlb[rand] = newEntryTlb
	end

	def translate(virtualAddress : UInt32)
		# Search address in TLB
		@tlb.each do |entry|
			if (entry.tagMask & entry.tag_offset) == (entry.tagMask & virtualAddress) # HIT
				return (~entry.tagMask & entry.tag_offset) + entry.ppn
			end
		end
		# If address is not in TBL, search in PT
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
			@pt << {line0, line1, line2}
		end
	end

end


