defmodule Scheme.Reader do
  # 1. ignore lines of pure whitespace
  # 2. print non-lists immediately
  # 3. if the number of ( equal the number of ), then print
  # 4. if the number of ( are greater than ), then recur until they do
  # 5. if the number of ( is less than ), then raise an error.
  def read do
    IO.gets("# ") |> String.strip |> IO.puts

    read
  end

  # Enum.filter(to_char_list("((("), fn (e) -> e == 40 end) |> length
  # Enum.filter(to_char_list("))"), fn (e) -> e == 41 end) |> length
end
