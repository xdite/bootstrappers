require 'rails/generators'
require 'rails/generators/rails/app/app_generator'


module Bootstrapers
  class AppGenerator < Rails::Generators::AppGenerator

    class_option :database, :type => :string, :aliases => '-d', :default => 'mysql',
      :desc => "Preconfigure for selected database (options: #{DATABASES.join('/')})"

    def finish_template
      invoke :bootstrapers_customization
      super
    end

    def bootstrapers_customization
      invoke :remove_files_we_dont_need
      invoke :setup_development_environment
      invoke :create_bootstrapers_views
      invoke :create_common_javascripts
      invoke :add_jquery_ui
      invoke :customize_gemfile
      invoke :setup_database
      #invoke :configure_app
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

    def create_bootstrapers_views
      say 'Creating bootstrapers views'
      build :create_partials_directory
      build :create_application_layout
    end

    def create_common_javascripts
      say 'Pulling in some common javascripts'
      build :create_common_javascripts
    end

    def add_jquery_ui
      say 'Add jQuery ui to the standard application.js'
      build :add_jquery_ui
    end

    def customize_gemfile
      build :add_custom_gems
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
      build :build_settings_from_config
      # TODO
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
      Bootstrapers::AppBuilder
    end

  end
end
