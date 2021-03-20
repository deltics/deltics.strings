
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
      class function BeginsWith(const aString: Utf8String; aChar: AsciiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString: Utf8String; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString, aSubstring: Utf8String; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWithText(const aString: Utf8String; aChar: AsciiChar): Boolean; overload;
      class function BeginsWithText(const aString: Utf8String; aChar: WideChar): Boolean; overload;
      class function BeginsWithText(const aString, aSubstring: Utf8String): Boolean; overload;

      class function Compare(const A, B: Utf8String; const aCaseMode: TCaseSensitivity = csCaseSensitive): TCompareResult;
      class function CompareText(const A, B: Utf8String): TCompareResult;
      class procedure DeleteLeft(var aString: Utf8String; aCount: Integer); overload;
      class function Find(const aString: Utf8String; const aChar: Utf8Char; var aPos: Integer): Boolean; overload;
      class function IsEmpty(const aString: Utf8String): Boolean; overload;
      class function IsEmpty(const aString: Utf8String; var aLength: Integer): Boolean; overload;
      class function IsNotEmpty(const aString: Utf8String): Boolean; overload;
      class function IsNotEmpty(const aString: Utf8String; var aLength: Integer): Boolean; overload;
      class function Split(const aString: Utf8String; const aChar: Utf8Char; var aLeft, aRight: Utf8String): Boolean; overload;
      //class function Split(const aString: Utf8String; const aDelim: Utf8String; var aLeft, aRight: Utf8String): Boolean; overload;
      class function StringOf(const aChar: Utf8Char; const aLength: Integer): Utf8String;
    end;


implementation

  uses
  {$ifdef DELPHIXE4__}
    ANSIStrings,
  {$endif}
    SysUtils,
    Windows,
    Deltics.Contracts,
    Deltics.Memory,
    Deltics.Strings;


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
  class function Utf8Fn.IsNotEmpty(const aString: Utf8String): Boolean;
  begin
    result := Length(aString) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.IsEmpty(const aString: Utf8String): Boolean;
  begin
    result := Length(aString) = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.IsEmpty(const aString: Utf8String; var aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.IsNotEmpty(const aString: Utf8String; var aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength > 0;
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
  class function Utf8Fn.BeginsWith(const aString: Utf8String;
                                         aChar: WideChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    asWide: UnicodeString;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    asWide := Wide.FromUtf8(aString);

    case aCaseMode of
      csCaseSensitive : result := (asWide[1] = aChar);
      csIgnoreCase    : result := Wide.BeginsWithText(asWide, aChar);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.BeginsWith(const aString, aSubstring: Utf8String;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    asWide: UnicodeString;
    sub: UnicodeString;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    case aCaseMode of
      csCaseSensitive : result := (Length(aSubString) <= Length(aString))
                              and CompareMem(Pointer(aString), Pointer(aSubString), Length(aSubstring));
                              
      csIgnoreCase    : begin
                          asWide  := Wide.FromUtf8(aString);
                          sub     := Wide.FromUtf8(aSubstring);

                          result  := (Length(sub) <= Length(asWide))
                                 and Wide.BeginsWithText(asWide, sub);
                        end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.BeginsWith(const aString: Utf8String;
                                         aChar: AsciiChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    Contract.RequiresUtf8('aChar', aChar).IsNotNull;
    Contract.RequiresUtf8('aChar', aChar).IsAscii;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    case aCaseMode of
      csCaseSensitive : result := aString[1] = aChar;
      csIgnoreCase    : result := BeginsWithText(aString, aChar);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.BeginsWithText(const aString: Utf8String; aChar: WideChar): Boolean;
  var
    asWide: UnicodeString;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    asWide := Wide.FromUtf8(aString);
    result := Wide.BeginsWithText(asWide, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.BeginsWithText(const aString, aSubstring: Utf8String): Boolean;
  var
    asWide: UnicodeString;
    sub: UnicodeString;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    asWide  := Wide.FromUtf8(aString);
    sub     := Wide.FromUtf8(aSubstring);

    result  := (Length(sub) <= Length(asWide))
           and Wide.BeginsWithText(asWide, sub);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.BeginsWithText(const aString: Utf8String; aChar: AsciiChar): Boolean;
  begin
    Contract.RequiresUtf8('aChar', aChar).IsNotNull;
    Contract.RequiresUtf8('aChar', aChar).IsAscii;

    result := Length(aString) > 0;
    if NOT result then
      EXIT;

    case aChar of
      #65..#90,
      #97..#122 : result := (Byte(aString[1]) xor 32) = (Byte(aChar) xor 32);
    else
      result := aString[1] = aChar;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utf8Fn.DeleteLeft(var aString: Utf8String;
                                        aCount: Integer);
  var
    copyChars: Integer;
    firstChar: Integer;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    if (aCount = 0) or IsEmpty(aString, copyChars) then
      EXIT;

    Dec(copyChars, aCount);
    firstChar := aCount + 1;

    if copyChars > 0 then
      Utils.CopyUtf8Chars(aString, firstChar, 1, copyChars)
    else
      copyChars := 0;

    SetLength(aString, copyChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Find(const aString: Utf8String;
                             const aChar: utf8Char;
                             var   aPos: Integer): Boolean;
  begin
    aPos    := Pos(aChar, aString);
    result  := aPos > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.Split(const aString: Utf8String;
                              const aChar: Utf8Char;
                              var aLeft: Utf8String;
                              var aRight: Utf8String): Boolean;
  var
    p: Integer;
  begin
    aLeft   := aString;
    aRight  := '';

    result  := Find(aString, aChar, p);
    if NOT result then
      EXIT;

    SetLength(aLeft, p - 1);
    aRight := System.Copy(aString, p + 1, System.Length(aString) - p);
  end;


//  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
//  class function Utf8Fn.Split(const aString: Utf8String;
//                              const aDelim: Utf8String;
//                              var aLeft: Utf8String;
//                              var aRight: Utf8String): Boolean;
//  var
//    p, delimLen: Integer;
//  begin
//    Contract.Requires('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);
//
//    aLeft   := aString;
//    aRight  := '';
//
//    result  := Find(aString, aDelim, p);
//    if NOT result then
//      EXIT;
//
//    SetLength(aLeft, p - 1);
//    aRight := System.Copy(aString, p + delimLen, System.Length(aString) - (p + delimLen - 1));
//  end;



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
  class function Utf8Fn.Compare(const A, B: Utf8String;
                                const aCaseMode: TCaseSensitivity): TCompareResult;
  var
    wideA: UnicodeString;
    wideB: UnicodeString;
  begin
    wideA := Wide.FromUtf8(A);
    wideB := Wide.FromUtf8(B);

    result := Wide.Compare(wideA, wideB, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utf8Fn.CompareText(const A, B: Utf8String): TCompareResult;
  var
    wideA: UnicodeString;
    wideB: UnicodeString;
  begin
    wideA := Wide.FromUtf8(A);
    wideB := Wide.FromUtf8(B);

    result := Wide.CompareText(wideA, wideB);
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

    CopyMemory(Memory.Offset(aBuffer, aOffset), PUtf8Char(aString), len);
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
