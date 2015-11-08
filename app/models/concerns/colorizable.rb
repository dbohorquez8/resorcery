module Colorizable
  extend ActiveSupport::Concern

  included do
    before_validation :setup_color, on: :create
  end

  def setup_color
    generator = ColorGenerator.new saturation: 0.3, lightness: 0.75
    self.metadata['background_color'] = generator.create_hex
  end
end
