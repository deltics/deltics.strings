
{$i deltics.strings.inc}

  unit Test.Utf32Functions;

interface

  uses
    Deltics.Smoketest;


  type
    Utf32Functions = class(TTest)
      procedure FromWideWithAsciiCharacters;
      procedure FromWideWithExtendedCharacters;
      procedure FromWideWithSurrogateCharacters;
      procedure FromWideSurrogatePair;
    end;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Test.Consts;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf32Functions.FromWideWithAsciiCharacters;
  var
    sut: Utf32Array;
  begin
    sut := Utf32.FromWide('abc');

    Test('Length').Assert(Length(sut)).Equals(3);
    Test('sut[0]').Assert(sut[0]).Equals(Ord('a'));
    Test('sut[1]').Assert(sut[1]).Equals(Ord('b'));
    Test('sut[2]').Assert(sut[2]).Equals(Ord('c'));
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf32Functions.FromWideWithExtendedCharacters;
  var
    sut: Utf32Array;
  begin
    sut := Utf32.FromWide('©2020');

    Test('Length').Assert(Length(sut)).Equals(5);
    Test('sut[0]').Assert(sut[0]).Equals(169);
    Test('sut[1]').Assert(sut[1]).Equals(Ord('2'));
    Test('sut[2]').Assert(sut[2]).Equals(Ord('0'));
    Test('sut[3]').Assert(sut[3]).Equals(Ord('2'));
    Test('sut[4]').Assert(sut[4]).Equals(Ord('0'));
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf32Functions.FromWideWithSurrogateCharacters;
  {
    For this test we use Unicode codepoint Ux1d11e - the treble clef

      UTF-8 Encoding  :	0xF0 0x9D 0x84 0x9E
      UTF-16 Encoding :	0xD834 0xDD1E
  }
  var
    src: UnicodeString;
    sut: Utf32Array;
  begin
    src  := 'a??b';
    src[2] := WideChar($d834);
    src[3] := WideChar($dd1e);

    sut := Utf32.FromWide(src);

    Test('Length').Assert(Length(sut)).Equals(3);
    Test('sut[0]').Assert(sut[0]).Equals(Ord('a'));
    Test('sut[1]').Assert(sut[1]).Equals($1d11e);
    Test('sut[2]').Assert(sut[2]).Equals(Ord('b'));
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf32Functions.FromWideSurrogatePair;
  var
    sut: Utf32Char;
  begin
    sut := Utf32.FromWide(WideChar($d834), WideChar($dd1e));

    Test('sut').Assert(sut).Equals($1d11e);
  end;






end.
