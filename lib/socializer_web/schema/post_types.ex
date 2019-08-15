defmodule SocializerWeb.Schema.PostTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Socializer.Repo

  alias SocializerWeb.Resolvers

  @desc "A post on the site"
  object :post do
    field :id, :id
    field :body, :string
    field :inserted_at, :naive_datetime

    field :user, :user, resolve: assoc(:user)

    field :comments, list_of(:comment) do
      resolve(
        assoc(:comments, fn comments_query, _args, _context ->
          comments_query |> order_by(desc: :id)
        end)
      )
    end
  end

  object :post_queries do
    @desc "Get all posts"
    field :posts, list_of(:post) do
      resolve(&Resolvers.PostResolver.list/3)
    end

    @des "Get a specific post"
    field :post, :post do
      resolve(&Resolvers.PostResolver.show/3)
    end
  end

  object :post_mutations do
    @desc "Create a post"
    field :create_post, :post do
      arg(:body, non_null(:string))
    end
  end

  object :post_subscriptions do
    field :posted_created, :post do
      # config is used to setup the subscription
      config(fn _, _ ->
        {:ok, topic: "posts"}
      end)

      # trigger tells absinthe which mutation should invoke the subscription
      trigger(:create_post,
        topic: fn _ ->
          "posts"
        end
      )
    end
  end
end
