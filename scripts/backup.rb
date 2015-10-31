# $ crontab -l
# 0 0 21 1/1 * ? * cd /Users/dreikanter/.rbenv/shims/bundle && /Users/dreikanter/.rbenv/shims/bundle exec rails r /Users/dreikanter/Sources/boodka/scripts/backup.rb

BACKUP_PATH = File.join(ENV['HOME'], 'Dropbox', 'Backup', ENV['app_name'])
DB_NAME = ENV['postgres_database']

FileUtils.mkdir_p(BACKUP_PATH)

timestamp = Time.now.strftime('%Y%m%d%H%M')
file_name = "#{BACKUP_PATH}/#{timestamp}-#{DB_NAME}.sql"

system("pg_dump #{DB_NAME} > #{BACKUP_PATH}/#{timestamp}-#{DB_NAME}.sql")
