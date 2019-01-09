module BootstrapFlashHelper
  ALERT_TYPES = [:danger, :info, :success, :warning, :notice, :alert, :error] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    begin
      if eval("@#{controller_name.singularize}.errors.size > 0")
        if eval("@#{controller_name.singularize}.errors[:base].present?")
          flash[:error] = eval("@#{controller_name.singularize}.errors[:base]")
        else
          flash[:error] = I18n.t("helpers.links.#{action_name}_error", model: Kernel.const_get(controller_name.singularize.camelize).model_name.human)
        end
      end
    rescue
      #flash[:error] = ""
    end
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      # next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
          class: "alert fade in alert-#{type} #{tag_class}"
      }.merge(options)

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash[:error] = nil
    flash_messages.join("\n").html_safe
  end
end
