# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_oc_session',
  :secret      => '5133ef6d374fe2470e0112d932e9fe7f2890d80c1a2b707d41725763e35690502e63c0eddda4219abdcaec7bc67eb69856abbe53ea205317aed286c2003bfef1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
