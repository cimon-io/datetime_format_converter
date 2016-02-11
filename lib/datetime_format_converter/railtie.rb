require 'datetime_format_converter/view_helpers'

module DatetimeFormatConverter
  class Railtie < Rails::Railtie
    initializer "datetime_format_converter.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
