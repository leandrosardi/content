# default screen
# TODO: Code Me!

# public screens (signup/landing page)
# TODO: Code Me!

# public screens (login page)
# TODO: Code Me!

# internal app screens
get "/content/seminars", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/seminars", :layout => :"/views/layouts/core"
end

get "/content/seminars/new", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/new_seminar", :layout => :"/views/layouts/core"
end

get "/content/seminars/:sid/edit", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/edit_seminar", :layout => :"/views/layouts/core"
end

get "/content/seminars/:sid/edit/:tid", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/edit_section", :layout => :"/views/layouts/core"
end

# public URLs of seminars
get "/seminars/pub/:path/:seminar", :agent => /(.*)/ do
    erb :"/extensions/content/views/seminar", :layout => :"/views/layouts/public"
end

# private URLs of seminars, for the loggedin users
get "/seminars/:path/:seminar", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/public", :layout => :"/views/layouts/core"
end

# filters
post "/content/filter_new_seminar", :auth => true do
    erb :"/extensions/content/views/filter_new_seminar"
end

post "/content/filter_edit_seminar", :auth => true do
    erb :"/extensions/content/views/filter_edit_seminar"
end

post "/content/filter_delete_seminar", :auth => true do
    erb :"/extensions/content/views/filter_delete_seminar"
end

post "/content/filter_new_version", :auth => true do
    erb :"/extensions/content/views/filter_new_version"
end

post "/content/filter_new_section", :auth => true do
    erb :"/extensions/content/views/filter_new_section"
end

post "/content/filter_edit_section", :auth => true do
    erb :"/extensions/content/views/filter_edit_section"
end

post "/content/filter_delete_section", :auth => true do
    erb :"/extensions/content/views/filter_delete_section"
end

# AJAX 
# TODO: Code Me!

# API
# TODO: Code Me!
