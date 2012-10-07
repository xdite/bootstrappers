# -*- encoding : utf-8 -*-
class Setting < Settingslogic
  source "#{Rails.root}/config/config.yml"
  namespace Rails.env
end
