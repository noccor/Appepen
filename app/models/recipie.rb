class Recipie < ActiveRecord::Base
  belongs_to :meal
  belongs_to :ingredient

  validates :meal_id, presence: true

  validates :ingredient_id, presence: true

end
