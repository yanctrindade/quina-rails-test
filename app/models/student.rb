class Student < ApplicationRecord
    has_many :homeworks
    validates :name, presence: true
end
