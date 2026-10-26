defmodule Acw.P2 do
  def answer(text \\ "test.txt") do
    read(text)
  end


  defp read(text) do
    Path.join(__DIR__, text)
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
