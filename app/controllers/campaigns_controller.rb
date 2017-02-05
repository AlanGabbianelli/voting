# CampaignsController
class CampaignsController < ApplicationController
  # GET /campaigns
  def index
    @campaigns = Campaign.all
  end

  # GET /campaigns/1
  def show
    @campaign = Campaign.find(params[:id])
  end
end
