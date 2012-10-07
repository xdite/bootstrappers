module Bootstrapers
  class AppBuilder < Rails::AppBuilder

    include Bootstrapers::Actions

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
    end

    def create_application_layout
      template 'bootstrapers_layout.html.erb.erb',
        'app/views/layouts/application.html.erb',
        :force => true
    end

    def create_common_javascripts
      directory 'javascripts', 'app/assets/javascripts'
    end

    def add_jquery_ui
      inject_into_file 'app/assets/javascripts/application.js',
        "//= require jquery-ui\n", :before => '//= require_tree .'
    end

    def add_custom_gems
      additions_path = find_in_source_paths 'Gemfile_additions'
      new_gems = File.open(additions_path).read
      inject_into_file 'Gemfile', "\n#{new_gems}",
      :after => /gem 'jquery-rails'/
    end

    def use_mysql_config_template
      template 'mysql_database.yml.erb', 'config/database.yml',
        :force => true
    end

    def create_database
      bundle_command 'exec rake db:create'
    end

  end
end
