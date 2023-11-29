defmodule LogParser do
  def valid_line?(line) do
    # Please implement the valid_line?/1 function
    line =~ ~r/^\[DEBUG|INFO|WARNING|ERROR\]/
  end

  def split_line(line) do
    # Please implement the split_line/1 function
    Regex.split(~r/<[~\*=-]*>/, line)
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
    Regex.replace(
      ~r/end\-of\-line\d+/i,
      line,
      ""
    )
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
    case Regex.run(~r/User\s*([^\s]{1,})/, line) do
      nil ->
        line

      [_head | tail] ->
        "[USER] #{tail} #{line}"
    end
  end
end
