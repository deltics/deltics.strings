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
    Deltics.Strings.Lists,
    Deltics.Strings.Types,
    Deltics.Strings.Utils,
    Deltics.StringTypes;


  {$i deltics.stringtypes.aliases.inc}

  type
    IStringList         = Deltics.Strings.Lists.IStringList;
    IAnsiStringList     = Deltics.Strings.Lists.IStringList;
    IUnicodeStringList  = Deltics.Strings.Lists.IUnicodeStringList;
    IUtf8StringList     = Deltics.Strings.Lists.IUtf8StringList;
    IWideStringList     = Deltics.Strings.Lists.IWideStringList;

    TAnsiStringList     = Deltics.Strings.Lists.TStringList;
    TAnsiStrings        = Deltics.Strings.Lists.TStrings;

    TStrings            = Deltics.Strings.Lists.TStrings;
    TStringList         = Deltics.Strings.Lists.TStringList;

    TUnicodeStringList  = Deltics.Strings.Lists.TWideStringList;
    TUnicodeStrings     = Deltics.Strings.Lists.TWideStrings;

    TUtf8Strings        = Deltics.Strings.Lists.TUtf8Strings;
    TUtf8StringList     = Deltics.Strings.Lists.TUtf8StringList;

    TWideStrings        = Deltics.Strings.Lists.TWideStrings;
    TWideStringList     = Deltics.Strings.Lists.TWideStringList;


  type
    Encoding      = Deltics.Strings.Encoding.Encoding;
    TEncoding     = Deltics.Strings.Encoding.TEncoding;

  const
    cpAscii    = Deltics.Strings.Encoding.cpAscii;
    cpUtf8     = Deltics.Strings.Encoding.cpUtf8;
    cpUtf16    = Deltics.Strings.Encoding.cpUtf16;
    cpUtf16Le  = Deltics.Strings.Encoding.cpUtf16Le;
    cpUtf32    = Deltics.Strings.Encoding.cpUtf32;
    cpUtf32Le  = Deltics.Strings.Encoding.cpUtf32Le;


  type
    TCaseSensitivity        = Deltics.Strings.Types.TCaseSensitivity;
    TCompareResult          = Deltics.Strings.Types.TCompareResult;
    TContainNeeds           = Deltics.Strings.Types.TContainNeeds;
    TCopyDelimiterOption    = Deltics.Strings.Types.TCopyDelimiterOption;
    TExtractDelimiterOption = Deltics.Strings.Types.TExtractDelimiterOption;
    TStringProcessingFlag   = Deltics.Strings.Types.TStringProcessingFlag;
    TStringScope            = Deltics.Strings.Types.TStringScope;

    SurrogateAction         = Deltics.Strings.Types.SurrogateAction;

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

    saError   = Deltics.Strings.Types.saError;   // An EUnicodeOrphanSurrogate exception is raised if a string operation results in an orphan surrogate
    saIgnore  = Deltics.Strings.Types.saIgnore;  // String operations may result in orphan surrogates

    saDelete  = Deltics.Strings.Types.saDelete;  // String operations will ensure that surrogates are not orphaned


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

    AsciiFn = class
    public
      class function Encode(const aString: String): AsciiString;
      class function TryEncode(const aString: String; var aAscii: AsciiString): Boolean;
    end;

  {$ifdef UNICODE}
    StrFn = class(Deltics.Strings.Fns.Wide.WideFn)
    public
      class function AllocAnsi(const aString: String): PAnsiChar;
      class function AllocWide(const aString: String): PWideChar;
      class function FromWide(const aString: String): UnicodeString; overload;
    end;
  {$else}
    StrFn = class(Deltics.Strings.Fns.Ansi.AnsiFn)
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
  StrClass    = class of StrFn;
  AsciiClass  = class of AsciiFn;

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

  function Str: StrClass; overload; {$ifdef InlineMethods} inline; {$endif}
  function Str(aInteger: Integer): String; overload;
  function Str(aString: AnsiString): String; overload;
  function Str(aString: UnicodeString): String; overload;

  function Utf8: Utf8Class; overload; {$ifdef InlineMethods} inline; {$endif}
  function Utf32: Utf32Class; overload; {$ifdef InlineMethods} inline; {$endif}
  function Ascii: AsciiClass; overload; {$ifdef InlineMethods} inline; {$endif}


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
      function Split(aChar: WideChar; var aArray: UnicodeStringArray): Integer; overload;
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
  {$endif}


  var
    AllowUnicodeDataLoss: Boolean = FALSE;

  type
    EUnicode                  = class(Exception);
    EUnicodeRequiresMultibyte = class(EUnicode);
    EUnicodeDataloss          = class(EUnicode);


  function NewStringArray(const aStrings: array of String): StringArray;


implementation

  uses
  {$ifdef FASTStrINGS}
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

  class function StrFn.AllocAnsi(const aString: String): PAnsiChar;
  begin
    result := Wide.AllocAnsi(aString);
  end;


  class function StrFn.AllocWide(const aString: String): PWideChar;
  begin
    result := Wide.Alloc(aString);
  end;


  class function StrFn.FromWide(const aString: String): UnicodeString;
  begin
    result := aString;
  end;

{$else}

  class function StrFn.AllocWide(const aString: String): PWideChar;
  begin
    result := Ansi.AllocWide(aString);
  end;


  class function StrFn.AllocAnsi(const aString: String): PAnsiChar;
  begin
    result := Ansi.Alloc(aString);
  end;


  class function StrFn.FromAnsi(const aString: String): AnsiString;
  begin
    result := aString;
  end;

{$endif}



  class function AsciiFn.Encode(const aString: String): AsciiString;
  begin
    TryEncode(aString, result);
  end;


  class function AsciiFn.TryEncode(const aString: String;
                                   var   aAscii: AsciiString): Boolean;
  var
    i: Integer;
    c: Char;
  begin
    aAscii := AsciiString(aString);
    result := TRUE;

    for i := 1 to Length(aString) do
    begin
      c := aString[i];

      if Ord(c) > 127 then
      begin
        result    := FALSE;
        aAscii[i] := '?';
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
    case aChar of
      #$0000..#$007f  : result := AnsiChar(aChar);
    else
      usedDefault := FALSE;

      if (WideCharToMultiByte(CP_ACP, 0, @aChar, 0, NIL, 0, '?', @usedDefault) > 1) then
//       or (usedDefault and NOT AllowUnicodeDataLoss) then
        raise EUnicodeRequiresMultibyte.Create('Unicode character ''' + aChar + ''' does not map to a single-byte character in the default Ansi codepage');

      if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, @result, 1, '?', @usedDefault) = 0 then
        raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default Ansi codepage');

      if usedDefault and NOT AllowUnicodeDataLoss then
        raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current Ansi codepage');
    end;
  end;


  procedure Ansi(aChar: WideChar; var aMBCS: AnsiString);
  var
    len: Integer;
    usedDefault: BOOL;
  begin
    case aChar of
      #$0000..#$007f  : aMBCS := AnsiChar(aChar);
    else
      len := WideCharToMultiByte(CP_ACP, 0, @aChar, 1, NIL, 0, '?', NIL);

      SetLength(aMBCS, len);

      usedDefault := FALSE;

      if WideCharToMultiByte(CP_ACP, 0, @aChar, 1, PAnsiChar(aMBCS), len, '?', @usedDefault) = 0 then
        raise EUnicode.Create('Unexpected error converting Unicode character ''' + aChar + ''' to the default Ansi codepage');

      if usedDefault and NOT AllowUnicodeDataLoss then
        raise EUnicodeDataloss.Create('Unicode character ''' + aChar + ''' is not supported in the current Ansi codepage');
    end;
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


  { Str  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }


  function Str: StrClass; overload;
  begin
    result := StrFn;
  end;


  function Str(aInteger: Integer): String;
  begin
    result := IntToStr(aInteger);
  end;

  function Str(aString: AnsiString): String;
  begin
  {$ifdef UNICODE}
    result := Wide(aString);
  {$else}
    result := aString;
  {$endif}
  end;

  function Str(aString: UnicodeString): String;
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


  function Ascii: AsciiClass;
  begin
    result := AsciiFn;
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
    result := Str.Trim(self) <> '';
  end;


  function UnicodeStringHelper.IsOneOfText(const aArray: array of String): Boolean;
  var
    i: Integer;
  begin
    result := FALSE;

    for i := 0 to High(aArray) do
    begin
      result := Str.SameText(aArray[i], self);
      if result then
        EXIT;
    end;
  end;


  function UnicodeStringHelper.Split(aChar: WideChar; var aLeft, aRight: String): Boolean;
  begin
    result := Wide.Split(self, aChar, aLeft, aRight);
  end;

  function UnicodeStringHelper.Split(aChar: WideChar; var aArray: UnicodeStringArray): Integer;
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
{$endif}





  function NewStringArray(const aStrings: array of String): StringArray;
  var
    i: Integer;
  begin
    SetLength(result, Length(aStrings));
    for i := 0 to High(aStrings) do
      result[i] := aStrings[i];
  end;


end.
