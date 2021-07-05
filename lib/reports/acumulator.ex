defmodule GenReport.Acumulator do
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

  @years [
    2016,
    2017,
    2018,
    2019,
    2020
  ]

  def report_acc do
    months = Enum.into(@months, %{}, &{&1, 0})
    years = Enum.into(@years, %{}, &{&1, 0})

    %{
      "all_hours" => Enum.into(@list_names, %{}, &{&1, 0}),
      "hours_per_month" => Enum.into(@list_names, %{}, &{&1, months}),
      "hours_per_year" => Enum.into(@list_names, %{}, &{&1, years})
    }
  end
end
