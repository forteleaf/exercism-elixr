defmodule LogLevel do
  def to_label(level, legacy?) do
    # Please implement the to_label/2 function
    cond do
      level == 0 and legacy? == false -> :trace
      level == 1 == true -> :debug
      level == 2 == true -> :info
      level == 3 == true -> :warning
      level == 4 == true -> :error
      level == 5 and legacy? == false -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    # Please implement the alert_recipient/2 function
    label = to_label(level, legacy?)

    cond do
      label == :error or label == :fatal -> :ops
      label == :unknown and legacy? == true -> :dev1
      label == :unknown and legacy? == false -> :dev2
      true -> false
    end
  end
end
