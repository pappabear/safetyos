class Job < ApplicationRecord
  broadcasts_refreshes
  acts_as_tenant :account
  validates_presence_of :name
  has_many :steps
  has_rich_text :notes
  has_rich_text :description
end
