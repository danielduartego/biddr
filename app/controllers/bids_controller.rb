class BidsController < ApplicationController

  before_action :authenticate_user

  def new
    @bid = Bid.new
  end

  def create
    @auction = Auction.find params[:auction_id]
    @current_price = @auction.bids.maximum(:price)
    bid_params = params.require(:bid).permit(:price)
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = @auction
    if current_user != @auction.user
      if (@auction.bids.first == nil) || (@auction.bids.maximum(:price) < @bid.price)
        @bid.save
        redirect_to @auction, notice: "Saved"
      else
        redirect_to auction_path(@auction), alert: "Bid amount need to bigger!"
      end
    else
      redirect_to auction_path(@auction), alert: "You cant Bid you on Auction!"
    end
  end

end
