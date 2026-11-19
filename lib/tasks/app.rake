namespace :app do
  desc 'Apply fixes'
  task fix: :environment do
    Log.transaction do
      Log.where(days: 0).where(created_at: ...Time.zone.parse('2026-11-05 18:00')).delete_all
      Log.where('days > 1').find_each do |log|
        (log.days - 1).times do
          Log.create!(
            user: log.user,
            week: log.week,
            year: log.year,
            theme: log.theme,
            cycle: log.cycle
          )
        end
        log.update_column :days, 1
      end
    end
  end

  desc 'Get database'
  task :db do
    Bundler.with_unbundled_env do
      Figaro.load # Load ENV variables
      # Get a new backup archive from Scalingo
      # PG Addon ID from `scalingo addons` CLI command.
      sh "scalingo --app #{ENV['SCALINGO_APP_NAME']} backups-create --addon #{ENV['SCALINGO_PG_ADDON_ID']}"
      sh "scalingo --app #{ENV['SCALINGO_APP_NAME']} backups-download --addon #{ENV['SCALINGO_PG_ADDON_ID']} --output db/scalingo-dump.tar.gz"

      sh 'rm -f db/latest.dump' # Remove an old backup file if it exists
      sh 'tar zxvf db/scalingo-dump.tar.gz -C db/' # Extract the new backup archive
      sh 'rm db/scalingo-dump.tar.gz' # Remove the backup archive
      sh 'mv db/*.pgsql db/latest.dump' # Rename the backup file
      sh 'DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop'
      sh 'bundle exec rails db:create'
      begin
        sh 'pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d timesheet_development db/latest.dump'
        sh 'rails db:migrate'
        sh 'rails db:seed'
      rescue
        'There were some warnings or errors while restoring'
      end
    end
  end
end
