defmodule SocializerWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)

  import_types(SocializerWeb.Schema.PostTypes)
  import_types(SocializerWeb.Schema.UserTypes)
  import_types(SocializerWeb.Schema.ConversationTypes)
  import_types(SocializerWeb.Schema.MessageTypes)

  query do
    import_types(:post_queries)
    import_types(:user_queries)
    import_types(:conversation_queries)
    import_types(:message_queries)
    import_types(:comment_queries)
  end

  mutations do
    import_types(:post_mutations)
    import_types(:user_mutations)
    import_types(:conversation_mutations)
    import_types(:message_mutations)
    import_types(:comment_mutations)
  end

  subscriptions do
    import_types(:post_subscriptions)
    import_types(:conversation_subscriptions)
    import_types(:message_subscriptions)
    import_types(:comment_subscriptions)
  end
end
