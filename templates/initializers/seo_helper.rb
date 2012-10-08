# -*- encoding : utf-8 -*-
SeoHelper.configure do |config|
  config.skip_blank               = false
  config.site_name = Setting.app_name
  config.default_page_description = "PAGE_DESSCRIPTION"
  config.default_page_keywords    = "PAGE_KEYWORDS"
  config.default_page_image = Setting.domain + Setting.default_logo_url
  config.site_name_formatter  = lambda { |title, site_name|   "#{title} « #{site_name}".html_safe }
  config.pagination_formatter = lambda { |title, page_number| "#{title} - Page No.#{page_number}" }

end
