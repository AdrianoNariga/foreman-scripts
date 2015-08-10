require 'spec_helper'
describe 'dlna' do

  context 'with defaults for all parameters' do
    it { should contain_class('dlna') }
  end
end
