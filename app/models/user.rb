class User < ActiveRecord::Base

  has_secure_password
  validates :email, presence: true, uniqueness: true

  has_many :auctions, dependent: :destroy

  has_many :bids, dependent: :destroy
  has_many :bidded_auctions, through: :bids, source: :auction

  def full_name
    "#{first_name} #{last_name}".strip
  end

end
