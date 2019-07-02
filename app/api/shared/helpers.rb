module Shared
  module Helpers
    extend Grape::API::Helpers
    def no_content!
      ok!(204)
    end

    def not_modified!
      ok!(304)
    end

    def ok!(code=200, body=nil)
      status code
      @body = body
    end

    def required_attributes!(*keys)
      keys.each do |key|
        bad_request!(key) unless params[key].present?
      end
    end

    def bad_request!(attribute)
      message = ['400 (Bad request)']
      message << "\"#{attribute}\" not given"
      render_api_error!(message.join(' '), 400)
    end

    def unprocessable_entity!(msg = '422 Unprocessable')
      render_api_error!(msg, 422)
    end

    def precondition_failed!
      render_api_error!('412 Precondition Failed', 412)
    end

    def unauthorized!
      render_api_error!('401 Unauthorized', 401)
    end

    def forbidden!
      render_api_error!('403 Unauthorized', 403)
    end

    def not_found!
      render_api_error!('404 Not Found', 404)
    end

    def render_api_error!(message, code)
      error!({ message: message }, code)
    end
  end
end
