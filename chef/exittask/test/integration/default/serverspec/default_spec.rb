require 'serverspec'
set :backend, :exec

describe "packages are installed" do
	it "all packages are installed" do
		expect(package('java-1.7.0-openjdk-devel')).to be_installed
		expect(package('tomcat')).to be_installed
		expect(package('nginx')).to be_installed
		expect(package('git')).to be_installed
		expect(package('jenkins')).to be_installed
	end
end

describe "services are running" do
	it "services are running" do
		expect(service("nginx")).to be_running
		expect(service("jenkins")).to be_running
		expect(service("tomcat")).to be_running
	end
end



describe "ports are listened" do
	it "ports are listened" do
		expect(port(8080)).to be_listening
		expect(port(9090)).to be_listening
		expect(port(10100)).to be_listening
		expect(port(22)).to be_listening
	end
end


require 'net/http'
describe 'Build art check' do
  it 'Webapp response is 200' do
     url = URI("http://localhost:8080/mntlab")
     status_response = Net::HTTP.get_response(url)
     expect status_response.kind_of? Net::HTTPSuccess
  end
end

