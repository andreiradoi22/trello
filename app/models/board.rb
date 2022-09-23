# frozen_string_literal: true

class Board < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_many :columns, dependent: :destroy
end
