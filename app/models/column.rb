class Column < ApplicationRecord
  validates :title, presence: true

  belongs_to :board
  has_many :stories
end
