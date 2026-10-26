defmodule Acw.P1 do
  def answer(text \\ "test.txt"),
    do:
      read(text)
      |> parse()

  defp parse(data) do
    data
  end

  defp read(text) do
    Path.join(__DIR__, text)
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
