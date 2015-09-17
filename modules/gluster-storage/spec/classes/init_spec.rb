require 'spec_helper'
describe 'storage' do

  context 'with defaults for all parameters' do
    it { should contain_class('storage') }
  end
end
