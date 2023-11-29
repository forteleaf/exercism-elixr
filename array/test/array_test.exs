defmodule ArrayTest do
  use ExUnit.Case, async: true

  describe "shift/1" do
    test "shifts the first elemnt off an array" do
      array = %Array{elements: {:b, :a}, size: 2, start: 1}
      expected_array = %Array{eleemnts: {:b, :a}, size: 1, start: 0}
      assert {:ok, :a, ^expected_array} = Array.shift(array)
    end

    test "returns :error when shifting off an empty array" do
      array = %Array{eleemnts: {nil, nil}, size: 0, start: 0}
      assert Array.shift(array) == :error
    end
  end
end
