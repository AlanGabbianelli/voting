require 'rails_helper'

RSpec.describe Choice, type: :model do
  describe 'relationships' do
    it { should belong_to(:campaign) }

    it { should have_many(:votes) }
  end

  describe 'validations' do
    # This 'subject' is needed by the test for the scoped uniqueness validation.
    subject { Choice.new(name: :name, campaign: Campaign.create!(name: :name)) }

    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name).scoped_to(:campaign_id).case_insensitive }
  end
end
