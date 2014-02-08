require 'net/http'

class QrCode
  PROTOCOL = 'http://'
  HOST = 'chart.apis.google.com'
  PATH = '/chart'
  TYPE = 'qr'
  WIDTH = 100
  HEIGHT = 100

  def initialize(data)
    @data = data
  end

  def get
    @result ||= Net::HTTP.get(URI("#{PROTOCOL}#{HOST}#{PATH}?#{params}"))
  end

  def params
    URI.escape("cht=#{TYPE}&chl=#{@data}&chs=#{WIDTH}x#{HEIGHT}")
  end
end
