# frozen_string_literal: true

class Recipe < ContentfulModel::Base
  self.content_type_id = 'recipe'

  def self.all_recipes
    all.load!
  end

  def tags_names
    return nil if tags.nil?

    tags.map(&:name).join(', ')
  end
end
