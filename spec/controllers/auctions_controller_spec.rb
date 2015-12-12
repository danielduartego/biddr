require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:user) { FactoryGirl.create(:user)}

  # new ------------------------------------------------------------------------
  describe "#new" do
    # rspec spec/controllers/auctions_controller_spec.rb:9
    context "with user not signed in" do
      it "redirects to user sign up page" do
        get :new
        expect(response).to redirect_to(new_user_path)
      end
    end

    # rspec spec/controllers/auctions_controller_spec.rb:17
    context "with user signed in" do
      before do
        u = FactoryGirl.create(:user)
        request.session[:user_id] = u.id
        get :new
      end

      # rspec spec/controllers/auctions_controller_spec.rb:25
      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      # rspec spec/controllers/auctions_controller_spec.rb:30
      it "create a new auction object" do
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end
  end

  # create ---------------------------------------------------------------------
  # rspec spec/controllers/auctions_controller_spec.rb:39
  describe "#create" do
    # rspec spec/controllers/auctions_controller_spec.rb:41
    context "with no user signed in" do
      it "redirects to the sign up page" do
        post :create, {auction: {}}
        expect(response).to redirect_to new_user_path
      end
    end
    # rspec spec/controllers/auctions_controller_spec.rb:48
    context "With user signed in" do
      def valid_params
        FactoryGirl.attributes_for(:auction)
      end
      before do
        request.session[:user_id] = user.id
      end
      # rspec spec/controllers/auctions_controller_spec.rb:56
      context "with valid parameters" do
        it "creates a auction record in the database" do
          before_count = Auction.count
          post :create, auction: valid_params
          after_count = Auction.count
          expect(after_count - before_count).to eq(1)
        end

        it "associates the auction with the signed in user" do
          post :create, auction: valid_params
          expect(Auction.last.user).to eq(user)
        end

        it "redirects to auction show page" do
          post :create, auction: valid_params
          expect(response).to redirect_to(auction_path(Auction.last))
        end
      end

      # rspec spec/controllers/auctions_controller_spec.rb:76
      context "With invalid parameters" do
        def request_with_invalid_title
          post :create, auction: valid_params.merge({title: nil})
        end

        it "doesn't create a auction record in the database" do
          expect { request_with_invalid_title}.not_to change { Auction.count }
        end

        it "renders the new template" do
          request_with_invalid_title
          expect(response).to render_template(:new)
        end
      end
    end
  end
  # end create -----------------------------------------------------------------

end
