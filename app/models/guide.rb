class Guide < ApplicationRecord
  broadcasts_refreshes
  has_rich_text :description
	has_one_attached :doc
  acts_as_tenant :account
  validates_presence_of :name
  validates :doc, attached: true
  has_one :step
end
