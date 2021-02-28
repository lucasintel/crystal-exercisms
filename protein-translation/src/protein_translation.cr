module ProteinTranslation
  STOP_CODONS = {"UAA", "UAG", "UGA"}

  PROTEINS = {
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UGG" => "Tryptophan",
  }

  def self.proteins(string : String)
    iterator = Char::Reader.new(string)
    result = [] of String

    iterator.in_groups_of(3) do |codons|
      codon = codons.join
      return result if STOP_CODONS.includes?(codon)

      if protein = PROTEINS[codon]?
        result << protein
      end
    end

    result
  end
end
