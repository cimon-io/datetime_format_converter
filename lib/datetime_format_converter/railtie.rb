module DatetimeFormatConverter
  module Railtie < Rails::Railtie
    initializer "datetime_format_converter.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
