# PartialLine PORO
class PartialLine
  attr_reader :needed_part

  def initialize(needed_part)
    @needed_part = needed_part
  end

  def campaign_name
    needed_part[2][9..-1]
  end

  def choice_name
    needed_part[4][7..-1]
  end

  def vote_time
    Time.at(needed_part[1].to_i)
  end

  def vote_validity
    needed_part[3][9..-1]
  end

  def valid_vote?
    vote_validity == 'during' ? true : false
  end

  def well_formed?
    description == 'VOTE' &&
      campaign_identifier == 'Campaign:' &&
      validity_identifier == 'Validity:' &&
      choice_identifier == 'Choice:' &&
      choice_name.present?
  end

  def create_models!
    campaign = Campaign.find_or_create_by!(name: campaign_name)
    choice = campaign.choices.find_or_create_by!(name: choice_name)
    choice.votes.create! time: vote_time, validity: vote_validity, valid_vote: valid_vote?
  end

  private

  def description
    needed_part[0]
  end

  def campaign_identifier
    needed_part[2][0..8]
  end

  def choice_identifier
    needed_part[4][0..6]
  end

  def validity_identifier
    needed_part[3][0..8]
  end
end
