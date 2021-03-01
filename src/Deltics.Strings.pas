{
  * X11 (MIT) LICENSE *

  Copyright © 2013 Jolyon Smith

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
    Deltics.Strings.Encoding,
    Deltics.Strings.Fns.Ansi,
    Deltics.Strings.Fns.Utf8,
    Deltics.Strings.Fns.Utf32,
    Deltics.Strings.Fns.Wide,
    Deltics.Strings.StringBuilder,
    Deltics.Strings.StringList,
    Deltics.Strings.Templates,
    Deltics.Strings.Types,
    Deltics.Strings.Types.BOM,
    Deltics.Strings.Utils;


  type
    Encoding          = Deltics.Strings.Encoding.Encoding;
    TEncoding         = Deltics.Strings.Encoding.TEncoding;

    ASCIIString       = Deltics.Strings.Types.ASCIIString;
    ASCIIChar         = Deltics.Strings.Types.ASCIIChar;

    Utf8Char          = Deltics.Strings.Types.Utf8Char;
    PUtf8Char         = Deltics.Strings.Types.PUtf8Char;

    Utf32Char         = Deltics.Strings.Types.Utf32Char;
    PUtf32Char        = Deltics.Strings.Types.PUtf32Char;

    Utf8String        = Deltics.Strings.Types.Utf8String;
    Utf32Array        = Deltics.Strings.Types.Utf32Array;
    UnicodeString     = Deltics.Strings.Types.UnicodeString;

    AnsiCharSet       = Deltics.Strings.Types.AnsiCharSet;
    TAnsiStringList   = Deltics.Strings.StringList.TAnsiStringList;
    TAnsiStrings      = Deltics.Strings.StringList.TAnsiStrings;

    TWideStringList   = Deltics.Strings.StringList.TWideStringList;
    TWideStrings      = Deltics.Strings.StringList.TWideStrings;

    CharIndexArray    = Deltics.Strings.Types.CharIndexArray;

    AnsiStringArray     = Deltics.Strings.Types.AnsiStringArray;
    StringArray         = Deltics.Strings.Types.StringArray;
    UnicodeStringArray  = Deltics.Strings.Types.UnicodeStringArray;
    Utf8StringArray     = Deltics.Strings.Types.Utf8StringArray;
    WideStringArray     = Deltics.Strings.Types.WideStringArray;

    TCaseSensitivity        = Deltics.Strings.Types.TCaseSensitivity;
    TCompareResult          = Deltics.Strings.Types.TCompareResult;
    TContainNeeds           = Deltics.Strings.Types.TContainNeeds;
    TCopyDelimiterOption    = Deltics.Strings.Types.TCopyDelimiterOption;
    TExtractDelimiterOption = Deltics.Strings.Types.TExtractDelimiterOption;
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

    TBOM        = Deltics.Strings.Types.BOM.TBOM;

    Utf8Bom     = Deltics.Strings.Types.BOM.Utf8Bom;
    Utf16Bom    = Deltics.Strings.Types.BOM.Utf16Bom;
    Utf16LEBom  = Deltics.Strings.Types.BOM.Utf16LEBom;
    Utf32Bom    = Deltics.Strings.Types.BOM.Utf32Bom;
    Utf32LEBom  = Deltics.Strings.Types.BOM.Utf32LEBom;


  const
    cpUtf32LE  = Deltics.Strings.Encoding.cpUtf32LE;
    cpUtf32    = Deltics.Strings.Encoding.cpUtf32;
    cpUtf16LE  = Deltics.Strings.Encoding.cpUtf16LE;
    cpUtf16    = Deltics.Strings.Encoding.cpUtf16;
    cpASCII    = Deltics.Strings.Encoding.cpASCII;
    cpUtf8     = Deltics.Strings.Encoding.cpUtf8;

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
    AnsiFn = class(Deltics.Strings.Fns.Ansi.AnsiFn)
    public
      class function Alloc(const aString: AnsiString): PAnsiChar;
      class function AllocWide(const aString: AnsiString): PWideChar;
    end;

    WideFn = class(Deltics.Strings.Fns.Wide.WideFn)
    public
      class function Alloc(const aString: UnicodeString): PWideChar;
      class function AllocAnsi(const aString: UnicodeString): PAnsiChar;
    end;

    Utf8Fn  = class(Deltics.Strings.Fns.Utf8.Utf8Fn);
    Utf32Fn = class(Deltics.Strings.Fns.Utf32.Utf32Fn);

    ASCIIFn = class
    public
      class function Encode(const aString: String): ASCIIString;
      class function TryEncode(const aString: String; var aASCII: ASCIIString): Boolean;
    end;

  {$ifdef UNICODE}
    STRFn = class(Deltics.Strings.Fns.Wide.WideFn)
    public
      class function AllocAnsi(const aString: String): PAnsiChar;
      class function AllocWide(const aString: String): PWideChar;
      class function FromWide(const aString: String): UnicodeString; overload;
    end;
  {$else}
    STRFn = class(Deltics.Strings.Fns.Ansi.AnsiFn)
    public
      class function AllocAnsi(const aString: String): PAnsiChar;
      class function AllocWide(const aString: String): PWideChar;
      class function FromAnsi(const aString: String): AnsiString; overload;
    end;
  {$endif}


  AnsiClass   = class of AnsiFn;
  Utf8Class   = class of Utf8Fn;
  Utf32Class  = class of Utf32Fn;
  WideClass   = class of WideFn;
  STRClass    = class of STRFn;
  ASCIIClass  = class of ASCIIFn;

  function Ansi: AnsiClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function Ansi(aBuffer: PAnsiChar; aLen: Integer): AnsiString; overload;
  function Ansi(aInteger: Integer): AnsiString; overload;
  function Ansi(aChar: AnsiChar): AnsiChar; overload;
  function Ansi(aChar: WideChar): AnsiChar; overload;
  function Ansi(aString: UnicodeString): AnsiString; overload;
  procedure Ansi(aChar: WideChar; var aMBCS: AnsiString); overload;

  function Wide: WideClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function Wide(aBuffer: PWideChar; aLen: Integer): UnicodeString; overload;
  function Wide(aChar: AnsiChar): WideChar; overload;
  function Wide(aChar: WideChar): WideChar; overload;
  function Wide(aString: AnsiString): UnicodeString; overload;
  function Wide(const aInteger: Integer): UnicodeString; overload;

  function STR: STRClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function STR(aInteger: Integer): String; overload;
  function STR(aString: AnsiString): String; overload;
  function STR(aString: UnicodeString): String; overload;

  function Utf8: Utf8Class; overload; {$ifdef InlineMethods} inline; {$endif}
  function Utf32: Utf32Class; overload; {$ifdef InlineMethods} inline; {$endif}
  function ASCII: ASCIIClass; overload; {$ifdef InlineMethods} inline; {$endif}


  {$ifdef TYPE_HELPERS}
  type
    AnsiStringHelper = record helper for AnsiString
    private
      function get_Length: Integer; inline;
    public
      function Split(aChar: AnsiChar; var aLeft, aRight: AnsiString): Boolean; overload;
      function Split(aChar: AnsiChar; var aArray: AnsiStringArray): Boolean; overload;
      property Length: Integer read get_Length;
    end;

    UnicodeStringHelper = record helper for String
    private
      function get_Length: Integer; //inline;
    public
      function BeginsWith(const aString: String): Boolean;
      function BeginsWithText(const aString: String): Boolean;
      function Contains(aChar: AnsiChar): Boolean; overload;
      function Contains(aChar: WideChar): Boolean; overload;
      function Contains(const aString: String): Boolean; overload;
      function EndsWith(const aChar: WideChar): Boolean; overload;
      function EndsWith(const aString: String): Boolean; overload;
      function EqualsText(const aString: String): Boolean;
      function IsEmpty: Boolean; inline;
      function IsNotEmpty: Boolean; inline;
      function IsNotEmptyOrWhitespace: Boolean; inline;
      function IsOneOfText(const aArray: array of String): Boolean;
      function Split(aChar: WideChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      function Split(aChar: WideChar; var aArray: WideStringArray): Integer; overload;
      function ToLower: String;
      function ToUpper: String;
      function Startcase: String;
      property Length: Integer read get_Length;
    end;


    StringArrayHelper = record helper for StringArray
    private
      function get_Count: Integer; inline;
      function get_IsEmpty: Boolean; inline;
    public
      function Add(const aString: String): Integer; inline;
      function Delete(const aIndex: Integer): Integer; inline;
      procedure Insert(const aIndex: Integer; const aValue: String); overload; inline;
      procedure Insert(const aIndex: Integer; const aValues: StringArray); overload; inline;
      property Count: Integer read get_Count;
      property IsEmpty: Boolean read get_IsEmpty;
    end;


    TStringListHelper = class helper for TStringList
    public
      procedure Add(const aArray: StringArray); overload;
      function AsArray: StringArray;
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
  {$ifdef DELPHIXE4__}
    AnsiStrings,
  {$endif}
  {$ifdef __DELPHIXE2}
    StrUtils,
  {$endif}
    Windows
  {$ifdef InlineMethodsSupported}
    ,Deltics.Unicode.Types
  {$endif};




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Alloc(const aString: AnsiString): PAnsiChar;
  var
    len: Integer;
  begin
    len     := Length(aString) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PAnsiChar(aString), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AllocWide(const aString: AnsiString): PWideChar;
  begin
    result := Wide.Alloc(Wide.FromAnsi(aString));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Alloc(const aString: UnicodeString): PWideChar;
  var
    len: Integer;
  begin
    len     := (Length(aString) + 1) * 2;
    result  := AllocMem(len);

    CopyMemory(result, PWideChar(aString), len);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.AllocAnsi(const aString: UnicodeString): PAnsiChar;
  var
    len: Integer;
    s: AnsiString;
  begin
    s := Ansi.FromWide(aString);

    len     := Length(s) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PAnsiChar(s), len);
  end;





{$ifdef UNICODE}

  class function STRFn.AllocAnsi(const aString: String): PAnsiChar;
  begin
    result := Wide.AllocAnsi(aString);
  end;


  class function STRFn.AllocWide(const aString: String): PWideChar;
  begin
    result := Wide.Alloc(aString);
  end;


  class function STRFn.FromWide(const aString: String): UnicodeString;
  begin
    result := aString;
  end;

{$else}

  class function STRFn.AllocWide(const aString: String): PWideChar;
  begin
    result := Ansi.AllocWide(aString);
  end;


  class function STRFn.AllocAnsi(const aString: String): PAnsiChar;
  begin
    result := Ansi.Alloc(aString);
  end;


  class function STRFn.FromAnsi(const aString: String): AnsiString;
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

  { Ansi - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

  function Ansi: AnsiClass;
  begin
    result := AnsiFn;
  end;

  function Ansi(aBuffer: PAnsiChar; aLen: Integer): AnsiString;
  begin
    SetLength(result, aLen);
    if aLen > 0 then
      Move(aBuffer^, result[1], aLen);
  end;

  function Ansi(aChar: AnsiChar): AnsiChar;
  begin
    result := aChar;
  end;


  function Ansi(aChar: WideChar): AnsiChar;
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
      raise EUnicodeRequiresMultibyte.Create('Unicode character ''' + aChar + ''' does not map to a single-byte character in the default Ansi codepage');

    if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, @result, 1, '?', @usedDefault) = 0 then
      raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default Ansi codepage');

    if usedDefault and NOT AllowUnicodeDataLoss then
      raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current Ansi codepage');
  end;


  procedure Ansi(aChar: WideChar; var aMBCS: AnsiString);
  var
    len: Integer;
    usedDefault: BOOL;
  begin
    len := WideCharToMultiByte(CP_ACP, 0, @aChar, 1, NIL, 0, '?', NIL);

    SetLength(aMBCS, len);

    if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, PAnsiChar(aMBCS), len, '?', @usedDefault) = 0 then
      raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default Ansi codepage');

    if usedDefault and NOT AllowUnicodeDataLoss then
      raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current Ansi codepage');
  end;


  function Ansi(aString: UnicodeString): AnsiString;
  begin
    result := Ansi.FromWide(aString);
  end;


  function Ansi(aInteger: Integer): AnsiString;
  begin
  {$ifdef UNICODE}
    result := Ansi.FromWide(IntToStr(aInteger));
  {$else}
    result := Format('%d', [aInteger]);
  {$endif}
  end;



  { Wide - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }


  function Wide: WideClass;
  begin
    result := WideFn;
  end;

  function Wide(aBuffer: PWideChar; aLen: Integer): UnicodeString;
  begin
    SetLength(result, aLen);
    if aLen > 0 then
      Move(aBuffer^, result[1], aLen * 2);
  end;

  function Wide(aChar: AnsiChar): WideChar;
  begin
    MultiByteToWideChar(CP_ACP, 0, @aChar, 1, @result, 1);
  end;

  function Wide(aChar: WideChar): WideChar;
  begin
    result := aChar;
  end;


  function Wide(aString: AnsiString): UnicodeString;
  begin
    result := Wide.FromAnsi(aString);
  end;


  function Wide(const aInteger: Integer): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := IntToStr(aInteger);
  {$else}
    result := Wide.Format('%d', [aInteger]);
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

  function STR(aString: AnsiString): String;
  begin
  {$ifdef UNICODE}
    result := Wide(aString);
  {$else}
    result := aString;
  {$endif}
  end;

  function STR(aString: UnicodeString): String;
  begin
  {$ifNdef UNICODE}
    result := Ansi(aString);
  {$else}
    result := aString;
  {$endif}
  end;



  { Utf8 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }

  function Utf8: Utf8Class;
  begin
    result := Utf8Fn;
  end;


  function Utf32: Utf32Class;
  begin
    result := Utf32Fn;
  end;


  function ASCII: ASCIIClass;
  begin
    result := ASCIIFn;
  end;





{$ifdef TYPE_HELPERS}

{ TAnsiStringHelper ------------------------------------------------------------------------------ }

  function AnsiStringHelper.get_Length: Integer;
  begin
    result := System.Length(self);
  end;


  function AnsiStringHelper.Split(aChar: AnsiChar; var aLeft, aRight: AnsiString): Boolean;
  begin
    result := Ansi.Split(self, aChar, aLeft, aRight);
  end;


  function AnsiStringHelper.Split(aChar: AnsiChar; var aArray: AnsiStringArray): Boolean;
  begin
    result := Ansi.Split(self, aChar, aArray);
  end;




{ TStringHelper ---------------------------------------------------------------------------------- }

  function UnicodeStringHelper.get_Length: Integer;
  begin
    result := System.Length(self);
  end;

  function UnicodeStringHelper.BeginsWith(const aString: String): Boolean;
  begin
    result := Wide.BeginsWith(self, aString, csCaseSensitive);
  end;

  function UnicodeStringHelper.BeginsWithText(const aString: String): Boolean;
  begin
    result := Wide.BeginsWith(self, aString, csIgnoreCase);
  end;

  function UnicodeStringHelper.Contains(aChar: AnsiChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Wide.Find(self, Wide.FromAnsi(aChar), notUsed);
  end;

  function UnicodeStringHelper.Contains(aChar: WideChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Wide.Find(self, aChar, notUsed);
  end;

  function UnicodeStringHelper.Contains(const aString: String): Boolean;
  var
    notUsed: Integer;
  begin
    result := Wide.Find(self, aString, notUsed);
  end;

  function UnicodeStringHelper.EndsWith(const aChar: WideChar): Boolean;
  begin
    result := Wide.EndsWith(self, aChar);
  end;

  function UnicodeStringHelper.EndsWith(const aString: String): Boolean;
  begin
    result := Wide.EndsWith(self, aString);
  end;

  function UnicodeStringHelper.EqualsText(const aString: String): Boolean;
  begin
    result := (Wide.Compare(self, aString, csIgnoreCase) = isEqual);
  end;

  function UnicodeStringHelper.IsEmpty: Boolean;
  begin
    result := self = '';
  end;

  function UnicodeStringHelper.IsNotEmpty: Boolean;
  begin
    result := self <> '';
  end;

  function UnicodeStringHelper.IsNotEmptyOrWhitespace: Boolean;
  begin
    result := STR.Trim(self) <> '';
  end;


  function UnicodeStringHelper.IsOneOfText(const aArray: array of String): Boolean;
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


  function UnicodeStringHelper.Split(aChar: WideChar; var aLeft, aRight: String): Boolean;
  begin
    result := Wide.Split(self, aChar, aLeft, aRight);
  end;

  function UnicodeStringHelper.Split(aChar: WideChar; var aArray: WideStringArray): Integer;
  begin
    result := Wide.Split(self, aChar, aArray);
  end;

  function UnicodeStringHelper.Startcase: String;
  begin
    result := Wide.Startcase(self);
  end;

  function UnicodeStringHelper.ToLower: String;
  begin
    result := Wide.Lowercase(self);
  end;


  function UnicodeStringHelper.ToUpper: String;
  begin
    result := Wide.Uppercase(self);
  end;





  function StringArrayHelper.get_Count: Integer;
  begin
    result := Length(self);
  end;


  function StringArrayHelper.get_IsEmpty: Boolean;
  begin
    result := Length(self) = 0;
  end;


  function StringArrayHelper.Add(const aString: String): Integer;
  begin
    result := Length(self);
    SetLength(self, result + 1);
    self[result] := aString;
  end;



  function StringArrayHelper.Delete(const aIndex: Integer): Integer;
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


  procedure StringArrayHelper.Insert(const aIndex: Integer;
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


  procedure StringArrayHelper.Insert(const aIndex: Integer;
                                      const aValues: StringArray);
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





  procedure TStringListHelper.Add(const aArray: StringArray);
  var
    i: Integer;
  begin
    for i := 0 to High(aArray) do
      Add(aArray[i]);
  end;



  function TStringListHelper.AsArray: StringArray;
  var
    i: Integer;
  begin
    SetLength(result, Count);

    for i := 0 to Pred(Count) do
      result[i] := self[i];
  end;




{$endif TYPE_HELPERS}


end.
