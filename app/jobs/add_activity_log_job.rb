class AddActivityLogJob < ApplicationJob
  queue_as :default

  before_enqueue do |job|
    p 'ini di before enqueue'
    ActivityLog.write(nil, '0', 'queue job', nil)
  end

  def perform(*args)
    # Do something later
    
    user = User.first
    begin
      log = ActivityLog.write(user.id, '0', 'perform queue job', nil)

      puts log
    end
  end
end
