defmodule GenReport.HoursPerMonth do
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

  @months [
    "abril",
    "dezembro",
    "fevereiro",
    "junho",
    "julho",
    "março",
    "maio",
    "setembro",
    "agosto",
    "outubro",
    "novembro",
    "janeiro"
  ]

  def build(list) do
    list
    |> Enum.reduce(report_acc(), fn line, report ->
      sum_values(line, report)
    end)
  end

  defp sum_values([name, hours, _day, months, _year], %{} = report) do
    frellas =
      Map.put(
        report[name],
        months,
        report[name][months] + hours
      )

    %{report | name => frellas}
  end

  defp report_acc do
    months = Enum.into(@months, %{}, &{&1, 0})
    Enum.into(@list_names, %{}, &{&1, months})
  end
end
