defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    # Please implement the extract_from_path/2 function
    keys = String.split(path, ".")

    find_value(data, keys)
  end

  def find_value(data, []), do: data

  def find_value(data, [head | tail]) do
    find_value(data[head], tail)
  end

  def get_in_path(data, path) do
    # Please implement the get_in_path/2 function
    data
    |> Kernel.get_in(String.split(path, "."))
  end
end
