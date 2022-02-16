defmodule Miner do
  def starts_with_5_zeroes(hash), do: String.starts_with?(hash, "00000")

  def hash_key_and_salt(key, salt), do: Base.encode16(:crypto.hash(:md5, "#{key}#{salt}"))

  def min_salt(key, salt) do
    min_salt = starts_with_5_zeroes(hash_key_and_salt(key, salt))
    case min_salt do
      false -> min_salt(key, salt + 1)
      true -> IO.puts(salt)
    end
  end

  def min_salt(key) do
    min_salt(key, 0)
  end
end

Miner.min_salt("bgvyzdsv")
