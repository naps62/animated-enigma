defmodule AnimatedEnigma.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :public_id, :string

      timestamps()
    end
  end
end
