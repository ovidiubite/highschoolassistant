class String

  def remove_diacritics
    self.gsub('ă', 'a')
    .gsub('Ă', 'A')
    .gsub('î', 'i')
    .gsub('Î', 'I')
    .gsub('ș', 's')
    .gsub('Ş', 'S')
    .gsub('ţ', 't')
    .gsub('Ț', 'T')
    .gsub('â', 'a')
    .gsub('Â', 'A')
  end
end
