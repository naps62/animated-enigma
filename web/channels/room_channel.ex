defmodule AnimatedEnigma.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", message, socket) do
    {:ok, %{value: 0}, socket}
  end

  def handle_in("inc", %{"value" => value}, socket) do
    broadcast! socket, "new_value", %{value: value + 1}
    {:noreply, socket}
  end
end
