class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter
  after_destroy :reduce_comment_counter

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def reduce_comment_counter
    post.decrement!(:comments_counter)
  end
end
