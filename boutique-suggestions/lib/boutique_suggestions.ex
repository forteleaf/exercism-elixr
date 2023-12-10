defmodule BoutiqueSuggestions do
  @default_options [maximum_price: 100.00]
  def get_combinations(tops, bottoms, options \\ []) do
    # Please implement the get_combinations/3 function
    options = Keyword.merge(@default_options, options)

    for x <- tops,
        y <- bottoms,
        x[:base_color] != y[:base_color] &&
          x[:price] + y[:price] < options[:maximum_price] do
      {x, y}
    end
  end
end
