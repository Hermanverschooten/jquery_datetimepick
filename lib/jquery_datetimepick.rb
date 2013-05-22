require "jquery_datetimepick/version"
require "jquery_datetimepick/datetimepick_helper"
require "jquery_datetimepick/form_helper"

module JqueryDatetimepick
  class Engine < ::Rails::Engine
  end
  class Railtie < Rails::Railtie
    initializer "JqueryDatetimepick" do
      ActionController::Base.helper(JqueryDatetimepick::DatepickHelper)
      ActionView::Helpers::FormHelper.send(:include, JqueryDatetimepick::FormHelper)
      ActionView::Base.send(:include, JqueryDatepick::DatetimepickHelper)
      ActionView::Helpers::FormBuilder.send(:include,JqueryDatetimepick::FormBuilder)
    end
  end
end
