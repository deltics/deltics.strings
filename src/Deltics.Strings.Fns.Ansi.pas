
{$i deltics.strings.inc}


  unit Deltics.Strings.Fns.Ansi;


interface

  uses
    SysUtils,
    Windows,
    Deltics.Strings.Parsers.Ansi,
    Deltics.Strings.Types;


  type
    AnsiFn = class
    private
      class function AddressOfIndex(const aString: AnsiString; aIndex: Integer): PAnsiChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: AnsiString; aDest: PAnsiChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: AnsiString; var aDest: AnsiString; aDestIndex: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: AnsiString; var aDest: AnsiString; aDestIndex: Integer; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastMove(var aString: AnsiString; aFromIndex, aToIndex, aCount: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastWrite(const aString: AnsiString; var aDest: PAnsiChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class function CheckCase(const aString: AnsiString; aCaseFn: TAnsiTestCharFn): Boolean;
      class procedure CopyToBuffer(const aString: AnsiString; aMaxBytes: Integer; aBuffer: Pointer; aOffset: Integer); overload;

    public
      class function Parse: AnsiParserClass;

      // Transcoding
      class function Encode(const aString: String): AnsiString;
      class function FromAnsi(const aBuffer: PAnsiChar; aMaxLen: Integer = -1): AnsiString; overload;
      class function FromString(const aString: String): AnsiString;
      class function FromUtf8(const aString: Utf8String): AnsiString; overload;
      class function FromUtf8(const aBuffer: PUtf8Char; aMaxLen: Integer = -1): AnsiString; overload;
      class function FromWide(const aString: UnicodeString): AnsiString; overload;
      class function FromWide(const aBuffer: PWideChar; aMaxLen: Integer = -1): AnsiString; overload;

      // Buffer (SZ pointer) routines
      class function AllocUtf8(const aSource: AnsiString): PUtf8Char;
      class procedure CopyToBuffer(const aString: AnsiString; aBuffer: Pointer); overload;
      class procedure CopyToBuffer(const aString: AnsiString; aBuffer: Pointer; aMaxChars: Integer); overload;
      class procedure CopyToBufferOffset(const aString: AnsiString; aBuffer: Pointer; aByteOffset: Integer); overload;
      class procedure CopyToBufferOffset(const aString: AnsiString; aBuffer: Pointer; aByteOffset: Integer; aMaxChars: Integer); overload;
      class function FromBuffer(aBuffer: PAnsiChar; aLen: Integer = -1): AnsiString; overload;
      class function FromBuffer(aBuffer: PWideChar; aLen: Integer = -1): AnsiString; overload;
      class function Len(aBuffer: PAnsiChar): Integer;

      // Misc utilities
      class function Coalesce(const aString, aDefault: AnsiString): AnsiString; overload;
      class function HasLength(const aString: AnsiString; var aLength: Integer): Boolean;
      class function HasIndex(const aString: AnsiString; aIndex: Integer): Boolean; overload;
      class function HasIndex(const aString: AnsiString; aIndex: Integer; var aChar: AnsiChar): Boolean; overload;
      class function IIf(aValue: Boolean; const aWhenTrue, aWhenFalse: AnsiString): AnsiString; overload;
      class function IndexOf(const aString: AnsiString; aValues: array of AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function IndexOfText(const aString: AnsiString; aValues: array of AnsiString): Integer; overload;
      class function Reverse(const aString: AnsiString): AnsiString;
      class function Split(const aString: AnsiString; aChar: AnsiChar; var aLeft, aRight: AnsiString): Boolean; overload;
      class function Split(const aString: AnsiString; aChar: WideChar; var aLeft, aRight: AnsiString): Boolean; overload;
      class function Split(const aString, aDelim: AnsiString; var aLeft, aRight: AnsiString): Boolean; overload;
      class function Split(const aString: AnsiString; aChar: AnsiChar; var aParts: TAnsiStringArray): Boolean; overload;
      class function Split(const aString: AnsiString; aChar: WideChar; var aParts: TAnsiStringArray): Boolean; overload;
      class function Split(const aString, aDelim: AnsiString; var aParts: TAnsiStringArray): Boolean; overload;

      // Assembling a string
      class function Concat(const aArray: array of AnsiString): AnsiString; overload;
      class function Concat(const aArray: array of AnsiString; const aSeparator: AnsiString): AnsiString; overload;
      class function Format(const aString: AnsiString; const aArgs: array of const): AnsiString;
      class function StringOf(aChar: AnsiChar; aCount: Integer): AnsiString; overload;
      class function StringOf(aChar: WideChar; aCount: Integer): AnsiString; overload;
      class function StringOf(const aString: AnsiString; aCount: Integer): AnsiString; overload;

      // Type conversions
      class function AsBoolean(const aString: AnsiString): Boolean; overload;
      class function AsBoolean(const aString: AnsiString; aDefault: Boolean): Boolean; overload;
      class function AsInteger(const aString: AnsiString): Integer; overload;
      class function AsInteger(const aString: AnsiString; aDefault: Integer): Integer; overload;
      class function IsBoolean(const aString: AnsiString): Boolean; overload;
      class function IsBoolean(const aString: AnsiString; var aValue: Boolean): Boolean; overload;
      class function IsInteger(const aString: AnsiString): Boolean; overload;
      class function IsInteger(const aString: AnsiString; var aValue: Integer): Boolean; overload;

      // Testing things about a string
      class function IsAlpha(aChar: AnsiChar): Boolean; overload;
      class function IsAlpha(const aString: AnsiString): Boolean; overload;
      class function IsAlphaNumeric(aChar: AnsiChar): Boolean; overload;
      class function IsAlphaNumeric(const aString: AnsiString): Boolean; overload;
      class function IsEmpty(const aString: AnsiString): Boolean;
      class function IsLowercase(const aChar: AnsiChar): Boolean; overload;
      class function IsLowercase(const aString: AnsiString): Boolean; overload;
      class function IsNull(aChar: AnsiChar): Boolean;
      class function IsNumeric(aChar: AnsiChar): Boolean; overload;
      class function IsNumeric(const aString: AnsiString): Boolean; overload;
      class function IsUppercase(const aChar: AnsiChar): Boolean; overload;
      class function IsUppercase(const aString: AnsiString): Boolean; overload;
      class function NotEmpty(const aString: AnsiString): Boolean;

      // Comparing with other strings
      class function Compare(const A, B: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): TCompareResult;
      class function CompareText(const A, B: AnsiString): TCompareResult;
      class function MatchesAny(const aString: AnsiString; aValues: array of AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function MatchesAnyText(const aString: AnsiString; aValues: array of AnsiString): Boolean; overload;
      class function SameString(const A, B: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean;
      class function SameText(const A, B: AnsiString): Boolean;

      // Checking for things in a string
      class function BeginsWith(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWithText(const aString: AnsiString; aChar: AnsiChar): Boolean; overload;
      class function BeginsWithText(const aString: AnsiString; aChar: WideChar): Boolean; overload;
      class function BeginsWithText(const aString, aSubstring: AnsiString): Boolean; overload;
      class function Contains(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ContainsText(const aString: AnsiString; aChar: AnsiChar): Boolean; overload;
      class function ContainsText(const aString: AnsiString; aChar: WideChar): Boolean; overload;
      class function ContainsText(const aString, aSubstring: AnsiString): Boolean; overload;
      class function EndsWith(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWithText(const aString: AnsiString; aChar: AnsiChar): Boolean; overload;
      class function EndsWithText(const aString: AnsiString; aChar: WideChar): Boolean; overload;
      class function EndsWithText(const aString, aSubstring: AnsiString): Boolean; overload;

      // Finding things in a string
      class function Find(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString: AnsiString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString, aSubstring: AnsiString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindText(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString: AnsiString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString, aSubstring: AnsiString; var aPos: Integer): Boolean; overload;
      class function FindNext(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString: AnsiString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString, aSubstring: AnsiString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNextText(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString: AnsiString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString, aSubstring: AnsiString; var aPos: Integer): Boolean; overload;
      class function FindPrevious(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString: AnsiString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString, aSubstring: AnsiString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPreviousText(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString: AnsiString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString, aSubstring: AnsiString; var aPos: Integer): Boolean; overload;
      class function FindLast(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString: AnsiString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString, aSubstring: AnsiString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLastText(const aString: AnsiString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString: AnsiString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString, aSubstring: AnsiString; var aPos: Integer): Boolean; overload;
      class function FindAll(const aString: AnsiString; aChar: AnsiChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString: AnsiString; aChar: WideChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString, aSubstring: AnsiString; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAllText(const aString: AnsiString; aChar: AnsiChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString: AnsiString; aChar: WideChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString, aSubstring: AnsiString; var aPos: TCharIndexArray): Integer; overload;

      // Adding to a string
      class function Append(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function Append(const aString, aSuffix: AnsiString): AnsiString; overload;
      class function Append(const aString, aSuffix: AnsiString; aSeparator: AnsiChar): AnsiString; overload;
      class function Append(const aString, aSuffix, aSeparator: AnsiString): AnsiString; overload;
      class function Insert(const aString: AnsiString; aPos: Integer; const aChar: AnsiChar): AnsiString; overload;
      class function Insert(const aString: AnsiString; aPos: Integer; const aInfix: AnsiString): AnsiString; overload;
      class function Insert(const aString: AnsiString; aPos: Integer; const aInfix: AnsiString; aSeparator: AnsiChar): AnsiString; overload;
      class function Insert(const aString: AnsiString; aPos: Integer; const aInfix, aSeparator: AnsiString): AnsiString; overload;
      class function Prepend(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function Prepend(const aString, aPrefix: AnsiString): AnsiString; overload;
      class function Prepend(const aString, aPrefix: AnsiString; aSeparator: AnsiChar): AnsiString; overload;
      class function Prepend(const aString, aPrefix, aSeparator: AnsiString): AnsiString; overload;
      class function Embrace(const aString: AnsiString; aBrace: AnsiChar = '('): AnsiString; overload;
      class function Embrace(const aString: AnsiString; aBrace: WideChar): AnsiString; overload;
      class function Enquote(const aString: AnsiString; aQuote: AnsiChar = ''''; aEscape: AnsiChar = ''''): AnsiString; overload;
      class function Enquote(const aString: AnsiString; aQuote: WideChar): AnsiString; overload;
      class function Enquote(const aString: AnsiString; aQuote, aEscape: WideChar): AnsiString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: AnsiChar = ' '): AnsiString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: WideChar): AnsiString; overload;
      class function PadLeft(const aString: AnsiString; aLength: Integer; aChar: AnsiChar = ' '): AnsiString; overload;
      class function PadLeft(const aString: AnsiString; aLength: Integer; aChar: WideChar): AnsiString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: AnsiChar = ' '): AnsiString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: WideChar): AnsiString; overload;
      class function PadRight(const aString: AnsiString; aLength: Integer; aChar: AnsiChar = ' '): AnsiString; overload;
      class function PadRight(const aString: AnsiString; aLength: Integer; aChar: WideChar): AnsiString; overload;

      // TODO: This is supposed to be a general purpose String library, so
      //        this particular function really belongs in an XML framework!
      class function Tag(const aString, aTag: AnsiString): AnsiString;

      // Deleting parts of a string (in-place)
      class procedure Delete(var aString: AnsiString; aIndex, aLength: Integer); overload;
      class procedure DeleteRange(var aString: AnsiString; aIndex, aEndIndex: Integer); overload;
      class function Delete(var aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: AnsiString; aChar: AnsiChar): Boolean; overload;
      class function DeleteText(var aString: AnsiString; aChar: WideChar): Boolean; overload;
      class function DeleteText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;
      class function DeleteAll(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAllText(var aString: AnsiString; aChar: AnsiChar): Integer; overload;
      class function DeleteAllText(var aString: AnsiString; aChar: WideChar): Integer; overload;
      class function DeleteAllText(var aString: AnsiString; const aSubstring: AnsiString): Integer; overload;
      class function DeleteLast(var aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLastText(var aString: AnsiString; aChar: AnsiChar): Boolean; overload;
      class function DeleteLastText(var aString: AnsiString; aChar: WideChar): Boolean; overload;
      class function DeleteLastText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;
      class procedure DeleteLeft(var aString: AnsiString; aCount: Integer); overload;
      class function DeleteLeft(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLeftText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;
      class procedure DeleteRight(var aString: AnsiString; aCount: Integer); overload;
      class function DeleteRight(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteRightText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;

      // Removing parts of a string (modified result)
      class function Remove(const aString: AnsiString; aIndex, aLength: Integer): AnsiString; overload;
      class function Remove(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Remove(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Remove(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveText(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function RemoveText(const aString: AnsiString; aChar: WideChar): AnsiString; overload;
      class function RemoveText(const aString, aSubstring: AnsiString): AnsiString; overload;
      class function RemoveAll(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveAll(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveAll(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveAllText(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function RemoveAllText(const aString: AnsiString; aChar: WideChar): AnsiString; overload;
      class function RemoveAllText(const aString, aSubstring: AnsiString): AnsiString; overload;
      class function RemoveLast(const aString: AnsiString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveLast(const aString: AnsiString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveLast(const aString, aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function RemoveLastText(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function RemoveLastText(const aString: AnsiString; aChar: WideChar): AnsiString; overload;
      class function RemoveLastText(const aString, aSubstring: AnsiString): AnsiString; overload;

      // Extracting parts of a string
      class function Extract(var aString: AnsiString; aIndex, aLength: Integer): AnsiString; overload;
      class function Extract(var aString: AnsiString; aIndex, aLength: Integer; var aExtract: AnsiString): Boolean; overload;
      class function ExtractLeft(var aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function ExtractLeft(var aString: AnsiString; aCount: Integer; var aExtract: AnsiString): Boolean; overload;
      class function ExtractLeft(var aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractLeft(var aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractLeft(var aString: AnsiString; const aDelimiter: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractLeft(var aString: AnsiString; aDelimiter: AnsiChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: AnsiString; aDelimiter: WideChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: AnsiString; const aDelimiter: AnsiString; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeftText(var aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractLeftText(var aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractLeftText(var aString: AnsiString; const aDelimiter: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractLeftText(var aString: AnsiString; aDelimiter: AnsiChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: AnsiString; aDelimiter: WideChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: AnsiString; const aDelimiter: AnsiString; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRight(var aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function ExtractRight(var aString: AnsiString; aCount: Integer; var aExtract: AnsiString): Boolean; overload;
      class function ExtractRightFrom(var aString: AnsiString; aIndex: Integer): AnsiString; overload;
      class function ExtractRightFrom(var aString: AnsiString; aIndex: Integer; var aExtract: AnsiString): Boolean; overload;
      class function ExtractRight(var aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractRight(var aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractRight(var aString: AnsiString; const aDelimiter: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ExtractRight(var aString: AnsiString; aDelimiter: AnsiChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: AnsiString; aDelimiter: WideChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: AnsiString; const aDelimiter: AnsiString; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRightText(var aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractRightText(var aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractRightText(var aString: AnsiString; const aDelimiter: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): AnsiString; overload;
      class function ExtractRightText(var aString: AnsiString; aDelimiter: AnsiChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: AnsiString; aDelimiter: WideChar; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: AnsiString; const aDelimiter: AnsiString; var aExtract: AnsiString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractQuotedValue(var aString: AnsiString; const aDelimiter: AnsiChar): AnsiString;

      // Consuming a string
      class function ConsumeLeft(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeLeftText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;
      class function ConsumeRight(var aString: AnsiString; const aSubstring: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeRightText(var aString: AnsiString; const aSubstring: AnsiString): Boolean; overload;

      // Copying parts of a string
      class function Copy(const aString: AnsiString; aStartPos, aLength: Integer): AnsiString; overload;
      class function Copy(const aString: AnsiString; aStartPos, aLength: Integer; var aCopy: AnsiString): Boolean; overload;
      class function CopyFrom(const aString: AnsiString; aIndex: Integer): AnsiString; overload;
      class function CopyFrom(const aString: AnsiString; aIndex: Integer; var aCopy: AnsiString): Boolean; overload;
      class function CopyRange(const aString: AnsiString; aStartPos, aEndPos: Integer): AnsiString; overload;
      class function CopyRange(const aString: AnsiString; aStartPos, aEndPos: Integer; var aCopy: AnsiString): Boolean; overload;
      class function CopyLeft(const aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function CopyLeft(const aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyLeft(const aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyLeft(const aString, aDelimiter: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyLeft(const aString: AnsiString; aCount: Integer; var aCopy: AnsiString): Boolean; overload;
      class function CopyLeft(const aString: AnsiString; aDelimiter: AnsiChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString: AnsiString; aDelimiter: WideChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString, aDelimiter: AnsiString; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeftText(const aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyLeftText(const aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyLeftText(const aString, aDelimiter: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyLeftText(const aString: AnsiString; aDelimiter: AnsiChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString: AnsiString; aDelimiter: WideChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString, aDelimiter: AnsiString; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRight(const aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function CopyRight(const aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyRight(const aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyRight(const aString, aDelimiter: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function CopyRight(const aString: AnsiString; aCount: Integer; var aCopy: AnsiString): Boolean; overload;
      class function CopyRight(const aString: AnsiString; aDelimiter: AnsiChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString: AnsiString; aDelimiter: WideChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString, aDelimiter: AnsiString; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRightText(const aString: AnsiString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyRightText(const aString: AnsiString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyRightText(const aString, aDelimiter: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): AnsiString; overload;
      class function CopyRightText(const aString: AnsiString; aDelimiter: AnsiChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString: AnsiString; aDelimiter: WideChar; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString, aDelimiter: AnsiString; var aCopy: AnsiString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;

      // Changing pieces of a string
      class function Replace(const aString: AnsiString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString: AnsiString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString, aSubstring: AnsiString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString, aSubstring, aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function Replace(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceText(const aString: AnsiString; aChar, aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceText(const aString: AnsiString; aChar, aReplacement: WideChar): AnsiString; overload;
      class function ReplaceText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceText(const aString, aSubstring: AnsiString; aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceText(const aString, aSubstring: AnsiString; aReplacement: WideChar): AnsiString; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceText(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: AnsiString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString: AnsiString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar, aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar, aReplacement: WideChar): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceAllText(const aString: AnsiString; const aSubstring: AnsiString; aReplacement: WideChar): AnsiString; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceLast(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: AnsiString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString: AnsiString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString, aSubstring: AnsiString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: AnsiString; aCaseMode: TCaseSensitivity = csCaseSensitive): AnsiString; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar, aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar, aReplacement: WideChar): AnsiString; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceLastText(const aString, aSubstring: AnsiString; aReplacement: AnsiChar): AnsiString; overload;
      class function ReplaceLastText(const aString, aSubstring: AnsiString; aReplacement: WideChar): AnsiString; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: AnsiString): AnsiString; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar, aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar, aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar: AnsiChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString: AnsiString; aChar: WideChar; const aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: AnsiString; aReplacement: AnsiChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: AnsiString; aReplacement: WideChar; var aResult: AnsiString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: AnsiString; var aResult: AnsiString): Boolean; overload;

      // Removing parts of a string
      class function Trim(const aString: AnsiString): AnsiString; overload;
      class function Trim(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function Trim(const aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function LTrim(const aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function LTrim(const aString: AnsiString): AnsiString; overload;
      class function LTrim(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function RTrim(const aString: AnsiString; aCount: Integer): AnsiString; overload;
      class function RTrim(const aString: AnsiString): AnsiString; overload;
      class function RTrim(const aString: AnsiString; aChar: AnsiChar): AnsiString; overload;
      class function RTrim(const aString: AnsiString; aChar: WideChar): AnsiString; overload;

      class function Unbrace(const aString: AnsiString): AnsiString; overload;
      class function Unbrace(const aString: AnsiString; var aResult: AnsiString): Boolean; overload;
      class function Unquote(const aString: AnsiString): AnsiString; overload;
      class function Unquote(const aString: AnsiString; var aResult: AnsiString): Boolean; overload;

      // Case conversions
      class function Lowercase(aChar: AnsiChar): AnsiChar; overload;
      class function Lowercase(const aString: AnsiString): AnsiString; overload;
      class function Startcase(const aString: AnsiString): AnsiString;
      class function Uppercase(aChar: AnsiChar): AnsiChar; overload;
      class function Uppercase(const aString: AnsiString): AnsiString; overload;
    end;



implementation

  uses
  { vcl: }
  {$ifdef DELPHI2009__}
    AnsiStrings,
  {$endif}
  { deltics: }
    Deltics.Contracts,
    Deltics.Exchange,
    Deltics.Math,
    Deltics.Pointers,
    Deltics.ReverseBytes,
    Deltics.Strings,
    Deltics.Strings.Fns.Utf8,
    Deltics.Strings.Fns.Wide,
    Deltics.Strings.Utils;





{ AnsiFn ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Parse: AnsiParserClass;
  begin
    result := AnsiParser;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AddressOfIndex(const aString: AnsiString;
                                             aIndex: Integer): PAnsiChar;
  begin
    result := @aString[aIndex];
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastCopy(const aString: AnsiString;
                                        aDest: PAnsiChar);
  begin
    CopyMemory(aDest, PAnsiChar(aString), Length(aString));
  end;
*)

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastCopy(const aString: AnsiString;
                                        aDest: PAnsiChar;
                                        aLen: Integer);
  begin
    CopyMemory(aDest, PAnsiChar(aString), aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastCopy(const aString: AnsiString;
                                  var   aDest: AnsiString;
                                        aDestIndex: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastCopy(const aString: AnsiString;
                                  var   aDest: AnsiString;
                                        aDestIndex: Integer;
                                        aLen: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PAnsiChar(aString), aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastMove(var aString: AnsiString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aCount: Integer);
  begin
    CopyMemory(AddressOfIndex(aString, aToIndex),
               AddressOfIndex(aString, aFromIndex), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.FastWrite(const aString: AnsiString;
                                   var   aDest: PAnsiChar;
                                         aLen: Integer);
  var
    strLen: Integer;
  begin
    if NOT HasLength(aString, strLen) then
      EXIT;

    if aLen > strLen then
      aLen := strLen;

    CopyMemory(aDest, PAnsiChar(aString), aLen);
    aDest := AddressOfIndex(aDest, aLen + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CheckCase(const aString: AnsiString;
                                        aCaseFn: TAnsiTestCharFn): Boolean;
  var
    i: Integer;
    bAlpha: Boolean;
    pc: PAnsiChar;
  begin
    result  := FALSE;
    bAlpha  := FALSE;

    pc := PAnsiChar(aString);
    for i := 0 to Pred(Length(aString)) do
    begin
      if Windows.IsCharAlphaA(pc^) then
      begin
        if NOT aCaseFn(pc^) then
          EXIT;

        bAlpha := TRUE;
      end;
      Inc(pc);
    end;

    if bAlpha then
      result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.CopyToBuffer(const aString: AnsiString;
                                            aMaxBytes: Integer;
                                            aBuffer: Pointer;
                                            aOffset: Integer);
  var
    len: Integer;
  begin
    Require('aBuffer', aBuffer).IsAssigned;
    Require('aMaxBytes', aMaxBytes).IsPositiveOrZero;

    if  (aMaxBytes = 0)
     or NOT HasLength(aString, len) then
      EXIT;

    if (aMaxBytes < len) then
      len := aMaxBytes;

    FastCopy(aString, Memory.ByteOffset(aBuffer, aOffset), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Coalesce(const aString: AnsiString;
                                 const aDefault: AnsiString): AnsiString;
  begin
    if (aString <> '') then
      result := aString
    else
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.HasLength(const aString: AnsiString; var aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.HasIndex(const aString: AnsiString;
                                       aIndex: Integer): Boolean;
  begin
    result := (aIndex > 0) and (aIndex <= Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.HasIndex(const aString: AnsiString;
                                       aIndex: Integer;
                                   var aChar: AnsiChar): Boolean;
  begin
    aChar   := #0;
    result  := (aIndex > 0) and (aIndex <= Length(aString));
    if result then
      aChar := PAnsiChar(aString)[aIndex - 1];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IIf(      aValue: Boolean;
                               const aWhenTrue: AnsiString;
                               const aWhenFalse: AnsiString): AnsiString;
  begin
    if aValue then
      result := aWhenTrue
    else
      result := aWhenFalse;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IndexOf(const aString: AnsiString;
                                      aValues: array of AnsiString;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    for result := 0 to High(aValues) do
      if Ansi.SameString(aString, aValues[result], aCaseMode) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IndexOfText(const aString: AnsiString;
                                          aValues: array of AnsiString): Integer;
  begin
    for result := 0 to High(aValues) do
      if Ansi.SameText(aString, aValues[result]) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Reverse(const aString: AnsiString): AnsiString;
  var
    i, strLen: Integer;
    c: AnsiChar;
    pc, prc: PAnsiChar;
  begin
    if NOT HasLength(aString, strLen) then
      EXIT;

    result := aString;
    pc   := PAnsiChar(result);
    prc  := @result[strLen];

    for i := 1 to strLen div 2 do
    begin
      c     := prc^;
      prc^  := pc^;
      pc^   := c;

      Inc(pc);
      Dec(prc);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                                    aChar: AnsiChar;
                              var   aLeft, aRight: AnsiString): Boolean;
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


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                                    aChar: WideChar;
                              var   aLeft, aRight: AnsiString): Boolean;
  begin
    result := Split(aString, Ansi(aChar), aLeft, aRight);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                              const aDelim: AnsiString;
                              var   aLeft, aRight: AnsiString): Boolean;
  var
    p, delimLen: Integer;
  begin
    Require('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);

    aLeft   := aString;
    aRight  := '';

    result  := Find(aString, aDelim, p);
    if NOT result then
      EXIT;

    SetLength(aLeft, p - 1);
    aRight := System.Copy(aString, p + delimLen, System.Length(aString) - (p + delimLen - 1));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                                    aChar: AnsiChar;
                              var   aParts: TAnsiStringArray): Boolean;
  var
    i: Integer;
    p: TCharIndexArray;
    plen: Integer;
  begin
    result := FindAll(aString, aChar, p) > 0;
    if NOT result then
    begin
      if aString <> '' then
      begin
        SetLength(aParts, 1);
        aParts[0] := aString;
      end;

      EXIT;
    end;

    plen := System.Length(p);
    SetLength(aParts, plen + 1);

    aParts[0] := self.Copy(aString, 1, p[0] - 1);
    for i := 1 to Pred(plen) do
      aParts[i] := self.Copy(aString, p[i - 1] + 1, p[i] - p[i - 1] - 1);

    i := p[Pred(plen)] + 1;
    aParts[plen] := self.Copy(aString, i, System.Length(aString) - i + 1)
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                                    aChar: WideChar;
                              var   aParts: TAnsiStringArray): Boolean;
  begin
    result := Split(aString, Ansi(aChar), aParts);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Split(const aString: AnsiString;
                              const aDelim: AnsiString;
                              var   aParts: TAnsiStringArray): Boolean;
  var
    i: Integer;
    p: TCharIndexArray;
    plen, delimLen: Integer;
  begin
    Require('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);

    result := FindAll(aString, aDelim, p) > 0;
    if NOT result then
    begin
      if aString <> '' then
      begin
        SetLength(aParts, 1);
        aParts[0] := aString;
      end;

      EXIT;
    end;

    plen := System.Length(p);
    SetLength(aParts, plen + 1);

    aParts[0] := self.Copy(aString, 1, p[0] - 1);
    for i := 1 to Pred(plen) do
      aParts[i] := self.Copy(aString, p[i - 1] + delimLen, p[i] - p[i - 1] - delimLen);

    i := p[Pred(plen)] + delimLen;
    aParts[plen] := self.Copy(aString, i, System.Length(aString) - i + delimLen)
  end;









  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Encode(const aString: String): AnsiString;
  begin
  {$ifdef UNICODE}
    result := FromWide(aString);
  {$else}
    result := aString;
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromAnsi(const aBuffer: PAnsiChar;
                                       aMaxLen: Integer): AnsiString;
  begin
    if aMaxLen = -1 then
      aMaxLen := Len(aBuffer)
    else
      aMaxLen := Min(aMaxLen, Len(aBuffer));

    SetLength(result, aMaxLen);
    CopyMemory(@result[1], aBuffer, aMaxLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromString(const aString: String): AnsiString;
  begin
  {$ifdef UNICODE}
    result := FromWide(aString);
  {$else}
    result := aString;
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromUtf8(const aString: Utf8String): AnsiString;
  begin
    // TODO: Can we do this more directly / efficiently ?
    result := Ansi.FromWide(Wide.FromUtf8(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromUtf8(const aBuffer: PUtf8Char;
                                       aMaxLen: Integer): AnsiString;
  begin
    Require('aMaxLen', aMaxLen).IsGreaterThanOrEqual(-1);

    // TODO: Can we do this more directly / efficiently ?
    result := Ansi.FromWide(Wide.FromUtf8(aBuffer, aMaxLen));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromWide(const aString: UnicodeString): AnsiString;
  begin
    result := FromWide(PWideChar(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromWide(const aBuffer: PWideChar;
                                       aMaxLen: Integer): AnsiString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := WideFn.Len(PWideChar(aBuffer));
      if len < aMaxLen then
        aMaxLen := len;
    end
    else
      aMaxLen := -1;

    len := WideCharToMultiByte(CP_ACP, 0, aBuffer, aMaxLen, NIL, 0, NIL, NIL);
    if aMaxLen = -1 then
      Dec(len);

    SetLength(result, len);
    WideCharToMultiByte(CP_ACP, 0, aBuffer, aMaxLen, PAnsiChar(result), System.Length(result), NIL, NIL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AllocUtf8(const aSource: AnsiString): PUtf8Char;
  begin
    result := Utf8.Alloc(Utf8.FromAnsi(aSource));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.CopyToBuffer(const aString: AnsiString;
                                            aBuffer: Pointer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.CopyToBuffer(const aString: AnsiString;
                                            aBuffer: Pointer;
                                            aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.CopyToBufferOffset(const aString: AnsiString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.CopyToBufferOffset(const aString: AnsiString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer;
                                                  aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromBuffer(aBuffer: PAnsiChar; aLen: Integer = -1): AnsiString;
  {
    Copies an Ansi string (null terminated) from a specified buffer.

    The length of the string should be specified if the length is known or is required
     to be less than the known length of the Ansi string in the buffer.

    If length is not specified then the contents of the buffer up to the first null
     terminator will be returned.
  }
  begin
    result := '';

    if NOT Assigned(aBuffer) then
      EXIT;
      
    case aLen of
      -1  : aLen := Len(aBuffer);
       0  : EXIT;
    end;

    if aLen <= 0 then
      EXIT;

    SetLength(result, aLen);
    CopyMemory(PAnsiChar(result), aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FromBuffer(aBuffer: PWideChar; aLen: Integer = -1): AnsiString;
  begin
    result := FromWide(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Len(aBuffer: PAnsiChar): Integer;
  begin
  {$ifdef DELPHIXE4__}
    result := AnsiStrings.StrLen(aBuffer);
  {$else}
    result := SysUtils.StrLen(aBuffer);
  {$endif}
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsAlpha(aChar: AnsiChar): Boolean;
  begin
    result := IsCharAlphaA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsAlpha(const aString: AnsiString): Boolean;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaA(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsAlphaNumeric(aChar: AnsiChar): Boolean;
  begin
    result := IsCharAlphaNumericA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsAlphaNumeric(const aString: AnsiString): Boolean;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaNumericA(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsEmpty(const aString: AnsiString): Boolean;
  begin
    result := Length(aString) = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsLowercase(const aChar: AnsiChar): Boolean;
  begin
    result := IsCharLowerA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsLowercase(const aString: AnsiString): Boolean;
  begin
    result := CheckCase(aString, IsCharLowerA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsNull(aChar: AnsiChar): Boolean;
  begin
    result := (aChar = #0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsNumeric(aChar: AnsiChar): Boolean;
  begin
    result := IsCharAlphaNumericA(aChar) and NOT IsCharAlphaA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsNumeric(const aString: AnsiString): Boolean;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT (IsCharAlphaNumericA(chars[i]) and NOT IsCharAlphaA(chars[i])) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsUppercase(const aChar: AnsiChar): Boolean;
  begin
    result := IsCharUpperA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsUppercase(const aString: AnsiString): Boolean;
  begin
    result := CheckCase(aString, IsCharUpperA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.NotEmpty(const aString: AnsiString): Boolean;
  begin
    result := (aString <> '');
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Compare(const A, B: AnsiString;
                                      aCaseMode: TCaseSensitivity): TCompareResult;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PAnsiChar(A), Length(A),
                             PAnsiChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CompareText(const A, B: AnsiString): TCompareResult;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PAnsiChar(A), Length(A),
                             PAnsiChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.MatchesAny(const aString: AnsiString;
                                         aValues: array of AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := IndexOf(aString, aValues, aCaseMode) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.MatchesAnyText(const aString: AnsiString;
                                             aValues: array of AnsiString): Boolean;
  begin
    result := IndexOf(aString, aValues, csIgnoreCase) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.SameString(const A, B: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PAnsiChar(A), Length(A),
                             PAnsiChar(B), Length(B)) = CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.SameText(const A, B: AnsiString): Boolean;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PAnsiChar(A), Length(A),
                             PAnsiChar(B), Length(B)) = CSTR_EQUAL;
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Concat(const aArray: array of AnsiString): AnsiString;
  var
    i: Integer;
    len: Integer;
    pResult: PAnsiChar;
  begin
    case Length(aArray) of
      0: result := '';
      1: result := aArray[0];
    else
      len := 0;
      for i := 0 to Pred(Length(aArray)) do
        Inc(len, Length(aArray[i]));

      SetLength(result, len);
      if len = 0 then
        EXIT;

      pResult := PAnsiChar(result);
      for i := 0 to Pred(Length(aArray)) do
      begin
        len := Length(aArray[i]);

        case len of
          0 : { NO-OP} ;
          1 : begin
                pResult^ := aArray[i][1];
                Inc(pResult);
              end;
        else
          FastWrite(aArray[i], pResult, len);
        end;
      end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Concat(const aArray: array of AnsiString;
                              const aSeparator: AnsiString): AnsiString;
  var
    p: PAnsiChar;

    procedure DoValue(const aIndex: Integer);
    var
      value: AnsiString;
      len: Integer;
    begin
      value := aArray[aIndex];
      len   := Length(value);

      case len of
        0 : { NO-OP} ;
        1 : begin
              p^ := value[1];
              Inc(p);
            end;
      else
        FastWrite(value, p, len);
      end;
    end;

    procedure DoWithChar(const aChar: AnsiChar);
    var
      i: Integer;
    begin
      for i := 0 to High(aArray) - 1 do
      begin
        DoValue(i);

        p^ := aChar;
        Inc(p);
      end;
    end;

    procedure DoWithString(const aLength: Integer);
    var
      i: Integer;
    begin
      for i := 0 to High(aArray) - 1 do
      begin
        DoValue(i);
        FastWrite(aSeparator, p, aLength);
      end;
    end;

  var
    i: Integer;
    len: Integer;
    sepLen: Integer;
  begin
    case Length(aArray) of
      0: result := '';
      1: result := aArray[0];
    else
      sepLen := Length(aSeparator);

      len := (Length(aArray) - 1) * seplen;
      for i := 0 to Pred(Length(aArray)) do
        Inc(len, Length(aArray[i]));

      SetLength(result, len);
      if len = 0 then
        EXIT;

      p := PAnsiChar(result);

      case sepLen of
        1 : DoWithChar(aSeparator[1]);
      else
        DoWithString(sepLen);
      end;

      DoValue(High(aArray));
    end;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Format(const aString: AnsiString;
                               const aArgs: array of const): AnsiString;
  begin
  {$ifdef DELPHI2009__}
    result := AnsiStrings.Format(aString, aArgs);
  {$else}
    result := SysUtils.Format(aString, aArgs);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Embrace(const aString: AnsiString;
                                      aBrace: AnsiChar): AnsiString;
  var
    dest: PAnsiChar absolute result;
    strLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      SetLength(result, strLen + 2);
      FastCopy(aString, result, 2);
    end
    else
      SetLength(result, 2);

    dest[0] := aBrace;

    case aBrace of
      '(' : dest[strLen + 1] := AnsiChar(')');
      '{' : dest[strLen + 1] := AnsiChar('}');
      '[' : dest[strLen + 1] := AnsiChar(']');
      '<' : dest[strLen + 1] := AnsiChar('>');
    else
      dest[strLen + 1] := aBrace;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Embrace(const aString: AnsiString;
                                      aBrace: WideChar): AnsiString;
  begin
    result := Embrace(aString, Ansi(aBrace));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Enquote(const aString: AnsiString;
                                      aQuote: AnsiChar;
                                      aEscape: AnsiChar): AnsiString;
  var
    dest: PAnsiChar absolute result;
    i, j: Integer;
    strLen: Integer;
    pc: PAnsiChar;
  begin
    j := 1;

    if HasLength(aString, strLen) then
    begin
      SetLength(result, (strLen * 2) + 2);

      pc  := PAnsiChar(aString);
      for i := 1 to strLen do
      begin
        if (pc^ = aQuote) then
        begin
          dest[j] := aEscape;
          Inc(j);
        end;

        dest[j] := pc^;
        Inc(j);

        Inc(pc);
      end;
    end;

    SetLength(result, j + 1);

    dest[0] := aQuote;
    dest[j] := aQuote;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Enquote(const aString: AnsiString;
                                      aQuote: WideChar): AnsiString;
  begin
    result := Enquote(aString, Ansi(aQuote), Ansi(aQuote));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Enquote(const aString: AnsiString;
                                      aQuote: WideChar;
                                      aEscape: WideChar): AnsiString;
  begin
    result := Enquote(aString, Ansi(aQuote), Ansi(aEscape));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: AnsiChar): AnsiString;
  begin
    result := PadLeft(Ansi(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WideChar): AnsiString;
  begin
    result := PadLeft(Ansi(aValue), aLength, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadLeft(const aString: AnsiString;
                                   aLength: Integer;
                                   aChar: AnsiChar): AnsiString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PAnsiChar;
  begin
    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
    begin
      result := aString;
      EXIT;
    end;

    SetLength(result, aLength);

    p := PAnsiChar(result);
    for i := 0 to Pred(pad) do
      p[i] := aChar;

    Inc(p, pad);
    FastCopy(aString, p, len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadLeft(const aString: AnsiString;
                                   aLength: Integer;
                                   aChar: WideChar): AnsiString;
  begin
    result := PadLeft(aString, aLength, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: AnsiChar): AnsiString;
  begin
    result := PadRight(Ansi(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WideChar): AnsiString;
  begin
    result := PadRight(Ansi(aValue), aLength, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadRight(const aString: AnsiString;
                                   aLength: Integer;
                                   aChar: AnsiChar): AnsiString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PAnsiChar;
  begin
    result := aString;

    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
      EXIT;

    SetLength(result, aLength);

    p := PAnsiChar(result);
    Inc(p, len);

    for i := 0 to Pred(pad) do
      p[i] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.PadRight(const aString: AnsiString;
                                   aLength: Integer;
                                   aChar: WideChar): AnsiString;
  begin
    result := PadRight(aString, aLength, Ansi(aChar));
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWith(const aString: AnsiString;
                                         aChar: AnsiChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PAnsiChar absolute aString;
  begin
    Require('aChar', aChar).IsNotNull;
    Require('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    case aCaseMode of

      csCaseSensitive : result := (aString <> '')
                              and (chars[0] = aChar);

      csIgnoreCase    : result := (aString <> '')
                              and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                                                  chars, 1,
                                                  @aChar, 1) = CSTR_EQUAL);
    else
      result := FALSE;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWith(const aString: AnsiString;
                                         aChar: WideChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWith(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := (subLen <= System.Length(aString))
          and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PAnsiChar(aString), subLen,
                              PAnsiChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWithText(const aString: AnsiString;
                                             aChar: AnsiChar): Boolean;
  begin
    Require('aChar', aChar).IsNotNull;

    result := (aString <> '')
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PAnsiChar(aString), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWithText(const aString: AnsiString;
                                             aChar: WideChar): Boolean;
  begin
    result := BeginsWithText(aString, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.BeginsWithText(const aString: AnsiString;
                                       const aSubstring: AnsiString): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := (subLen <= System.Length(aString))
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PAnsiChar(aString), subLen,
                              PAnsiChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Contains(const aString: AnsiString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Contains(const aString: AnsiString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, Ansi(aChar), notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Contains(const aString: AnsiString;
                                 const aSubstring: AnsiString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ContainsText(const aString: AnsiString;
                                           aChar: AnsiChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ContainsText(const aString: AnsiString;
                                           aChar: WideChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, Ansi(aChar), notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ContainsText(const aString: AnsiString;
                                     const aSubstring: AnsiString): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWith(const aString: AnsiString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PAnsiChar absolute aString;
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;
    Require('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    case aCaseMode of

      csCaseSensitive : result := HasLength(aString, strLen)
                              and (chars[strLen - 1] = aChar);

      csIgnoreCase    : result := HasLength(aString, strLen)
                              and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                                  PAnsiChar(Memory.ByteOffset(Pointer(aString), strLen - 1)), 1,
                                                  @aChar, 1) = CSTR_EQUAL);
    else
      result := FALSE;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWith(const aString: AnsiString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result  := EndsWith(aString, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWith(const aString: AnsiString;
                                 const aSubstring: AnsiString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    strLen := Length(aString);
    result := (subLen <= strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PAnsiChar(Memory.ByteOffset(Pointer(aString), strLen - subLen)), subLen,
                              PAnsiChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWithText(const aString: AnsiString;
                                           aChar: AnsiChar): Boolean;
  var
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;

    result := HasLength(aString, strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PAnsiChar(Memory.ByteOffset(Pointer(aString), strLen - 1)), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWithText(const aString: AnsiString;
                                           aChar: WideChar): Boolean;
  begin
    result := EndsWithText(aString, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.EndsWithText(const aString: AnsiString;
                                     const aSubstring: AnsiString): Boolean;
  var
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    strLen := Length(aString);
    result := (subLen <= strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PAnsiChar(Memory.ByteOffset(Pointer(aString), strLen - subLen)), subLen,
                              PAnsiChar(aSubstring), subLen) = CSTR_EQUAL);
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Find(const aString: AnsiString;
                                   aChar: AnsiChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Find(const aString: AnsiString;
                                   aChar: WideChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, Ansi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Find(const aString: AnsiString;
                             const aSubstring: AnsiString;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindText(const aString: AnsiString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindText(const aString: AnsiString;
                                       aChar: WideChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, Ansi(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindText(const aString: AnsiString;
                                 const aSubstring: AnsiString;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLast(const aString: AnsiString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLast(const aString: AnsiString;
                                       aChar: WideChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindLast(aString, Ansi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLast(const aString: AnsiString;
                                 const aSubstring: AnsiString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLastText(const aString: AnsiString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLastText(const aString: AnsiString;
                                           aChar: WideChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, Ansi(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindLastText(const aString: AnsiString;
                                     const aSubstring: AnsiString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNext(const aString: AnsiString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    pos: Integer;
    len: Integer;
    first: PAnsiChar;
    curr: PAnsiChar;
  begin
    Require('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      pos := Max(aPos, 0);

      if  (NOT HasLength(aString, len))
       or (pos >= len) then
        EXIT;

      first := Pointer(aString);
      curr  := PAnsiChar(Memory.ByteOffset(first, pos));
      Dec(len, pos);

      if (aCaseMode = csCaseSensitive) or (NOT Ansi.IsAlpha(aChar)) then
      begin
        for i := 1 to len do
        begin
          result := (curr^ = aChar);
          if result then
            BREAK;

          Inc(curr);
        end;
      end
      else
      begin
        // csIgnoreCase and char is Alpha

        for i := 1 to len do
        begin
          result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                                   curr, 1, @aChar, 1) = CSTR_EQUAL;
          if result then
            BREAK;

          Inc(curr);
        end;
      end;

    finally
      if result then
        aPos := (curr - first) + 1
      else
        aPos := 0;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNext(const aString: AnsiString;
                                       aChar: WideChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindNext(aString, Ansi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNext(const aString: AnsiString;
                                 const aSubstring: AnsiString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    pos: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PAnsiChar;
    curr: PAnsiChar;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      pos := Max(aPos, 0);

      if  (NOT HasLength(aString, strLen))
       or (pos + subLen > strLen) then
        EXIT;

      first := PAnsiChar(aString);
      curr  := PAnsiChar(Memory.ByteOffset(first, pos));
      Dec(strLen, pos + subLen - 1);

      for i := 1 to strLen do
      begin
        result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PAnsiChar(aSubstring), subLen) = CSTR_EQUAL;
        if result then
          BREAK;

        Inc(curr);
      end;

    finally
      if result then
        aPos := (curr - first) + 1
      else
        aPos := 0;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNextText(const aString: AnsiString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNextText(const aString: AnsiString;
                                           aChar: WideChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, Ansi(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindNextText(const aString: AnsiString;
                                     const aSubstring: AnsiString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPrevious(const aString: AnsiString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    pos: Integer;
    first: PAnsiChar;
    curr: PAnsiChar;
  begin
    Require('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if (aPos < 1) or NOT HasLength(aString, len) then
        EXIT;

      pos   := Min(aPos, len + 1);
      first := PAnsiChar(aString);
      curr  := PAnsiChar(Memory.ByteOffset(first, pos - 2));
      len   := pos - 1;

      if (aCaseMode = csCaseSensitive) or (NOT Ansi.IsAlpha(aChar)) then
      begin
        for i := 1 to len do
        begin
          result := (curr^ = aChar);
          if result then
            BREAK;

          Dec(curr);
        end;
      end
      else
      begin
        // csIgnoreCase and char is alpha

        for i := 1 to len do
        begin
          result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                                   curr, 1, @aChar, 1) = CSTR_EQUAL;
          if result then
            BREAK;

          Dec(curr);
        end;
      end;

    finally
      if result then
        aPos := (curr - first) + 1
      else
        aPos := 0;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPrevious(const aString: AnsiString;
                                           aChar: WideChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindPrevious(aString, Ansi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPrevious(const aString: AnsiString;
                                     const aSubstring: AnsiString;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PAnsiChar;
    curr: PAnsiChar;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if  (aPos < 1) or (SubLen = 0)
       or (NOT HasLength(aString, strLen)) then
        EXIT;

      aPos  := Min(aPos - 1, strLen - subLen + 1);
      first := PAnsiChar(aString);
      curr  := PAnsiChar(Memory.ByteOffset(first, aPos - 1));

      for i := 1 to aPos do
      begin
        result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PAnsiChar(aSubstring), subLen) = CSTR_EQUAL;
        if result then
          BREAK;

        Dec(curr);
      end;

    finally
      if result then
        aPos := (curr - first) + 1
      else
        aPos := 0;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPreviousText(const aString: AnsiString;
                                               aChar: AnsiChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPreviousText(const aString: AnsiString;
                                               aChar: WideChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, Ansi(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindPreviousText(const aString: AnsiString;
                                         const aSubstring: AnsiString;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAll(const aString: AnsiString;
                                      aChar: AnsiChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    len: Integer;
    firstChar: PAnsiChar;
    currChar: PAnsiChar;
  begin
    Require('aChar', aChar).IsNotNull;

    result := 0;
    SetLength(aPos, 0);

    len  := System.Length(aString);

    if (len = 0) then
      EXIT;

    SetLength(aPos, len);
    firstChar := PAnsiChar(aString);
    currChar  := firstChar;

    if (aCaseMode = csCaseSensitive) or (NOT Ansi.IsAlpha(aChar)) then
    begin
      for i := Pred(len) downto 0 do
      begin
        if (currChar^ = aChar) then
        begin
          aPos[result] := (currChar - firstChar) + 1;
          Inc(result);
        end;

        Inc(currChar);
      end;
    end
    else
    begin
      // csIgnoreCase and char is alpha

      for i := Pred(len) downto 0 do
      begin
        if CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                          currChar, 1,
                          @aChar, 1) = CSTR_EQUAL then
        begin
          aPos[result] := (currChar - firstChar) + 1;
          Inc(result);
        end;

        Inc(currChar);
      end;
    end;

    SetLength(aPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAll(const aString: AnsiString;
                                      aChar: WideChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := FindAll(aString, Ansi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAll(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    currChar: PAnsiChar;
    firstChar: PAnsiChar;
    pstr: PAnsiChar;
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := 0;
    SetLength(aPos, 0);

    strLen  := System.Length(aString);
    if (strLen = 0) or (subLen = 0) or (subLen > strLen)then
      EXIT;

    SetLength(aPos, strLen);
    pstr      := PAnsiChar(aSubstring);
    firstChar := PAnsiChar(aString);
    currChar  := firstChar;

    for i := (strLen - subLen) downto 0 do
    begin
      if (Windows.CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 currChar, subLen,
                                 pstr, subLen) = CSTR_EQUAL) then
      begin
        aPos[result] := (currChar - firstChar) + 1;
        Inc(result)
      end;

      Inc(currChar);
    end;

    SetLength(aPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAllText(const aString: AnsiString;
                                          aChar: AnsiChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAllText(const aString: AnsiString;
                                          aChar: WideChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, Ansi(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.FindAllText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.Delete(var aString: AnsiString;
                                    aIndex: Integer;
                                    aLength: Integer);
  begin
    Require('aIndex', aIndex).IsValidIndexForString(aString);
    Require('aLength', aLength).IsPositiveOrZero;

    if aLength = 0 then
      EXIT;

    System.Delete(aString, aIndex, aLength);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.DeleteRange(var aString: AnsiString;
                                         aIndex: INteger;
                                         aEndIndex: Integer);
  begin
    Require('aIndex', aIndex).IsValidIndexForString(aString);
    Require('aEndIndex', aEndIndex).IsValidIndexForString(aString);

    if aIndex > aEndIndex then
      Exchange(aIndex, aEndIndex);

    System.Delete(aString, aIndex, aEndIndex - aIndex + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Delete(var aString: AnsiString;
                                   aChar: AnsiChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Delete(var aString: AnsiString;
                                   aChar: WideChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Delete(aString, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Delete(var   aString: AnsiString;
                               const aSubstring: AnsiString;
                                     aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := Find(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteText(var aString: AnsiString;
                                       aChar: AnsiChar): Boolean;
  begin
    result := Delete(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteText(var aString: AnsiString;
                                       aChar: WideChar): Boolean;
  begin
    result := Delete(aString, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteText(var   aString: AnsiString;
                                   const aSubstring: AnsiString): Boolean;
  begin
    result := Delete(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAll(var   aString: AnsiString;
                                  const aSubstring: AnsiString;
                                        aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    idx: TCharIndexArray;
    subLen: Integer;
  begin
    result := FindAll(aString, aSubstring, idx, aCaseMode);
    if result > 0 then
    begin
      subLen := Length(aSubstring);

      for i := 0 to Pred(Length(idx)) do
        Delete(aString, idx[i] - (i * subLen), subLen);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAll(var aString: AnsiString;
                                      aChar: AnsiChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    idx: TCharIndexArray;
  begin
    result := FindAll(aString, aChar, idx, aCaseMode);
    if result > 0 then
      for i := 0 to Pred(Length(idx)) do
        Delete(aString, idx[i] - i, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAll(var aString: AnsiString;
                                      aChar: WideChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := DeleteAll(aString, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAllText(var aString: AnsiString;
                                          aChar: AnsiChar): Integer;
  begin
    result := DeleteAll(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAllText(var aString: AnsiString;
                                          aChar: WideChar): Integer;
  begin
    result := DeleteAll(aString, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteAllText(var   aString: AnsiString;
                                      const aSubstring: AnsiString): Integer;
  begin
    result := DeleteAll(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLast(var aString: AnsiString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLast(var aString: AnsiString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, Ansi(aChar), idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLast(var   aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLastText(var aString: AnsiString;
                                           aChar: AnsiChar): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLastText(var aString: AnsiString;
                                           aChar: WideChar): Boolean;
  begin
    result := Delete(aString, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLastText(var   aString: AnsiString;
                                       const aSubstring: AnsiString): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, csIgnoreCase);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.DeleteLeft(var aString: AnsiString;
                                        aCount: Integer);
  var
    copyChars: Integer;
    firstChar: Integer;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    if (aCount = 0) or NOT HasLength(aString, copyChars) then
      EXIT;

    Dec(copyChars, aCount);
    firstChar := aCount + 1;

    if copyChars > 0 then
      Utils.CopyChars(aString, firstChar, 1, copyChars) // _VAR_ aString - cannot case as pointer, must supply the address of char 1
    else
      copyChars := 0;

    SetLength(aString, copyChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLeft(var   aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteLeft(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteLeftText(var   aString: AnsiString;
                                    const aSubstring: AnsiString): Boolean;
  begin
    result := DeleteLeft(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure AnsiFn.DeleteRight(var aString: AnsiString;
                                     aCount: Integer);
  var
    len: Integer;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    if (aCount > 0) and HasLength(aString, len) then
      SetLength(aString, len - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteRight(var   aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteRight(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.DeleteRightText(var   aString: AnsiString;
                                    const aSubstring: AnsiString): Boolean;
  begin
    result := DeleteRight(aString, aSubstring, csIgnoreCase);
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Remove(const aString: AnsiString;
                                     aIndex: Integer;
                                     aLength: Integer): AnsiString;
  begin
    result := aString;
    System.Delete(result, aIndex, aLength);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Remove(const aString: AnsiString;
                                     aChar: AnsiChar;
                                     aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    Delete(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Remove(const aString: AnsiString;
                                     aChar: WideChar;
                                     aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    Delete(result, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Remove(const aString, aSubstring: AnsiString;
                                     aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    Delete(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveText(const aString: AnsiString;
                                         aChar: AnsiChar): AnsiString;
  begin
    result := aString;
    Delete(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveText(const aString: AnsiString;
                                         aChar: WideChar): AnsiString;
  begin
    result := aString;
    Delete(result, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveText(const aString, aSubstring: AnsiString): AnsiString;
  begin
    result := aString;
    Delete(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAll(const aString, aSubstring: AnsiString;
                                        aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAll(const aString: AnsiString;
                                        aChar: AnsiChar;
                                        aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteAll(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAll(const aString: AnsiString;
                                        aChar: WideChar;
                                        aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteAll(result, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAllText(const aString: AnsiString;
                                            aChar: AnsiChar): AnsiString;
  begin
    result := aString;
    DeleteAll(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAllText(const aString: AnsiString;
                                            aChar: WideChar): AnsiString;
  begin
    result := aString;
    DeleteAll(result, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveAllText(const aString, aSubstring: AnsiString): AnsiString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLast(const aString: AnsiString;
                                         aChar: AnsiChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteLast(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLast(const aString: AnsiString;
                                         aChar: WideChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteLast(result, Ansi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLast(const aString, aSubstring: AnsiString;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLastText(const aString: AnsiString;
                                             aChar: AnsiChar): AnsiString;
  begin
    result := aString;
    DeleteLast(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLastText(const aString: AnsiString;
                                             aChar: WideChar): AnsiString;
  begin
    result := aString;
    DeleteLast(result, Ansi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RemoveLastText(const aString, aSubstring: AnsiString): AnsiString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, csIgnoreCase);
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Extract(var aString: AnsiString;
                                    aIndex: Integer;
                                    aLength: Integer): AnsiString;
  begin
    if NOT Extract(aString, aIndex, aLength, result) then
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Extract(var aString: AnsiString;
                                    aIndex: Integer;
                                    aLength: Integer;
                                var aExtract: AnsiString): Boolean;
  var
    strLen: Integer;
  begin
    aExtract := '';
    result   := FALSE;

    if  (aLength = 0)
     or NOT HasLength(aString, strLen) then
      EXIT;

    Require('aIndex', aIndex).IsValidIndexForString(aString);
    Require('aIndex + aLength - 1', aIndex + aLength - 1).IsValidIndexForString(aString);

    aExtract := self.Copy(aString, aIndex, aLength);
    Delete(aString, aIndex, aLength);

    result := NOT IsEmpty(aExtract);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var aString: AnsiString;
                                     aCount: Integer): AnsiString;
  begin
    ExtractLeft(aString, aCount, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var aString: AnsiString;
                                     aCount: Integer;
                                 var aExtract: AnsiString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aExtract  := System.Copy(aString, 1, aCount);
    result    := NOT IsEmpty(aExtract);

    if result then
      System.Delete(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var  aString: AnsiString;
                                      aDelimiter: AnsiChar;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var  aString: AnsiString;
                                      aDelimiter: WideChar;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractLeft(aString, Ansi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var   aString: AnsiString;
                                 const aDelimiter: AnsiString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var  aString: AnsiString;
                                      aDelimiter: AnsiChar;
                                 var  aExtract: AnsiString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := Find(aString, aDelimiter, pos, aDelimiterCase);
    if result then
    begin
      case aDelimiterOption of
        doLeaveOptionalDelimiter,
        doDeleteOptionalDelimiter   : aExtract := System.Copy(aString, 1, pos - 1);
        doExtractOptionalDelimiter  : aExtract := System.Copy(aString, 1, pos);
      end;

      case aDelimiterOption of
        doLeaveOptionalDelimiter    : DeleteLeft(aString, pos - 1);
        doDeleteOptionalDelimiter,
        doExtractOptionalDelimiter  : DeleteLeft(aString, pos);
      end
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var  aString: AnsiString;
                                      aDelimiter: WideChar;
                                 var  aExtract: AnsiString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractLeft(aString, Ansi(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeft(var   aString: AnsiString;
                                 const aDelimiter: AnsiString;
                                 var   aExtract: AnsiString;
                                       aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
    delimLen: Integer;
  begin
    result := Find(aString, aDelimiter, pos, aDelimiterCase);

    if result then
    begin
      delimLen  := Length(aDelimiter);

      case aDelimiterOption of
        doLeaveOptionalDelimiter,
        doDeleteOptionalDelimiter   : aExtract := System.Copy(aString, 1, pos - 1);
        doExtractOptionalDelimiter  : aExtract := System.Copy(aString, 1, pos + delimLen - 1);
      end;

      case aDelimiterOption of
        doLeaveOptionalDelimiter    : DeleteLeft(aString, pos - 1);
        doDeleteOptionalDelimiter,
        doExtractOptionalDelimiter  : DeleteLeft(aString, pos + delimLen - 1);
      end
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var  aString: AnsiString;
                                          aDelimiter: AnsiChar;
                                          aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var  aString: AnsiString;
                                          aDelimiter: WideChar;
                                          aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractLeft(aString, Ansi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var   aString: AnsiString;
                                     const aDelimiter: AnsiString;
                                           aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var  aString: AnsiString;
                                          aDelimiter: AnsiChar;
                                     var  aExtract: AnsiString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var  aString: AnsiString;
                                          aDelimiter: WideChar;
                                     var  aExtract: AnsiString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, Ansi(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractLeftText(var   aString: AnsiString;
                                     const aDelimiter: AnsiString;
                                     var   aExtract: AnsiString;
                                           aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var aString: AnsiString; aCount: Integer): AnsiString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    SetLength(aString, Length(aString) - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var aString: AnsiString;
                                     aCount: Integer;
                                 var aExtract: AnsiString): Boolean;
  begin
    aExtract := ExtractRight(aString, aCount);
    result   := (aExtract <> '');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightFrom(var aString: AnsiString;
                                         aIndex: Integer): AnsiString;
  begin
    ExtractRightFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightFrom(var aString: AnsiString;
                                         aIndex: Integer;
                                     var aExtract: AnsiString): Boolean;
  var
    strLen: Integer;
  begin
    Require('aIndex', aIndex).IsPositiveOrZero;

    result := HasLength(aString, strLen) and (aIndex < strLen);
    if result then
    begin
      aExtract := System.Copy(aString, aIndex + 1, strLen - aIndex);
      SetLength(aString, aIndex);
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var aString: AnsiString;
                                     aDelimiter: AnsiChar;
                                     aDelimiterOption: TExtractDelimiterOption;
                                     aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var aString: AnsiString;
                                     aDelimiter: WideChar;
                                     aDelimiterOption: TExtractDelimiterOption;
                                     aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractRight(aString, Ansi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var   aString: AnsiString;
                                 const aDelimiter: AnsiString;
                                       aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var  aString: AnsiString;
                                      aDelimiter: AnsiChar;
                                 var  aExtract: AnsiString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
    strLen: Integer;
  begin
    result := HasLength(aString, strLen)
          and FindLast(aString, aDelimiter, pos, aDelimiterCase);

    if result then
    begin
      case aDelimiterOption of
        doLeaveOptionalDelimiter,
        doDeleteOptionalDelimiter   : aExtract := System.Copy(aString, pos + 1, strLen - pos);
        doExtractOptionalDelimiter  : aExtract := System.Copy(aString, pos, strLen - pos + 1);
      end;

      case aDelimiterOption of
        doLeaveOptionalDelimiter    : SetLength(aString, pos);
        doDeleteOptionalDelimiter,
        doExtractOptionalDelimiter  : SetLength(aString, pos - 1);
      end
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var  aString: AnsiString;
                                      aDelimiter: WideChar;
                                 var  aExtract: AnsiString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractRight(aString, Ansi(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRight(var   aString: AnsiString;
                                 const aDelimiter: AnsiString;
                                 var   aExtract: AnsiString;
                                       aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
    strLen, delimLen: Integer;
  begin
    result := HasLength(aString, strLen)
          and FindLast(aString, aDelimiter, pos, aDelimiterCase);

    if result then
    begin
      delimLen := Length(aDelimiter);

      case aDelimiterOption of
        doLeaveOptionalDelimiter,
        doDeleteOptionalDelimiter   : aExtract := System.Copy(aString, pos + delimLen, strLen - (pos + delimLen - 1));
        doExtractOptionalDelimiter  : aExtract := System.Copy(aString, pos, (strLen - pos) + delimLen);
      end;

      case aDelimiterOption of
        doLeaveOptionalDelimiter    : SetLength(aString, pos + delimLen - 1);
        doDeleteOptionalDelimiter,
        doExtractOptionalDelimiter  : SetLength(aString, pos - 1);
      end
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var  aString: AnsiString;
                                          aDelimiter: AnsiChar;
                                          aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var  aString: AnsiString;
                                          aDelimiter: WideChar;
                                          aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractRight(aString, Ansi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var   aString: AnsiString;
                                     const aDelimiter: AnsiString;
                                           aDelimiterOption: TExtractDelimiterOption): AnsiString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var  aString: AnsiString;
                                          aDelimiter: AnsiChar;
                                     var  aExtract: AnsiString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var  aString: AnsiString;
                                          aDelimiter: WideChar;
                                     var  aExtract: AnsiString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, Ansi(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractRightText(var   aString: AnsiString;
                                     const aDelimiter: AnsiString;
                                     var   aExtract: AnsiString;
                                           aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ExtractQuotedValue(var   aString: AnsiString;
                                           const aDelimiter: AnsiChar): AnsiString;
  var
    i: Integer;
    inQuote: Boolean;
  begin
    inQuote := FALSE;
    result  := '';
    i       := 1;

    try
      while i <= Length(aString) do
      begin
        if inQuote then
        begin
          if (i = Length(aString))
           or ((aString[i] = '"') and (aString[i + 1] <> '"')) then
            inQuote := FALSE;
        end
        else if aString[i] = '"' then
          inQuote := TRUE
        else if aString[i] = aDelimiter then
          BREAK;

        Inc(i);
      end;

    finally
      if (i > 1) then
        result := Copy(aString, 1, i - 1);

      Delete(aString, 1, i);
    end;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ConsumeLeft(var   aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      System.Delete(aString, 1, subLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ConsumeLeftText(var   aString: AnsiString;
                                        const aSubstring: AnsiString): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := BeginsWith(aString, aSubstring, csIgnoreCase);
    if result then
      System.Delete(aString, 1, subLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ConsumeRight(var   aString: AnsiString;
                                     const aSubstring: AnsiString;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen, strLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := HasLength(aString, strLen)
          and EndsWith(aString, aSubstring, aCaseMode);

    if result and (strLen > 0) then
      SetLength(aString, strLen - subLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ConsumeRightText(var   aString: AnsiString;
                                         const aSubstring: AnsiString): Boolean;
  var
    subLen, strLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := HasLength(aString, strLen)
          and EndsWith(aString, aSubstring, csIgnoreCase);

    if result and (strLen > 0) then
      SetLength(aString, strLen - subLen);
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Copy(const aString: AnsiString;
                                   aStartPos, aLength: Integer): AnsiString;
  begin
    Copy(aString, aStartPos, aLength, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Copy(const aString: AnsiString;
                                   aStartPos, aLength: Integer;
                             var   aCopy: AnsiString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aStartPos, aLength);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyFrom(const aString: AnsiString;
                                       aIndex: Integer): AnsiString;
  begin
    CopyFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyFrom(const aString: AnsiString;
                                       aIndex: Integer;
                                 var   aCopy: AnsiString): Boolean;
  begin
    Require('aIndex', aIndex).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aIndex, Length(aString) - aIndex + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRange(const aString: AnsiString;
                                        aStartPos: Integer;
                                        aEndPos: Integer): AnsiString;
  begin
    CopyRange(aString, aStartPos, aEndPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRange(const aString: AnsiString;
                                        aStartPos: Integer;
                                        aEndPos: Integer;
                                  var   aCopy: AnsiString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aStartPos, aEndPos - aStartPos + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aCount: Integer): AnsiString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aDelimiter: AnsiChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aDelimiter: WideChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyLeft(aString, Ansi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                              const aDelimiter: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aCount: Integer;
                              var   aCopy: AnsiString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aDelimiter: AnsiChar;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    if Find(aString, aDelimiter, p, aDelimiterCase) then
      case aDelimiterOption of
        doExcludeOptionalDelimiter,
        doExcludeRequiredDelimiter  : aCopy := System.Copy(aString, 1, p - 1);
        doIncludeOptionalDelimiter,
        doIncludeRequiredDelimiter  : aCopy := System.Copy(aString, 1, p);
      end
    else if aDelimiterOption in CopyDelimiterOptional then
      aCopy := aString
    else
      aCopy := '';

    result := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                                    aDelimiter: WideChar;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyLeft(aString, Ansi(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeft(const aString: AnsiString;
                              const aDelimiter: AnsiString;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p, delimLen: Integer;
  begin
    Require('aDelimiter', aDelimiter).IsNotEmpty.GetLength(delimLen);

    if Find(aString, aDelimiter, p, aDelimiterCase) then
      case aDelimiterOption of
        doExcludeOptionalDelimiter,
        doExcludeRequiredDelimiter  : aCopy := System.Copy(aString, 1, p - 1);
        doIncludeOptionalDelimiter,
        doIncludeRequiredDelimiter  : aCopy := System.Copy(aString, 1, p + delimLen - 1);
      end
    else if aDelimiterOption in CopyDelimiterOptional then
      aCopy := aString
    else
      aCopy := '';

    result := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                        aDelimiter: AnsiChar;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                        aDelimiter: WideChar;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyLeft(aString, Ansi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                  const aDelimiter: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                        aDelimiter: AnsiChar;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                        aDelimiter: WideChar;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, Ansi(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyLeftText(const aString: AnsiString;
                                  const aDelimiter: AnsiString;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aCount: Integer): AnsiString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aDelimiter: AnsiChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aDelimiter: WideChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyRight(aString, Ansi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                              const aDelimiter: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): AnsiString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aCount: Integer;
                              var   aCopy: AnsiString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aDelimiter: AnsiChar;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    if Find(aString, aDelimiter, p, aDelimiterCase) then
      case aDelimiterOption of
        doExcludeOptionalDelimiter,
        doExcludeRequiredDelimiter  : aCopy := System.Copy(aString, p + 1, Length(aString) - p);
        doIncludeOptionalDelimiter,
        doIncludeRequiredDelimiter  : aCopy := System.Copy(aString, p, Length(aString) - p + 1);
      end
    else if aDelimiterOption in CopyDelimiterOptional then
      aCopy := aString
    else
      aCopy := '';

    result := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                                    aDelimiter: WideChar;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyRight(aString, Ansi(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRight(const aString: AnsiString;
                              const aDelimiter: AnsiString;
                              var   aCopy: AnsiString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p, delimLen: Integer;
  begin
    Require('aDelimiter', aDelimiter).IsNotEmpty.GetLength(delimLen);

    if Find(aString, aDelimiter, p, aDelimiterCase) then
      case aDelimiterOption of
        doExcludeOptionalDelimiter,
        doExcludeRequiredDelimiter  : aCopy := System.Copy(aString, p + delimLen, Length(aString) - (p + delimLen - 1));
        doIncludeOptionalDelimiter,
        doIncludeRequiredDelimiter  : aCopy := System.Copy(aString, p, Length(aString) - p + 1);
      end
    else if aDelimiterOption in CopyDelimiterOptional then
      aCopy := aString
    else
      aCopy := '';

    result := Length(aCopy) > 0;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                        aDelimiter: AnsiChar;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                        aDelimiter: WideChar;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyRight(aString, Ansi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                  const aDelimiter: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): AnsiString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                        aDelimiter: AnsiChar;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                        aDelimiter: WideChar;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, Ansi(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.CopyRightText(const aString: AnsiString;
                                  const aDelimiter: AnsiString;
                                  var   aCopy: AnsiString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;



















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: AnsiChar;
                                      aReplacement: AnsiChar;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: WideChar;
                                      aReplacement: WideChar;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, Ansi(aChar), Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: AnsiChar;
                                const aReplacement: AnsiString;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: WideChar;
                                const aReplacement: AnsiString;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aReplacement: AnsiChar;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aReplacement: WideChar;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aSubstring, Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                const aReplacement: AnsiString;
                                      aCaseMode: TCaseSensitivity): AnsiString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: AnsiChar;
                                      aReplacement: AnsiChar;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;
    result := (aChar <> aReplacement) and Find(aString, aChar, p, aCaseMode);
    if result then
      PAnsiChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: WideChar;
                                      aReplacement: WideChar;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, Ansi(aChar), Ansi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: AnsiChar;
                                const aReplacement: AnsiString;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := Find(aString, aChar, p, aCaseMode);
    if result then
    begin
      if HasLength(aReplacement, replaceLen) then
      begin
        if (replaceLen > 1) then
        begin
          strLen := Length(aString);

          SetLength(aResult, strLen + replaceLen - 1);
          FastMove(aResult, p + 1, p + replaceLen, strLen - p);
          FastCopy(aReplacement, aResult, p, replaceLen);
        end
        else if (aChar <> PAnsiChar(aReplacement)[0]) then
          PAnsiChar(aResult)[p - 1] := PAnsiChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := Remove(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                      aChar: WideChar;
                                const aReplacement: AnsiString;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, Ansi(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aReplacement: AnsiChar;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := Find(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      subLen := Length(aSubstring);

      if subLen > 1 then
      begin
        strLen := Length(aString);
        FastMove(aResult, p + subLen, p + 1, strLen - (p + subLen - 1));
        SetLength(aResult, strLen - (subLen - 1));
      end
      else
        result := (aReplacement <> PAnsiChar(aSubString)[0]);

      if result then
        PAnsiChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                      aReplacement: WideChar;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, aSubstring, Ansi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Replace(const aString: AnsiString;
                                const aSubstring: AnsiString;
                                const aReplacement: AnsiString;
                                var   aResult: AnsiString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    subLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := Find(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      subLen := Length(aSubstring);

      if HasLength(aReplacement, replaceLen) then
      begin
        result := NOT (aReplacement = aSubstring);
        if NOT result then
          EXIT;

        if replaceLen > subLen then
          SetLength(aResult, Length(aString) + replaceLen - subLen);

        if replaceLen <> subLen then
          FastMove(aResult, p + subLen, p + replaceLen, Length(aString) - p);

        if (replaceLen = 1) then
          PAnsiChar(aResult)[p - 1] := PAnsiChar(aReplacement)[0]
        else
          FastCopy(aReplacement, aResult, p, replaceLen);

        if replaceLen < subLen then
          SetLength(aResult, Length(aString) + replaceLen - subLen);
      end
      else
        aResult := RemoveLast(aString, aSubstring, aCaseMode);
    end;
  end;





//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar): AnsiString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: WideChar;
                                          aReplacement: WideChar): AnsiString;
  begin
    result := Replace(aString, Ansi(aChar), Ansi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: AnsiChar;
                                    const aReplacement: AnsiString): AnsiString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: WideChar;
                                    const aReplacement: AnsiString): AnsiString;
  begin
    result := Replace(aString, Ansi(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: AnsiChar): AnsiString;
  begin
    result := Replace(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: WideChar): AnsiString;
  begin
    result := Replace(aString, aSubstring, Ansi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                    const aReplacement: AnsiString): AnsiString;
  begin
    result := Replace(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                    var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                    var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, Ansi(aChar), Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: AnsiChar;
                                    const aReplacement: AnsiString;
                              var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                          aChar: WideChar;
                                    const aReplacement: AnsiString;
                              var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, Ansi(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: AnsiChar;
                                    var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, aSubString, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: WideChar;
                                    var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, aSubstring, Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceText(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                    const aReplacement: AnsiString;
                              var   aResult: AnsiString): Boolean;
  begin
    result := Replace(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;




//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: AnsiChar;
                                         aReplacement: AnsiChar;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    p: TCharIndexArray;
  begin
    aResult := aString;

    result := (aChar <> aReplacement) and (FindAll(aString, aChar, p, aCaseMode) > 0);
    if result then
      for i := Low(p) to High(p) do
        PAnsiChar(aResult)[p[i] - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: WideChar;
                                         aReplacement: WideChar;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, Ansi(aChar), Ansi(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: AnsiChar;
                                   const aReplacement: AnsiString;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: TCharIndexArray;
    strLen, replaceLen: Integer;
    occurs, nudge: Integer;
  begin
    aResult := aString;

    result := HasLength(aString, strLen);
    if NOT result then
      EXIT;

    occurs := FindAll(aString, aChar, pa, aCaseMode);
    result := occurs > 0;
    if NOT result then
      EXIT;

    if HasLength(aReplacement, replaceLen) then
    begin
      if (replaceLen > 1) then
      begin
        nudge := replaceLen - 1;

        SetLength(aResult, strLen + (occurs * nudge));

        for i := 0 to Pred(occurs) do
        begin
          p := pa[i] + (i * nudge);
          FastMove(aResult, p + 1, p + replaceLen, strLen - p + (i * nudge));
          FastCopy(aReplacement, aResult, p, replaceLen);
        end;
      end
      else for i := 0 to Pred(occurs) do
        PAnsiChar(aResult)[pa[i] - 1] := PAnsiChar(aReplacement)[0];
    end
    else
      aResult := RemoveAll(aString, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: WideChar;
                                   const aReplacement: AnsiString;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, Ansi(aChar), aReplacement, aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aReplacement: AnsiChar;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: TCharIndexArray;
    strLen, subLen: Integer;
    occurs, nudge: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := HasLength(aString, strLen);
    if NOT result then
      EXIT;

    occurs := FindAll(aString, aSubstring, pa, aCaseMode);
    result := occurs > 0;
    if NOT result then
      EXIT;

    subLen := Length(aSubstring);
    if (subLen > 1) then
    begin
      nudge := 1 - subLen;

      for i := 0 to Pred(occurs) do
      begin
        p := pa[i] + (i * nudge);
        FastMove(aResult, p + subLen, p + 1, strLen - (p + subLen - 1));
        PAnsiChar(aResult)[p - 1] := aReplacement;
      end;

      SetLength(aResult, strLen + (occurs * nudge));
    end
    else for i := 0 to Pred(occurs) do
      PAnsiChar(aResult)[pa[i] - 1] := PAnsiChar(aReplacement)[0];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aReplacement: WideChar;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, Ansi(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                   const aReplacement: AnsiString;
                                   var   aResult: AnsiString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: TCharIndexArray;
    strLen, subLen, replaceLen: Integer;
    occurs, nudge: Integer;
  begin
    aResult := aString;

    result := HasLength(aString, strLen);
    if NOT result then
      EXIT;

    occurs := FindAll(aString, aSubstring, pa, aCaseMode);
    result := occurs > 0;
    if NOT result then
      EXIT;

    subLen := Length(aSubstring);

    if HasLength(aReplacement, replaceLen) then
    begin
      result := NOT (aReplacement = aSubstring);
      if NOT result then
        EXIT;

      if replaceLen <> subLen then
      begin
        nudge := replaceLen - subLen;

        if nudge > 0 then
          SetLength(aResult, strLen + (occurs * nudge));

        if replaceLen > 1 then
        begin
          for i := 0 to Pred(occurs) do
          begin
            p := pa[i] + (i * nudge);
            FastMove(aResult, p + subLen, p + replaceLen, strLen - p);
            FastCopy(aReplacement, aResult, p, replaceLen);
          end;
        end
        else for i := 0 to Pred(occurs) do
        begin
          p := pa[i] + (i * nudge);
          FastMove(aResult, p + subLen, p + replaceLen, strLen - p);
          PAnsiChar(aResult)[p - 1] := PAnsiChar(aReplacement)[0];
        end;

        if nudge < 0 then
          SetLength(aResult, strLen + (occurs * nudge));
      end
      else if (replaceLen = 1) then
      begin
        for i := 0 to Pred(occurs) do
          PAnsiChar(aResult)[pa[i] - 1] := PAnsiChar(aReplacement)[0];
      end
      else for i := 0 to Pred(occurs) do
        FastCopy(aReplacement, aResult, pa[i], replaceLen);
    end
    else
      aResult := RemoveAll(aString, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: AnsiChar;
                                         aReplacement: AnsiChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: WideChar;
                                         aReplacement: WideChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, Ansi(aChar), Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: AnsiChar;
                                   const aReplacement: AnsiString;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                         aChar: WideChar;
                                   const aReplacement: AnsiString;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, Ansi(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aReplacement: AnsiChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                         aReplacement: WideChar;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAll(const aString: AnsiString;
                                   const aSubstring: AnsiString;
                                   const aReplacement: AnsiString;
                                         aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: AnsiChar;
                                             aReplacement: AnsiChar;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: WideChar;
                                             aReplacement: WideChar;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, Ansi(aChar), Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: AnsiChar;
                                       const aReplacement: AnsiString;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: WideChar;
                                       const aReplacement: AnsiString;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, Ansi(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                             aReplacement: AnsiChar;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                             aReplacement: WideChar;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                       const aReplacement: AnsiString;
                                       var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: AnsiChar;
                                             aReplacement: AnsiChar): AnsiString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: WideChar;
                                             aReplacement: WideChar): AnsiString;
  begin
    ReplaceAll(aString, Ansi(aChar), Ansi(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: AnsiChar;
                                       const aReplacement: AnsiString): AnsiString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                             aChar: WideChar;
                                       const aReplacement: AnsiString): AnsiString;
  begin
    ReplaceAll(aString, Ansi(aChar), aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                             aReplacement: AnsiChar): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                             aReplacement: WideChar): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, Ansi(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceAllText(const aString: AnsiString;
                                       const aSubstring: AnsiString;
                                       const aReplacement: AnsiString): AnsiString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;



//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := (aChar <> aReplacement) and FindLast(aString, aChar, p, aCaseMode);
    if result then
      PAnsiChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, Ansi(aChar), Ansi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: AnsiChar;
                                    const aReplacement: AnsiString;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := FindLast(aString, aChar, p, aCaseMode);
    if result then
    begin
      if HasLength(aReplacement, replaceLen) then
      begin
        if (replaceLen > 1) then
        begin
          strLen := Length(aString);

          SetLength(aResult, strLen + replaceLen - 1);
          FastMove(aResult, p + 1, p + replaceLen, strLen - p);
          FastCopy(aReplacement, aResult, p, replaceLen);
        end
        else if (aChar <> PAnsiChar(aReplacement)[0]) then
          PAnsiChar(aResult)[p - 1] := PAnsiChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: WideChar;
                                    const aReplacement: AnsiString;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, Ansi(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: AnsiChar;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := FindLast(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      subLen := Length(aSubstring);

      if subLen > 1 then
      begin
        strLen := Length(aString);

        FastMove(aResult, p + subLen, p + 1, strLen - (p + subLen - 1));
        SetLength(aResult, strLen - (subLen - 1));
      end
      else
        result := (aReplacement <> PAnsiChar(aSubString)[0]);

      if result then
        PAnsiChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: WideChar;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, Ansi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                    const aReplacement: AnsiString;
                                    var   aResult: AnsiString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := HasLength(aString, strLen);
    if NOT result then
      EXIT;

    result := FindLast(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      subLen := Length(aSubstring);

      if HasLength(aReplacement, replaceLen) then
      begin
        result := NOT (aReplacement = aSubstring);
        if NOT result then
          EXIT;

        if replaceLen > subLen then
          SetLength(aResult, strLen + replaceLen - subLen);

        if (replaceLen <> subLen) and (p + subLen <= strLen) then
          FastMove(aResult, p + subLen, p + replaceLen, strLen - (p + subLen - 1));

        if (replaceLen = 1) then
          PAnsiChar(aResult)[p - 1] := PAnsiChar(aReplacement)[0]
        else
          FastCopy(aReplacement, aResult, p, replaceLen);

        if replaceLen < subLen then
          SetLength(aResult, strLen + replaceLen - subLen);
      end
      else
        aResult := RemoveLast(aString, aSubstring, aCaseMode);
    end;
  end;


//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, Ansi(aChar), Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: AnsiChar;
                                    const aReplacement: AnsiString;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                          aChar: WideChar;
                                    const aReplacement: AnsiString;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: AnsiChar;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                          aReplacement: WideChar;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aSubstring, Ansi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLast(const aString: AnsiString;
                                    const aSubstring: AnsiString;
                                    const aReplacement: AnsiString;
                                          aCaseMode: TCaseSensitivity): AnsiString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: AnsiChar;
                                              aReplacement: AnsiChar): AnsiString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: WideChar;
                                              aReplacement: WideChar): AnsiString;
  begin
    result := ReplaceLast(aString, Ansi(aChar), Ansi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: AnsiChar;
                                        const aReplacement: AnsiString): AnsiString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: WideChar;
                                        const aReplacement: AnsiString): AnsiString;
  begin
    result := ReplaceLast(aString, Ansi(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                              aReplacement: AnsiChar): AnsiString;
  begin
    result := ReplaceLast(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                              aReplacement: WideChar): AnsiString;
  begin
    result := ReplaceLast(aString, aSubstring, Ansi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                        const aReplacement: AnsiString): AnsiString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: AnsiChar;
                                              aReplacement: AnsiChar;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: WideChar;
                                              aReplacement: WideChar;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, Ansi(aChar), Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: AnsiChar;
                                        const aReplacement: AnsiString;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                              aChar: WideChar;
                                        const aReplacement: AnsiString;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, Ansi(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                              aReplacement: AnsiChar;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, aSubString, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                              aReplacement: WideChar;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, Ansi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.ReplaceLastText(const aString: AnsiString;
                                        const aSubstring: AnsiString;
                                        const aReplacement: AnsiString;
                                        var   aResult: AnsiString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;



















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.StringOf(aChar: AnsiChar; aCount: Integer): AnsiString;
  var
    i: Integer;
  begin
    SetLength(result, aCount);

    for i := Pred(aCount) downto 0 do
      result[i + 1] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.StringOf(aChar: WideChar;
                                 aCount: Integer): AnsiString;
  begin
    result := StringOf(Ansi(aChar), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.StringOf(const aString: AnsiString; aCount: Integer): AnsiString;
  var
    i: Integer;
    strLen: Integer;
    pr: PAnsiChar;
  begin
    if HasLength(aString, strLen) and (aCount > 0) then
    begin
      SetLength(result, strLen * aCount);

      pr := PAnsiChar(result);

      for i := 1 to aCount do
        FastWrite(aString, pr, strLen);
    end
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AsBoolean(const aString: AnsiString): Boolean;
  begin
    result := Parse.AsBoolean(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AsBoolean(const aString: AnsiString;
                                        aDefault: Boolean): Boolean;
  begin
    result := Parse.AsBoolean(PAnsiChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AsInteger(const aString: AnsiString): Integer;
  begin
    result := Parse.AsInteger(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.AsInteger(const aString: AnsiString;
                                        aDefault: Integer): Integer;
  begin
    result := Parse.AsInteger(PAnsiChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsBoolean(const aString: AnsiString): Boolean;
  begin
    result := Parse.IsBoolean(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsBoolean(const aString: AnsiString;
                                  var   aValue: Boolean): Boolean;
  begin
    result := Parse.IsBoolean(PAnsiChar(aString), Length(aString), aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsInteger(const aString: AnsiString): Boolean;
  begin
    result := Parse.IsInteger(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.IsInteger(const aString: AnsiString;
                                  var   aValue: Integer): Boolean;
  begin
    result := Parse.IsInteger(PAnsiChar(aString), Length(aString), aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Append(const aString: AnsiString;
                                    aChar: AnsiChar): AnsiString;
  begin
    result := aString;
    SetLength(result, Length(result) + 1);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Append(const aString, aSuffix: AnsiString): AnsiString;
  var
    strLen: Integer;
    sfxlen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxLen) then
      begin
        SetLength(result, strLen + sfxlen);
        FastCopy(aSuffix, result, strLen + 1, sfxLen);
      end;
    end
    else
      result := aSuffix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Append(const aString: AnsiString;
                               const aSuffix: AnsiString;
                                     aSeparator: AnsiChar): AnsiString;
  var
    strLen: Integer;
    sfxLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxlen) then
      begin
        SetLength(result, strLen + sfxLen + 1);

        PAnsiChar(result)[strLen] := aSeparator;

        FastCopy(aSuffix, result, strLen + 2, sfxLen);
      end;
    end
    else
      result := aSuffix
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   class function AnsiFn.Append(const aString: AnsiString;
                                const aSuffix: AnsiString;
                                const aSeparator: AnsiString): AnsiString;
  var
    strLen: Integer;
    sepLen: Integer;
    sfxLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxlen) then
      begin
        if HasLength(aSeparator, sepLen) then
        begin
          SetLength(result, strLen + sepLen + sfxLen);

          FastCopy(aSeparator, result, strLen + 1, sepLen);
          FastCopy(aSuffix, result, strLen + sepLen + 1, sfxLen);
        end
        else
        begin
          SetLength(result, strLen + sfxLen);

          FastCopy(aSuffix, result, strLen + 1, sfxLen);
        end;
      end;
    end
    else
      result := aSuffix
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Insert(const aString: AnsiString;
                                    aPos: Integer;
                              const aChar: AnsiChar): AnsiString;
  var
    strLen: Integer;
  begin
    result := aString;

    strLen := Length(aString);
    if (aPos <= 1) or (aPos > strLen) then    // Deals with strLen = 0
      EXIT;

    SetLength(result, strLen + 1);

    // Shift the previous end of the string to make room for the infix
    Utils.CopyChars(result, aPos - 1, aPos, strLen - aPos + 1);

    result[aPos] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Insert(const aString: AnsiString;
                                    aPos: Integer;
                              const aInfix: AnsiString): AnsiString;
  var
    strLen: Integer;
    ifxlen: Integer;
    bufPos: INteger;
  begin
    result := aString;

    strLen := Length(aString);
    ifxlen := Length(aInfix);

    if  (ifxlen = 0)
     or ((aPos <= 1) or (aPos > strLen)) then   // Deals with strLen = 0
      EXIT;

    SetLength(result, strLen + ifxlen);

    bufPos := Pred(aPos);

    // Shift the previous end of the string to make room for the infix
    Utils.CopyChars(result, bufPos, bufPos + ifxlen, strLen - aPos + 1);

    // Copy the infix into the space left by shifting the previous end of the string
    Ansi.CopyToBuffer(aInfix, ifxlen, Pointer(result), bufPos);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Insert(const aString: AnsiString;
                                    aPos: Integer;
                              const aInfix: AnsiString;
                                    aSeparator: AnsiChar): AnsiString;
  var
    strLen: Integer;
    ifxLen: Integer;
    bufPos: INteger;
  begin
    result := aString;

    strLen := Length(aString);
    ifxlen := Length(aInfix);

    if  (ifxlen = 0)
     or ((aPos <= 1) or (aPos > strLen)) then   // Deals with strLen = 0
      EXIT;

    SetLength(result, strLen + ifxLen + 2);

    bufPos := Pred(aPos);

    // Shift the previous end of the string to make room for the infix
    Utils.CopyChars(result, bufPos, bufPos + ifxLen + 2, strLen - aPos + 1);

    // Copy the infix into the space left by shifting the previous end of the string
    Ansi.CopyToBuffer(aInfix, ifxLen, Pointer(result), aPos);

    result[aPos]              := aSeparator;
    result[aPos + ifxLen + 1] := aSeparator;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Insert(const aString: AnsiString;
                                    aPos: Integer;
                              const aInfix: AnsiString;
                              const aSeparator: AnsiString): AnsiString;
  var
    strLen: Integer;
    ifxLen: Integer;
    sepLen: Integer;
    bufPos: INteger;
  begin
    result := aString;

    strLen := Length(aString);
    ifxlen := Length(aInfix);

    if  (ifxlen = 0)
     or ((aPos <= 1) or (aPos > strLen)) then   // Deals with strLen = 0
      EXIT;

    if HasLength(aSeparator, sepLen) then
    begin
      SetLength(result, strLen + ifxLen + (2 * sepLen));

      bufPos := Pred(aPos);

      // Shift the previous end of the string to make room for the infix
      Utils.CopyChars(result, bufPos, bufPos + ifxLen + (2 * sepLen), strLen - aPos + 1);

      // Copy the infix into the space left by shifting the previous end of the string
      Ansi.CopyToBuffer(aInfix, ifxLen, Pointer(result), bufPos + sepLen);

      // Copy the separator into the space either side of the infix
      Ansi.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos);
      Ansi.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos + ifxLen + sepLen);
    end
    else
      result := Insert(aString, aPos, aInfix);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Prepend(const aString: AnsiString;
                                     aChar: AnsiChar): AnsiString;
  var
    strLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      SetLength(result, strLen + 1);

      Utils.CopyChars(result, 0, 1, strLen);
    end
    else
      SetLength(result, 1);

    result[1] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Prepend(const aString: AnsiString;
                               const aPrefix: AnsiString): AnsiString;
  var
    strLen: Integer;
    pfxLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aPrefix, pfxLen) then
      begin
        SetLength(result, strLen + pfxLen);

        Utils.CopyChars(result, 0, pfxLen, Length(aString));

        CopyToBuffer(aPrefix, pfxLen, PAnsiChar(result), 0);
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Prepend(const aString: AnsiString;
                               const aPrefix: AnsiString;
                                     aSeparator: AnsiChar): AnsiString;
  var
    strLen: Integer;
    pfxLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aPrefix, pfxLen) then
      begin
        SetLength(result, strLen + pfxLen + 1);

        Utils.CopyChars(result, 0, pfxLen + 1, Length(aString));

        CopyToBuffer(aPrefix, pfxLen, PAnsiChar(result), 0);

        result[pfxLen + 1] := aSeparator;
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Prepend(const aString: AnsiString;
                               const aPrefix: AnsiString;
                               const aSeparator: AnsiString): AnsiString;
  var
    strLen: Integer;
    pfxLen: Integer;
    sepLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if NOT HasLength(aPrefix, pfxLen) then
        EXIT;

      if HasLength(aSeparator, sepLen) then
      begin
        SetLength(result, strLen + pfxLen + sepLen);

        Utils.CopyChars(result, 0, pfxLen + sepLen, Length(aString));

        CopyToBuffer(aPrefix,     pfxLen, PAnsiChar(result), 0);
        CopyToBuffer(aSeparator,  sepLen, PAnsiChar(result), pfxLen);
      end
      else
        result := Prepend(aString, aPrefix);
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Tag(const aString, aTag: AnsiString): AnsiString;
  var
    tlen: Integer;
    rlen: Integer;
    blen: Integer;
    p: PAnsiChar;
    buf: PByte absolute p;
  begin
    tlen := Length(aTag);
    if tlen = 0 then
      EXIT;

    blen := Length(aString);

    rlen := blen + (tlen * 2) + 5;
    SetLength(result, rlen);

    p := PAnsiChar(result);
    p[0]        := '<';
    p[tlen + 1] := '>';

    p[tlen + blen + 2] := '<';
    p[tlen + blen + 3] := '/';
    p[rlen - 1]        := '>';

    if blen > 0 then
      CopyToBuffer(aString, blen, buf, tlen + 2);

    CopyToBuffer(aTag, tlen, buf, 1);
    CopyToBuffer(aTag, tlen, buf, tlen + blen + 4);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.LTrim(const aString: AnsiString): AnsiString;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := 0;
    while (i < strLen) and (chars[i] <= #32) do
      Inc(i);

    if i = strLen then
      result := ''
    else
      result := Remove(aString, 1, i);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.LTrim(const aString: AnsiString;
                                    aChar: AnsiChar): AnsiString;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := 0;
    while (i < strLen) and (chars[i] = aChar) do
      Inc(i);

    if i = strLen then
      result := ''
    else
      result := Remove(aString, 1, i)
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.LTrim(const aString: AnsiString;
                                    aCount: Integer): AnsiString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := aString;
    DeleteLeft(result, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RTrim(const aString: AnsiString): AnsiString;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := Pred(strLen);
    while (i >= 0) and (chars[i] <= #32) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RTrim(const aString: AnsiString;
                                        aChar: AnsiChar): AnsiString;
  var
    chars: PAnsiChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, len) then
      EXIT;

    i := Pred(len);
    while (i >= 0) and (chars[i] = aChar) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RTrim(const aString: AnsiString;
                                        aChar: WideChar): AnsiString;
  begin
    result := RTrim(aString, Ansi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.RTrim(const aString: AnsiString;
                                        aCount: Integer): AnsiString;
  var
    len: Integer;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := aString;

    if (aCount > 0) and HasLength(result, len) then
      if aCount < len then
        SetLength(result, len - aCount)
      else
        SetLength(result, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Trim(const aString: AnsiString): AnsiString;
  begin
    result := RTrim(LTrim(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Trim(const aString: AnsiString;
                                   aChar: AnsiChar): AnsiString;
  begin
    result := RTrim(LTrim(aString, aChar), aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Trim(const aString: AnsiString;
                                   aCount: Integer): AnsiString;
  begin
    result := aString;
    DeleteLeft(result, aCount);
    DeleteRight(result, aCount);
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Unbrace(const aString: AnsiString): AnsiString;
  begin
    Unbrace(aString, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Unbrace(const aString: AnsiString;
                                var   aResult: AnsiString): Boolean;
  const
    MATCH_SET : set of AnsiChar = ['!','@','#','%','&','*','-','_',
                                   '+','=',':','/','?','\','|','~'];
  var
    strLen, rlen: Integer;
    firstChar: AnsiChar;
    lastChar: AnsiChar;
  begin
    result  := FALSE;
    aResult := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    rlen := strLen - 2;
    if rlen < 0 then
      EXIT;

    // First determine whether the string is braced - if not we return the
    //  original string

    firstChar := PAnsiChar(aString)[0];
    lastChar  := PAnsiChar(aString)[strLen - 1];

    case firstChar of
      '{' : if lastChar <> '}' then EXIT;
      '<' : if lastChar <> '>' then EXIT;
      '(' : if lastChar <> ')' then EXIT;
      '[' : if lastChar <> ']' then EXIT;
    else
      if NOT (firstChar in MATCH_SET)
          or (lastChar <> firstChar) then
        EXIT;
    end;

    SetLength(aResult, rlen);

    if rlen > 0 then
      aResult := System.Copy(aString, 2, rlen)
    else
      aResult := '';

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Unquote(const aString: AnsiString): AnsiString;
  begin
    Unquote(aString, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Unquote(const aString: AnsiString;
                                var   aResult: AnsiString): Boolean;
  var
    strLen: Integer;
    qc: AnsiChar;
    prc, psc, last: PAnsiChar;
  begin
    result  := FALSE;
    aResult := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    qc := PAnsiChar(aString)[0];
    if (PAnsiChar(aString)[strLen - 1] <> qc)
     or ((qc <> '''') and (qc <> '"') and (qc <> '`')) then
      EXIT;

    prc   := PAnsiChar(aResult);
    psc   := PAnsiChar(aString);
    last  := psc + (strLen - 2);
    Inc(psc);

    while psc <= last do
    begin
      prc^ := psc^;

      if (psc^ = qc) then
      begin
        Inc(psc);
        if psc^ = qc then
          Inc(psc)
        else
          raise Exception.CreateFmt('Quoted string ''%s'' contains incorrectly escaped quotes', [STR.FromAnsi(aString)]);
      end
      else
        Inc(psc);

      Inc(prc);
    end;

    SetLength(aResult, Integer(prc) - Integer(PAnsiChar(aResult)));
    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Startcase(const aString: AnsiString): AnsiString;
  var
    i: Integer;
    len: Integer;
    prev: AnsiChar;
    prevAlpha: Boolean;
    ch: AnsiChar;
  begin
    result := aString;

    if NOT HasLength(result, len) then
      EXIT;

    prev      := result[1];
    prevAlpha := IsAlpha(prev);
    if prevAlpha then
      result[1] := Uppercase(prev);

    for i := 2 to len do
    begin
      ch := result[i];

      if IsAlpha(ch) then
      begin
         if  (prevAlpha)
          or (prev = '''') then
          result[i] := Lowercase(ch)
        else
          result[i] := Uppercase(ch);

        prevAlpha := TRUE;
      end
      else
        prevAlpha := FALSE;

      prev := ch;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Lowercase(aChar: AnsiChar): AnsiChar;
  begin
    result := aChar;
    CharLowerBuffA(@result, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Lowercase(const aString: AnsiString): AnsiString;
  begin
    result := aString;
    if result <> '' then
      CharLowerBuffA(PAnsiChar(result), Length(result));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Uppercase(aChar: AnsiChar): AnsiChar;
  begin
    result := aChar;
    CharUpperBuffA(@result, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiFn.Uppercase(const aString: AnsiString): AnsiString;
  begin
    result := aString;
    if result <> '' then
      CharUpperBuffA(PAnsiChar(result), Length(result));
  end;







end.
