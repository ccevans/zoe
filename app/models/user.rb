class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:stripe_connect]

  validates_uniqueness_of :username
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }
  validates :email, presence: true
  validates_length_of :username, :minimum => 2, :maximum => 15

  ROLES = %w[registered contributor admin seller moderator editor banned]

  def role?(base_role)
        role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  has_many :posts, dependent: :destroy
  has_many :brands, dependent: :destroy
  has_many :exhibitions, dependent: :destroy

    # Favorite recipes of user
  has_many :favorite_posts # just the 'relationships'
  has_many :favorites, through: :favorite_posts, source: :post

    # Like recipes of user
  has_many :like_posts # just the 'relationships'
  has_many :likes, through: :like_posts, source: :post

  has_many :credits
  has_many :charges
  has_many :addresses

  has_many :sales, class_name: "Order", foreign_key: "seller_id"
  has_many :purchases, class_name: "Order", foreign_key: "buyer_id"

  def subscribed?
    stripe_subscription_id?
  end
end