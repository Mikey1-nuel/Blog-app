class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :email, uniqueness: true

  after_initialize :set_defaults

  def set_defaults
    self.posts_counter ||= 0
  end

  def return_three_most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def self.public_count
    count
  end
end
