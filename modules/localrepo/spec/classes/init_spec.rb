require 'spec_helper'
describe 'offline' do

  context 'with defaults for all parameters' do
    it { should contain_class('offline') }
  end
end
