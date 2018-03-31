require 'rails_helper'

RSpec.describe Location do
  it { should have_many(:posts) }
  it { should have_many(:users).through(:posts) }
end
