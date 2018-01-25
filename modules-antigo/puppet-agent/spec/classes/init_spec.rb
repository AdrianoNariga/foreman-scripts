require 'spec_helper'
describe 'agent' do

  context 'with defaults for all parameters' do
    it { should contain_class('agent') }
  end
end
