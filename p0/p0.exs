defmodule ACW.P0 do
  def answer(text \\ "input.txt"),
    do:
      read(text)
      |> parse()
      |> assign_scores()
      |> evaluate()
      |> Enum.sum()

  defp evaluate(map) do
    for word <- map.rest do
      if String.contains?(map.haystack, word) do
        {idx, _} = :binary.match(map.haystack, word)

        Enum.at(map.scores, idx)
      else
        -1
      end
    end
  end

  defp score_letters(first) do
    stack_words = String.split(first, "\s", trim: true)
    stack_values = Range.to_list(0..(length(stack_words) - 1))

    Enum.zip(stack_words, stack_values)
    |> Enum.map(fn {k, v} -> List.duplicate(v, String.length(k)) end)
    |> List.flatten()
  end

  defp assign_scores(map) do
    letter_scores = score_letters(map.first)

    Map.put(map, :scores, letter_scores)
  end

  defp parse([first | rest]) do
    %{
      haystack: String.replace(first, "\s", "", trim: true),
      first: first,
      rest: rest
    }
  end

  defp read(text) do
    File.read!(text)
    |> String.split("\n", trim: true)
  end
end

ACW.P0.answer() |> IO.inspect()
