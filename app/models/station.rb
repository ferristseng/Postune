class Station < ActiveRecord::Base
  attr_accessible :name, :permalink, :user_id
end
