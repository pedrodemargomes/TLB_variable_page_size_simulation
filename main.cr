require "./tlb.cr"
path_file_addresses = "lista_enderecos.txt"
path_file_pt = "pt.txt"

# Create empty TLB
tlb = Tlb.new 8

# Fill PT
tlb.fillPt(path_file_pt)

File.each_line path_file_addresses do |line|
    address = line.to_u64(16)
    puts "#{address}"
    tlb.translate(address)
    tlb.printLRU()
end

print "\nMiss counter = #{tlb.missCounter}\n\n"
tlb.printTlb
print "\n"
tlb.printPt
