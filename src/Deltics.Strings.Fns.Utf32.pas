
{$i deltics.strings.inc}


  unit Deltics.Strings.Fns.Utf32;


interface

  uses
    Deltics.Strings.Types;


  type
    Utf32Fn = class
      // Transcoding
      class function Encode(const aString: String): Utf32Array;
      class function FromAnsi(const aString: AnsiString): Utf32Array; overload;
      class function FromAnsi(const aString: PAnsiChar; aMaxLen: Integer = -1): Utf32Array; overload;
      class function FromString(const aString: String): Utf32Array;
      class function FromWide(const aString: UnicodeString): Utf32Array; overload;
      class function FromWide(aString: PWideChar; aMaxLen: Integer): Utf32Array; overload;
      class function FromWide(const aHi, aLo: WideChar): Utf32Char; overload;

      // Buffer operations
      class function Alloc(const aString: Utf32Array): PUtf32Char;
      class function Len(const aBuffer: PUtf32Char): Integer;
      class procedure CopyToBuffer(const aString: Utf32Array; aMaxBytes: Integer; aBuffer: Pointer; aOffset: Integer);
      class function FromBuffer(aBuffer: PUtf32Char; aLen: Integer = -1): Utf32Array;

      class function Append(const aString: Utf32Array; const aChar: Utf32Char): Utf32Array;
    end;


implementation

  uses
  {$ifdef DELPHIXE4__}
    AnsiStrings,
  {$endif}
    SysUtils,
    Windows,
    Deltics.Memory,
    Deltics.Strings;


{ _Utf32 ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.Encode(const aString: String): Utf32Array;
  begin
  {$ifdef UNICODE}
    result := FromWide(aString);
  {$else}
    result := FromAnsi(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromAnsi(const aString: AnsiString): Utf32Array;
  begin
    result := FromWide(Wide.FromAnsi(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromAnsi(const aString: PAnsiChar;
                                        aMaxLen: Integer): Utf32Array;
  begin
    result := FromWide(Wide.FromAnsi(Copy(aString, 1, aMaxLen)));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromString(const aString: String): Utf32Array;
  begin
  {$ifdef UNICODE}
    result := FromWide(aString);
  {$else}
    result := FromAnsi(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromWide(const aString: UnicodeString): Utf32Array;
  begin
    result := FromWide(PWideChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromWide(aString: PWideChar;
                                  aMaxLen: Integer): Utf32Array;
  var
    buf: array[0..255] of Utf32Char;
    idx: Integer;

    procedure Flushbuf(const aAddNull: Integer);
    begin
      SetLength(result, Length(result) + idx + aAddNull);
      Move(buf, result[Length(result) - idx - aAddNull], idx * SizeOf(Utf32Char));

      if aAddNull > 0 then
        result[Length(result) - 1] := 0;

      idx := 0;
    end;

  begin
    idx := 0;
    while (aString[0] <> #0) and (aMaxLen > 0) do
    begin
      if ((aString[0] >= #$d800) and (aString[0] <= #$dbff)) and (aMaxLen > 0) and (aString[1] <> #0) then
      begin
        buf[idx] := Utf32Char((Cardinal(aString[0]) and $000003ff) shl 10 or (Cardinal(aString[1]) and $000003ff) + $00010000);
        Inc(aString);
      end
      else
        buf[idx] := Utf32Char(aString[0]);

      Inc(idx);
      Inc(aString);
      Dec(aMaxLen);

      if idx >= Length(buf) then
        Flushbuf(0);
    end;
    Flushbuf(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromWide(const aHi, aLo: WideChar): Utf32Char;
  begin
    result := Utf32Char(aHi);
    if aLo = #0 then
      EXIT;

    result := Utf32Char((result and $000003ff) shl 10 or (Cardinal(aLo) and $000003ff) + $00010000);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.Alloc(const aString: Utf32Array): PUtf32Char;
  var
    len: Integer;
  begin
    len     := Length(aString) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PUtf32Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.Len(const aBuffer: PUtf32Char): Integer;
  begin
  {$ifdef DELPHIXE4__}
    result := AnsiStrings.StrLen(PAnsiChar(aBuffer));
  {$else}
    result := SysUtils.StrLen(PAnsiChar(aBuffer));
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.Append(const aString: Utf32Array;
                                const aChar: Utf32Char): Utf32Array;
  begin
    SetLength(result, Length(aString) + 1);
    CopyMemory(@result[0], @aString[0], Length(aString) * 4);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utf32Fn.CopyToBuffer(const aString: Utf32Array;
                                             aMaxBytes: Integer;
                                             aBuffer: Pointer;
                                             aOffset: Integer);
  var
    len: Integer;
  begin
    len := Length(aString);

    if (aMaxBytes < len) then
      len := aMaxBytes;

    CopyMemory(Memory.Offset(aBuffer, aOffset), PUtf32Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf32Fn.FromBuffer(aBuffer: PUtf32Char;
                                    aLen: Integer): Utf32Array;
  begin
    if aLen = -1 then
      aLen := Len(aBuffer);

    SetLength(result, aLen);
    CopyMemory(Pointer(result), aBuffer, aLen);
  end;



end.
