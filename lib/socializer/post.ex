defmodule Socializer.Post do
  use Socializer.Model

  alias Socializer.{Repo, Comment, User}

  schema "posts" do
    field :body, :string

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  def all do
    Repo.all(from row in __MODULE__, order_by: [desc: row.id])
  end

  def changeset(post, attr) do
    post
    |> cast(attr, [:body, :user])
    |> validate_required([:body, :user])
    |> foreign_key_constraint(:user_id)
  end
end
