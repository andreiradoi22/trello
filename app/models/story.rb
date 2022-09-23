# frozen_string_literal: true

class Story < ApplicationRecord
  validates :title, presence: true

  belongs_to :column

  scope :filter_by_status, ->(status) { where(status: status) }
  scope :filter_by_due_date, ->(due_date) { where(due_date: due_date) }
end
