class Disc < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }

  belongs_to :manufacturer
  validates :name, presence: true, uniqueness: { scope: :manufacturer_id }
  validates :slug, presence: true, uniqueness: { scope: :manufacturer_id }
  validates_presence_of :speed,
                        :glide,
                        :turn,
                        :fade,
                        :diameter,
                        :height,
                        :rim_depth,
                        :rim_width
end
