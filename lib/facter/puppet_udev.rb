Facter.add("puppet_udev") do
  if File.exists?('/etc/puppet_udev')
    setcode do
     Facter::Util::Resolution.exec("cat /etc/puppet_udev")
    end
  end
end
