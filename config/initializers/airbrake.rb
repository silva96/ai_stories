# frozen_string_literal: true

if (project_id = ENV.fetch('AIRBRAKE_PROJECT_ID', nil)) && (project_key = ENV.fetch('AIRBRAKE_PROJECT_KEY', nil))
  Airbrake.configure do |c|
    c.project_id = project_id
    c.project_key = project_key
    c.root_directory = Rails.root
    c.logger = Airbrake::Rails.logger
    c.environment = Rails.env
    c.ignore_environments = %w[test development]
    c.blocklist_keys = [/password/i, /authorization/i, /open_ai_token/i]
  end
end
