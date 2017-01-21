defmodule AnimatedEnigma.Player do
  use AnimatedEnigma.Web, :model

  @derive {Poison.Encoder, only: [:public_id, :name, :role, :game_id]}

  alias AnimatedEnigma.Game
  alias AnimatedEnigma.Repo
  import Ecto.Query

  schema "players" do
    field :public_id, :string
    field :name, :string
    field :role, :string

    belongs_to :game, Game

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :game_id, :public_id])
    |> validate_required([:game_id, :public_id])
    |> validate_only_4_players
  end

  def find_or_create(params) do
    query = from p in __MODULE__, where: p.public_id == ^params.public_id and p.game_id == ^params.game_id

    case Repo.one(query) do
      nil -> changeset(%__MODULE__{}, params) |> Repo.insert
      player -> player
    end
  end

  def validate_only_4_players(changeset) do
    game_id = changeset |> get_field(:game_id)

    query = __MODULE__ |> where(game_id: ^game_id)

    player_count = Repo.aggregate(query, :count, :id)

    if player_count == 4 do
      add_error(changeset, :game, "Game is full")
    else
      changeset
    end
  end
end
