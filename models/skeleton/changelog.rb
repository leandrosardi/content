module BlackStack
    module Content
        class Changelog < Sequel::Model(:cnt_changelog)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            many_to_one :section, :class=>:'BlackStack::Content::Section', :key=>:id_section
        end # class
    end # Content
end # BlackStack