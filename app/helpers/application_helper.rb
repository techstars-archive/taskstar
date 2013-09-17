module ApplicationHelper
  def form_errors_for(obj, attr)
    unless obj.errors[attr].empty?
      content_tag :small, obj.errors.get(attr).join(", "), class: "error"
    end
  end
end
