defmodule Chessboard do
  def rank_range do
    # Please implement the rank_range/0 function
    1..8
  end

  def file_range do
    # Please implement the file_range/0 function
    ?A..?H
  end

  def ranks do
    # Please implement the ranks/0 function
    Enum.to_list(rank_range())
  end

  def files do
    # Please implement the files/0 function
    file_range()
    |> Enum.to_list()
    |> Enum.map(&<<&1>>)
  end
end
