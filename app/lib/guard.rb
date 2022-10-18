class Guards
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])

    rescue ActiveRecord::RecordNotFound => e
      status 403
      error!(['Forbidden Request', e.message], env['api.response.code'] = 403)
    rescue JWT::DecodeError => e
      error!(e.message, env['api.response.code'] = 401)
    end
  end
end
