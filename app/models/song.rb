# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  path       :string(255)
#  title      :string(255)
#  artist     :string(255)
#  album      :string(255)
#  artwork    :string(255)
#  user_id    :integer
#  station_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Song < ActiveRecord::Base
  attr_accessible :album, :artist, :artwork, :path, :station_id, :title, :user_id
end
