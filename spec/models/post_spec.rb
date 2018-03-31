require 'rails_helper'

RSpec.describe Post do
  it { should belong_to(:location) }
  it { should belong_to(:user) }
end
