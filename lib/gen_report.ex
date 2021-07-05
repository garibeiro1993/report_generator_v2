defmodule GenReport do
  alias GenReport.Acumulator
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

  def build_from_many(filenames) when not is_list(filenames) do
    {:error, "Please provide a list of strings"}
  end

  def build_from_many(filenames) do
    filenames
    |> Task.async_stream(&build/1)
    |> Enum.reduce(Acumulator.report_acc(), fn {:ok, result}, report ->
      sum_reports(report, result)
    end)
  end

  def sum_reports(
        %{
          "all_hours" => all_hours1,
          "hours_per_month" => hours_per_month1,
          "hours_per_year" => hours_per_year1
        },
        %{
          "all_hours" => all_hours2,
          "hours_per_month" => hours_per_month2,
          "hours_per_year" => hours_per_year2
        }
      ) do
    all_hours = merge_maps(all_hours1, all_hours2)
    hours_per_month = merge_nested_maps(hours_per_month1, hours_per_month2)
    hours_per_year = merge_nested_maps(hours_per_year1, hours_per_year2)

    %{
      "all_hours" => all_hours,
      "hours_per_month" => hours_per_month,
      "hours_per_year" => hours_per_year
    }
  end

  defp merge_nested_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 ->
      merge_maps(value1, value2)
    end)
  end

  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, value1, value2 -> value1 + value2 end)
  end

  defp build_report(report) do
    %{
      "all_hours" => AllHours.build(report),
      "hours_per_month" => HoursPerMonth.build(report),
      "hours_per_year" => HoursPerYear.build(report)
    }
  end

  # def sum_reports() do
  #   all_hours = Enum.
  #   %{
  #     "all_hours" => %{
  #       "cleiton" => 704
  #     },
  #     "hours_per_month" => %{
  #       "cleiton" => %{
  #         "abril" => 21
  #       }
  #     },
  #     "hours_per_year" => %{
  #       "cleiton" => %{
  #         2016 => 87
  #       }
  #     }
  #   }

  #   all_hours =
  # end
end
