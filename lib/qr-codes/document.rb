require 'prawn'
require 'prawn/measurement_extensions'
require_relative 'people'
require_relative 'person-box'

class Document
  attr_reader :people, :font, :logo, :logo2, :background

  def initialize(people, font, logo, logo2, background)
    @people, @font, @logo, @logo2, @background =
      people, font, logo, logo2, background
  end

  def self.from_csv(file, *args)
    new(People.from_csv(file), *args)
  end

  def generate(pdffile)
    render
    document.render_file(pdffile)
  end

  def document
    @document ||= Prawn::Document.new(page_size: "A4")
  end

  private

  def render
    document.font(font) do
      people.each_slice(4) do |(p1,p2,p3,p4)|
        PersonBox.new(p1,self).draw(0,0) if p1
        PersonBox.new(p2,self).draw(0,1) if p2
        PersonBox.new(p3,self).draw(1,0) if p3
        PersonBox.new(p4,self).draw(1,1) if p4
        document.start_new_page if p4
      end
    end
  end
end
