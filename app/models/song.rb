# == Schema Information
#
# Table name: songs
#
#  id         :integer          not null, primary key
#  path       :text
#  title      :string(255)
#  artist     :string(255)
#  album      :string(255)
#  artwork    :string(255)
#  user_id    :integer
#  station_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'soundcloud'
require 'net/http'

class Song < ActiveRecord::Base
  attr_accessible :album, :artist, :artwork, :path, :station_id, :title, :user_id

  # validation
  validate :validate_url

  # relationships
  belongs_to :user
  belongs_to :station

  private

	  def validate_url
	  	puts self.path
	    case self.path
	    when /^https*:\/\/(?:www.)?api.soundcloud.com\/tracks\/(?:\d+)\/\S*$/
	      self.path = find_redirect_url "#{self.path}?consumer_key=#{Settings['api_keys']['soundcloud']['client_key']}"
	    when /^https*:\/\/(?:www.)?soundcloud.com\/\w+\/\S+$/
	    	client = Soundcloud.new(:client_id => Settings['api_keys']['soundcloud']['client_key'])
	    	# get the stream URL
	    	self.path = find_redirect_url client.get('/resolve', self.path).stream_url
	    when /^https*:\/\/\S+.mp3\?*\S*$/
	      self.path = self.path
	    when /^https*:\/\/(?:www.)?tumblr.com\/audio_file\/\S+$/
	      self.path = find_redirect_url self.path
	    when /^https*:\/\/(?:www.)?\w+.bandcamp.com\/\S+$/
	      self.path = find_redirect_url self.path
	    else
	    	self.path = nil
	    end
	    puts self.path
	    errors.add(:url, "is invalid") unless self.path.match(/^https*:\/\/\S+.mp3\?*\S*$/)
	  end

	  def find_redirect_url(url)
	  	url = url.match(/^https\S+$/).nil? ? url : url.gsub("https://", "http://")
	  	Net::HTTP.get_response(URI.parse(url))['location']
	  end

end
