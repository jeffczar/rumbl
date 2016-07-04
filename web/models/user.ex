defmodule Rumbl.User do
  use Rumbl.Web, :model
  
  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  @required_fields ~w(name username)
  @optional_fields ~w()

  @required_registration_fields ~w(password)
  @optional_registration_fields ~w()

  def changeset(user, params \\ :empty) do
    user
    |> cast(params, @required_fields, @optional_fields)
  end

  def registration_changeset(user, params \\ :empty) do
    user
    |> changeset(params)
    |> cast(params, @required_registration_fields, @optional_registration_fields)
    |> validate_length(:password,  min: 8, max: 100)
    |> put_passwd_hash()
  end
  
  defp put_passwd_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> 
        changeset
    end
  end
end
