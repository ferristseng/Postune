class StationCollaborator < ActiveRecord::Base
  attr_accessible :station_id, :title, :user_id
end
