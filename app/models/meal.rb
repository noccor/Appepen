class Meal < ActiveRecord::Base
  belongs_to :menu_category
  has_many :recipes

  validates :menu_category_id, presence: true

  validates :price, presence: true

  validates :name, presence: true,
                    length: { minimum: 3 }

  validates :description, presence: true,
                    length: { minimum: 5 }

end
