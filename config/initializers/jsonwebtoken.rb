class Jsonwebtoken
  SECRET_KEY = "PintuKemanaSadj4"

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)

    decoded.first
  end
end
