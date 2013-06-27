
execute "apt-get update" do
  action :nothing
end

execute "add postgres apt key" do
  command "wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -"
  action :nothing
end

cookbook_file "/etc/apt/sources.list.d/postgres.list" do
  source 'postgres.list'
  owner "root"
  mode "0644"
  notifies :run, resources(:execute => "add postgres apt key"), :immediately
  notifies :run, resources(:execute => "apt-get update"), :immediately
end
