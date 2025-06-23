# frozen_string_literal: true

class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }

  MAXIMUM_IMAGE_SIZE = 5

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: 'must be a valid image format' },
                    size: { less_than: Micropost::MAXIMUM_IMAGE_SIZE.megabytes,
                            message: "should be less than #{MAXIMUM_IMAGE_SIZE}MB" }

  def display_image
    image.variant(resize_to_limit: [500, 500]).processed
  end
end
