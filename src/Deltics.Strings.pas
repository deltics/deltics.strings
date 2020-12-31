{
  * X11 (MIT) LICENSE *

  Copyright � 2013 Jolyon Smith

  Permission is hereby granted, free of charge, to any person obtaining a copy of
   this software and associated documentation files (the "Software"), to deal in
   the Software without restriction, including without limitation the rights to
   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
   of the Software, and to permit persons to whom the Software is furnished to do
   so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.


  * GPL and Other Licenses *

  The FSF deem this license to be compatible with version 3 of the GPL.
   Compatability with other licenses should be verified by reference to those
   other license terms.


  * Contact Details *

  Original author : Jolyon Smith
  skype           : deltics
  e-mail          : <EXTLINK mailto: jsmith@deltics.co.nz>jsmith@deltics.co.nz</EXTLINK>
  website         : <EXTLINK http://www.deltics.co.nz>www.deltics.co.nz</EXTLINK>
}

{$i deltics.strings.inc}

{$debuginfo OFF}
{$ifdef debug_DelticsStringsHelpers}
  {$debuginfo ON}
{$endif}

  unit Deltics.Strings;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Strings.ANSI,
    Deltics.Strings.UTF8,
    Deltics.Strings.WIDE,
    Deltics.Strings.Encoding,
    Deltics.Strings.StringBuilder,
    Deltics.Strings.StringList,
    Deltics.Strings.Templates,
    Deltics.Strings.Types,
    Deltics.Strings.Utils;


  type
    TEncoding         = Deltics.Strings.Encoding.TEncoding;

    ASCIIString       = Deltics.Strings.Types.ASCIIString;
    ASCIIChar         = Deltics.Strings.Types.ASCIIChar;

    UTF8Char          = Deltics.Strings.Types.UTF8Char;
    PUTF8Char         = Deltics.Strings.Types.PUTF8Char;

    UTF8String        = Deltics.Strings.Types.UTF8String;
    UnicodeString     = Deltics.Strings.Types.UnicodeString;

    TCharIndexArray   = Deltics.Strings.Types.TCharIndexArray;
    TUTF8StringArray  = Deltics.Strings.Types.TUTF8StringArray;

    TANSICharSet      = Deltics.Strings.Types.TANSICharSet;
    TANSIStringArray  = Deltics.Strings.Types.TANSIStringArray;
    TANSIStringList   = Deltics.Strings.StringList.TANSIStringList;
    TANSIStrings      = Deltics.Strings.StringList.TANSIStrings;

    TWIDEStringArray  = Deltics.Strings.Types.TWIDEStringArray;
    TWIDEStringList   = Deltics.Strings.StringList.TWIDEStringList;
    TWIDEStrings      = Deltics.Strings.StringList.TWIDEStrings;

    TUnicodeStringArray  = Deltics.Strings.Types.TWIDEStringArray;

    TCaseSensitivity        = Deltics.Strings.Types.TCaseSensitivity;
    TCompareResult          = Deltics.Strings.Types.TCompareResult;
    TContainNeeds           = Deltics.Strings.Types.TContainNeeds;
    TCopyDelimiterOption    = Deltics.Strings.Types.TCopyDelimiterOption;
    TExtractDelimiterOption = Deltics.Strings.Types.TExtractDelimiterOption;
    TStringArray            = Deltics.Strings.Types.TStringArray;
    TStringProcessingFlag   = Deltics.Strings.Types.TStringProcessingFlag;
    TStringScope            = Deltics.Strings.Types.TStringScope;

    TStringBuilder            = Deltics.Strings.StringBuilder.TStringBuilder;
    TStringList               = Deltics.Strings.StringList.TStringList;
    IStringList               = Deltics.Strings.StringList.IStringList;
    TComInterfacedStringList  = Deltics.Strings.StringList.TComInterfacedStringList;

    TStringTemplate           = Deltics.Strings.Templates.TStringTemplate;

    TUnicodeSurrogateStrategy = Deltics.Strings.Types.TUnicodeSurrogateStrategy;

    EUnicode                  = Deltics.Strings.Types.EUnicode;
    EUnicodeDataloss          = Deltics.Strings.Types.EUnicodeDataloss;
    EUnicodeRequiresMultibyte = Deltics.Strings.Types.EUnicodeRequiresMultibyte;
    EUnicodeOrphanSurrogate   = Deltics.Strings.Types.EUnicodeOrphanSurrogate;

    Utils = Deltics.Strings.Utils.Utils;


  const
    csCaseSensitive  = Deltics.Strings.Types.csCaseSensitive;
    csIgnoreCase     = Deltics.Strings.Types.csIgnoreCase;

    doExcludeOptionalDelimiter  = Deltics.Strings.Types.doExcludeOptionalDelimiter;
    doExcludeRequiredDelimiter  = Deltics.Strings.Types.doExcludeRequiredDelimiter;
    doIncludeOptionalDelimiter  = Deltics.Strings.Types.doIncludeOptionalDelimiter;
    doIncludeRequiredDelimiter  = Deltics.Strings.Types.doIncludeRequiredDelimiter;

    doDeleteOptionalDelimiter   = Deltics.Strings.Types.doDeleteOptionalDelimiter;
    doDeleteRequiredDelimiter   = Deltics.Strings.Types.doDeleteRequiredDelimiter;
    doExtractOptionalDelimiter  = Deltics.Strings.Types.doExtractOptionalDelimiter;
    doExtractRequiredDelimiter  = Deltics.Strings.Types.doExtractRequiredDelimiter;
    doLeaveOptionalDelimiter    = Deltics.Strings.Types.doLeaveOptionalDelimiter;
    doLeaveRequiredDelimiter    = Deltics.Strings.Types.doLeaveRequiredDelimiter;

    CopyDelimiterOptional     = Deltics.Strings.Types.CopyDelimiterOptional;
    ExtractDelimiterOptional  = Deltics.Strings.Types.ExtractDelimiterOptional;

    isLesser  = Deltics.Strings.Types.isLesser;
    isEqual   = Deltics.Strings.Types.isEqual;
    isGreater = Deltics.Strings.Types.isGreater;

    cnAny     = Deltics.Strings.Types.cnAny;
    cnEvery   = Deltics.Strings.Types.cnEvery;
    cnOneOf   = Deltics.Strings.Types.cnOneOf;

    ssAll     = Deltics.Strings.Types.ssAll;
    ssFirst   = Deltics.Strings.Types.ssFirst;
    ssLast    = Deltics.Strings.Types.ssLast;

    ssError   = Deltics.Strings.Types.ssError;   // An EUnicodeOrphanSurrogate exception is raised if a string operation results in an orphan surrogate
    ssIgnore  = Deltics.Strings.Types.ssIgnore;  // String operations may result in orphan surrogates

    ssAvoid   = Deltics.Strings.Types.ssAvoid;   // String operations will ensure that surrogates are not orphaned


    dupAccept = Classes.dupAccept;

    dupError  = Classes.dupError;
    dupIgnore = Classes.dupIgnore;


  type
    ANSIFn = class(Deltics.Strings.ANSI.ANSIFn)
    public
      class function Alloc(const aString: ANSIString): PANSIChar;
      class function AllocWIDE(const aString: ANSIString): PWIDEChar;
    end;

    WIDEFn = class(Deltics.Strings.WIDE.WIDEFn)
    public
      class function Alloc(const aString: UnicodeString): PWIDEChar;
      class function AllocANSI(const aString: UnicodeString): PANSIChar;
    end;

    UTF8Fn = class(Deltics.Strings.UTF8.UTF8Fn);

    ASCIIFn = class
    public
      class function Encode(const aString: String): ASCIIString;
      class function TryEncode(const aString: String; var aASCII: ASCIIString): Boolean;
    end;

  {$ifdef UNICODE}
    STRFn = class(Deltics.Strings.WIDE.WIDEFn)
    public
      class function AllocANSI(const aString: String): PANSIChar;
      class function AllocWIDE(const aString: String): PWIDEChar;
      class function FromWIDE(const aString: String): UnicodeString; overload;
    end;
  {$else}
    STRFn = class(Deltics.Strings.ANSI.ANSIFn)
    public
      class function AllocANSI(const aString: String): PANSIChar;
      class function AllocWIDE(const aString: String): PWIDEChar;
      class function FromANSI(const aString: String): ANSIString; overload;
    end;
  {$endif}


  ANSIClass   = class of ANSIFn;
  UTF8Class   = class of UTF8Fn;
  WIDEClass   = class of WIDEFn;
  STRClass    = class of STRFn;
  ASCIIClass  = class of ASCIIFn;

  function ANSI: ANSIClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function ANSI(aBuffer: PANSIChar; aLen: Integer): ANSIString; overload;
  function ANSI(aInteger: Integer): ANSIString; overload;
  function ANSI(aChar: ANSIChar): ANSIChar; overload;
  function ANSI(aChar: WIDEChar): ANSIChar; overload;
  function ANSI(aString: UnicodeString): ANSIString; overload;
  procedure ANSI(aChar: WIDEChar; var aMBCS: ANSIString); overload;

  function WIDE: WIDEClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function WIDE(aBuffer: PWIDEChar; aLen: Integer): UnicodeString; overload;
  function WIDE(aChar: ANSIChar): WIDEChar; overload;
  function WIDE(aChar: WIDEChar): WIDEChar; overload;
  function WIDE(aString: ANSIString): UnicodeString; overload;
  function WIDE(const aInteger: Integer): UnicodeString; overload;

  function STR: STRClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function STR(aInteger: Integer): String; overload;
  function STR(aString: ANSIString): String; overload;
  function STR(aString: UnicodeString): String; overload;

  function UTF8: UTF8Class; overload; {$ifdef InlineMethods} inline; {$endif}
  function ASCII: ASCIIClass; overload; {$ifdef InlineMethods} inline; {$endif}


  {$ifdef TYPE_HELPERS}
  type
    TANSIStringHelper = record helper for ANSIString
    private
      function get_Length: Integer; inline;
    public
      function Split(aChar: ANSIChar; var aLeft, aRight: ANSIString): Boolean; overload;
      function Split(aChar: ANSIChar; var aArray: TANSIStringArray): Boolean; overload;
      property Length: Integer read get_Length;
    end;

    TStringHelper = record helper for UnicodeString
    private
      function get_Length: Integer; //inline;
    public
      function BeginsWith(const aString: String): Boolean;
      function BeginsWithText(const aString: String): Boolean;
      function Contains(aChar: ANSIChar): Boolean; overload;
      function Contains(aChar: WIDEChar): Boolean; overload;
      function Contains(const aString: String): Boolean; overload;
      function EndsWith(const aChar: WIDEChar): Boolean; overload;
      function EndsWith(const aString: String): Boolean; overload;
      function EqualsText(const aString: String): Boolean;
      function IsEmpty: Boolean; inline;
      function IsNotEmpty: Boolean; inline;
      function IsNotEmptyOrWhitespace: Boolean; inline;
      function IsOneOfText(const aArray: array of String): Boolean;
      function Split(aChar: WIDEChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      function Split(aChar: WIDEChar; var aArray: TWIDEStringArray): Integer; overload;
      function ToLower: String;
      function ToUpper: String;
      function Startcase: String;
      property Length: Integer read get_Length;
    end;


    TStringArrayHelper = record helper for TUnicodeStringArray
    private
      function get_Count: Integer; inline;
      function get_IsEmpty: Boolean; inline;
    public
      function Add(const aString: String): Integer; inline;
      function Delete(const aIndex: Integer): Integer; inline;
      procedure Insert(const aIndex: Integer; const aValue: String); overload; inline;
      procedure Insert(const aIndex: Integer; const aValues: TStringArray); overload; inline;
      property Count: Integer read get_Count;
      property IsEmpty: Boolean read get_IsEmpty;
    end;


    TStringListHelper = class helper for TStringList
    public
      procedure Add(const aArray: TStringArray); overload;
      function AsArray: TStringArray;
    end;

  {$endif TYPE_HELPERS}

  const
    BytesPerChar  = {$ifdef UNICODE} 2 {$else} 1 {$endif};

  var
    AllowUnicodeDataLoss      : Boolean = TRUE;
    UnicodeSurrogateStrategy  : TUnicodeSurrogateStrategy;


implementation

  uses
  {$ifdef FASTSTRINGS}
    FastStrings,
  {$endif}
  { vcl: }
  {$ifdef DELPHIXE4__}
    ANSIStrings,
  {$endif}
  {$ifdef __DELPHIXE2}
    StrUtils,
  {$endif}
    Windows;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Alloc(const aString: ANSIString): PANSIChar;
  var
    len: Integer;
  begin
    len     := Length(aString) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PANSIChar(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AllocWIDE(const aString: ANSIString): PWIDEChar;
  begin
    result := WIDE.Alloc(WIDE.FromANSI(aString));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Alloc(const aString: UnicodeString): PWIDEChar;
  var
    len: Integer;
  begin
    len     := (Length(aString) + 1) * 2;
    result  := AllocMem(len);

    CopyMemory(result, PWIDEChar(aString), len);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AllocANSI(const aString: UnicodeString): PANSIChar;
  var
    len: Integer;
    s: ANSIString;
  begin
    s := ANSI.FromWIDE(aString);

    len     := Length(s) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PANSIChar(s), len);
  end;





{$ifdef UNICODE}

  class function STRFn.AllocANSI(const aString: String): PANSIChar;
  begin
    result := WIDE.AllocANSI(aString);
  end;


  class function STRFn.AllocWIDE(const aString: String): PWIDEChar;
  begin
    result := WIDE.Alloc(aString);
  end;


  class function STRFn.FromWIDE(const aString: String): UnicodeString;
  begin
    result := aString;
  end;

{$else}

  class function STRFn.AllocWIDE(const aString: String): PWIDEChar;
  begin
    result := ANSI.AllocWIDE(aString);
  end;


  class function STRFn.AllocANSI(const aString: String): PANSIChar;
  begin
    result := ANSI.Alloc(aString);
  end;


  class function STRFn.FromANSI(const aString: String): ANSIString;
  begin
    result := aString;
  end;

{$endif}



  class function ASCIIFn.Encode(const aString: String): ASCIIString;
  begin
    TryEncode(aString, result);
  end;


  class function ASCIIFn.TryEncode(const aString: String;
                                   var   aASCII: ASCIIString): Boolean;
  var
    i: Integer;
    c: Char;
  begin
    aASCII := ASCIIString(aString);
    result := TRUE;

    for i := 1 to Length(aString) do
    begin
      c := aString[i];

      if Ord(c) > 127 then
      begin
        result    := FALSE;
        aASCII[i] := '?';
      end;
    end;
  end;







{ Factories -------------------------------------------------------------------------------------- }

  { ANSI - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

  function ANSI: ANSIClass;
  begin
    result := ANSIFn;
  end;

  function ANSI(aBuffer: PANSIChar; aLen: Integer): ANSIString;
  begin
    SetLength(result, aLen);
    if aLen > 0 then
      Move(aBuffer^, result[1], aLen);
  end;

  function ANSI(aChar: ANSIChar): ANSIChar;
  begin
    result := aChar;
  end;


  function ANSI(aChar: WIDEChar): ANSIChar;
  var
    usedDefault: BOOL;
  begin
    if aChar = #0 then
    begin
      result := #0;
      EXIT;
    end;

    usedDefault := FALSE;

    if (WideCharToMultiByte(CP_ACP, 0, @aChar, 0, NIL, 0, '?', @usedDefault) > 1)
     or (usedDefault and NOT AllowUnicodeDataLoss) then
      raise EUnicodeRequiresMultibyte.Create('Unicode character ''' + aChar + ''' does not map to a single-byte character in the default ANSI codepage');

    if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, @result, 1, '?', @usedDefault) = 0 then
      raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default ANSI codepage');

    if usedDefault and NOT AllowUnicodeDataLoss then
      raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current ANSI codepage');
  end;


  procedure ANSI(aChar: WIDEChar; var aMBCS: ANSIString);
  var
    len: Integer;
    usedDefault: BOOL;
  begin
    len := WideCharToMultiByte(CP_ACP, 0, @aChar, 1, NIL, 0, '?', NIL);

    SetLength(aMBCS, len);

    if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, PANSIChar(aMBCS), len, '?', @usedDefault) = 0 then
      raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default ANSI codepage');

    if usedDefault and NOT AllowUnicodeDataLoss then
      raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current ANSI codepage');
  end;


  function ANSI(aString: UnicodeString): ANSIString;
  begin
    result := ANSI.FromWIDE(aString);
  end;


  function ANSI(aInteger: Integer): ANSIString;
  begin
  {$ifdef UNICODE}
    result := ANSI.FromWIDE(IntToStr(aInteger));
  {$else}
    result := Format('%d', [aInteger]);
  {$endif}
  end;



  { WIDE - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }


  function WIDE: WIDEClass;
  begin
    result := WIDEFn;
  end;

  function WIDE(aBuffer: PWIDEChar; aLen: Integer): UnicodeString;
  begin
    SetLength(result, aLen);
    if aLen > 0 then
      Move(aBuffer^, result[1], aLen * 2);
  end;

  function WIDE(aChar: ANSIChar): WIDEChar;
  begin
    MultiByteToWideChar(CP_ACP, 0, @aChar, 1, @result, 1);
  end;

  function WIDE(aChar: WIDEChar): WIDEChar;
  begin
    result := aChar;
  end;


  function WIDE(aString: ANSIString): UnicodeString;
  begin
    result := WIDE.FromANSI(aString);
  end;


  function WIDE(const aInteger: Integer): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := IntToStr(aInteger);
  {$else}
    result := WIDE.Format('%d', [aInteger]);
  {$endif}
  end;


  { STR  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }


  function STR: STRClass; overload;
  begin
    result := STRFn;
  end;


  function STR(aInteger: Integer): String;
  begin
    result := IntToStr(aInteger);
  end;

  function STR(aString: ANSIString): String;
  begin
  {$ifdef UNICODE}
    result := WIDE(aString);
  {$else}
    result := aString;
  {$endif}
  end;

  function STR(aString: UnicodeString): String;
  begin
  {$ifNdef UNICODE}
    result := ANSI(aString);
  {$else}
    result := aString;
  {$endif}
  end;



  { UTF8 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

  function UTF8: UTF8Class;
  begin
    result := UTF8Fn;
  end;


  function ASCII: ASCIIClass;
  begin
    result := ASCIIFn;
  end;





{$ifdef TYPE_HELPERS}

{ TANSIStringHelper ------------------------------------------------------------------------------ }

  function TANSIStringHelper.get_Length: Integer;
  begin
    result := System.Length(self);
  end;


  function TANSIStringHelper.Split(aChar: ANSIChar; var aLeft, aRight: ANSIString): Boolean;
  begin
    result := ANSI.Split(self, aChar, aLeft, aRight);
  end;


  function TANSIStringHelper.Split(aChar: ANSIChar; var aArray: TANSIStringArray): Boolean;
  begin
    result := ANSI.Split(self, aChar, aArray);
  end;




{ TStringHelper ---------------------------------------------------------------------------------- }

  function TStringHelper.get_Length: Integer;
  begin
    result := System.Length(self);
  end;

  function TStringHelper.BeginsWith(const aString: String): Boolean;
  begin
    result := WIDE.BeginsWith(self, aString, csCaseSensitive);
  end;

  function TStringHelper.BeginsWithText(const aString: String): Boolean;
  begin
    result := WIDE.BeginsWith(self, aString, csIgnoreCase);
  end;

  function TStringHelper.Contains(aChar: ANSIChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := WIDE.Find(self, WIDE.FromANSI(aChar), notUsed);
  end;

  function TStringHelper.Contains(aChar: WIDEChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := WIDE.Find(self, aChar, notUsed);
  end;

  function TStringHelper.Contains(const aString: String): Boolean;
  var
    notUsed: Integer;
  begin
    result := WIDE.Find(self, aString, notUsed);
  end;

  function TStringHelper.EndsWith(const aChar: WIDEChar): Boolean;
  begin
    result := WIDE.EndsWith(self, aChar);
  end;

  function TStringHelper.EndsWith(const aString: String): Boolean;
  begin
    result := WIDE.EndsWith(self, aString);
  end;

  function TStringHelper.EqualsText(const aString: String): Boolean;
  begin
    result := (WIDE.Compare(self, aString, csIgnoreCase) = isEqual);
  end;

  function TStringHelper.IsEmpty: Boolean;
  begin
    result := self = '';
  end;

  function TStringHelper.IsNotEmpty: Boolean;
  begin
    result := self <> '';
  end;

  function TStringHelper.IsNotEmptyOrWhitespace: Boolean;
  begin
    result := STR.Trim(self) <> '';
  end;


  function TStringHelper.IsOneOfText(const aArray: array of String): Boolean;
  var
    i: Integer;
  begin
    result := FALSE;

    for i := 0 to High(aArray) do
    begin
      result := STR.SameText(aArray[i], self);
      if result then
        EXIT;
    end;
  end;


  function TStringHelper.Split(aChar: WIDEChar; var aLeft, aRight: String): Boolean;
  begin
    result := WIDE.Split(self, aChar, aLeft, aRight);
  end;

  function TStringHelper.Split(aChar: WIDEChar; var aArray: TWIDEStringArray): Integer;
  begin
    result := WIDE.Split(self, aChar, aArray);
  end;

  function TStringHelper.Startcase: String;
  begin
    result := WIDE.Startcase(self);
  end;

  function TStringHelper.ToLower: String;
  begin
    result := WIDE.Lowercase(self);
  end;


  function TStringHelper.ToUpper: String;
  begin
    result := WIDE.Uppercase(self);
  end;





  function TStringArrayHelper.get_Count: Integer;
  begin
    result := Length(self);
  end;


  function TStringArrayHelper.get_IsEmpty: Boolean;
  begin
    result := Length(self) = 0;
  end;


  function TStringArrayHelper.Add(const aString: String): Integer;
  begin
    result := Length(self);
    SetLength(self, result + 1);
    self[result] := aString;
  end;



  function TStringArrayHelper.Delete(const aIndex: Integer): Integer;
  var
    i: Integer;
  begin
    result := Count - 1;

    for i := 0 to High(self) do
      if i < aIndex then
        CONTINUE
      else if i > aIndex then
        self[i - 1] := self[i];

    SetLength(self, result);
  end;


  procedure TStringArrayHelper.Insert(const aIndex: Integer;
                                      const aValue: String);
  var
    i: Integer;
  begin
    SetLength(self, Length(self) + 1);

    for i := High(self) downto aIndex do
      if i > aIndex then
        self[i] := self[i - 1];

    self[aIndex] := aValue;
  end;


  procedure TStringArrayHelper.Insert(const aIndex: Integer;
                                      const aValues: TStringArray);
  var
    i: Integer;
    wedge: Integer;
  begin
    wedge := Length(aValues);
    SetLength(self, Length(self) + wedge);

    for i := High(self) downto (aIndex + wedge) do
      if i > aIndex then
        self[i] := self[i - wedge];

    for i := 0 to Pred(wedge) do
      self[aIndex + i] := aValues[i];
  end;





  procedure TStringListHelper.Add(const aArray: TStringArray);
  var
    i: Integer;
  begin
    for i := 0 to High(aArray) do
      Add(aArray[i]);
  end;



  function TStringListHelper.AsArray: TStringArray;
  var
    i: Integer;
  begin
    SetLength(result, Count);

    for i := 0 to Pred(Count) do
      result[i] := self[i];
  end;




{$endif TYPE_HELPERS}


end.
