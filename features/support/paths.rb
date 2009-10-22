module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    new_record_models = 'currency|country|computer type|manufacturer|user|io port|builtin storage|storage name|storage format|storage size|cpu family|cpu|operative system|builtin language|co cpu name|co cpu'
    list_models = 'currencies|countries|computer types|manufacturers|io ports|builtin storages|storage names|storage formats|storage sizes|cpu families|cpus|operative systems|builtin languages|co cpu names|co cpus'
    case page_name
    
    when /the homepage/
      '/'
    when /the user login page/
      new_user_session_path
    when /the new (#{new_record_models}) page/
      send("new_admin_#{$1.gsub(' ', '_')}_path")
    when /the (#{list_models}) page/
      send ("admin_#{$1.gsub(' ', '_')}_path")
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
