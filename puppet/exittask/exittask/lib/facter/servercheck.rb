Facter.add(:servercheck) do
  setcode do
	name = Facter.value(:hostname)
	name == 'puppet'
  end
end

