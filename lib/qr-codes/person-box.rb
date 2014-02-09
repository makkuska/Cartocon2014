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
    d.bounding_box(top_left(row,col), width: WIDTH, height: HEIGHT) do
      d.line_width = 0.25
      d.stroke_bounds
      images
      texts
      qr_code
    end

    print '.'
  end

  private

  def d
    document.document
  end

  def top_left(row, col)
    [col * WIDTH, (1 + invert(row)) * HEIGHT]
  end

  def images
    d.fill_color "0000ff"
    d.fill_rectangle [0,1.2.cm], WIDTH, 1.cm

    d.image document.background, at: [0,HEIGHT], width: WIDTH
    d.image document.logo, at: [0,HEIGHT], width: WIDTH
    d.image document.logo2, at: [0 + 1.cm,HEIGHT-2.cm], width: WIDTH - 2.cm
  end

  def texts
    d.fill_color [100, 65, 25, 0]
    d.text_box person.name, align: :center, size: 18,
      at: [1.cm,8.cm], width: WIDTH - 2.cm
    d.text_box person.organization, align: :center, size: 14,
      at: [1.cm,7.cm], width: WIDTH - 2.cm
    d.text_box person.city, align: :center, size: 14,
      at: [1.cm,6.3.cm], width: WIDTH - 2.cm
  end

  def qr_code
    d.fill_color [0, 0, 0, 67]
    d.text_box person.topic, align: :center, size: 12,
      at: [0.5.cm,4.5.cm], width: WIDTH - QrCode::WIDTH - 1.cm,
      height: QrCode::HEIGHT + 10

    d.image QrFile.new(person.data).file.path,
      at: [WIDTH - QrCode::WIDTH - 10, QrCode::HEIGHT + 10 + 1.cm]
  end

  def invert(zero_or_one)
    zero_or_one == 0 ? 1 : 0
  end
end
