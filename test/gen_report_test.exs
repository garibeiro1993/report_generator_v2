defmodule GenReportTest do
  use ExUnit.Case

  alias GenReport
  alias GenReport.Support.ReportFixture

  @file_name "gen_report.csv"

  describe "build/1" do
    test "When passing file name return a report" do
      response = GenReport.build(@file_name)

      assert response == ReportFixture.build()
    end

    test "When no filename was given, returns an error" do
      response = GenReport.build()

      assert response == {:error, "Insira o nome de um arquivo"}
    end
  end

  describe "build_from_many/1" do
    test "When passing filesname return a report" do
      response = GenReport.build_from_many(["report_1.csv", "report_2.csv", "report_3.csv"])

      assert response == ReportFixture.build()
    end

    test "When sent a invalid format file" do
      response = GenReport.build_from_many("report_1.csv")

      assert {:error, "Please provide a list of strings"} = response
    end
  end
end
