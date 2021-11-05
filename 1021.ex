#https://www.beecrowd.com.br/judge/pt/problems/view/1021

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
end

defmodule Ex1021 do
  defp print_money(amount, symbol) when symbol >= 2, do:
    IO.puts("#{amount} nota(s) de R$#{symbol |> BcParse.float_to_str(2) |> String.replace(".",",")}")
  defp print_money(amount, symbol), do:
    IO.puts("#{amount} moeda(s) de R$#{symbol |> BcParse.float_to_str(2) |> String.replace(".",",")}")

  def distribute(_, []), do: nil
  def distribute(value, symbol) do
    [actual | rest] = symbol
    act_symbol = trunc(actual * 100)
    int_value = trunc(value * 100)

    print_money(div(int_value, act_symbol), actual)
    distribute(rem(int_value, act_symbol) / 100, rest)
  end
end

require Integer

value = BcInput.input_as_float()
banknotes = [100.0, 50.0, 20.0, 10.0, 5.0, 2.0]
coins = [1.0, 0.5, 0.25, 0.1, 0.05, 0.01]

coins_part = fn value ->
  frac = BcParse.float_frac(value)
  if (rem(trunc(value), 5) |> Integer.is_odd)do
    frac + 1
  else
    frac
  end
end

IO.puts("NOTAS:")
Ex1021.distribute(value - coins_part.(value), banknotes)

IO.puts("MOEDAS:")
Ex1021.distribute(coins_part.(value), coins)
