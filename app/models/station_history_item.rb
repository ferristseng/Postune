class StationHistoryItem < ActiveRecord::Base
  attr_accessible :played, :song_id

  belongs_to :song
end
