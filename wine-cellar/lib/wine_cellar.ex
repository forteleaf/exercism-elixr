defmodule WineCellar do
  def explain_colors do
    # Please implement the explain_colors/0 function
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []) do
    # Please implement the filter/3 function
    year = Keyword.get(opts, :year)
    country = Keyword.get(opts, :country)

    #    IO.inspect("!!!!!!!!!!#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
    #    IO.inspect(opts)

    cellar
    |> Keyword.get_values(color)
    |> filter_by_year(year)
    |> filter_by_country(country)
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year(wines, nil), do: wines
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []
  defp filter_by_country(country, nil), do: country

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
