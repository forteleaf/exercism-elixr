defmodule TakeANumber do
  def start() do
    # Please implement the start/0 function
    spawn(fn -> loop() end)
  end

  def loop(s \\ 0) do
    receive do
      :stop ->
        exit(:normal)

      {:report_state, sender_pid} ->
        send(sender_pid, s)
        loop(s)

      {:take_a_number, sender_pid} ->
        send(sender_pid, s + 1)
        loop(s + 1)

      _ ->
        loop(s)
    end
  end
end
