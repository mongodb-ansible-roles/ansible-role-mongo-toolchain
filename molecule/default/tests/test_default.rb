# frozen_string_literal: true

# rubocop:disable LineLength

describe file('/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin/python3.7') do
  it { should exist }
end

describe file('/opt/mongodbtoolchain/v3/bin') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/opt/mongodbtoolchain/v3/bin/python3.7') do
  it { should exist }
end

describe command('/opt/mongodbtoolchain/revisions/test_mongodbtoolchain/v3/bin/python3.7 --version') do
  its('stdout') { should eq "Python 3.7.0\n" }
  its('exit_status') { should eq 0 }
end

describe command('/opt/mongodbtoolchain/v3/bin/python3.7 --version') do
  its('stdout') { should eq "Python 3.7.0\n" }
  its('exit_status') { should eq 0 }
end

# rubocop:enable LineLength
