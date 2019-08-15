defmodule SocializerWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)

  import_types(SocializerWeb.Schema.PostTypes)

  query do
    import_types(:post_queries)
  end

  mutations do
    import_types(:post_mutations)
  end

  subscriptions do
    import_types(:post_subscriptions)
  end
end
