class Message
    def self.not_found(record = 'record')
        "Sorry, #{record} not found."
    end

    def self.missing_params
        "Missing Parameters"
    end
end