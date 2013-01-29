class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper, SocialHelper, ExFmHelper, StationsHelper, DropdownHelper
end
