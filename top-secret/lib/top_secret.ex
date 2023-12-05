defmodule TopSecret do
  def to_ast(string) do
    # Please implement the to_ast/1 function
    {:ok, res} = Code.string_to_quoted(string)
    res
  end

  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    {name, arity} = get_function_name_and_arity(args)
    msg = String.slice(to_string(name), 0, length(arity))
    {ast, [msg | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    # Please implement the decode_secret_message_part/2 function
    {ast, acc}
  end

  def get_function_name_and_arity(def_args) do
    case def_args do
      [{:when, _, args} | _] -> get_function_name_and_arity(args)
      [{name, _, args} | _] when is_list(args) -> {name, args}
      [{name, _, args} | _] when is_atom(args) -> {name, []}
    end
  end

  def decode_secret_message(string) do
    # Please implement the decode_secret_message/1 function
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("")
  end
end
