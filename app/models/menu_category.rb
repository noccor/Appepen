class MenuCategory < ActiveRecord::Base
  belongs_to :menu
  has_many :meals

  validates :menu_id, presence: true

  validates :name, presence: true,
                    length: { minimum: 3 }

  validates :description, presence: true,
                    length: { minimum: 5 }

end
