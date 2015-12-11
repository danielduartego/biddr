class BidsController < ApplicationController

  def new
    @bid = Bid.new
  end

  def create
    bid_params = params.require(:bid).permit(:price)
    @auction = Auction.find params[:auction_id]
    @bid = current_user.bids.new(bid_params)
    @bid.auction = @auction
    if @bid.save
      redirect_to @auction
    else
      render "/auctions/show"
    end

  end
end
