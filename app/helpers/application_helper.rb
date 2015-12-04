module ApplicationHelper

  def normalize_url  url
    pattern = /https?:\/\//
    if pattern.match url
      url
    else
      "http://#{url}"
    end
  end
end
