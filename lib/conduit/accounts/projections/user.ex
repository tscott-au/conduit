defmodule Conduit.Accounts.Projectors.User do
  use Commanded.Projections.Ecto, name: "Accounts.Projectors.User"

  alias Conduit.Accounts.Events.UserRegistered
  alias Conduit.Accounts.User

  project %UserRegistered{} = registered do
    Ecto.Multi.insert(multi, :user, %User{
      uuid: registered.uuid,
      username: registered.username,
      email: registered.email,
      hashed_password: registered.hashed_password,
      bio: nil,
      image: nil,
    })
  end
end
