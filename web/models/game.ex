defmodule AnimatedEnigma.Game do
  use AnimatedEnigma.Web, :model

  @derive {Poison.Encoder, only: [:public_id]}

  alias AnimatedEnigma.Repo
  import Ecto.Query

  schema "games" do
    field :public_id, :string

    has_many :players, AnimatedEnigma.Player

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:public_id])
    |> validate_required([:public_id])
  end

  def find_or_create(params) do
    query = from g in __MODULE__, where: g.public_id == ^params.public_id

    case Repo.one(query) do
      nil -> changeset(%__MODULE__{}, params) |> Repo.insert!
      game -> game
    end
  end
end
