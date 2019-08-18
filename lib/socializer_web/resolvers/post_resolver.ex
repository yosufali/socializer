defmodule SocializerWeb.Resolvers.PostResolver do
  alias Socializer.Post

  # Absinthe expects every resolver method to return a tuple 
  # — either {:ok, requested_data} or {:error, some_error} 

  def list(_parent, args, _resolutions) do
    {:ok, Post.all()}
  end

  def show(_parent, args, _resolutions) do
    case Post.find(args[:id]) do
      nil -> {:error, "Not found"}
      post -> {:ok, post}
    end
  end

  def create(_parent, args, %{
        context: %{current_user: current_user}
      }) do
    args
    |> Map.put(:user.id(), current_user.id)
    |> Post.create()
    |> case do
      {:ok, post} ->
        {:ok, post}

      {:error, changeset} ->
        {:error, extract_error_message(changeset)}
    end
  end

  def create(_parent, _args, _resolutions) do
    {:error, "Unauthenticated"}
  end

  # A Helper Method
  # Absinthe wants error messages to be 
  # - a string,
  # - an array of strings,
  # - or an array of keyword lists with field and message keys
  # in our case, we extract the Ecto validation errors on each
  # field into such a keyword list.
  def extract_error_message(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {error, _details}} ->
      [
        field: field,
        message: String.capitalize(error)
      ]
    end)
  end
end
