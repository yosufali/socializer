defmodule SocializerWeb.PostSubscriptionsTest do
  use SocializerWeb.SubscriptionCase

  describe "Post subscription" do
    it "updates on new post", %{socket: socket} do
      # Query to establish the subscription.
      subscription_query = """
        subscription {
          postCreated {
            id
            body
          }
        }
      """

      # Push the query onto the socket.
      ref = push_doc(socket, subscription_query)

      # Assert that the subscription was successfully created.
      assert_reply(ref, :ok, %{subscriptionId: _subscription_id})

      # Query to create a new post to invoke the subscription.
      create_post_mutation = """
        mutation CreatePost {
          createPost(body: "Big discussion") {
            id
            body
          }
        }
      """

      # Push the mutation onto the socket.
      ref =
        push_doc(
          socket,
          create_post_mutation
        )

      # Assert that the mutation successfully created the post.
      assert_reply(ref, :ok, reply)
      data = reply.data["createPost"]
      assert data["body"] == "Big discussion"

      # Assert that the subscription notified us of the new post.
      assert_push("subscription:data", push)
      data = push.result.data["postCreated"]
      assert data["body"] == "Big discussion"
    end
  end
end
