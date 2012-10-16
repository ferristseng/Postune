# == Schema Information
#
# Table name: station_history_items
#
#  id         :integer          not null, primary key
#  song_id    :integer
#  played     :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StationHistoryItem < ActiveRecord::Base
  attr_accessible :played, :song_id

  belongs_to :song
end
