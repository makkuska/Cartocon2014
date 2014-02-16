require 'unicode_utils/upcase'

Person = Struct.new(:firstname, :lastname, :email, :organization, :city, :state,
                    :topic, :qr, :phone, :type) do
  def name
    [firstname,lastname].join(' ')
  end

  def cap_lastname
    UnicodeUtils.upcase(lastname)
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
