module ApplicationHelper

  def normalize_url  url
    pattern = /https?:\/\//
    if pattern.match url
      url
    else
      "http://#{url}"
    end
  end

  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end

end
