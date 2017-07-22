class Meal < ActiveRecord::Base
  belongs_to :menu
  has_many :ingredients
end
