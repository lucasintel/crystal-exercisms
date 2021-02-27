module RnaComplement
  private NUCLEOTIDE_FROM = "GCTA"
  private NUCLEOTIDE_TO   = "CGAU"

  def self.of_dna(dna : String) : String
    dna.tr(NUCLEOTIDE_FROM, NUCLEOTIDE_TO)
  end
end
