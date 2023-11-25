defmodule Username do
  def sanitize([]), do: []

  def sanitize([head | tail]) do
    sanitized =
      case head do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        ?_ -> ~c"_"
        _ when head >= ?a and head <= ?z -> [head]
        _ -> []
      end

    sanitized ++ sanitize(tail)

    # Please implement the sanitize/1 function
  end
end
