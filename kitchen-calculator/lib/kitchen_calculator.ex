defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) do
    # Please implement the to_milliliter/1 functions
    unit = elem(volume_pair, 0)

    cond do
      unit == :cup -> {:milliliter, 240 * get_volume(volume_pair)}
      unit == :fluid_ounce -> {:milliliter, 30 * get_volume(volume_pair)}
      unit == :teaspoon -> {:milliliter, 5 * get_volume(volume_pair)}
      unit == :tablespoon -> {:milliliter, 15 * get_volume(volume_pair)}
      unit == :milliliter -> {:milliliter, get_volume(volume_pair)}
    end
  end

  def from_milliliter(volume_pair, unit) do
    # Please implement the from_milliliter/2 functions
    ml = elem(volume_pair, 1)

    cond do
      unit == :cup -> {unit, ml / 240}
      unit == :fluid_ounce -> {unit, ml / 30}
      unit == :teaspoon -> {unit, ml / 5}
      unit == :tablespoon -> {unit, ml / 15}
      unit == :milliliter -> {unit, ml}
    end
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    volume_pair
    |> to_milliliter
    |> from_milliliter(unit)
  end
end
