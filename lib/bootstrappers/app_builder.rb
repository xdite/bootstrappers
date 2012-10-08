module Bootstrappers
  class AppBuilder < Rails::AppBuilder

    include Bootstrappers::Actions

    def readme
      template 'README.md.erb', 'README.md'
    end

    def remove_public_index
      remove_file 'public/index.html'
    end

    def remove_rails_logo_image
      remove_file 'app/assets/images/rails.png'
    end

    def raise_delivery_errors
      replace_in_file 'config/environments/development.rb',
        'raise_delivery_errors = false', 'raise_delivery_errors = true'
    end

    def create_partials_directory
      empty_directory 'app/views/application'
      empty_directory 'app/views/pages'
      empty_directory 'app/views/common'
    end

    def create_application_layout
      template 'bootstrappers_layout.html.erb.erb',
        'app/views/layouts/application.html.erb',
        :force => true
    end

    def create_common_javascripts
      directory 'javascripts', 'app/assets/javascripts'
    end

    def create_common_stylesheets
      directory 'stylesheets', 'app/assets/stylesheets'
    end

    def create_common_partial
      directory 'common', 'app/views/common'
    end

    def add_jquery_ui
      inject_into_file 'app/assets/javascripts/application.js',
        "//= require jquery-ui\n", :before => '//= require_tree .'
    end

    def add_bootstrap_js
      inject_into_file 'app/assets/javascripts/application.js',
        "//= require twitter/bootstrap/alert\n", :before => '//= require_tree .'
    end

    def add_custom_gems
      additions_path = find_in_source_paths 'Gemfile_additions'
      new_gems = File.open(additions_path).read
      inject_into_file 'Gemfile', "\n#{new_gems}",
      :after => /gem 'jquery-rails'/
    end

    def add_devise_gem
      inject_into_file 'Gemfile', "\ngem 'devise'",
        :after => /gem 'jquery-rails'/
    end

    def use_mysql_config_template
 
      template 'mysql_database.yml.erb', 'config/database.yml',
        :force => true
      template 'mysql_database.yml.erb', 'config/database.yml.example',
        :force => true
    end

    def create_database
      bundle_command 'exec rake db:create'
    end

    def generate_devise
      generate 'devise:install'
      generate 'devise User'
    end

    def build_settings_from_config

      template 'setting.rb', 'app/models/setting.rb',:force => true
      template 'config_yml.erb', 'config/config.yml',:force => true
    end

    def create_initializers
      directory 'initializers', 'config/initializers'
    end

    def setup_stylesheets
      copy_file 'app/assets/stylesheets/application.css', 'app/assets/stylesheets/application.css.scss'
      remove_file 'app/assets/stylesheets/application.css'
      concat_file 'import_scss_styles', 'app/assets/stylesheets/application.css.scss'
    end

    def setup_root_route
      template 'welcome.html.erb', 'app/views/pages/welcome.html.erb',:force => true
      route "root :to => 'high_voltage/pages#show', :id => 'welcome'"
    end

    def remove_routes_comment_lines
      replace_in_file 'config/routes.rb', /Application\.routes\.draw do.*end/m, "Application.routes.draw do\nend"
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
      run 'git init'
    end
  end
end
