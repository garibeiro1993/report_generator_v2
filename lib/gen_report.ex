defmodule GenReport do
  alias GenReport.AllHours
  alias GenReport.HoursPerMonth
  alias GenReport.HoursPerYear
  alias GenReport.Parser

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> build_report()
  end

  def build(), do: {:error, "Insira o nome de um arquivo"}

  defp build_report(report) do
    %{
      "all_hours" => AllHours.build(report),
      "hours_per_month" => HoursPerMonth.build(report),
      "hours_per_year" => HoursPerYear.build(report)
    }
  end
end
