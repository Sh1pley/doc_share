class Document < ApplicationRecord
  belongs_to :teacher
  has_one_attached :file

  validates :title, presence: true
  validates :file, presence: true
  validate :validate_file_type

  def validate_file_type
    if file.attached? && !file.content_type.in?(%w[text/markdown])
      errors.add(:file, "must be a markdown file.")
    end
  end

  def render_html
    raise NotImplementedError, "Document subclass must implement a render_html method!"
  end
end
