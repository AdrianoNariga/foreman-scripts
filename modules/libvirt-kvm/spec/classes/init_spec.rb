require 'spec_helper'
describe 'kvm' do

  context 'with defaults for all parameters' do
    it { should contain_class('kvm') }
  end
end
