module ApplicationHelper
  def full_title(page_title)
    base_title = "Bóng đá số "
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end
end
