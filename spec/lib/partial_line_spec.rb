require 'rails_helper'
require 'partial_line'

RSpec.describe PartialLine do
  let(:needed_part_1) { ['VOTE', '1168041980', 'Campaign:ssss_uk_01B', 'Validity:during', 'Choice:Tupele'] }
  subject(:partial_line) { described_class.new(needed_part_1) }

  let(:needed_part_2) { ['VOTE', '1168041980', 'Campaign:ssss_uk_01B', 'Validity:pre', 'Choice:Tupele'] }
  let(:partial_line_with_pre) { described_class.new(needed_part_2) }

  describe '#campaign_name' do
    it { expect(partial_line.campaign_name).to eq('ssss_uk_01B') }
  end

  describe '#choice_name' do
    it { expect(partial_line.choice_name).to eq('Tupele') }
  end

  describe '#vote_time' do
    it { expect(partial_line.vote_time).to eq(Time.at(1_168_041_980)) }
  end

  describe '#vote_validity' do
    it { expect(partial_line.vote_validity).to eq('during') }
  end

  describe '#valid_vote?' do
    context 'vote_validity is "during"' do
      it 'returns true' do
        expect(partial_line.valid_vote?).to eq(true)
      end
    end

    context 'vote_validity is not "during"' do
      it 'returns false' do
        expect(partial_line_with_pre.valid_vote?).to eq(false)
      end
    end
  end

  describe '#well_formed?' do
    context 'all identifiers are correct' do
      it 'returns true' do
        expect(partial_line.well_formed?).to eq(true)
      end
    end

    context 'the first field identifier is not "VOTE"' do
      it 'returns false' do
        ary = ['OTE', '1168041980', 'Campaign:ssss_uk_01B', 'Validity:during', 'Choice:Tupele']
        expect(described_class.new(ary).well_formed?).to eq(false)
      end
    end

    context 'the "Campaign:" identifier is not correct' do
      it 'returns false' do
        ary = ['VOTE', '1168041980', 'ampaign:ssss_uk_01B', 'Validity:during', 'Choice:Tupele']
        expect(described_class.new(ary).well_formed?).to eq(false)
      end
    end

    context 'the "Validity:" identifier is not correct' do
      it 'returns false' do
        ary = ['VOTE', '1168041980', 'Campaign:ssss_uk_01B', 'alidity:during', 'Choice:Tupele']
        expect(described_class.new(ary).well_formed?).to eq(false)
      end
    end

    context 'the "Choice:" identifier is not correct' do
      it 'returns false' do
        ary = ['VOTE', '1168041980', 'Campaign:ssss_uk_01B', 'Validity:during', 'hoice:Tupele']
        expect(described_class.new(ary).well_formed?).to eq(false)
      end
    end

    context 'the #choice_name identifier is empty' do
      it 'returns false' do
        ary = ['VOTE', '1168041980', 'Campaign:ssss_uk_01B', 'Validity:during', 'Choice:']
        expect(described_class.new(ary).well_formed?).to eq(false)
      end
    end
  end

  describe '#create_models!' do
    context 'the Campaign is not present' do
      it 'creates a new Campaign with right name' do
        expect { partial_line.create_models! }.to change(Campaign, :count)
        expect(Campaign.last.name).to eq(partial_line.campaign_name)
      end
    end

    context 'Campaign with same name is already present' do
      it 'does not create a new Campaign' do
        partial_line.create_models!
        expect { partial_line.create_models! }.to_not change(Campaign, :count)
        expect(Campaign.last.name).to eq(partial_line.campaign_name)
      end
    end

    context 'the Choice is not present' do
      it 'creates a new Choice with right name' do
        expect { partial_line.create_models! }.to change(Choice, :count)
        expect(Choice.last.name).to eq(partial_line.choice_name)
      end
    end

    context 'Choice with same name is already present' do
      it 'does not create a new Choice' do
        partial_line.create_models!
        expect { partial_line.create_models! }.to_not change(Choice, :count)
        expect(Choice.last.name).to eq(partial_line.choice_name)
      end
    end

    context 'the Vote is not present' do
      it 'creates a new Vote with right attributes' do
        expect { partial_line.create_models! }.to change(Vote, :count)
        expect(Vote.last.time).to eq(partial_line.vote_time)
        expect(Vote.last.validity).to eq(partial_line.vote_validity)
        expect(Vote.last.valid_vote).to eq(partial_line.valid_vote?)
      end
    end

    context 'Vote with same attributes is already present' do
      it 'creates a new Vote with right attributes' do
        partial_line.create_models!
        expect { partial_line.create_models! }.to change(Vote, :count)
        expect(Vote.last.time).to eq(partial_line.vote_time)
        expect(Vote.last.validity).to eq(partial_line.vote_validity)
        expect(Vote.last.valid_vote).to eq(partial_line.valid_vote?)
      end
    end
  end
end
