class Step < ApplicationRecord
  broadcasts_refreshes
  acts_as_tenant :account
  validates_presence_of :name
  has_one :job
  has_many :guides
  has_rich_text :notes
  has_rich_text :description
end
