require 'rails_helper'

RSpec.describe Item, type: :model do
  #Ensure item has a relashionship of m:1 with todo model
  it { should belong_to(:todo) }
  #Ensure  presence of properties
  it { should validate_presence_of(:name) }
end
