module ApplicationHelper
  def full_title(page_title)
    base_title = 'Football Tournament'
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def list_roles
    Role.all
  end
end
