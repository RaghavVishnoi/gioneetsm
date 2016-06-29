# config valid only for Capistrano 3.1
lock '3.5.0'

set :application, 'gionee'
set :repo_url, 'ssh://xp-dev.com/GIONEE_GQUESTION_ROR' # Edit this to match your repository
set :branch, :mum
set :deploy_to, '/var/www/gquestions/mum'
set :pty, true
set :linked_dirs, fetch(:linked_dirs, []).push('public/uploads','public/retailer_csv','public/sales_beat_csv','public/target_csv')
#set :linked_files, %w{config/database.yml config/application.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.2.1' # Edit this if you are using MRI Ruby

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false
set :bundle_gemfile, "/var/www/gquestions/mum"

 

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
      	execute :bundle_install
        execute :rake, 'db:migrate'
      end
    end
  end

end
