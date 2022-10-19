class Length < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params)
    unless params[attr_name].length >= @option
      raise Grape::Exceptions::Validation.new params: [@scope.full_name(attr_name)], message: "minimum character for username is #{@option} character long"
    end
  end
end