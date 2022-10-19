class IsUnique < Grape::Validations::Validators::Base
  def validate_param!(attr_name, params)
    model = @option.first
    field = @option.last

    table_name = model.table_name
    sql = "select id from #{table_name} r where r.#{field} = '#{params[attr_name]}'"

    result = model.find_by_sql(sql)
    if result.length > 0
      raise Grape::Exceptions::Validation.new params: [@scope.full_name(attr_name)],
                    message: "data with #{params[attr_name]} is already exists"
    end
  end
end