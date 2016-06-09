class Ticket < ActiveRecord::Base
  belongs_to :user
  has_many :ticket_comments,:dependent=> :destroy
end
