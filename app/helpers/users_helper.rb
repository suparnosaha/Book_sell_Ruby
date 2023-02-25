module UsersHelper
  def find_user_name(id)
    @user = User.find(id)
    @user.name
  end
end
