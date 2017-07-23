class Menu < ActiveRecord::Base
  validates :name, presence: true,
                    length: { minimum: 3 }

  validates :description, presence: true,
                    length: { minimum: 5 }

  validates :cat, presence: true,
                    length: { minimum: 2 }
end
