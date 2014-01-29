require 'spec_helper'

describe Zuppler::Restaurant do
  
  it { should validate_presence_of(:name) }

end
