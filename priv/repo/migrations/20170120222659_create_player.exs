defmodule AnimatedEnigma.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :public_id, :string
      add :name, :string
      add :game_id, :integer, null: false
      add :role, :string

      timestamps()
    end

  end
end
