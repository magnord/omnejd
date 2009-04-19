# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_omnejd_session',
  :secret      => '746a9a2f5b3c77a534f3583535c56bc998e918d730e47d43c2f36fce0f8ac5f3465db6fdcde375ede98866b008858212eef47434d0f9b2dc4a3771bd189e1481'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
