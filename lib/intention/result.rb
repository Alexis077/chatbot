module Intention
  class Result
    attr_reader :created, :message, :errors
    def initialize(valid: false, message: nil, errors: [])
      @valid = valid
      @message = message
      @errors = errors 
    end
  end
end
