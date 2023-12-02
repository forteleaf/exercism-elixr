defmodule LibraryFees do
  @spec datetime_from_string(string :: String.t()) :: NaiveDateTime
  def datetime_from_string(string) do
    # Please implement the datetime_from_string/1 function
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    # Please implement the before_noon?/1 function
    datetime
    |> NaiveDateTime.to_time()
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    # Please implement the return_date/1 function
    days = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.add(days * 24 * 60 * 60)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    # Please implement the days_late/2 function
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    # Please implement the monday?/1 function
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    # Please implement the calculate_late_fee/3 function
    return_datetime = datetime_from_string(return)

    days_late =
      checkout
      |> datetime_from_string()
      |> return_date()
      |> days_late(return_datetime)

    fee = rate * days_late
    if monday?(return_datetime), do: div(fee, 2), else: fee
  end
end
