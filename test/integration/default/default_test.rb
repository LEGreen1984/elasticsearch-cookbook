# # encoding: utf-8

# Inspec test for recipe elasticsearch::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package("default-jre") do
  it { should be_installed }
end

describe package("apt-transport-https") do
  it { should be_installed }
end

describe package("elasticsearch") do
  it { should be_installed }
  its('version') { should match /5.6.15/ }
end

describe service("elasticsearch") do
  it { should be_running}
end

describe file('/etc/elasticsearch/elasticsearch.yml') do
  it { should be_symlink }
end
