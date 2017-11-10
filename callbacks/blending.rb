module Blending
  extend ActiveSupport::Concern

  included do
    after_save :after_save
  end

  def after_save
    if self.class.to_s == 'Apple'
      make_juice
    end
  end

  def make_juice
    puts "#{self.class} juice made"
  end
end