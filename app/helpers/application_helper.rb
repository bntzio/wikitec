module ApplicationHelper
  def current_standard(user)
    if current_user
      user.role == 'standard'
    end
  end
end
