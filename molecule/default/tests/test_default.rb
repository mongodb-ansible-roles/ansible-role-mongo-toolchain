# frozen_string_literal: true

describe file('/opt/mongodbtoolchain') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/opt/mongodbtoolchain/v3') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/opt/mongodbtoolchain/v3/bin') do
  its('type') { should eq :directory }
  it { should be_directory }
end

describe file('/opt/mongodbtoolchain/v3/bin/gcc') do
  it { should exist }
end

# rubocop:disable LineLength

describe command('/opt/mongodbtoolchain/v3/bin/gcc --version') do
  its('stderr') { should eq "gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516\nCopyright (C) 2016 Free Software Foundation, Inc.\nThis is free software; see the source for copying conditions.  There is NO\nwarranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.\n\n" }
  its('exit_status') { should eq 0 }
end

# rubocop:enable LineLength
