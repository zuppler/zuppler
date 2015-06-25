require 'spec_helper'

describe Zuppler::Item do
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }

  it 'saves' do
    subject.name, subject.price = 'pizza', 9.99
    expect(subject).to receive(:items_url).and_return('http://example.com')
    expect(subject).to receive(:execute_post).with('http://example.com', item: { 'name' => 'pizza', 'price' => 9.99 })
    expect(subject).to receive(:v3_success?).twice.and_return(false)
    expect(subject.save).to eql(false)
  end
end
