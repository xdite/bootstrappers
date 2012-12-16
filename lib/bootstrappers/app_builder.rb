module Bootstrappers
  class AppBuilder < Rails::AppBuilder

    include Bootstrappers::Actions
    include Bootstrappers::LayoutActions


    def raise_delivery_errors
      replace_in_file 'config/environments/development.rb',
        'raise_delivery_errors = false', 'raise_delivery_errors = true'
    end

    def add_common_rake_tasks
      directory 'tasks', 'lib/tasks'
    end

    def add_devise_gem
      inject_into_file 'Gemfile', "\ngem 'devise'",
      :after => /gem 'jquery-rails'/
    end

    def create_capistrano_files
      template 'capistrano/deploy_rb.erb', 'config/deploy.rb',:force => true
      template 'capistrano/Capfile', 'Capfile',:force => true
      empty_directory 'config/deploy'
      directory 'capistrano/deploy', 'config/deploy'
    end

    def create_database
      bundle_command 'exec rake db:create'
    end

    def generate_devise
      generate 'devise:install'
      generate 'devise User'
      replace_in_file 'config/initializers/devise.rb', /config\.mailer_sender = \".+\"/ , "config.mailer_sender = Setting.email_sender"

    end

    def gitignore_files
      concat_file 'bootstrappers_gitignore', '.gitignore'
      ['app/models',
       'app/assets/images',
       'app/views/pages',
       'db/migrate',
       'log',
      ].each do |dir|
        empty_directory_with_gitkeep dir
      end
    end

    def init_git
      run "git init"
    end


    def build_settings_from_config

      template 'setting.rb', 'app/models/setting.rb',:force => true
      template 'config_yml.erb', 'config/config.yml',:force => true
    end

    def create_initializers
      directory 'initializers', 'config/initializers'
    end


    def remove_routes_comment_lines
      replace_in_file 'config/routes.rb', /Application\.routes\.draw do.*end/m, "Application.routes.draw do\nend"
    end

    def use_mysql_config_template
      template 'mysql_database.yml.erb', 'config/database.yml',:force => true
      template 'mysql_database.yml.erb', 'config/database.yml.example', :force => true

      db_user_name = ask("What is your local database user name? [root]")
      db_password = ask("What is your local database password? ['']")

      replace_in_file 'config/database.yml', 'username: root', "username: #{db_user_name}" if db_user_name.present?
      replace_in_file 'config/database.yml', 'password: ""', "password: '#{db_password}'" if db_password.present?

    end


  end
end
