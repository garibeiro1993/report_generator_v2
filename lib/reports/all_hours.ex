defmodule GenReport.AllHours do
  def build(list) do
    list
    |> Enum.reduce(%{}, fn line, list ->
      [name, hours, _day, _month, _year] = line
      Map.put(list, name, (list[name] || 0) + hours)
    end)
  end
end
