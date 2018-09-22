class Post < ApplicationRecord
  has_many :images
  validates :title, presence: true
  validates :body, presence: true
  validate :image_type

  def thumbnail input
    return self.images[input].image.variant(resize: '300x300').processed
  end

  private
  def image_type
    if images.present? == false
      errors.add(:images, "are missing")
    end
    images.each do |image|
      if !image.image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:images, 'needs to be a JPEG or PNG')
      end
    end
  end
end
