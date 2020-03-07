class ApplicationController < ActionController::Base

  # 新規登録時(sign_up時)にemailというキーのパラメーターを追加で許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  # ログイン後に遷移するpathを設定
  def after_sign_in_path_for(resource)
      user_path(current_user.id)
  end

  # ログアウト後に遷移するpathを設定
  def after_sign_out_path_for(resource)
      root_path
  end


  def user_params
  	  params.require(:user).permit(:name, :email)
  end

  # 新規登録時(sign_up時)にemailというキーのパラメーターを追加で許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end


end
