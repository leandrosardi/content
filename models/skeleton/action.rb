module BlackStack
    module Content
        class Action < Sequel::Model(:cnt_action)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            many_to_one :section, :class=>:'BlackStack::Content::Section', :key=>:id_section
        
            TYPE_SEEN = 0
            TYPE_DONE = 1
        end # class
    end # Content
end # BlackStack