require 'date'

module JqueryDatetimepick
  module FormHelper
    
    include ActionView::Helpers::JavaScriptHelper

    # Mehtod that generates datetimepicker input field inside a form
    def datetimepicker(object_name, method, options = {})
      input_tag =  JqueryDatetimepick::InstanceTag.new(object_name, method, self, options)
      dp_options, tf_options =  input_tag.split_options(options)
      tf_options[:value] = input_tag.format_datetime(tf_options[:value], String.new(dp_options[:dateFormat])) if  tf_options[:value] && !tf_options[:value].empty? && dp_options.has_key?(:dateFormat)
      [ :minDateTime, :maxDateTime ].each do |var|
        if(o = dp_options[var])
          if o.respond_to?(:strftime)
            dp_options[var] = "new Date(#{o.to_i*1000})"
          else
            dp_options[var] = "function() { return #{o}; }"
          end
        end
      end
      json = dp_options.to_json
      json.gsub! /"(new Date\([^\)]*\))"/, '\1'
      json.gsub! /"(function\(\) \{[^\}]*\})"/, '\1'
      html= if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
        input_tag.to_input_field_tag("text", tf_options)
      else
        ActionView::Helpers::Tags::TextField.new(object_name, method, tf_options).render
      end
      html += javascript_tag("jQuery(document).ready(function(){jQuery('##{input_tag.get_name_and_id["id"]}').datetimepicker($.extend(#{json}, $.timepicker.regional[#{I18n.locale}]))});")
      html.html_safe
    end
    
  end

end

module JqueryDatetimepick::FormBuilder
  def datetime_picker(method, options = {})
    @template.datetimepicker(@object_name, method, objectify_options(options))
  end
end

module JqueryDatetimepick_instance
  FORMAT_REPLACEMENTES = { "yy" => "%Y", "mm" => "%m", "dd" => "%d", "d" => "%-d", "m" => "%-m", "y" => "%y", "M" => "%b", "hh" => "%H", "h" => "%I", "mm" => "%M"}
  
  # Extending ActionView::Helpers::InstanceTag module to make Rails build the name and id
  # Just returns the options before generate the HTML in order to use the same id and name (see to_input_field_tag mehtod)
  
  def get_name_and_id(options = {})
    add_default_name_and_id(options)
    options
  end
  
  def available_datetimepicker_options
    [ :altField, :altFormat, :appendText, :autoSize, :alwaysSetTime, :altFieldTimeOnly, :altTimeFormat, :altSeparator, 
      :altTimeSuffix, :addSliderAccess,
      :buttonImage, :buttonImageOnly, :buttonText, 
      :calculateWeek, :changeMonth, :changeYear, :closeText, :constrainInput, :currentText, :controlType, 
      :disabled, :dateFormat, :dayNames, :dayNamesMin, :dayNamesShort, :defaultDate, :duration, :defaultValue,
      :firstDay, 
      :gotoCurrent, 
      :hideIfNoPrevNext, :hourMin, :hourMax, :hourGrid,
      :isRTL, 
      :maxDate, :minDate, :monthNames, :monthNamesShort, :minuteMin, :millisecMin, :microsecMin, :minuteMax, :millisecMax, :microsecMax,
      :minuteGrid, :millisecGrid, :microsecGrid, :minDateTime, :maxDateTime,
      :navigationAsDateFormat, :nextText, :numberOfMonths, 
      :prevText, 
      :selectOtherMonths, :shortYearCutoff, :showAnim, :showButtonPanel, :showCurrentAtPos, 
      :showMonthAfterYear, :showOn, :showOptions, :showOtherMonths, :showWeek, :stepMonths,
      :showHour, :showMinute, :showSecond, :showMilliSecond, :showMicrosec, :showTimewone,
      :showTime,:stepHour, :stepMinute, :stepSecond, :stepMillisec, :stepMicrosec, :secondMin, :secondMax, 
      :secondGrid, :separator, :showTimepicker,
      :timeOnly, :timezonelist,
      :weekHeader, 
      :yearRange, :yearSuffix]
  end
  
  def split_options(options)
    tf_options = options.slice!(*available_datetimepicker_options)
    return options, tf_options
  end
  
  def format_datetime(tb_formatted, format)
    new_format = translate_format(format)
    DateTime.parse(tb_formatted).strftime(new_format)
  end

  # Method that translates the datepicker date formats, defined in (http://docs.jquery.com/UI/Datepicker/formatDate)
  # to the ruby standard format (http://www.ruby-doc.org/core-1.9.3/Time.html#method-i-strftime).
  # This gem is not going to support all the options, just the most used.
  
  def translate_format(format)
    format.gsub!(/#{FORMAT_REPLACEMENTES.keys.join("|")}/) { |match| FORMAT_REPLACEMENTES[match] }
  end
end

if defined?(ActionView::Helpers::InstanceTag) && ActionView::Helpers::InstanceTag.instance_method(:initialize).arity != 0
class JqueryDatetimepick::InstanceTag < ActionView::Helpers::InstanceTag
    include JqueryDatetimepick_instance
  end
else
  class JqueryDatetimepick::InstanceTag < ActionView::Helpers::Tags::Base
    include JqueryDatetimepick_instance
  end
end

