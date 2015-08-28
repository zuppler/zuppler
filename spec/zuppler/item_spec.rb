require 'spec_helper'

describe Zuppler::Item do
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
end
