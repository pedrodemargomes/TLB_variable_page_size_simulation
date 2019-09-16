require "./tlb.cr"

if ARGV.size() != 3
	print "Numero errado de argumentos\n"
	print "crystal run main.cr -- lista_enderecos.txt pt.txt tamanho_da_TLB\n"
	exit -1
end

path_file_addresses = ARGV[0]#"lista_enderecos.txt"
path_file_pt = ARGV[1]#"pt.txt"

# Create empty TLB
tlb = Tlb.new ARGV[2].to_u64

# Fill PT
tlb.fillPt(path_file_pt)

#print "\nMiss counter = #{tlb.missCounter}\n\n"
#tlb.printTlb
#print "\n"
#tlb.printPt
#tlb.printLRU()

File.each_line path_file_addresses do |line|
	address = line.to_u64(16)
	#puts "#{line}"
    if tlb.translate(address) == -1
		print "Endereco fora da pt\n"
		exit -1
	end

	#gets
	#print "\nMiss counter = #{tlb.missCounter}\n\n"
	#tlb.printTlb
	#print "\n"
	#tlb.printPt
	#tlb.printLRU()
end

print "\nMiss counter = #{tlb.missCounter}\n\n"
tlb.printTlb
print "\n"
tlb.printPt

