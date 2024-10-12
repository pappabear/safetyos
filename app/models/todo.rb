class Todo < ApplicationRecord
  broadcasts_refreshes
  has_rich_text :description
  has_rich_text :notes
  has_one :step
end
