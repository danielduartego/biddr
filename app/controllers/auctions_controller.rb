class AuctionsController < ApplicationController

  before_action :authenticate_user, except: [:index, :show]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit([:title, :price, :details, :end_date])
    @auction = Auction.new auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, notice: "Auction create successefuly!"
    else
      render :new, alert: "Error"
    end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new
    @current_price = @auction.bids.maximum(:price)
  end


end
