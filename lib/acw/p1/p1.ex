defmodule Acw.P1 do
  def answer(text \\ "input.txt"),
    do:
      read(text)
      |> Enum.map(&stage_one(&1))
      |> Enum.map(&stage_two(&1))
      |> Enum.with_index(1)
      |> Enum.map(fn {line, index} -> calculate_total(index, line) end)
      |> Enum.sum()

  defp calculate_total(index, data) do
    # IO.inspect(index, label: :index)
    # IO.inspect(data.line, label: :line)
    index * String.length(data.line)
  end

  def stage_two(line) do
    alphabet = Range.new(97, 122) |> Enum.map(fn n -> <<n::utf8>> end)

    groups =
      Regex.scan(~r/[[:alpha:]]\d+/, line)
      |> List.flatten()
      |> Enum.frequencies()
      |> Enum.sort_by(&most_savings(&1), :desc)
      |> Enum.filter(fn {group, count} ->
        (String.length(group) - 1) * count - String.length(group) > 0
      end)
      |> Enum.take(26)

    data = %{
      alphas: alphabet,
      line: line
    }

    result = Enum.reduce(groups, data, &replace_groups(&1, &2))

    if String.length(result.line) < String.length(line) do
      result
    else
      data
    end
  end

  defp most_savings({group, count}) do
    (String.length(group) - 1) * count - String.length(group)
  end

  defp replace_groups({group, _count}, data) do
    [char | rest] = data.alphas
    line = data.line

    new_line =
      if String.contains?(line, ";;") do
        [start, rest] = String.split(line, ";;")
        last = String.replace(rest, group, char, global: true)

        "#{group}#{start};;#{last}"
      else
        last = String.replace(line, group, char, global: true)

        "#{group};;#{last}"
      end

    %{
      alphas: rest,
      line: new_line
    }
  end

  defp stage_one(line) do
    String.split(line, ~r/(?<=(.))(?!\1)/, trim: true)
    |> Enum.map_join(fn run ->
      String.first(run) <> Integer.to_string(String.length(run))
    end)
  end

  defp find_max_run(line) do
    # find maximal run of the same letter
    line_groups = line_groups(line)
    unique_chars = unique_chars(line)

    for c <- unique_chars, group <- line_groups do
      if String.contains?(group, c) do
        {c, String.length(group)}
      end
    end
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.group_by(fn {letter, _count} -> letter end, fn {_letter, count} -> count end)
    |> Enum.map(fn {letter, counts} -> {letter, Enum.max(counts)} end)
  end

  defp line_groups(line) do
    String.split(line, ~r/(?<=(.))(?!\1)/, trim: true) |> Enum.uniq()
  end

  defp unique_chars(line), do: String.graphemes(line) |> Enum.uniq()

  defp read(text) do
    Path.join(__DIR__, text)
    |> File.read!()
    |> String.split("\n", trim: true)
  end
end
