require 'rails/generators'
require 'rails/generators/rails/app/app_generator'


module Bootstrapers
  class AppGenerator < Rails::Generators::AppGenerator
    
    def finish_template
      invoke :bootstrapers_customization
      super
    end

    def bootstrapers_customization
    end
    
  end
end
