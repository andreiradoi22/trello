class Board < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :columns
end
