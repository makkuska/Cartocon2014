#!/usr/bin/env ruby
require_relative '../lib/qr-codes'

csv          = ARGV[0]
pdf          = ARGV[1] || "#{Dir.pwd}/qr.pdf"
bg           = ARGV[2] || "#{Dir.pwd}/template_%s.jpg"
regular_font = ARGV[3] || "#{Dir.pwd}/MyriadPro-Regular.ttf"
# bold_font    = ARGV[3] || "#{Dir.pwd}/MyriadPro-Bold.ttf"
bold_font    = ARGV[3] || "#{Dir.pwd}/MyriadPro-Regular.ttf"

unless pdf && csv
  puts 'usage: generate.rb csvfile [pdffile background regular_font bold_font]'
  exit(1)
end

Document.from_csv(csv,regular_font,bold_font,bg).generate(pdf)
