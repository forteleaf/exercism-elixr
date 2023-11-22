defmodule BirdCount do
  def today([]), do: nil

  def today([head | _]) do
    # Please implement the today/1 function
    head
  end

  def increment_day_count([]), do: [1]

  def increment_day_count([head | tail]) do
    # Please implement the increment_day_count/1 function
    [head + 1 | tail]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true

  def has_day_without_birds?([_head | tail]) do
    # Please implement the has_day_without_birds?/1 function
    has_day_without_birds?(tail)
  end

  def total([]), do: 0

  def total([h | t]) do
    # Please implement the total/1 function
    h + total(t)
  end

  def busy_days([]), do: 0

  def busy_days([h | t]) when h >= 5 do
    # Please implement the busy_days/1 function
    1 + busy_days(t)
  end

  def busy_days([_ | t]), do: busy_days(t)
end
