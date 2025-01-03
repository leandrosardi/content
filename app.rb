# default screen
get "/content", :agent => /(.*)/ do
    redirect2 "/content/seminars", params
end
get "/content/", :agent => /(.*)/ do
    redirect2 "/content/seminars", params
end

# internal app screens
get "/content/seminars", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/seminars", :layout => :'/views/layouts/classic'
end

get "/content/seminars/new", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/new_seminar", :layout => :'/views/layouts/classic'
end

get "/content/seminars/:sid/view", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/view_seminar", :layout => :'/views/layouts/classic'
end

get "/content/seminars/:sid/edit", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/edit_seminar", :layout => :'/views/layouts/classic'
end

get "/content/seminars/:sid/edit/:tid", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/edit_section", :layout => :'/views/layouts/classic'
end

# public URLs of seminars
get "/seminars/pub/:path/:name", :agent => /(.*)/ do
    path = params[:path].to_s
    name = params[:name].to_s
    s = BlackStack::Content::Seminar.where(:path=>path, :name=>name).first
    if s.type == 0 # BlackStack::Content::Seminar::TYPE_PROGRESSIVE_SEMINAR
        erb :"/extensions/content/views/public_seminar", :layout => :"/views/layouts/public"
    elsif s.type == 1 # BlackStack::Content::Seminar::TYPE_PLAIN_ARTICLE
        erb :"/extensions/content/views/public_article", :layout => :"/views/layouts/public"
    else
        halt 404
    end
end

# private URLs of seminars, for the loggedin users
get "/seminars/:path/:name", :auth => true, :agent => /(.*)/ do
    path = params[:path].to_s
    name = params[:name].to_s
    s = BlackStack::Content::Seminar.where(:path=>path, :name=>name).first
    if s.type == 0 # BlackStack::Content::Seminar::TYPE_PROGRESSIVE_SEMINAR
        erb :"/extensions/content/views/private_seminar", :layout => :'/views/layouts/classic'
    elsif s.type == 1 # BlackStack::Content::Seminar::TYPE_PLAIN_ARTICLE
        erb :"/extensions/content/views/private_article", :layout => :'/views/layouts/classic'
    else
        halt 404
    end
end

# show all the available paths
get "/seminars/", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/view_paths", :layout => :'/views/layouts/classic'
end
get "/seminars", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/view_paths", :layout => :'/views/layouts/classic'
end

# show all the available seminars into a path
get "/seminars/:path/", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/view_seminars", :layout => :'/views/layouts/classic'
end
get "/seminars/:path", :auth => true, :agent => /(.*)/ do
    erb :"/extensions/content/views/view_seminars", :layout => :'/views/layouts/classic'
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
get "/content/filter_delete_seminar", :auth => true do
    erb :"/extensions/content/views/filter_delete_seminar"
end

post "/content/filter_new_version", :auth => true do
    erb :"/extensions/content/views/filter_new_version"
end

post "/content/filter_new_section", :auth => true do
    erb :"/extensions/content/views/filter_new_section"
end
get "/content/filter_new_section", :auth => true do
    erb :"/extensions/content/views/filter_new_section"
end

post "/content/filter_edit_section", :auth => true do
    erb :"/extensions/content/views/filter_edit_section"
end

post "/content/filter_delete_section", :auth => true do
    erb :"/extensions/content/views/filter_delete_section"
end
get "/content/filter_delete_section", :auth => true do
    erb :"/extensions/content/views/filter_delete_section"
end

post "/content/filter_done_section", :auth => true do
    erb :"/extensions/content/views/filter_done_section"
end
get "/content/filter_done_section", :auth => true do
    erb :"/extensions/content/views/filter_done_section"
end

# AJAX 
post "/ajax/content/upload_picture.json", :auth => true do
    erb :"/extensions/content/views/ajax/upload_picture"
end

# API
# TODO: Code Me!
