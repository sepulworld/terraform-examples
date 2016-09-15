# Download and install Packer 0.10.1
remote_file '/tmp/packer_0.10.1_linux_amd64.zip' do
  source 'https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip'
  owner 'root'
  group 'root'
  mode '0655'
  action :create
end

execute 'unzip_packerio' do
  command 'unzip /tmp/packer_0.10.1_linux_amd64.zip -d /usr/local/bin'
  creates '/usr/local/bin/packer'
  action :run
end
