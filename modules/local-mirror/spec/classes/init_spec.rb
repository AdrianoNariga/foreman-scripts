require 'spec_helper'
describe 'mirror' do

  context 'with defaults for all parameters' do
    it { should contain_class('mirror') }
  end
end
