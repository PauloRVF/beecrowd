#https://www.beecrowd.com.br/judge/pt/problems/view/1101

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
    #IO.inspect (float_frac (round(number * 100)) / 100)
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

defmodule Ex1101 do
  def start() do
    [m, n] = BcInput.input_as_integer_array()
    compute(m, n)
  end

  defp compute(start, final) when start == 0 or final == 0, do: nil
  defp compute(start, final) do
    list = expand_values(start, final)

    Enum.each(list, &(IO.write "#{&1} ") )
    IO.puts("Sum=#{Enum.sum(list)}")

    start()
  end

  defp expand_values(m, n) do
    m..n
    |> Enum.to_list()
    |> Enum.sort()
  end
end

Ex1101.start()
