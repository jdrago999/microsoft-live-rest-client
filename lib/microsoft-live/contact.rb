
module MicrosoftLive
  class Contact
    attr_accessor :id,
                  :first_name,
                  :last_name,
                  :name,
                  :is_friend,
                  :is_favorite,
                  :user_id,
                  :email_hashes,
                  :updated_time,
                  :birth_day,
                  :birth_month,
                  :simple

    def initialize(data: {}, simple:)
      data.each do |key,val|
        self.send "#{key}=", val
      end
      self.simple = simple
    end

    def user
      return unless user_id
      simple.user(user_id)
    end
  end
end
