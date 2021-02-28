require "spec"
require "../src/*"

describe "ProteinTranslation" do
  it "Methionine RNA sequence" do
    ProteinTranslation.proteins("AUG").should eq(["Methionine"])
  end

  it "Phenylalanine RNA sequence 1" do
    ProteinTranslation.proteins("UUU").should eq(["Phenylalanine"])
  end

  it "Phenylalanine RNA sequence 2" do
    ProteinTranslation.proteins("UUC").should eq(["Phenylalanine"])
  end

  it "Leucine RNA sequence 1" do
    ProteinTranslation.proteins("UUA").should eq(["Leucine"])
  end

  it "Leucine RNA sequence 2" do
    ProteinTranslation.proteins("UUG").should eq(["Leucine"])
  end

  it "Serine RNA sequence 1" do
    ProteinTranslation.proteins("UCU").should eq(["Serine"])
  end

  it "Serine RNA sequence 2" do
    ProteinTranslation.proteins("UCC").should eq(["Serine"])
  end

  it "Serine RNA sequence 3" do
    ProteinTranslation.proteins("UCA").should eq(["Serine"])
  end

  it "Serine RNA sequence 4" do
    ProteinTranslation.proteins("UCG").should eq(["Serine"])
  end

  it "Tyrosine RNA sequence 1" do
    ProteinTranslation.proteins("UAU").should eq(["Tyrosine"])
  end

  it "Tyrosine RNA sequence 2" do
    ProteinTranslation.proteins("UAC").should eq(["Tyrosine"])
  end

  it "Cysteine RNA sequence 1" do
    ProteinTranslation.proteins("UGU").should eq(["Cysteine"])
  end

  it "Cysteine RNA sequence 2" do
    ProteinTranslation.proteins("UGC").should eq(["Cysteine"])
  end

  it "Tryptophan RNA sequence" do
    ProteinTranslation.proteins("UGG").should eq(["Tryptophan"])
  end

  it "STOP codon RNA sequence 1" do
    ProteinTranslation.proteins("UAA").should eq([] of String)
  end

  it "STOP codon RNA sequence 2" do
    ProteinTranslation.proteins("UAG").should eq([] of String)
  end

  it "STOP codon RNA sequence 3" do
    ProteinTranslation.proteins("UGA").should eq([] of String)
  end

  it "Translate RNA strand into correct protein list" do
    ProteinTranslation.proteins("AUGUUUUGG").should eq(["Methionine", "Phenylalanine", "Tryptophan"])
  end

  it "Translation stops if STOP codon at beginning of sequence" do
    ProteinTranslation.proteins("UAGUGG").should eq([] of String)
  end

  it "Translation stops if STOP codon at end of two-codon sequence" do
    ProteinTranslation.proteins("UGGUAG").should eq(["Tryptophan"])
  end

  it "Translation stops if STOP codon at end of three-codon sequence" do
    ProteinTranslation.proteins("AUGUUUUAA").should eq(["Methionine", "Phenylalanine"])
  end

  it "Translation stops if STOP codon in middle of three-codon sequence" do
    ProteinTranslation.proteins("UGGUAGUGG").should eq(["Tryptophan"])
  end

  it "Translation stops if STOP codon in middle of six-codon sequence" do
    ProteinTranslation.proteins("UGGUGUUAUUAAUGGUUU").should eq(["Tryptophan", "Cysteine", "Tyrosine"])
  end
end
