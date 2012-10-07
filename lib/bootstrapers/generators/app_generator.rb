require 'rails/generators'
require 'rails/generators/rails/app/app_generator'


module Bootstrapers
  class AppGenerator < Rails::Generators::AppGenerator

    def finish_template
      invoke :bootstrapers_customization
      super
    end

    def bootstrapers_customization
      invoke :remove_files_we_dont_need
      invoke :setup_development_environment
      invoke :create_bootstrapers_views
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

    protected

    def get_builder_class
      Bootstrapers::AppBuilder
    end

  end
end
