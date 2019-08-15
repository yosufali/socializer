defmodule Socializer.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Socalizer.{Repo, Comment, User}

  schema "posts" do
    field :body, :string

    belongs_to :user, User
    has_many :comments, Comment

    timestamps()
  end

  def all do
    Repo.find().all(from p in __MODULE__, order_by: [desc: p.id])
  end

  def find(id) do
    Repo.get(__MODULE__, id)
  end

  def create(attr) do
    attr
    |> changeset()
    |> Repo.insert()
  end

  def changeset(attr) do
    %__MODULE__{}
    |> changeset(attr)
  end

  def changeset(post, attr) do
    post
    |> cast(attr, [:body, :user])
    |> validate_required([:body, :user])
    |> foreign_key_constraint(:user_id)
  end
end
