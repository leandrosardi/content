module BlackStack
    module Content
        class Section < Sequel::Model(:cnt_section)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            many_to_one :seminar, :class=>:'BlackStack::Content::Seminar', :key=>:id_seminar

            TYPE_HTML = 0
            TYPE_MARKDOWN = 1

            # return the latest change of this section.
            # return nil if no change.
            def current_changelog
                BlackStack::Content::Changelog.where(:id_section=>self.id).reverse(Sequel.desc(:create_time)).first
            end

            # return true if the user has seen the latest change of this section before.
            def seen_by?(u)
                !BlackStack::Content::Action.where(
                    :id_changelog=>self.current_changelog.id, 
                    :id_user=>u.id, 
                    :type=>BlackStack::Content::Action::TYPE_SEEN
                ).first.nil?
            end # seen?by?

            # return true if the user has done the latest change of this section before.
            def done_by?(u)
                !BlackStack::Content::Action.where(
                    :id_changelog=>self.current_changelog.id,
                    :id_user=>u.id,
                    :type=>BlackStack::Content::Action::TYPE_DONE
                ).first.nil?
            end

            # if the user has never seen the latest change of this section before, register the seen in the database.
            # else, do nothing.
            def seen_by(u)
                if !self.seen_by?(u)
                    a = BlackStack::Content::Action.new
                    a.id = guid
                    a.create_time = now
                    a.id_changelog = self.current_changelog.id
                    a.id_user = u.id
                    a.type = BlackStack::Content::Action::TYPE_SEEN
                    a.save
                end
            end # seen_by

            # if the user has never done the latest change of this section before, register it as done done in the database.
            # else, do nothing.
            def done_by(u)
                if !self.done_by?(u)
                    a = BlackStack::Content::Action.new
                    a.id = guid
                    a.create_time = now
                    a.id_changelog = self.current_changelog.id
                    a.id_user = u.id
                    a.type = BlackStack::Content::Action::TYPE_DONE
                    a.save
                end
            end # done_by


        end # class
    end # Content
end # BlackStack