require 'rails_helper'

RSpec.describe Student, type: :model do

  # Association tests
  describe 'associations' do
    it { should have_many(:homeworks) }
  end
  
  # You can add validation tests if you had validations in your model.
  # For now, we're only testing associations.
  
end
