require 'rails_helper'

RSpec.describe Teacher, type: :model do

  # Association tests
  describe 'associations' do
    it { should have_many(:homeworks) }
  end
  
  # Just like with the Student model, if you have more logic, methods, validations, scopes, etc., 
  # in your Teacher model, you would need to add appropriate tests for those.

end
