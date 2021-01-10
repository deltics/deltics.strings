
{$i deltics.inc}

  unit Test.Encoding;


interface

  uses
    Deltics.Smoketest;


  type
    EncodingTests = class(TTest)
      procedure DetectsUtf8WithBom;
      procedure DetectsUtf16BEWithBom;
      procedure DetectsUtf16LEWithBom;
      procedure DetectsUtf32BEWithBom;
      procedure DetectsUtf32LEWithBom;
      procedure DetectsUtf16BEWithNoBom;
      procedure DetectsUtf16LEWithNoBom;
      procedure Utf8Decoding;
      procedure Utf8Encoding;
    end;


implementation

  uses
    Deltics.Pointers,
    Deltics.ReverseBytes,
    Deltics.Strings;


{ Encoding }

  procedure EncodingTests.DetectsUtf16BEWithBom;
  var
    bom: TBOM;
    buf: array[0..7] of Byte;
    enc: TEncoding;
  begin
    bom := Utf16Bom.AsBytes;
    Memory.Copy(@bom[0], @buf[0], Length(bom));
    buf[2]  := 0;
    buf[3]  := 65;
    buf[4]  := 0;
    buf[5]  := 66;
    buf[6]  := 0;
    buf[7]  := 67;

    Encoding.Identify(buf, Length(buf), enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf16);
  end;


  procedure EncodingTests.DetectsUtf16BEWithNoBom;
  var
    buf: array[0..5] of Byte;
    enc: TEncoding;
  begin
    buf[0]  := 0;
    buf[1]  := 65;
    buf[2]  := 0;
    buf[3]  := 66;
    buf[4]  := 0;
    buf[5]  := 67;

    Encoding.Identify(buf, Length(buf), enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf16);
  end;


  procedure EncodingTests.DetectsUtf16LEWithBom;
  var
    bom: TBOM;
    buf: array[0..7] of Byte;
    enc: TEncoding;
  begin
    bom := Utf16Bom.AsBytes;
    Memory.Copy(@bom[0], @buf[0], Length(bom));
    buf[2]  := 0;
    buf[3]  := 65;
    buf[4]  := 0;
    buf[5]  := 66;
    buf[6]  := 0;
    buf[7]  := 67;
    ReverseBytes(PWord(@buf[0]), Length(buf) div 2);

    Encoding.Identify(buf, Length(buf), enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf16LE);
  end;


  procedure EncodingTests.DetectsUtf16LEWithNoBom;
  var
    buf: array[0..5] of Byte;
    enc: TEncoding;
  begin
    buf[0]  := 0;
    buf[1]  := 65;
    buf[2]  := 0;
    buf[3]  := 66;
    buf[4]  := 0;
    buf[5]  := 67;
    ReverseBytes(PWord(@buf[0]), Length(buf) div 2);

    Encoding.Identify(buf, Length(buf), enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf16LE);
  end;


  procedure EncodingTests.DetectsUtf32BEWithBom;
  var
    bom: TBOM;
    buf: array[0..7] of Byte;
    enc: TEncoding;
  begin
    bom := Utf32Bom.AsBytes;
    Memory.Copy(@bom[0], @buf[0], Length(bom));
    buf[4]  := 0;
    buf[5]  := 0;
    buf[6]  := 0;
    buf[7]  := 65;

    Encoding.Identify(buf, Length(buf), enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf32);
  end;


  procedure EncodingTests.DetectsUtf32LEWithBom;
  var
    bom: TBOM;
    buf: array[0..7] of Byte;
    enc: TEncoding;
  begin
    bom := Utf32Bom.AsBytes;
    Memory.Copy(@bom[0], @buf[0], Length(bom));
    buf[4]  := 0;
    buf[5]  := 0;
    buf[6]  := 0;
    buf[7]  := 65;
    ReverseBytes(PCardinal(@buf), 2);

    Encoding.Identify(buf, 8, enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf32LE);
  end;


  procedure EncodingTests.DetectsUtf8WithBom;
  var
    bom: TBOM;
    buf: array[0..5] of Byte;
    enc: TEncoding;
  begin
    bom := Utf8Bom.AsBytes;
    Memory.Copy(@bom[0], @buf[0], Length(bom));
    buf[3]  := 65;
    buf[4]  := 66;
    buf[5]  := 67;

    Encoding.Identify(buf, 8, enc);

    Test('Encoding').Assert(enc).IsNotNIL;
    if Assigned(enc) then
      Test('Codepage').Assert(enc.Codepage).Equals(cpUtf8);
  end;



  procedure EncodingTests.Utf8Decoding;
  var
    input: Utf8String;
    output: WideString;
    numChars: Integer;
  begin
    // The following is essentially a hand-crafted version of:  input := Utf8.FromString('abc©2020');
    input := 'abc??2020';
    input[4] := Utf8Char($c2);
    input[5] := Utf8Char($a9);

    numChars := TEncoding.Utf8.GetCharCount(input[1], Length(input));

    Test('GetCharCount').Assert(numChars).Equals(8);

    SetLength(output, numChars);

    TEncoding.Utf8.Decode(input[1], Length(input), @output[1], numChars);

    Test('Decode').Assert(output).Equals('abc©2020');
  end;


  procedure EncodingTests.Utf8Encoding;
  var
    input: WideString;
    output: Utf8String;
    numBytes: Integer;
  begin
    input := 'abc©2020';

    numBytes := TEncoding.Utf8.GetByteCount(@input[1], Length(input));

    Test('GetByteCount').Assert(numBytes).Equals(9);

    SetLength(output, numBytes);

    TEncoding.Utf8.Encode(@input[1], Length(input), output[1], numBytes);

    Test('Encode').Assert(STR.FromUtf8(output)).Equals('abc©2020');
  end;





end.
