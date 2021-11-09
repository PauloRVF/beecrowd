#https://www.beecrowd.com.br/judge/pt/problems/view/1048

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

bs_table = [
  %{"salary" => {   0.00,     400.0}, "perc_adjust" => 15},
  %{"salary" => { 400.01,     800.0}, "perc_adjust" => 12},
  %{"salary" => { 800.01,    1200.0}, "perc_adjust" => 10},
  %{"salary" => {1200.01,    2000.0}, "perc_adjust" =>  7},
  %{"salary" => {2000.00, :infinity}, "perc_adjust" =>  4}
]

is_in_range = fn ({min, max}, value) ->
  (value >= min) and (value <= max)
end

get_rule = fn salary ->
  Enum.filter(bs_table, fn item ->
    is_in_range.(item["salary"], salary)
  end)
  |> Enum.at(0)
end

get_inc_value = fn salary, perc_inc ->
  salary * perc_inc / 100.0
end

salary = BcInput.input_as_float()

perc_adjust = get_rule.(salary)["perc_adjust"]
inc_value = get_inc_value.(salary, perc_adjust)

IO.puts ~s/Novo salario: #{(salary + inc_value) |> BcParse.float_to_str(2)}/
IO.puts ~s/Reajuste ganho: #{inc_value |> BcParse.float_to_str(2)}/
IO.puts ~s/Em Percentual: #{perc_adjust} %/
