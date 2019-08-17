defmodule Socializer.Model do
  alias Socializer.Repo

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import Ecto.Query

      def find(id) do
        Repo.get(__MODULE__, id)
      end

      def find_by(conds) do
        Repo.get_by(__MODULE__, conds)
      end

      def create(attr) do
        attr
        |> changeset()
        |> Repo.insert()
      end

      def changeset(attr) do
        __MODULE__.__struct__()
        |> changeset(attr)
      end
    end
  end
end
