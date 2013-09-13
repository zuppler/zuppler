require 'spec_helper'

describe Zuppler::Restaurant do
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:remote_id) }
  it { should validate_presence_of(:logo) }
  it { should validate_presence_of(:location) }
  it { should validate_presence_of(:owner) }

  it 'should validate owner' do
    subject.name, subject.remote_id, subject.logo, subject.location = 'n',2,'http://example.com','Main'
    subject.owner = {:name => 'name'}
    subject.should_not be_valid
    subject.errors[:owner].should eql(["email is required", "phone is required"])
  end
end
