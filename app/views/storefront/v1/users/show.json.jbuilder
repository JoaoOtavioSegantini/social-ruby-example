json.user do
  json.(@user, :id, :name, :email, :profile)
  json.avatar @user.avatar.url
end