defmodule ACW.P1 do
  def answer(text \\ "test.txt"),
    do:
      read(text)
      |> parse()

  defp parse(data) do
    data
  end

  defp read(text) do
    File.read!(text)
    |> String.split("\n", trim: true)
  end
end

ACW.P1.answer() |> IO.inspect()
