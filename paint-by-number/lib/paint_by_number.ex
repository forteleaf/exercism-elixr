defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    # Please implement the palette_bit_size/1 function
    power_number(0, color_count)
  end

  def power_number(i, j) do
    if Integer.pow(2, i) >= j do
      i
    else
      power_number(i + 1, j)
    end
  end

  def empty_picture() do
    # Please implement the empty_picture/0 function
    <<>>
  end

  def test_picture() do
    # Please implement the test_picture/0 function
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    # Please implement the prepend_pixel/3 function
    <<pixel_color_index::size(palette_bit_size(color_count)), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil

  def get_first_pixel(picture, color_count) do
    # Please implement the get_first_pixel/2 function
    s = palette_bit_size(color_count)
    <<color_index::size(s), _::bitstring>> = picture
    color_index
  end

  def drop_first_pixel(<<>>, _), do: <<>>

  def drop_first_pixel(picture, color_count) do
    # Please implement the drop_first_pixel/2 function
    s = palette_bit_size(color_count)
    <<_::size(s), rest::bitstring>> = picture
    rest
  end

  def concat_pictures(picture1, picture2) do
    # Please implement the concat_pictures/2 function
    <<picture1::bitstring, picture2::bitstring>>
  end
end
