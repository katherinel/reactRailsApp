class Record < ActiveRecord::Base
	validates :title, :date, :amount, presence: true
end
