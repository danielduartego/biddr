class BidsController < ApplicationController

  before_action :authenticate_user

  def new
    @bid = Bid.new
  end

  def create
    @auction = Auction.find params[:auction_id]
    bid_params = params.require(:bid).permit(:price)
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = @auction
    if @auction.bids.maximum(:price) < @bid.price
      @bid.save
      redirect_to @auction
    else
      redirect_to auction_path(@auction), alert: "Bid amount need to bigger than auction price"
    end
  end

end
