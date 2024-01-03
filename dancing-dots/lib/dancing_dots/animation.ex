defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_opts) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  alias DancingDots.Dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) when rem(frame_number, 4) === 0 do
    %Dot{dot | opacity: dot.opacity / 2}
  end

  def handle_frame(dot, _frame_number, _opts), do: dot
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  alias DancingDots.Dot

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)

    cond do
      is_integer(velocity) ->
        {:ok, opts}

      true ->
        {:error,
         "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    velocity = Keyword.get(opts, :velocity)
    %Dot{dot | radius: dot.radius + (frame_number - 1) * velocity}
  end
end
