Person = Struct.new(:firstname, :lastname, :organization, :city,
                    :email, :phone, :topic) do
  def name
    [firstname,lastname].join(' ')
  end

  def data
    @data ||=
"""BEGIN:VCARD
VERSION:3.0
N:#{lastname};#{firstname}
FN:#{name}
EMAIL:#{email}
TEL:#{phone}
END:VCARD
"""
  end
end
