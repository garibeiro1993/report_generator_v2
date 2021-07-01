defmodule GenReport.HoursPerYear do
  @list_names [
    "daniele",
    "mayk",
    "giuliano",
    "cleiton",
    "jakeliny",
    "joseph",
    "diego",
    "danilo",
    "rafael",
    "vinicius"
  ]

  @years [
    2016,
    2017,
    2018,
    2019,
    2020
  ]

  def build(list) do
    list
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp sum_values([name, hours, _day, _month, years], %{} = report) do
    frellas =
      Map.put(
        report[name],
        years,
        report[name][years] + hours
      )

    %{report | name => frellas}
  end

  defp report_acc do
    years = Enum.into(@years, %{}, &{&1, 0})
    Enum.into(@list_names, %{}, &{&1, years})
  end
end
