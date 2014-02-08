require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'people'
require_relative 'qr-file'

class Document
  def initialize(people, font, logo, logo2, background)
    @people, @font, @logo, @logo2, @background = people, font, logo, logo2, background
  end

  def self.from_csv(file, *args)
    new(People.from_csv(file), *args)
  end

  def generate(pdffile)
    render
    document.render_file(pdffile)
  end

  private

  def document
    @document ||= Prawn::Document.new(page_size: "A4")
  end
  alias_method :d, :document

  def render
    d.font(@font) do
      @people.each_slice(4) do |(p1,p2,p3,p4)|
        box(p1,0,0) if p1; box(p2,0,1) if p2
        box(p3,1,0) if p3; box(p4,1,1) if p4
        d.start_new_page if p4
      end
    end
  end

  HEIGHT = 12.5.cm
  WIDTH = 8.2.cm

  def box(person,row,col)
    top_left = [col * WIDTH, (1 + invert(row)) * HEIGHT]
    d.bounding_box(top_left, width: WIDTH, height: HEIGHT) do
      d.stroke_bounds
      images
      texts(person)
      qr_code(person)
    end
    print '.'
  end

  def images
    d.image @background
    d.image @logo, at: [0,HEIGHT], width: WIDTH
    d.image @logo2, at: [0,HEIGHT-2.7.cm], width: WIDTH
    d.fill_color "0000ff"
    d.fill_rectangle [0,HEIGHT], WIDTH/3, HEIGHT
  end

  def texts(person)
    d.fill_color [100, 65, 25, 0]
    d.text_box person.name, align: :center, size: 18,
      at: [1.cm,6.5.cm], width: WIDTH - 2.cm
    d.text_box person.organization, align: :center, size: 14,
      at: [1.cm,5.5.cm], width: WIDTH - 2.cm
    d.text_box person.city, align: :center, size: 14,
      at: [1.cm,4.8.cm], width: WIDTH - 2.cm

    d.fill_color [0, 0, 0, 67]
    d.text_box person.topic, align: :center, size: 12,
      at: [0.5.cm,3.5.cm], width: WIDTH - QrCode::WIDTH - 1.cm,
      height: QrCode::HEIGHT + 10
  end

  def qr_code(person)
    d.image QrFile.new(person.data).file.path,
      at: [WIDTH - QrCode::WIDTH - 10, QrCode::HEIGHT + 10]
  end

  def invert(zero_or_one)
    zero_or_one == 0 ? 1 : 0
  end
end
