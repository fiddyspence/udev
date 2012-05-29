require 'facter/util/ip'

interfaces = Facter::Util::IP.get_interfaces.collect { |iface| Facter::Util::IP.alphafy(iface) }
routingtable = %x{/bin/netstat -rn}.split(/\r|\n/)

interfaces.select{ |i| i =~ /eth/ }.each do |interface|
  routingtable.each do |line|
    if line =~ /^0\.0\.0\.0.*#{interface}$/
      Facter.add("gateway_#{interface}") do
        setcode do
          line.split[1].chomp
        end
      end
    end
  end
end


