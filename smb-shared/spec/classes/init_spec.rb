require 'spec_helper'
describe 'shared' do

  context 'with defaults for all parameters' do
    it { should contain_class('shared') }
  end
end
