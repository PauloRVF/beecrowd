#https://www.beecrowd.com.br/judge/pt/problems/view/1134

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

  def number_to_str(number) do
    if ((round(number * 100)) / 100) |> float_frac() == 0 do
      trunc((round(number * 100)) / 100)
    else
      float_to_str(number, 1)
    end
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

defmodule Ex1134 do
  def start() do
    reading([])
    |> totalize()
  end

  def reading(history) do
    input = BcInput.input_as_integer()
    IO.inspect(input)
    if input == 4, do: history, else: reading( compute_product(history, input) )
  end

  defp compute_product(history, id) do
    case id do
      1 -> ["alcool" | history]
      2 -> ["gasolina" | history]
      3 -> ["diesel" | history]
      _ -> history
    end
  end

  defp totalize(history) do
    initial_reduc = %{"alcool" => 0, "gasolina" => 0, "diesel" => 0}
    Enum.reduce(history, initial_reduc, fn x, acc ->
      Map.update(acc, x, 1, &(&1 + 1))
    end)
  end
end


report = Ex1134.start()

IO.puts("MUITO OBRIGADO")
IO.puts("Alcool: #{report["alcool"]}")
IO.puts("Gasolina: #{report["gasolina"]}")
IO.puts("Diesel: #{report["diesel"]}")
