#https://www.beecrowd.com.br/judge/pt/problems/view/1043

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

defmodule Ex1043 do
  def is_triangle(a, b, c) do
    (abs(b - c) < a and (b + c) > a) or \
    (abs(a - c) < b and (a + c) > b) or \
    (abs(a - b) < c and (a + b) > c)
  end

  def calc_perimeter(a, b, c) do
    a + b + c
  end

  def calc_area(a, b, c) do
    ((a + b) * c) / 2
  end
end

[a, b, c] = BcInput.input_as_float_array()

if Ex1043.is_triangle(a, b, c) do
  IO.puts("Perimetro = #{Ex1043.calc_perimeter(a, b, c) |> BcParse.float_to_str(1)}")
else
  IO.puts("Area = #{Ex1043.calc_area(a, b, c) |> BcParse.float_to_str(1)}")
end
