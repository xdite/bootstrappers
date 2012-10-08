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
      invoke :customize_gemfile
      invoke :setup_database
      invoke :configure_app
      invoke :create_initializers
      invoke :setup_stylesheets
      invoke :remove_routes_comment_lines
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
      say 'Add add_common_js_library to the standard application.js'
      build :add_jquery_ui
      build :add_bootstrap_js
    end



    def customize_gemfile
      build :add_custom_gems
      build :add_devise_gem
      bundle_command 'install'
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
      build :build_settings_from_config

    end

    def create_initializers
      say 'create_initializers'
      build :create_initializers
    end

    def setup_devise
      build :generate_devise
    end


    def customize_error_pages
      say 'Customizing the 500/404/422 pages'
      build :customize_error_pages
    end


    def setup_stylesheets
      say 'Set up stylesheets'
      build :setup_stylesheets
    end

    def remove_routes_comment_lines
      build :remove_routes_comment_lines
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
