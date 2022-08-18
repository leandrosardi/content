module BlackStack
    module Content
        class Seminar < Sequel::Model(:cnt_seminar)
            many_to_one :user, :class=>:'BlackStack::MySaaS::User', :key=>:id_user
            one_to_many :sections, :class=>:'BlackStack::Content::Section', :key=>:id_seminar
            one_to_many :versions, :class=>:'BlackStack::Content::Version', :key=>:id_seminar
        
            # replace some mergetags with the actual values in config.rb file
            def self.merge(s)
                ret = s.dup
                # replace merge-tags with no fallback values
                ret.gsub!(/#{Regexp.escape('{APP_NAME}')}/, APP_NAME)
                ret.gsub!(/#{Regexp.escape('{APP_SHORT_NAME}')}/, APP_SHORT_NAME)
                ret.gsub!(/#{Regexp.escape('{HELPDESK_EMAIL}')}/, HELPDESK_EMAIL)
                ret.gsub!(/#{Regexp.escape('{COMPANY_NAME}')}/, COMPANY_NAME)
                ret.gsub!(/#{Regexp.escape('{COMPANY_TYPE}')}/, COMPANY_TYPE)
                ret.gsub!(/#{Regexp.escape('{COMPANY_ADDRESS}')}/, COMPANY_ADDRESS)
                ret.gsub!(/#{Regexp.escape('{COMPANY_PHONE}')}/, COMPANY_PHONE)
                ret.gsub!(/#{Regexp.escape('{COMPANY_URL}')}/, COMPANY_URL)
                ret.gsub!(/#{Regexp.escape('{HOME_WEBSITE}')}/, CS_HOME_WEBSITE)
                ret.gsub!(/#{Regexp.escape('{TERMS_URL}')}/, TERMS_URL)
                ret.gsub!(/#{Regexp.escape('{PRIVACY_URL}')}/, PRIVACY_URL)
                ret.gsub!(/#{Regexp.escape('{CANCEL_URL}')}/, CANCEL_URL)
                ret.gsub!(/#{Regexp.escape('{HELPDESK_URL}')}/, HELPDESK_URL)
                ret.gsub!(/#{Regexp.escape('{TIMEZONE}')}/, DEFAULT_TIMEZONE_SHORT_DESCRIPTION)
                # return
                ret
            end
            
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
                chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['_', '-']
                s.chars.detect {|ch| !chars.include?(ch)}.nil?
            end

            # Return true if the parameter s is valid to be used as a seminar path.
            def self.valid_path?(s)
                chars = ('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a + ['_', '-']
                s.chars.detect {|ch| !chars.include?(ch)}.nil?
            end

        end # class
    end # Content
end # BlackStack