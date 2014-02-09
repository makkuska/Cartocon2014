#!/usr/bin/env ruby
require_relative '../lib/qr-codes'

csv          = ARGV[0]
pdf          = ARGV[1] || "#{Dir.pwd}/qr.pdf"
logo         = ARGV[2] || "#{Dir.pwd}/logo.png"
logo2        = ARGV[3] || "#{Dir.pwd}/logo2.png"
bg           = ARGV[4] || "#{Dir.pwd}/background.png"
regular_font = ARGV[5] || "#{Dir.pwd}/MyriadPro-Regular.ttf"
bold_font    = ARGV[5] || "#{Dir.pwd}/MyriadPro-Bold.ttf"

unless pdf && csv
  puts 'usage: generate.rb csvfile [pdffile logo background font]'
  exit(1)
end

Document.from_csv(csv,regular_font,bold_font,logo,logo2,bg).generate(pdf)
