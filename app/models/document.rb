class Document < ApplicationRecord
  VALID_FILE_TYPES = %w[text/markdown]
  belongs_to :teacher
  has_one_attached :file

  validates :title, presence: true
  validates :file, presence: true
  validate :validate_file_type

  before_create :generate_slug

  def self.build_from_params(params = {})
    model = Document.new(params)
    if model.valid?
      file = model.file
      subclass = subclass_for_file_type(file.content_type)
      subclass.new(params)
    else
      raise ArgumentError, model.errors.full_messages
    end
  end

  def shareable_url
    "/share/#{slug}"
  end

  def render_html
    raise NotImplementedError, "Document subclass must implement a render_html method!"
  end

  private

    def generate_slug
      self.slug = SlugGenerator.generate(title.to_s, Document)
    end

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
