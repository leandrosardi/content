module BlackStack
    module Content
        class Seminar < Sequel::Model(:cnt_seminar)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            one_to_many :sections, :class=>:'BlackStack::Content::Section', :key=>:id_seminar
            one_to_many :versions, :class=>:'BlackStack::Content::Version', :key=>:id_seminar
        end # class
    end # Content
end # BlackStack