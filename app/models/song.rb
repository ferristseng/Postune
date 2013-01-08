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
require 'open-uri'

class Song < ActiveRecord::Base
  attr_accessible :album, :artist, :artwork, :path, :title, :user_id

  # validation
  validate :validate_url

  # relationships
  belongs_to :user

  def title
  	read_attribute(:title).blank? ? "Unknown" : read_attribute(:title)
  end

  def artist
  	read_attribute(:artist).blank? ? "Unknown" : read_attribute(:artist)
  end

  def album
  	read_attribute(:album).blank? ? "Unknown" : read_attribute(:album)
  end

  def display_title
  	self.title.truncate(30, :omission => "...")
  end

  def display_artist
  	self.artist.truncate(30, :omission => "...")
  end

  def display_album
  	self.album.truncate(30, :omission => "...")
  end

  private
  	#
  	# Make sure the url resolves to a valid MP3 path
	  def validate_url
	    case self.path
	    when /^https*:\/\/(?:www.)?api.soundcloud.com\/tracks\/(?:\d+)\/\S*$/
	      self.path = find_redirect_url "#{self.path}?consumer_key=#{Settings['soundcloud']['client_key']}"
	    when /^https*:\/\/(?:www.)?soundcloud.com\/\w+\/\S+$/
	    	client = Soundcloud.new(:client_id => Settings['soundcloud']['client_key'])
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
	    errors.add(:url, "is invalid") unless self.path.match(/^https*:\/\/\S+.mp3\?*\S*$/)
	  end

	  # 
	  # Get the last redirection given a URL
	  def find_redirect_url(url)
	  	url = url.match(/^https\S+$/).nil? ? url : url.gsub("https://", "http://")
	  	result = Curl::Easy.perform(url) do |curl|
		    curl.follow_location = true
		  end
		  result.last_effective_url
	  end

end
