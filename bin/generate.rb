#!/usr/bin/env ruby
require_relative '../lib/qr-codes'

csv   = ARGV[0]
pdf   = ARGV[1] || "#{Dir.pwd}/qr.pdf"
logo  = ARGV[2] || "#{Dir.pwd}/logo.png"
logo2 = ARGV[3] || "#{Dir.pwd}/logo2.png"
bg    = ARGV[4] || "#{Dir.pwd}/background.png"
# font  = ARGV[5] || "#{Dir.pwd}/Ubuntu-R.ttf"
font  = ARGV[5] || "#{Dir.pwd}/MyriadPro-Regular.ttf"

unless pdf && csv
  puts 'usage: generate.rb csvfile [pdffile logo background font]'
  exit(1)
end

Document.from_csv(csv,font,logo,logo2,bg).generate(pdf)
