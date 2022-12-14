# frozen_string_literal: true

class Column < ApplicationRecord
  validates :title, presence: true

  belongs_to :board
  has_many :stories, dependent: :destroy
end
