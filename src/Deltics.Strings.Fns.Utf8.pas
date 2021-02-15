
{$i deltics.strings.inc}


  unit Deltics.Strings.Fns.Utf8;


interface

  uses
    Deltics.Strings.Types;


  type
    Utf8Fn = class
      // Transcoding
      class function Encode(const aString: String): Utf8String;
      class function FromANSI(const aString: ANSIString): Utf8String; overload;
      class function FromANSI(const aString: PANSIChar; aMaxLen: Integer = -1): Utf8String; overload;
      class function FromString(const aString: String): Utf8String;
      class function FromWIDE(const aString: UnicodeString): Utf8String; overload;
      class function FromWIDE(const aString: PWIDEChar; aMaxLen: Integer = -1): Utf8String; overload;

      // Buffer operations
      class function Alloc(const aString: Utf8String): PUtf8Char;
      class function Len(const aBuffer: PUtf8Char): Integer;
      class procedure CopyToBuffer(const aString: Utf8String; aMaxBytes: Integer; aBuffer: Pointer; aOffset: Integer);
      class function FromBuffer(aBuffer: PUtf8Char; aLen: Integer = -1): Utf8String;

      // Miscellaneous functions
      class function Append(const aString: Utf8String; const aChar: Utf8Char): Utf8String; overload;
      class function Append(const aString: Utf8String; const aValue: Utf8String): Utf8String; overload;
      class function StringOf(const aChar: Utf8Char; const aLength: Integer): Utf8String;
    end;


implementation

  uses
  {$ifdef DELPHIXE4__}
    ANSIStrings,
  {$endif}
    SysUtils,
    Windows,
    Deltics.Strings,
    Deltics.Pointers;


{ _Utf8 ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Encode(const aString: String): Utf8String;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromANSI(const aString: ANSIString): Utf8String;
  begin
    result := FromWIDE(WIDE.FromANSI(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromANSI(const aString: PANSIChar;
                                       aMaxLen: Integer): Utf8String;
  begin
    result := FromWIDE(WIDE.FromANSI(Copy(aString, 1, aMaxLen)));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromString(const aString: String): Utf8String;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromWIDE(const aString: UnicodeString): Utf8String;
  begin
    result := FromWIDE(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromWIDE(const aString: PWIDEChar;
                                       aMaxLen: Integer): Utf8String;
  var
    len: Integer;
  begin
    len := WideCharToMultiByte(CP_Utf8, 0, aString, -1, NIL, 0, NIL, NIL);
    Dec(len);

    SetLength(result, len);
    WideCharToMultiByte(CP_Utf8, 0, aString, aMaxLen, PANSIChar(result), len, NIL, NIL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Alloc(const aString: Utf8String): PUtf8Char;
  var
    len: Integer;
  begin
    len     := Length(aString) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PUtf8Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Len(const aBuffer: PUtf8Char): Integer;
  begin
  {$ifdef DELPHIXE4__}
    result := ANSIStrings.StrLen(PANSIChar(aBuffer));
  {$else}
    result := SysUtils.StrLen(PANSIChar(aBuffer));
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Append(const aString: Utf8String;
                               const aChar: Utf8Char): Utf8String;
  begin
    result := aString;

    SetLength(result, Length(result) + 1);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Append(const aString: Utf8String;
                               const aValue: Utf8String): Utf8String;
  var
    p: PUtf8Char;
  begin
    result := aString;

    SetLength(result, Length(result) + Length(aValue));
    p := PUtf8Char(@(result[Length(aString)]));
    Inc(p);

    CopyMemory(p, @aValue[1], Length(aValue));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.StringOf(const aChar: Utf8Char;
                                 const aLength: Integer): Utf8String;
  var
    i: Integer;
  begin
    SetLength(result, aLength);
    for i := 1 to aLength do
      result[i] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utf8Fn.CopyToBuffer(const aString: Utf8String;
                                            aMaxBytes: Integer;
                                            aBuffer: Pointer;
                                            aOffset: Integer);
  var
    len: Integer;
  begin
    len := Length(aString);

    if (aMaxBytes < len) then
      len := aMaxBytes;

    CopyMemory(Memory.ByteOffset(aBuffer, aOffset), PUtf8Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.FromBuffer(aBuffer: PUtf8Char;
                                   aLen: Integer): Utf8String;
  begin
    if aLen = -1 then
      aLen := Len(aBuffer);

    SetLength(result, aLen);
    CopyMemory(Pointer(result), aBuffer, aLen);
  end;



end.
