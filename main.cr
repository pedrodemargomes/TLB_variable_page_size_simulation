require "./tlb.cr"
path_file = "lista_enderecos.txt"

# Create empty TLB
tlb = Tlb.new 8

# Fill PT


File.each_line path_file do |line|
    address = line.to_u32
    puts "#{address}"
    tlb.translate(address)
end
