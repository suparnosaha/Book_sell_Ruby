require 'rails_helper'

RSpec.describe "UsersControllers", type: :request do
  it "don't allow user to access all users" do
    user = User.find_by_id(1)
    # session[:current_user] = user
    get '/users'
    expect(response).to have_http_status(:found)
  end

  it "all user to access the homepage" do
    get ''
    expect(response).to have_http_status(200)
  end

  it "all user to create new user in signup" do
    get '/users/new'
    expect(response).to have_http_status(200)
  end

  it "post a new user" do
    post '/users', params: { user: {name:"ds", username: "saa", password: "1234", email:"ss@erf.fg", address:"asdcfg" } }
    expect(response).to have_http_status(:found)
  end

  it "user cannot delete any other user" do
    delete '/users/1'
    expect(response).to_not have_http_status(:success)
  end
end
