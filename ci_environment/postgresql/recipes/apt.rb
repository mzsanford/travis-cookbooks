
execute "apt-get update" do
  action :nothing
end

remote_file "/tmp/postgres-apt-key.asc" do
  source "https://www.postgresql.org/media/keys/ACCC4CF8.asc"
end

execute "add postgres apt key" do
  command "sudo apt-key add /tmp/postgres-apt-key.asc"
  action :nothing
end

cookbook_file "/etc/apt/sources.list.d/postgres.list" do
  source 'postgres.list'
  owner "root"
  mode "0644"
  notifies :run, resources(:execute => "add postgres apt key"), :immediately
  notifies :run, resources(:execute => "apt-get update"), :immediately
end
