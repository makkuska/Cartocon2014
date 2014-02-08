require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'people'
require_relative 'qr-file'

class Document
  def initialize(people)
    @people = people
  end

  def self.from_csv(file)
    new(People.from_csv(file))
  end

  def generate(pdffile,fontfile)
    render(fontfile)
    document.render_file(pdffile)
  end

  private

  def document
    @document ||= Prawn::Document.new(page_size: "A4")
  end

  def render(fontfile)
    document.font(fontfile) do
      @people.each_slice(4) do |(p1,p2,p3,p4)|
        box(p1,0,0) if p1; box(p2,0,1) if p2
        box(p3,1,0) if p3; box(p4,1,1) if p4
        document.start_new_page if p4
      end
    end
  end

  HEIGHT = 14.cm
  WIDTH = 9.2.cm

  def box(person,row,col)
    top_left = [col * WIDTH, (1 + invert(row)) * HEIGHT]
    document.bounding_box(top_left, width: WIDTH, height: HEIGHT) do
      document.stroke_bounds
      # image logo
      p person.name
      document.text_box person.name, align: :center, size: 18,
        at: [1.cm,6.5.cm], width: WIDTH - 2.cm
      document.text_box person.organization, align: :center, size: 14,
        at: [1.cm,5.5.cm], width: WIDTH - 2.cm
      document.text_box person.city, align: :center, size: 14,
        at: [1.cm,4.8.cm], width: WIDTH - 2.cm
      document.text_box person.topic, align: :center, size: 12,
        at: [0.5.cm,3.2.cm], width: WIDTH - QrCode::WIDTH - 1.cm,
        height: QrCode::HEIGHT + 10
      document.image QrFile.new(person.data).file.path,
        at: [WIDTH - QrCode::WIDTH - 10, QrCode::HEIGHT + 10]
    end
  end

  def invert(zero_or_one)
    zero_or_one == 0 ? 1 : 0
  end
end
