module SessionsHelper

  def current_user?(user)
    user == current_user
  end

  def current_circle?(circle)
    circle == current_circle
  end

end