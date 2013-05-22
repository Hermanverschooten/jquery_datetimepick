require 'jquery_datetimepick/form_helper'

module JqueryDatetimepick
  module DatetimepickHelper

    include JqueryDatetimepick::FormHelper

    def datetime_picker_input(object_name, method, options = {})
      datetimepicker(object_name, method, options, true)
    end
  end
end