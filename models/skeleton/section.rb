module BlackStack
    module Content
        class Section < Sequel::Model(:cnt_section)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            many_to_one :seminar, :class=>:'BlackStack::Content::Seminar', :key=>:id_seminar

        end # class
    end # Content
end # BlackStack