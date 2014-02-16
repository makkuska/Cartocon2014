require_relative 'qr-file'

class PersonBox
  HEIGHT = 12.5.cm
  WIDTH = 8.2.cm

  attr_reader :person, :document

  def initialize(person,document)
    @person = person
    @document = document
  end

  def draw(row,col)
    p person
    d.bounding_box(top_left(row,col), width: WIDTH, height: HEIGHT) do
      d.line_width = 0.25
      d.stroke_bounds
      background
      texts
      qr_code
    end

    # print '.'
  end

  private

  def d
    document.document
  end

  def top_left(row, col)
    [col * WIDTH, (1 + invert(row)) * HEIGHT]
  end

  def background
    d.image document.background % [person.type], at: [0,HEIGHT], width: WIDTH
  end

  def texts
    d.fill_color [100, 60, 25, 0]
    d.font document.bold_font
    d.text_box person.firstname, size: 30,
      at: [0.7.cm,9.1.cm], width: WIDTH - 1.6.cm
    d.text_box person.cap_lastname, size: 24,
      at: [0.7.cm,8.cm], width: WIDTH - 1.6.cm

    d.fill_color [0, 0, 0, 70]
    d.font document.regular_font
    d.text_box person.organization, size: 12,
      at: [0.7.cm,6.7.cm], width: WIDTH - 1.6.cm
    d.text_box [person.city,person.state].join(', '), size: 12,
      at: [0.7.cm,6.2.cm], width: WIDTH - 1.6.cm
  end

  def qr_code
    d.fill_color [100, 60, 25, 0]
    d.text_box person.topic.gsub('\\', "\n"), size: 12, valign: :center,
      # at: [0.7.cm,4.2.cm],
      at: [0.7.cm,QrCode::HEIGHT + 1.cm - 10],
      width: WIDTH - (person.qr? ? QrCode::WIDTH : 0) - 1.6.cm,
      height: QrCode::HEIGHT - 20

    if person.qr?
      # p person.data.length
      p person.data.bytesize
      d.image QrFile.new(person.data).file.path,
        at: [WIDTH - QrCode::WIDTH - 10, QrCode::HEIGHT + 10 + 1.cm]
    end
  end

  def invert(zero_or_one)
    zero_or_one == 0 ? 1 : 0
  end
end
