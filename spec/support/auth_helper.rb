module AuthHelper
  
  def sign_in user
    request.session[:id] = user.id
  end

  def current_user
    User.find(request.session[:id])
  end
end
