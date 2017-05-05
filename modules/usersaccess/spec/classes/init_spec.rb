require 'spec_helper'
describe 'access' do

  context 'with defaults for all parameters' do
    it { should contain_class('access') }
  end
end
