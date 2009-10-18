module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the countries page/
      countries_path
    when /the new country page/
      new_country_path
    when /the new user page/
      new_user_path
    when /the user login page/
      new_user_session_path
    when /the currencies page/
      currencies_path
    when /the new currency page/
      new_currency_path
    when /the manufacturers page/
      manufacturers_path
    when /the new manufacturer page/
      new_manufacturer_path
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)