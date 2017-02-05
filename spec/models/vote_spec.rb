require 'rails_helper'

RSpec.describe Vote, type: :model do
  describe 'relationships' do
    it { should belong_to(:choice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:time) }

    it { should_not allow_value(nil).for(:valid_vote) }
  end
end
