require 'spec_helper'
describe 'confs' do

  context 'with defaults for all parameters' do
    it { should contain_class('confs') }
  end
end
