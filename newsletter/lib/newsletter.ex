defmodule Newsletter do
  def read_emails(path) do
    # Please implement the read_emails/1 function
    File.read!(path)
    |> String.split()
  end

  def open_log(path) do
    # Please implement the open_log/1 function
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    # Please implement the log_sent_email/2 function
    IO.write(pid, email <> "\n")
  end

  def close_log(pid) do
    # Please implement the close_log/1 function
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    # Please implement the send_newsletter/3 function
    emails = read_emails(emails_path)
    log = open_log(log_path)

    emails
    |> Enum.each(
      &case send_fun.(&1) do
        :ok ->
          log_sent_email(log, &1)

        :error ->
          nil
      end
    )

    close_log(log)
  end

  # def send_newsletter(emails_path, log_path, send_fun) do
  #   # Please implement the send_newsletter/3 function
  #   emails = read_emails(emails_path)
  #   log = open_log(log_path)
  #
  #   emails
  #   |> Enum.each(fn email ->
  #     case send_fun.(email) do
  #       :ok ->
  #         log_sent_email(log, &1)
  #
  #       :error ->
  #         nil
  #     end
  #   end)
  #
  #   close_log(log)
  # end
end
