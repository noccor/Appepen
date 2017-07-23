class Meal < ActiveRecord::Base
  belongs_to :menu
  has_many :ingredients

  validates :name, presence: true,
                    length: { minimum: 3 }

  validates :description, presence: true,
                    length: { minimum: 5 }

end
