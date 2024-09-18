class Job < ApplicationRecord
  broadcasts_refreshes
  acts_as_tenant :account
  validates_presence_of :name
end
