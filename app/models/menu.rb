class Menu < ActiveRecord::Base
  has_many :menu_categories 
  validates :name, presence: true,
                    length: { minimum: 3 }

  validates :description, presence: true,
                    length: { minimum: 5 }

  validates :cat, presence: true,
                    length: { minimum: 2 }
end
