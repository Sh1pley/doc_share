class MarkdownDocument < Document
  validate :markdown_file_type

  def render_html
    return "" unless file&.download
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true)
    markdown.render(file.download)
  end

  private

  def markdown_file_type
    errors.add(:file, "must be a Markdown file.") unless file.content_type == "text/markdown"
  end
end
