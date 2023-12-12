defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    files
    |> Enum.map(&file_grep(pattern, match_flags(flags), &1))
    |> List.flatten()
    |> Enum.map(&format_line(&1, format_flags(flags, length(files))))
    |> Enum.uniq()
    |> Enum.join("")
  end

  defp file_grep(pattern, flags, file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(fn {line, index} -> line_grep(pattern, flags, {line, index + 1}) end)
    |> Enum.reject(&is_nil/1)
    |> Enum.map(fn {line, index} -> {line, index, file} end)
  end

  defp line_grep(_pattern, _flags, {"", _index}), do: nil

  defp line_grep(pattern, flags, {line, index}) do
    cond do
      !flags[:v] && line_match?(pattern, line, flags) -> {line, index}
      flags[:v] && !line_match?(pattern, line, flags) -> {line, index}
      true -> nil
    end
  end

  defp line_match?(pattern, line, flags) do
    line = if flags[:i], do: String.downcase(line), else: line
    pattern = if flags[:i], do: String.downcase(pattern), else: pattern
    if flags[:x], do: line == pattern, else: String.contains?(line, pattern)
  end

  defp format_line({line, index, file}, flags) do
    cond do
      flags[:l] -> "#{file}\n"
      flags[:m] && flags[:n] -> "#{file}:#{index}:#{line}\n"
      flags[:m] -> "#{file}:#{line}\n"
      flags[:n] -> "#{index}:#{line}\n"
      true -> "#{line}\n"
    end
  end

  defp match_flags(flags) do
    {switches, _} =
      OptionParser.parse!(flags,
        switches: [i: :boolean, v: :boolean, x: :boolean],
        aliases: [i: :i, v: :v, x: :x]
      )

    switches
  end

  defp format_flags(flags, nb_files) do
    {switches, _} =
      OptionParser.parse!(flags, switches: [n: :boolean, l: :boolean], aliases: [n: :n, l: :l])

    if nb_files > 1, do: switches ++ [m: true], else: switches
  end
end
