require 'rails_helper'

RSpec.describe User do
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  it { should have_many(:locations).through(:posts) }
end
