execute 'apt-get update'

package ['unzip']

git '/var/lib/jenkins/tfenv' do
  repository 'https://github.com/kamatama41/tfenv.git'
  revision 'master'
  action :sync
  user 'jenkins'
  group 'jenkins'
end

file '/var/lib/jenkins/.profile' do
  content 'if [ -f /var/lib/jenkins/tfenv/bin/tfenv ]; then
  PATH=/var/lib/jenkins/tfenv/bin:$PATH
fi
'
  mode '0644'
  owner 'jenkins'
  group 'jenkins'
end

execute 'tfenv install 0.6.16' do
  environment 'PATH' => "/var/lib/jenkins/tfenv/bin:#{ENV['PATH']}"
  user 'jenkins'
  group 'jenkins'
end

execute 'tfenv install 0.7.2' do
  environment 'PATH' => "/var/lib/jenkins/tfenv/bin:#{ENV['PATH']}"
  user 'jenkins'
  group 'jenkins'
end

execute 'tfenv install latest' do
  environment 'PATH' => "/var/lib/jenkins/tfenv/bin:#{ENV['PATH']}"
  user 'jenkins'
  group 'jenkins'
end
