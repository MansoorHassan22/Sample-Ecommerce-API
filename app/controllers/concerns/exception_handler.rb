module ExceptionHandler
    extend ActiveSupport::Concern
  
    # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    class ForbiddenRequest < StandardError; end
    class BadRequest < StandardError; end
  
    included do
      # Define custom handlers
      # rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ExceptionHandler::ForbiddenRequest, with: :forbidden_request
      rescue_from ExceptionHandler::BadRequest, with: :four_hundred
  
      rescue_from ActiveRecord::RecordNotFound do |e|
        json_response({ error: e.message }, :not_found)
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e|
        json_response({ error: e.message }, :unprocessable_entity)
      end
    end
  
    private
  
    # JSON response with message; Status code 422 - unprocessable entity
    def four_twenty_two(e)
      json_response({ error: e.message }, :unprocessable_entity)
    end
  
    # JSON response with message; Status code 401 - Unauthorized
    def unauthorized_request(e)
      json_response({ error: e.message }, :unauthorized)
    end
  
    # JSON response with message; Status code 403 - Unauthorized
    def forbidden_request(e)
      json_response({ error: e.message }, :forbidden)
    end
  
    # JSON response with message; Status code 400 - Unauthorized
    def four_hundred(e)
        json_response({ error: e.message }, :bad_request)
    end

end
  