module HasSlug
  extend ActiveSupport::Concern

  included do
    after_initialize {|r| r.slug = r.class.generate_slug if r.slug.blank? }
  end

  class_methods do
    def generate_slug
      SecureRandom.base58(8).downcase
    end
  end
end
