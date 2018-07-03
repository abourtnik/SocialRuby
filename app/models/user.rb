class User < ApplicationRecord

  has_many :posts
  has_many :likes

  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followings, through: :following_relationships, source: :following


  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, presence: true, uniqueness: {case_sensitive: false} , format: {with: /\A[a-zA-Z0-9 _\.]*\z/}

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  def self.find_first_by_auth_conditions (warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value" , value: login.downcase).first
    else
      where(conditions.to_hash).first
    end
  end

end