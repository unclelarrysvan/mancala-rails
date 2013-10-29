class Board < ActiveRecord::Base
  has_many :players
  has_many :cups
end
