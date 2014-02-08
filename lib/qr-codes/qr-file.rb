require 'tempfile'
require_relative 'qr-code'

class QrFile
  def initialize(data)
    @data = data
  end

  def file
    unless @file
      @file = Tempfile.new(@data[0..10])
      @file.write(QrCode.new(@data).get)
      @file.close
      @file
    end
  end
end
