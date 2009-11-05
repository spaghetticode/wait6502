module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    new_record_models = 'currency|country|manufacturer|user|io port|builtin storage|storage name|storage format|storage size|cpu family|cpu|operative system|builtin language|co cpu name|co cpu|cpu name|hardware type'
    list_models = 'currencies|countries|manufacturers|io ports|builtin storages|storage names|storage formats|storage sizes|cpu families|cpus|operative systems|builtin languages|co cpu names|co cpus|cpu names|hardware types'
    case page_name
    
    when /the homepage/
      '/'
    when /the user login page/
      new_user_session_path
    when /the new (#{new_record_models}) page/
      send("new_admin_#{$1.gsub(' ', '_')}_path")
    when /the hardware page/
      admin_hardware_index_path
    when /the (#{list_models}) page/
      send ("admin_#{$1.gsub(' ', '_')}_path")
    when /the "(.+)" hardware editor page/
      send("edit_admin_hardware_path", Hardware.find_by_name($1))
    when /the "(.+)" (hardware) images page/
      send("admin_#{$2}_images_path", $2.capitalize.constantize.find_by_name($1))
    when /the "(.+)" (hardware) keywords page/
      send("admin_#{$2}_ebay_keywords_path", $2.capitalize.constantize.find_by_name($1))
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
