require 'spec_helper'
describe 'nag' do

  context 'with defaults for all parameters' do
    it { should contain_class('nag') }
  end
end
