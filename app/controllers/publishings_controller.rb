class PublishingsController < ApplicationController

  before_action :authenticate_user

  def create
    auction = Auction.find params[:auction_id]
    if auction.reserve
      auction.save
      redirect_to auction, notice: "Auction Reserved"
    else
      redirect_to auction, alert: "Cant' reserve"
    end
  end

end
