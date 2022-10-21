class Api::V0::UserActivity::Resources::UserActivity < Grape::API
  resources :user_activity do
    get '/report' do
      @activities = ActivityLog::all

      xlsx = Axlsx::Package.new
      xlsx.workbook.add_worksheet(:name => 'First worksheet') do |sheet|
        bold = sheet.styles.add_style(b: true)

        sheet.add_row ['User', 'IP Address', 'Activity', 'User Agent'], :style => [bold, bold, bold, bold]
        @activities.each do |activity|
          sheet.add_row [activity.user_id, activity.req_ip, activity.activity, activity.user_agent]
        end
      end

      xlsx.use_shared_strings = true
      env['api.format'] = :binary
      header['Content-Disposition'] = "attachment; filename=activity.xlsx"

      body xlsx.to_stream.read
    end
  end
end
