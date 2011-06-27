# Load the rails application
require File.expand_path('../application', __FILE__)

Mime::Type.register 'application/zip', :zip

# Initialize the rails application
Glenwoodbroll::Application.initialize!
