require 'spec_helper'
describe 'online' do

  context 'with defaults for all parameters' do
    it { should contain_class('online') }
  end
end
