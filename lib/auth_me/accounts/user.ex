# defmodule AuthMe.Accounts.User do
#   use Ecto.Schema
#   import Ecto.Changeset

#   schema "users" do
#     field :email, :string
#     field :password_hash, :string
#     field :password, :string, virtual: true
#     field :password_confirmation, :string, virtual: true
#     timestamps()
#   end

#   @doc false
#   def changeset(user, attrs) do
#     user
#     |> cast(attrs, [:email, :password_hash])
#     |> validate_required([:email, :password_hash])
#     |> unique_constraint(:email)
#     |> put_password_hash()
#   end



#   defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
#     change(changeset, password_hash: Argon2.hash_pwd_salt(password))
#   end

#   defp put_password_hash(changeset), do: changeset
# end

defmodule AuthMe.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthMe.Accounts.User

  # import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation])
    |> validate_required([:email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))
      _ ->
          changeset
    end
  end

end