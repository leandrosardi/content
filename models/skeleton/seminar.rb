module BlackStack
    module Content
        class Seminar < Sequel::Model(:cnt_seminar)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            one_to_many :sections, :class=>:'BlackStack::Content::Section', :key=>:id_seminar
            one_to_many :versions, :class=>:'BlackStack::Content::Version', :key=>:id_seminar
        
            # Retrurn false if the path exists in other seminar of another account.
            # Return true if the path is available.
            def self.available?(path, account)
                s = "
                    SELECT s.id
                    FROM cnt_seminar s
                    JOIN \"user\" u ON u.id = s.id_user
                    WHERE UPPER(s.path) = UPPER('#{path.to_sql}')
                    AND u.id_account <> '#{account.id.to_sql}'
                "
                DB[s].first.nil?
            end

            # Return true if the parameter s is valid to be used as a seminar name.
            def self.valid_name?(s)
                chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['_', '-']
                s.chars.detect {|ch| !chars.include?(ch)}.nil?
            end

            # Return true if the parameter s is valid to be used as a seminar path.
            def self.valid_path?(s)
                chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['_', '-']
                s.chars.detect {|ch| !chars.include?(ch)}.nil?
            end

        end # class
    end # Content
end # BlackStack