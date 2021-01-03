
{$i deltics.strings.inc}


  unit Deltics.Strings.UTF8;


interface

  uses
    Deltics.Strings.Types;


  type
    UTF8Fn = class
      // Transcoding
      class function Encode(const aString: String): UTF8String;
      class function FromANSI(const aString: ANSIString): UTF8String; overload;
      class function FromANSI(const aString: PANSIChar; aMaxLen: Integer = -1): UTF8String; overload;
      class function FromString(const aString: String): Utf8String;
      class function FromWIDE(const aString: UnicodeString): UTF8String; overload;
      class function FromWIDE(const aString: PWIDEChar; aMaxLen: Integer = -1): UTF8String; overload;

      // Buffer operations
      class function Alloc(const aString: UTF8String): PUTF8Char;
      class function Len(const aBuffer: PUTF8Char): Integer;
      class procedure CopyToBuffer(const aString: UTF8String; aMaxBytes: Integer; aBuffer: Pointer; aOffset: Integer);
      class function FromBuffer(aBuffer: PUTF8Char; aLen: Integer = -1): UTF8String;
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


{ _UTF8 ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.Encode(const aString: String): UTF8String;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromANSI(const aString: ANSIString): UTF8String;
  begin
    result := FromWIDE(WIDE.FromANSI(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromANSI(const aString: PANSIChar;
                                       aMaxLen: Integer): UTF8String;
  begin
    result := FromWIDE(WIDE.FromANSI(Copy(aString, 1, aMaxLen)));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromString(const aString: String): Utf8String;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromWIDE(const aString: UnicodeString): UTF8String;
  begin
    result := FromWIDE(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromWIDE(const aString: PWIDEChar;
                                       aMaxLen: Integer): UTF8String;
  var
    len: Integer;
  begin
    len := WideCharToMultiByte(CP_UTF8, 0, aString, -1, NIL, 0, NIL, NIL);
    Dec(len);

    SetLength(result, len);
    WideCharToMultiByte(CP_UTF8, 0, aString, aMaxLen, PANSIChar(result), len, NIL, NIL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.Alloc(const aString: UTF8String): PUTF8Char;
  var
    len: Integer;
  begin
    len     := Length(aString) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PUTF8Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.Len(const aBuffer: PUTF8Char): Integer;
  begin
  {$ifdef DELPHIXE4__}
    result := ANSIStrings.StrLen(PANSIChar(aBuffer));
  {$else}
    result := SysUtils.StrLen(PANSIChar(aBuffer));
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure UTF8Fn.CopyToBuffer(const aString: UTF8String;
                                            aMaxBytes: Integer;
                                            aBuffer: Pointer;
                                            aOffset: Integer);
  var
    len: Integer;
  begin
    len := Length(aString);

    if (aMaxBytes < len) then
      len := aMaxBytes;

    CopyMemory(Memory.ByteOffset(aBuffer, aOffset), PUTF8Char(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function UTF8Fn.FromBuffer(aBuffer: PUTF8Char;
                                   aLen: Integer): UTF8String;
  begin
    if aLen = -1 then
      aLen := Len(aBuffer);

    SetLength(result, aLen);
    CopyMemory(Pointer(result), aBuffer, aLen);
  end;



end.
