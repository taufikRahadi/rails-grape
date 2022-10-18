module Config
  def self.included(base)
    base.instance_eval do
      default_format :json
      version "v0", using: :param, parameter: "v"
      format :json
      content_type :json, "application/json; charset=UTF-8"
    end
  end
end