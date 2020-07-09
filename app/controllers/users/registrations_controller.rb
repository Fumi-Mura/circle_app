class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: %i[update, destroy]

  def check_guest
    if resource.email == 'guestuser@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません。'
    end
  end

end
