require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'relationships' do
    it { should have_many(:choices) }

    it { should have_many(:votes).through(:choices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
