module Png
  class Image
    def self.create_from_filename(filename)
      File.open(filename, 'r') {|f|
        # read the header all at once
        header_byte_array = f.read(Header::DEFAULT_SIZE_IN_BYTES).unpack('C*')

        loop {
          chunk_data_length     = nil
          chunk_type            = nil
          chunk_data_byte_array = nil
          crc_byte_array        = nil

          # read 4 bytes which is the length of the chunk's data (Big Endian)
          if read_result = f.read(4)
            chunk_data_length = read_result.unpack('N').first
          else
            break
          end

          # read 4 bytes which is chunk type
          if read_result = f.read(4)
            chunk_type = read_result
          else
            break
          end

          # read N bytes which is the chunk_data
          if read_result = f.read(chunk_data_length)
            chunk_data_byte_array = read_result.unpack('C*')
          else
            break
          end

          # read 4 bytes which is the CRC
          if read_result = f.read(4)
            crc_byte_array = read_result.unpack('C*')
          else
            break
          end

          puts chunk_type + ' ' + chunk_data_byte_array.to_s
        }
      }
    end

    def initialize
    end

    class Header
      DEFAULT_SIZE_IN_BYTES = 8
    end
    class Chunk
    end
    class CriticalChunk < Chunk
    end
    class AncillaryChunk < Chunk
    end
  end # Image
end # Png
