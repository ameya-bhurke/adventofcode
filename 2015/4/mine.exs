defmodule Miner do
  def n_time_zero_tostr(n), do: String.duplicate("0", n)

  def starts_with_n_zeroes(hash, n), do: String.starts_with?(hash, n)

  def hash_key_and_salt(key, salt), do: Base.encode16(:crypto.hash(:md5, "#{key}#{salt}"))

  def min_salt(key, salt, n) do
    min_salt = starts_with_n_zeroes(hash_key_and_salt(key, salt), n)
    case min_salt do
      false -> min_salt(key, salt + 1, n)
      true -> IO.puts(salt)
    end
  end

  def min_salt(key, n) do
    min_salt(key, 0, n_time_zero_tostr(n))
  end
end

Miner.min_salt("bgvyzdsv", 5)
Miner.min_salt("bgvyzdsv", 6)
