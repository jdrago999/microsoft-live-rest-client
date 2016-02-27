
module MicrosoftLive
  class User
    attr_accessor :id,
                  :name,
                  :first_name,
                  :last_name,
                  :gender,
                  :link,
                  :birth_day,
                  :birth_month,
                  :birth_year,
                  :work,  # Object
                  :emails, # Object
                  :addresses, # Object
                  :locale,
                  :updated_time,
                  :simple

    def initialize(data: {}, simple:)
      data.each do |key,val|
        self.public_send "#{key}=", val
      end
      self.simple = simple
    end

  end
end
