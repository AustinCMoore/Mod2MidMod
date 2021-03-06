class Movie < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :creation_year
  validates_presence_of :genre

  has_many :movie_actors
  has_many :actors, through: :movie_actors
  belongs_to :studio

  def order_from_youngest
    self.actors.order(:age)
  end

  def avg_age
    self.actors.average(:age)
  end
end
