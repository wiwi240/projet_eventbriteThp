module ApplicationHelper
  # convert rails flash types to bootstrap alert classes
  def bootstrap_class_for_flash(type)
    case type.to_s
    when 'notice' then 'alert-info'
    when 'success' then 'alert-success'
    when 'error' then 'alert-danger'
    when 'alert' then 'alert-warning'
    else 'alert-secondary'
    end
  end
end
