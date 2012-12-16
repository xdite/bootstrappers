module Bootstrappers
  module LayoutActions

    def readme
      template 'README.md.erb', 'README.md'
    end

    def remove_public_index
      remove_file 'public/index.html'
    end

    def remove_rails_logo_image
      remove_file 'app/assets/images/rails.png'
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
      remove_file 'app/assets/javascripts/application.js'
      directory 'javascripts', 'app/assets/javascripts'
    end

    def create_common_stylesheets
      remove_file 'app/assets/stylesheets/application.css'
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


    def setup_stylesheets
      copy_file 'app/assets/stylesheets/application.css', 'app/assets/stylesheets/application.css.scss'
      remove_file 'app/assets/stylesheets/application.css'
      concat_file 'import_scss_styles', 'app/assets/stylesheets/application.css.scss'
    end

    def setup_root_route
      template 'welcome.html.erb', 'app/views/pages/welcome.html.erb',:force => true
      route "root :to => 'high_voltage/pages#show', :id => 'welcome'"
    end


    def customize_error_pages
      meta_tags =<<-EOS
      <meta charset='utf-8' />
      <meta name='ROBOTS' content='NOODP' />
      EOS
      style_tags =<<-EOS
      <link href='/assets/application.css' media='all' rel='stylesheet' type='text/css' />
      EOS
      %w(500 404 422).each do |page|
        inject_into_file "public/#{page}.html", meta_tags, :after => "<head>\n"
        replace_in_file "public/#{page}.html", /<style.+>.+<\/style>/mi, style_tags.strip
        replace_in_file "public/#{page}.html", /<!--.+-->\n/, ''
      end
    end

  end
end
