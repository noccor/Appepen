class Recipie < ActiveRecord::Base
  belongs_to :menu
  belongs_to :ingredient

  validates :menu_id, presence: true

  validates :ingredient_id, presence: true

end
