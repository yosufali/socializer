defmodule Socializer.Factory do
  use ExMachina.Ecto, repo: Socializer.Repo

  def user_factory do
    %Socializer.User{
      name: Faker.Name.name(),
      email: Faker.Internet.email(),
      password: "password",
      password_hash: Bcrypt.hash_pwd_salt("password")
    }
  end

  def post_factory do
    %Socializer.Post{
      body: Faker.Lorem.paragraph(),
      user: build(:user)
    }
  end

  # ...factories for other models
end
