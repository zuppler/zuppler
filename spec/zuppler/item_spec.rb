require "spec_helper"

describe Zuppler::Item do
  
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

  it 'saves' do
    subject.name, subject.price = 'pizza', 9.99
    subject.should_receive(:items_url).and_return("http://example.com")
    subject.should_receive(:execute_create).with("http://example.com", :body=>{:item=>{"name"=>'pizza',"price"=>9.99}})
    subject.should_receive(:success?).and_return(false)
    subject.save.should eql(subject)
  end
  
end
