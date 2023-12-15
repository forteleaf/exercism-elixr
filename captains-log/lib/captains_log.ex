defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @spec random_planet_class() :: String.t()
  def random_planet_class() do
    # Please implement the random_planet_class/0 function
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    # Please implement the random_ship_registry_number/0 function
    "NCC-#{Enum.random(1_000..9_999)}"
  end

  @spec random_stardate() :: float
  def random_stardate() do
    # Please implement the random_stardate/0 function
    :rand.uniform() * 1_000 + 41_000
  end

  def format_stardate(stardate) do
    # Please implement the format_stardate/1 function
    :io_lib.format("~.1f", [stardate])
    |> to_string()
  end
end
