# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  @spec start(list()) :: {:ok, pid()}

  @type plot_registration :: %Plot{plot_id: non_neg_integer, registered_to: String.t()}
  def start(opts \\ []) do
    # Please implement the start/1 function
    Agent.start(fn -> [] end, opts)
  end

  # @spec list_registrations(pid()) :: list(plot_registration)
  def list_registrations(pid) do
    # Please implement the list_registrations/1 function
    Agent.get(pid, fn x -> Enum.filter(x, fn y -> y.registered_to != nil end) end)
  end

  @spec register(pid(), String.t()) :: {plot_registration, list(plot_registration)}
  def register(pid, register_to) do
    # Please implement the register/2 function
    Agent.get_and_update(pid, fn x ->
      entry = %Plot{
        plot_id: Map.get(List.first(x, %{}), :plot_id, 0) + 1,
        registered_to: register_to
      }

      new_list = [entry | x]

      {entry, new_list}
    end)
  end

  @spec release(pid(), pos_integer) :: :ok
  def release(pid, plot_id) do
    # Please implement the release/2 function
    Agent.update(
      pid,
      fn x ->
        List.replace_at(
          x,
          Enum.find_index(x, fn x ->
            x.plot_id == plot_id
          end),
          %Plot{plot_id: plot_id, registered_to: nil}
        )
      end
    )

    :ok
  end

  @spec get_registration(pid(), pos_integer) :: plot_registration()
  def get_registration(pid, plot_id) do
    # Please implement the get_registration/2 function
    entry =
      Agent.get(pid, fn x ->
        Enum.find(x, fn y ->
          y.plot_id == plot_id
        end)
      end) || %Plot{plot_id: 0, registered_to: nil}

    case entry.registered_to do
      nil -> {:not_found, "plot is unregistered"}
      _ -> entry
    end
  end
end
