require 'spec_helper'

describe Zuppler::Restaurant, type: :model do
  it { should validate_presence_of(:name) }
end
