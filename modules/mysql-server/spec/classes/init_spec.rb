require 'spec_helper'
describe 'server' do

  context 'with defaults for all parameters' do
    it { should contain_class('server') }
  end
end
