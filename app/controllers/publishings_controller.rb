class PublishingsController < ApplicationController

  before_action :authenticate_user

  def create
    auction = Auction.find params[:auction_id]
    if auction.reserve
      auction.save
      redirect_to auction, notice: "campaing published"
    else
      redirect_to auction, alert: "Cant' publish"
    end
  end

end
