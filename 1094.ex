#https://www.beecrowd.com.br/judge/pt/problems/view/1080

defmodule BcParse do
  def str_to_float(str) do
    str
    |> Float.parse()
    |> elem(0)
  end

  def str_to_integer(str) do
    str
    |> Integer.parse()
    |> elem(0)
  end

  def float_to_str(number, precision \\ 2) do
    :erlang.float_to_binary(number, [decimals: precision])
  end

  def float_frac(number) do
    round((number - trunc(number)) * 100) / 100
  end
end

defmodule BcInput do
  def input_as_float() do
    IO.gets("") |> BcParse.str_to_float
  end

  def input_as_integer() do
    IO.gets("") |> BcParse.str_to_integer
  end

  def input_as_float_array() do
    IO.gets("")
    |> String.split
    |> Enum.map(&(BcParse.str_to_float/1))
  end

  def input_as_integer_array() do
    IO.gets("")
    |> String.split
    |> Enum.map(&(BcParse.str_to_integer/1))
  end

  def input_n_integers(n_times) do
    do_input_n_integers(n_times, [])
    |> Enum.reverse()
  end

  defp do_input_n_integers(0, list), do: list
  defp do_input_n_integers(n_times, list) do
    input = BcInput.input_as_integer()
    do_input_n_integers(n_times - 1, [input | list])
  end
end

defmodule BcEnumAux do
  def is_in_range(value, {min, max}) when min > max, do: is_in_range(value, {max, min})
  def is_in_range(value, {min, max}), do: (value >= min) and (value <= max)
end

defmodule Ex1094 do
  def start_cases(n) do
    mapped_input = get_inputs(n) |> map_input

    IO.puts("Total: #{get_total(mapped_input)} cobaias")
    IO.puts("Total de coelhos: #{get_key(mapped_input, "coelhos")}")
    IO.puts("Total de ratos: #{get_key(mapped_input, "ratos")}")
    IO.puts("Total de sapos: #{get_key(mapped_input, "sapos")}")
    IO.puts("Percentual de coelhos #{get_perc(mapped_input, "coelhos")} %")
    IO.puts("Percentual de ratos #{get_perc(mapped_input, "ratos")} %")
    IO.puts("Percentual de sapos #{get_perc(mapped_input, "sapos")} %")
  end

  def get_inputs(0), do: []
  def get_inputs(n) do
    inp = IO.gets("") |> String.trim() |> String.split(" ")
    [inp | get_inputs(n - 1)]
  end

  def map_input(list) do
    Enum.map(list, fn [qt, type] -> {translate(type), BcParse.str_to_integer(qt)} end)
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Map.update(acc, key, value, fn x -> x + value end)
    end)
  end

  def get_key(map, key) do
    map[key]
  end

  def get_perc(map, key) do
    BcParse.float_to_str((map[key] / get_total(map) * 100))
  end

  def translate(type) do
    case type do
      "C" -> "coelhos"
      "R" -> "ratos"
      "S" -> "sapos"
        _ -> ArgumentError
    end
  end

  def get_total(mapped_input) do
    mapped_input
    |> Map.values()
    |> Enum.sum()
  end

end

Ex1094.start_cases(10)
