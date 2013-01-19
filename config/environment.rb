# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Postune::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address        => Settings['email']['address'],
    :domain         => Settings['domain'],
    :port           => Settings['email']['port'],
    :user_name      => Settings['email']['username'],
    :password       => Settings['email']['password'],
    :authentication => :plain
}
