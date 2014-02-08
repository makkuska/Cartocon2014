#!/usr/bin/env ruby
require_relative '../lib/qr-codes'

csvfile = ARGV[0]
pdffile = ARGV[1]
fontfile = ARGV[2] || "#{Dir.pwd}/Ubuntu-R.ttf"

unless pdffile && csvfile
  puts 'usage: generate.rb csvfile pdffile'
  exit(1)
end

Document.from_csv(csvfile).generate(pdffile,fontfile)
