class Post < ApplicationRecord
  has_many_attached :images
  validates :title, presence: true
  validates :body, presence: true
  validate :image_type

  def thumbnail input
    return self.images[input].variant(resize: '300x300').processed
  end

  private
  def image_type
    if images.attached? == false
      errors.add(:images, "are missing")
    end
  end
end
