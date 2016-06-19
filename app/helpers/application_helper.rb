module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "AP-elearning"
    if page_title.empty?
      base_title
    else
      page_title
    end
  end

  # Check current user ís admin or not
  def is_admin?(user)
    if !user
      return false
    end
    if user.username == 'admin'
      return true
    else
      return false
    end
  end

  def is_manager?(user)
    if user.nil?
      return false
    end
    if user.roles.exists?(2)
      return true
    else
      return false
    end
  end

  def is_teacher?(user)
    if user.nil?
      return false
    end
    if user.roles.exists?(2) || user.roles.exists?(1)
      return true
    else
      return false
    end
  end
end
