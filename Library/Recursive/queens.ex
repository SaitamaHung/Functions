# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
# This File if From Theopse (Self@theopse.org)
# Licensed under BSD-2-Caluse
# File:	queens.ex (Functions/Library/Recursive/queens.ex)
# Content:	Queens
# Copyright (c) 2020 Theopse Organization All rights reserved
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

defmodule Functions.Recursive do
	@moduledoc """
  	Recursive Functions
	"""

	@doc """
  Queens

  ## Examples

      iex> Functions.Recursive.queens(4)
      [{1, 3, 0, 2}, {2, 0, 3, 1}]

  """
	@spec queens(pos_integer, [integer()]) :: [{integer()}]
	def queens(num \\ 8, state \\ [])

	def queens(num, state) when is_list(state) and is_integer(num) and num >= 4 do
		length = :erlang.length(state)

		next =
			state
			|> case do
				[] ->
					0..(num - 1)

				state ->
					0..(num - 1)
					|> Enum.filter(fn pos ->
						state
						|> Enum.with_index()
						|> Enum.any?(fn {item, i} ->
							pos == item || abs(item - pos) == length - i
						end)
						|> Kernel.==(false)
					end)
			end

		if length == num - 1 do
			next
			|> Enum.map(&{&1})
		else
			fun = fn
				[], result, _ ->
					result

				[pos | next], result, fun ->
					queen = queens(num, state ++ [pos])

					newFun = fn
						[], result, _ ->
							result

						[head | tail], result, newFun ->
							newFun.(tail, result ++ [head |> Tuple.insert_at(0,pos)], newFun)
					end

					result = newFun.(queen, result, newFun)
					fun.(next, result, fun)
			end

			fun.(next |> Enum.to_list(), [], fun)
		end
	end
end
