module ResponseModule
  extend ActiveSupport::Concern

  private

  # 200 Success
  def response_success(class_name, action_name)
    render status: 200, json: {
      status: 200,
      message: "Success #{class_name.capitalize} #{action_name.capitalize}",
    }
  end

  # 204 Deleted
  def response_deleted
    render json: { message: 'deleted' }, status: 204
  end

  # 400 Bad Request
  def response_bad_request(error_messages = nil)
    json = { type: 'Bad Request' }
    json.merge!({ message: error_messages }) if error_messages.present?
    render status: 400, json: json
  end

  # 401 Unauthorized
  def response_unauthorized
    render status: 401, json: { status: 401, message: 'Unauthorized' }
  end

  # 403 Forbidden
  def response_forbidden
    render status: 403, json: { status: 403, message: 'Forbidden' }
  end

  # 404 Not Found
  def response_not_found(class_name = nil)
    json = { type: 'Not Found' }
    json.merge!({ message: "#{class_name.capitalize} Not Found" }) if class_name.present?
    render status: 404, json: json
  end

  def custom_error_404(error = nil)
    logger.info "Rendering 404 with exception: #{error.message}" if error
    render status: 404, json: { status: 404, message: 'Not Found' }
  end

  # 409 Conflict
  def response_conflict(class_name)
    render status: 409, json: { status: 409, message: "#{class_name.capitalize} Conflict" }
  end

  # 500 Internal Server Error
  def response_internal_server_error
    render status: 500, json: { status: 500, message: 'Internal Server Error' }
  end

  def custom_error_500(error = nil)
    logger.error "Rendering 500 with exception: #{error.message}" if error
    render status: 500, json: { status: 500, message: "Internal Server Error #{error}" }
  end
end
