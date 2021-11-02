#https://www.beecrowd.com.br/judge/pt/problems/view/1004

{a, _} = IO.gets("") |> Integer.parse
{b, _} = IO.gets("") |> Integer.parse

IO.puts("PROD = #{a * b}")
