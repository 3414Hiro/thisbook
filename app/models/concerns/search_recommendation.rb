module SearchBook
  extend ActiveSupport::Concern
  included do
    
    def self.generate_keyword(keyword = nil)
      keyword ||= @keyword
      keyword ||= ''
      keyword.strip.split(/[　|\s]+/)
    end

    scope :with_keyword, lambda { |keyword_string|
      table = Book.arel_table
      keywords = generate_keyword(keyword_string)
      condition = nil
      keywords.each do |keyword|
        k = "%#{keyword}%"
        c = table[:title].matches(k)
        condition = condition.present? ? condition.or(c) : c
      end
      where(condition)
    }


    scope :search, lambda { |s|
      r = self
      r = r.with_keyword(s[:keyword]) if s[:keyword].present?
      return r if r != self
      where({})
    }
  end
end
