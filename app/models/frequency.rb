class Frequency < ApplicationRecord
  broadcasts_refreshes
  validates_presence_of :name
end
