defmodule Archive.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Archive.Repo

  alias Archive.Accounts.User
  alias Archive.Accounts.Credential
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Archive.Accounts.Credential

  @doc """
  Returns the list of credentials.

  ## Examples

      iex> list_credentials()
      [%Credential{}, ...]

  """
  def list_credentials do
    Repo.all(Credential)
  end

  @doc """
  Gets a single credential.

  Raises `Ecto.NoResultsError` if the Credential does not exist.

  ## Examples

      iex> get_credential!(123)
      %Credential{}

      iex> get_credential!(456)
      ** (Ecto.NoResultsError)

  """
  def get_credential!(id), do: Repo.get!(Credential, id)

  @doc """
  Creates a credential.

  ## Examples

      iex> create_credential(%{field: value})
      {:ok, %Credential{}}

      iex> create_credential(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_credential(attrs \\ %{}) do
    %Credential{}
    |> Credential.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a credential.

  ## Examples

      iex> update_credential(credential, %{field: new_value})
      {:ok, %Credential{}}

      iex> update_credential(credential, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_credential(%Credential{} = credential, attrs) do
    credential
    |> Credential.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Credential.

  ## Examples

      iex> delete_credential(credential)
      {:ok, %Credential{}}

      iex> delete_credential(credential)
      {:error, %Ecto.Changeset{}}

  """
  def delete_credential(%Credential{} = credential) do
    Repo.delete(credential)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking credential changes.

  ## Examples

      iex> change_credential(credential)
      %Ecto.Changeset{source: %Credential{}}

  """
  def change_credential(%Credential{} = credential) do
    Credential.changeset(credential, %{})
  end



  def get_auth_by_email_and_password(nil, _password), do: {:error, :invalid}
  def get_auth_by_email_and_password(_email, nil), do: {:error, :invalid}

  def get_auth_by_email_and_password(email, password) do
    with %Credential{} = auth <-
           Repo.get_by(Credential, email: String.downcase(email)),
         true <- Comeonin.Bcrypt.checkpw(password, auth.hashed_password) do
      {:ok, auth}
    else
      _ ->
        # Help to mitigate timing attacks
        Comeonin.Bcrypt.dummy_checkpw()
        {:error, :unauthorised}
    end
  end

  def authentificate_by_oauth2(%Ueberauth.Auth{provider: provider, uid: uid} = auth) do
    provider = Atom.to_string(provider)

    auth =
    Credential
      |> Repo.get_by(provider: provider, uid: cast_uid(uid))
      |> Repo.preload(:partner)

    case auth do
      nil -> create_oauth2(auth)
      auth -> {:ok, auth}
    end
  end

  def authenticate_by_email_and_password(email, password) do
    auth =
      Credential
      |> Repo.get_by(email: email)
      |> Repo.preload(:user)

    cond do
      auth && auth.user && auth.password_hash && checkpw(password, auth.password_hash) ->
        {:ok, auth}

      auth ->
        {:error, :unauthorized}

      true ->
        dummy_checkpw()
        {:error, :not_found}
    end
  end

  defp cast_uid(uid) when is_integer(uid) do
    Integer.to_string(uid)
  end

  defp cast_uid(uid) when is_binary(uid) do
    uid
  end

  defp create_oauth2(%Ueberauth.Auth{provider: provider, uid: uid, info: info} = attrs) do
    user_attrs = extract_user_attrs(attrs)

    auth_attrs = %{
      is_new?: true,
      provider: Atom.to_string(provider),
      uid: cast_uid(uid),
      email: info.email || uid,
      partner: user_attrs
    }

    %Credential{}
    |> Credential.oauth2_changeset(auth_attrs)
    |> Repo.insert()
  end

  defp extract_user_attrs(%{info: info}) do
    # todo we need to search to see if a partner already exists before creating a new one
    # not done now to move on to more functionality
    %{}
    |> Map.put(:name, info.name || "#{info.first_name} #{info.last_name}")
  end

  def create_identity(attrs) do
    user_changeset = User.changeset(%User{}, attrs)
    if user_changeset.valid? do
      do_create_identity(attrs)
    else
      user_changeset =  %Ecto.Changeset{user_changeset | action: :insert}
      {:error, user_changeset}
    end
  end

  defp do_create_identity(attrs) do
    auth_attrs = %{
      is_new?: true,
      provider: nil,
      email: attrs["email"],
      user: attrs,
      password: attrs["password"],
      password_confirmation: attrs["password_confirmation"]
    }

    %Credential{}
    |> Credential.identity_changeset(auth_attrs)
    |> Repo.insert()
  end

  def sign_in(conn, user) do
    IO.puts "Accounts.sign_in"
    IO.inspect user
    ArchiveWeb.AuthenticationController.sign_in(conn, user)
  end

  def sign_out(conn) do
    ArchiveWeb.AuthController.delete(conn)
  end

end
