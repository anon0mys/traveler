require 'rails_helper'

RSpec.describe Post do
  it { should belong_to(:location) }
  it { should belong_to(:user) }
  it { should accept_nested_attributes_for(:location) }
end
