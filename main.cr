require "./tlb.cr"

if ARGV.size() != 2
	print "Numero errado de argumentos\n"
	print "crystal run main.cr -- lista_enderecos.txt pt.txt\n"
	exit -1
end

path_file_addresses = ARGV[0]#"lista_enderecos.txt"
path_file_pt = ARGV[1]#"pt.txt"

# Create empty TLB
tlb = Tlb.new 8

# Fill PT
tlb.fillPt(path_file_pt)

File.each_line path_file_addresses do |line|
    address = line.to_u64(16)
	#puts "#{address}"
    if tlb.translate(address) == -1
		print "Endereco fora da pt\n"
		exit -1
	end
	#tlb.printLRU()
end

print "\nMiss counter = #{tlb.missCounter}\n\n"
tlb.printTlb
print "\n"
tlb.printPt

