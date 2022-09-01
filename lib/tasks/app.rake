namespace :app do
  desc 'Get database'
  task :db do
    Bundler.with_original_env do
      sh "heroku pg:backups capture --app coop-noesya-timesheet"
      sh "curl -o db/latest.dump `heroku pg:backups public-url --app coop-noesya-timesheet`"
      sh 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop'
      sh 'bundle exec rails db:create'
      begin
        sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d timesheet_development db/latest.dump'
      rescue
        'There were some warnings or errors while restoring'
      end
      sh 'rails db:migrate'
    end
  end

  task fix: :environment do
    Week.where('id >= ?', 55).destroy_all
    Week.where('id >= ?', 4).destroy_all
  end
end
