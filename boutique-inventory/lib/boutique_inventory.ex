defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    # Please implement the sort_by_price/1 function
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    # Please implement the with_missing_price/1 function
    inventory
    |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    # Please implement the update_names/3 function
    inventory
    |> Enum.map(fn item -> %{item | name: String.replace(item.name, old_word, new_word)} end)
  end

  def increase_quantity(item, count) do
    # Please implement the increase_quantity/2 function
    quantities =
      Map.new(item.quantity_by_size, fn {size, quantity} -> {size, quantity + count} end)

    %{item | quantity_by_size: quantities}
  end

  def total_quantity(item) do
    # Please implement the total_quantity/1 function
    Enum.reduce(item.quantity_by_size, 0, fn {_k, c}, acc -> acc + c end)
  end
end
