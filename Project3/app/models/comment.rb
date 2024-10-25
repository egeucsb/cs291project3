class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
  validate :content_cannot_include_prohibited_words

  private

  def content_cannot_include_prohibited_words
    prohibited_words = ["Trump", "Harris"]
    if content.present? && prohibited_words.any? { |word| content.downcase.include?(word.downcase) }
      errors.add(:content, "contains prohibited words.")
    end
  end
end
