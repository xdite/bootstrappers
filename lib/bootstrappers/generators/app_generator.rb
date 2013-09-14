require 'rails/generators'
require 'rails/generators/rails/app/app_generator'


module Bootstrappers
  class AppGenerator < Rails::Generators::AppGenerator

    class_option :database, :type => :string, :aliases => '-d', :default => 'mysql',
      :desc => "Preconfigure for selected database (options: #{DATABASES.join('/')})"

    def finish_template
      invoke :bootstrappers_customization
      super
    end

    def bootstrappers_customization
      invoke :remove_files_we_dont_need
      invoke :setup_development_environment
      invoke :create_bootstrappers_views
      invoke :create_common_partial
      invoke :create_common_javascripts
      invoke :create_common_stylesheets
      invoke :add_common_js_library
      invoke :add_common_rake_tasks
      invoke :customize_gemfile
      invoke :setup_capistrano
      invoke :setup_database
      invoke :configure_app
      invoke :create_initializers
      invoke :remove_routes_comment_lines
      invoke :add_common_method_to_application_controller
      invoke :setup_root_route
      invoke :setup_git
    end

    def remove_files_we_dont_need
      build :remove_public_index
      build :remove_rails_logo_image
    end

    def setup_development_environment
      say 'Setting up the development environment'
      build :raise_delivery_errors
    end

    def create_bootstrappers_views
      say 'Creating bootstrappers views'
      build :create_partials_directory
      build :create_application_layout
    end

    def create_common_partial
      say 'Pulling in some common partials'
      build :create_common_partial
    end

    def create_common_javascripts
      say 'Pulling in some common javascripts'
      build :create_common_javascripts
    end

    def create_common_stylesheets
      say 'Pulling in some common stylesheets'
      build :create_common_stylesheets
    end

    def add_common_js_library
      say 'Add coomon javascripts to the standard application.js'
    end

    def add_common_rake_tasks
      say 'Add common rake tasks'
      build :add_common_rake_tasks
    end

    def customize_gemfile
      build :add_custom_gems
      build :add_devise_gem
      build :add_rvmrc_and_powrc
      bundle_command 'install'
    end

    def setup_capistrano
      build :create_capistrano_files
      say 'Setting up capinstrano'
    end

    def setup_database
      say 'Setting up database'

      if 'mysql' == options[:database]
        build :use_mysql_config_template
      end

      build :create_database
    end

    def configure_app
      say 'Configuring app'
      build :setup_devise
      build :build_auto_facebook
      build :build_settings_from_config
      build :build_admin_method_to_user
    end

    def create_initializers
      say 'create_initializers'
      build :create_initializers
    end

    def setup_devise
      build :generate_devise
      build :replace_email_sender_for_devise
    end

    def build_auto_facebook
      build :generate_auto_facebook
    end

    def build_admin_method_to_user
      build :insert_admin_method_to_user
    end

    def customize_error_pages
      say 'Customizing the 500/404/422 pages'
      build :customize_error_pages
    end

    def remove_routes_comment_lines
      build :remove_routes_comment_lines
    end

    def add_common_method_to_application_controller
      build :add_common_method_to_application_controller
    end

    def setup_root_route
      build :setup_root_route
    end

    def setup_git
      say 'Initializing git'
      invoke :setup_gitignore
      invoke :init_git
    end

    def setup_gitignore
      build :gitignore_files
    end

    def init_git
      build :init_git
    end

    protected

    def get_builder_class
      Bootstrappers::AppBuilder
    end

  end
end
