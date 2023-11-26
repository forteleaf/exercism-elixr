defmodule NameBadge do
  # @spec(id :: integer(), name :: String.t(), department :: String.t())
  def print(id, name, department) do
    # Please implement the print/3 function
    department = if department, do: department, else: "owner"
    department = String.upcase(department)

    if id == nil,
      do: "#{name} - #{department}",
      else: "[#{id}] - #{name} - #{department}"
  end
end
