class Auction < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}

  belongs_to :user

  has_many :bids, dependent: :destroy
  has_many :biddings_users, through: :bids, source: :user

  include AASM


  aasm whiny_transitions: false do
    state :published, initial: true
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met


    event :reserve do
      transitions from: :published, to: :reserve_met
    end

    event :win do
      transitions from: :reserve_met, to: :won
    end

    event :close do
      transitions from: [:published, :reserve_not_met], to: :canceled
    end

  end

end
