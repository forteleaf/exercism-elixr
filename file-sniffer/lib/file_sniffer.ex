defmodule FileSniffer do
  def type_from_extension(extension) do
    # Please implement the type_from_extension/1 function
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    # Please implement the type_from_binary/1 function

    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "application/octet-stream"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "image/png"
      <<0x42, 0x4D, _::binary>> -> "image/bmp"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "image/jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "image/gif"
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    # Please implement the verify/2 function

    type = type_from_binary(file_binary)

    case type_from_extension(extension) do
      nil -> {:error, "Warning, file format and file extension do not match."}
      f when f == type -> {:ok, type}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end
