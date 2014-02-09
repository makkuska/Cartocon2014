Person = Struct.new(:firstname, :lastname, :organization, :city,
                    :email, :phone, :topic, :qr) do
  def name
    [firstname,lastname].join(' ')
  end

  def qr?
    qr == 'ano'
  end

  def data
    @data ||=
"""BEGIN:VCARD
VERSION:3.0
N:#{lastname};#{firstname}
FN:#{name}
EMAIL:#{email}
TEL:#{phone}
ORG:#{organization}
END:VCARD
"""
  end
end
