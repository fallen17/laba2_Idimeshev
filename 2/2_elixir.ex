defmodule Pangram do
  def check do
    IO.puts("Type in your string...")
    input = IO.gets("") |> String.trim()
    
    cond do
      input == "" ->
        IO.puts("String is empty...")
      not allowed_symbols?(input) ->
        IO.puts("Your string contains restricted symbols...")
      true ->
        case pangram?(input) do
          true -> IO.puts("Pangram - Yes...")
          false -> IO.puts("Pangram - No...")
        end
    end
  end
  
  defp pangram?(string) do
    letters = string
    |> String.downcase()
    |> to_charlist()
    |> Enum.filter(fn c -> c >= ?a and c <= ?z end)
    |> Enum.uniq()
    
    length(letters) == 26
  end
  
  defp allowed_symbols?(string) do
    string
    |> to_charlist()
    |> Enum.all?(fn c ->
      (c >= ?a and c <= ?z) or
      c == ?\s or c == ?, or c == ?! or c == ?. or c == ?'
    end)
  end
end

Pangram.check()