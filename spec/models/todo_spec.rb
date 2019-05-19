require 'rails_helper'

RSpec.describe Todo, type: :model do
  #Ensure Todo has association 1:m with item model
  it { should have_many(:items).dependent(:destroy) }
  #ensure model properties are present before saaving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
