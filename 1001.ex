#https://www.beecrowd.com.br/judge/pt/problems/view/1001

{a, _} = IO.gets("") |> Integer.parse
{b, _} = IO.gets("") |> Integer.parse

IO.puts("X = #{a + b}")
