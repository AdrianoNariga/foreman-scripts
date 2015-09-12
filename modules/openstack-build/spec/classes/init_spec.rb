require 'spec_helper'
describe 'build' do

  context 'with defaults for all parameters' do
    it { should contain_class('build') }
  end
end
