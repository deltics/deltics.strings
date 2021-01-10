{$i deltics.strings.inc}

  unit Deltics.Strings.Encoding.Bom;


interface

  uses
    Deltics.Strings.Types;


  type
    TBOM = array of Byte;


    Utf8Bom = class
      class function AsBytes: TBOM;
      class function AsString: Utf8String;
    end;


    Utf16Bom = class
      class function AsBytes: TBOM;
      class function AsString: UnicodeString;
    end;


    Utf16LEBom = class
      class function AsBytes: TBOM;
      class function AsString: UnicodeString;
    end;


    Utf32Bom = class
      class function AsBytes: TBOM;
    end;


    Utf32LEBom = class
      class function AsBytes: TBOM;
    end;


implementation

  const
    bomUtf8    : array[0..2] of Byte = ($ef, $bb, $bf);
    bomUtf16   : array[0..1] of Byte = ($fe, $ff);
    bomUtf32   : array[0..3] of Byte = ($00, $00, $fe, $ff);




{ Utf8Bom }

  class function Utf8Bom.AsBytes: TBOM;
  begin
    SetLength(result, 3);
    result[0] := bomUtf8[0];
    result[1] := bomUtf8[1];
    result[2] := bomUtf8[2];
  end;


  class function Utf8Bom.AsString: Utf8String;
  begin
    result := Utf8Char(bomUtf8[0]) + Utf8Char(bomUtf8[1]) + Utf8Char(bomUtf8[2]);
  end;





{ Utf16Bom }

  class function Utf16Bom.AsBytes: TBOM;
  begin
    SetLength(result, 2);
    result[0] := bomUtf16[0];
    result[1] := bomUtf16[1];
  end;

  class function Utf16Bom.AsString: UnicodeString;
  begin
    result := WideChar((bomUtf16[0] shl 8) or bomUtf16[1]);
  end;




{ Utf16LEBom }

  class function Utf16LEBom.AsBytes: TBOM;
  begin
    SetLength(result, 2);
    result[0] := bomUtf16[1];
    result[1] := bomUtf16[0];
  end;

  class function Utf16LEBom.AsString: UnicodeString;
  begin
    result := WideChar(Word((bomUtf16[1] shl 8) or bomUtf16[0]))
  end;




{ Utf32Bom }

  class function Utf32Bom.AsBytes: TBOM;
  begin
    SetLength(result, 4);
    result[0] := bomUtf32[0];
    result[1] := bomUtf32[1];
    result[2] := bomUtf32[2];
    result[3] := bomUtf32[3];
  end;




{ Utf32LEBom }

  class function Utf32LEBom.AsBytes: TBOM;
  begin
    SetLength(result, 4);
    result[0] := bomUtf32[3];
    result[1] := bomUtf32[2];
    result[2] := bomUtf32[1];
    result[3] := bomUtf32[0];
  end;




end.
