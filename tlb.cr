class TlbEntry
	property tagMask, tag_offset, ppn, valid, ptIndex, countAccess

	def initialize(@tagMask : UInt64, @tag_offset : UInt64, @ppn : UInt64, @valid : Bool, @ptIndex : UInt64, @countAccess : UInt64)
		
	end

end

class Tlb
	getter length, missCounter : UInt64

	def initialize(@length : UInt64)
		@tlb = [] of TlbEntry
		@length.times.each{|i| @tlb << TlbEntry.new(0,0,0, false,i,0) }
		@pt = [] of TlbEntry
		@missCounter = 0
		@lru = [] of UInt64
		@length.times.each{|i| @lru << i }
	end

	def insertTlbRand(newEntryTlb : TlbEntry)
		rand =  Random.new.rand(@length)
		@tlb[rand] = newEntryTlb
	end

	def insertTlbLRU(newEntryTlb : TlbEntry, ptIndex : UInt64)
		indexInTlb = @tlb.index{|x| x.ptIndex == @lru.first }
		#print indexInTlb
		@tlb.delete_at(indexInTlb.as(Int32))
		@tlb.push(newEntryTlb)
		@lru.delete_at(0)
		@lru.push(newEntryTlb.ptIndex)
	end

	def updateLRU(ptIndex)
		# procura na lru o elemento com valor ptIndex e sobe ele
		@lru.delete(ptIndex)
		@lru.push(ptIndex)
	end

	def translate(virtualAddress : UInt64)
		# Search address in TLB
		@tlb.each do |entry|
			if (entry.valid) && ((entry.tagMask & entry.tag_offset) == (entry.tagMask & virtualAddress) ) # HIT
				# ++++++ Using LRU ++++++
				updateLRU(entry.ptIndex)
				# +++++++++++++++++++++++

				# Increment count of accesses in pt entry
				@pt[entry.ptIndex].countAccess += 1

				return (~entry.tagMask & entry.tag_offset) + entry.ppn
			end
		end
		# If address is not in TLB, search in PT
		@missCounter += 1
		@pt.each do |entry|
			if (entry.tagMask & entry.tag_offset) == (entry.tagMask & virtualAddress) # HIT
				# Increment count of accesses in pt entry
				@pt[entry.ptIndex].countAccess += 1
				
				insertTlbLRU(entry, entry.ptIndex) # Insert address in TLB using LRU
				# insertTlbRand(entry) # Insert address in TLB random
				
				return (~entry.tagMask & entry.tag_offset) + entry.ppn
			end
		end
		return -1;
	end

	def fillPt(path_file_pt)
		count = uninitialized UInt64
		count = 0
		File.each_line path_file_pt do |line|
			aux = line.split
			@pt << TlbEntry.new(aux[1].to_u64(16), aux[0].to_u64(16), aux[2].to_u64(16), true, count, 0)
			count += 1
		end
	end

	def printTlb()
		@tlb.each_with_index do |entry, index|
			print "[#{index}]: tagMask: #{entry.tagMask.to_s(16)} , tag_offset: #{entry.tag_offset.to_s(16)} , ppn: #{entry.ppn} , valid: #{entry.valid} , ptIndex: #{entry.ptIndex} , countAccess: #{entry.countAccess}\n"
		end
	end

	def printPt()
		@pt.each_with_index do |entry, index|
			print "[#{index}]: tagMask: #{entry.tagMask.to_s(16)} , tag_offset: #{entry.tag_offset.to_s(16)} , ppn: #{entry.ppn} , valid: #{entry.valid} , ptIndex: #{entry.ptIndex} , countAccess: #{entry.countAccess}\n"
		end
	end

	def printLRU()
		@lru.each_with_index do |entry, index|
			print  "#{index}: #{entry}\n"
		end
	end

end


