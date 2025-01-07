class Document < ApplicationRecord
  VALID_FILE_TYPES = %w[text/markdown]
  belongs_to :teacher
  has_one_attached :file

  validates :title, presence: true
  validates :file, presence: true
  validate :validate_file_type

  def self.build_from_params(params = {})
    subclass = subclass_for_file_type(params[:file].content_type)
    subclass.new(params)
  end

  def render_html
    raise NotImplementedError, "Document subclass must implement a render_html method!"
  end

  private

  def self.subclass_for_file_type(file_type)
    case file_type
    when "text/markdown"
      MarkdownDocument
    else
      Document
    end
  end

  def validate_file_type
    if file.attached? && !file.content_type.in?(VALID_FILE_TYPES)
      errors.add(:file, "must be a valid file type. Valid types: #{VALID_FILE_TYPES.join(", ")}")
    end
  end
end
