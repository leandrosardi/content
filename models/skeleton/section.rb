module BlackStack
    module Content
        class Section < Sequel::Model(:cnt_section)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            many_to_one :seminar, :class=>:'BlackStack::Content::Seminar', :key=>:id_seminar

            TYPE_HTML = 0
            TYPE_MARKDOWN = 1
        end # class
    end # Content
end # BlackStack