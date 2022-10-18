class ActivityLog < ApplicationRecord
  def self.write(user_id, ip, activity, user_agent)
    act = self.create(user_id: user_id, req_ip: ip, activity: activity, user_agent: user_agent) 

    p act['activity']
  end
end
