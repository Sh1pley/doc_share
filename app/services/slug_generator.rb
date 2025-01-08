class SlugGenerator
  def self.generate(base, model)
    slug = base.parameterize

    while model.exists?(slug: slug)
      slug = "#{slug}-#{SecureRandom.hex(4)}"
    end

    slug
  end
end
