
{$i deltics.strings.inc}


  unit Deltics.Strings.ANSI;


interface

  uses
    SysUtils,
    Windows,
    Deltics.Strings.Parsers.ANSI,
    Deltics.Strings.Types;


  type
    ANSIFn = class
    private
      class function AddressOfByte(aBase: Pointer; aByteIndex: Integer): PANSIChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AddressOfIndex(const aString: ANSIString; aIndex: Integer): PANSIChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: ANSIString; aDest: PANSIChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: ANSIString; var aDest: ANSIString; aDestIndex: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: ANSIString; var aDest: ANSIString; aDestIndex: Integer; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastMove(var aString: ANSIString; aFromIndex, aToIndex, aCount: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastWrite(const aString: ANSIString; var aDest: PANSIChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class function CheckCase(const aString: ANSIString; aCaseFn: TANSITestCharFn): Boolean;
      class procedure CopyToBuffer(const aString: ANSIString; aMaxBytes: Integer; aBuffer: Pointer; aOffset: Integer); overload;

    public
      class function Parse: ANSIParserClass;

      // Transcoding
      class function Encode(const aString: String): ANSIString;
      class function FromANSI(const aBuffer: PAnsiChar; aMaxLen: Integer = -1): AnsiString; overload;
      class function FromString(const aString: String): ANSIString;
      class function FromUTF8(const aString: UTF8String): ANSIString; overload;
      class function FromUTF8(const aBuffer: PUTF8Char; aMaxLen: Integer = -1): ANSIString; overload;
      class function FromWIDE(const aString: UnicodeString): ANSIString; overload;
      class function FromWIDE(const aBuffer: PWIDEChar; aMaxLen: Integer = -1): ANSIString; overload;

      // Buffer (SZ pointer) routines
      class function AllocUTF8(const aSource: ANSIString): PUTF8Char;
      class procedure CopyToBuffer(const aString: ANSIString; aBuffer: Pointer); overload;
      class procedure CopyToBuffer(const aString: ANSIString; aBuffer: Pointer; aMaxChars: Integer); overload;
      class procedure CopyToBufferOffset(const aString: ANSIString; aBuffer: Pointer; aByteOffset: Integer); overload;
      class procedure CopyToBufferOffset(const aString: ANSIString; aBuffer: Pointer; aByteOffset: Integer; aMaxChars: Integer); overload;
      class function FromBuffer(aBuffer: PANSIChar; aLen: Integer = -1): ANSIString; overload;
      class function FromBuffer(aBuffer: PWIDEChar; aLen: Integer = -1): ANSIString; overload;
      class function Len(aBuffer: PANSIChar): Integer;

      // Misc utilities
      class function Coalesce(const aString, aDefault: ANSIString): ANSIString; overload;
      class function HasLength(const aString: ANSIString; var aLength: Integer): Boolean;
      class function HasIndex(const aString: ANSIString; aIndex: Integer): Boolean; overload;
      class function HasIndex(const aString: ANSIString; aIndex: Integer; var aChar: ANSIChar): Boolean; overload;
      class function IIf(aValue: Boolean; const aWhenTrue, aWhenFalse: ANSIString): ANSIString; overload;
      class function IndexOf(const aString: ANSIString; aValues: array of ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function IndexOfText(const aString: ANSIString; aValues: array of ANSIString): Integer; overload;
      class function Reverse(const aString: ANSIString): ANSIString;
      class function Split(const aString: ANSIString; aChar: ANSIChar; var aLeft, aRight: ANSIString): Boolean; overload;
      class function Split(const aString: ANSIString; aChar: WIDEChar; var aLeft, aRight: ANSIString): Boolean; overload;
      class function Split(const aString, aDelim: ANSIString; var aLeft, aRight: ANSIString): Boolean; overload;
      class function Split(const aString: ANSIString; aChar: ANSIChar; var aParts: TANSIStringArray): Boolean; overload;
      class function Split(const aString: ANSIString; aChar: WIDEChar; var aParts: TANSIStringArray): Boolean; overload;
      class function Split(const aString, aDelim: ANSIString; var aParts: TANSIStringArray): Boolean; overload;

      // Assembling a string
      class function Concat(const aArray: array of ANSIString): ANSIString; overload;
      class function Concat(const aArray: array of ANSIString; const aSeparator: ANSIString): ANSIString; overload;
      class function Format(const aString: ANSIString; const aArgs: array of const): ANSIString;
      class function StringOf(aChar: ANSIChar; aCount: Integer): ANSIString; overload;
      class function StringOf(aChar: WIDEChar; aCount: Integer): ANSIString; overload;
      class function StringOf(const aString: ANSIString; aCount: Integer): ANSIString; overload;

      // Type conversions
      class function AsBoolean(const aString: ANSIString): Boolean; overload;
      class function AsBoolean(const aString: ANSIString; aDefault: Boolean): Boolean; overload;
      class function AsInteger(const aString: ANSIString): Integer; overload;
      class function AsInteger(const aString: ANSIString; aDefault: Integer): Integer; overload;
      class function IsBoolean(const aString: ANSIString): Boolean; overload;
      class function IsBoolean(const aString: ANSIString; var aValue: Boolean): Boolean; overload;
      class function IsInteger(const aString: ANSIString): Boolean; overload;
      class function IsInteger(const aString: ANSIString; var aValue: Integer): Boolean; overload;

      // Testing things about a string
      class function IsAlpha(aChar: ANSIChar): Boolean; overload;
      class function IsAlpha(const aString: ANSIString): Boolean; overload;
      class function IsAlphaNumeric(aChar: ANSIChar): Boolean; overload;
      class function IsAlphaNumeric(const aString: ANSIString): Boolean; overload;
      class function IsEmpty(const aString: ANSIString): Boolean;
      class function IsLowercase(const aChar: ANSIChar): Boolean; overload;
      class function IsLowercase(const aString: ANSIString): Boolean; overload;
      class function IsNull(aChar: ANSIChar): Boolean;
      class function IsNumeric(aChar: ANSIChar): Boolean; overload;
      class function IsNumeric(const aString: ANSIString): Boolean; overload;
      class function IsUppercase(const aChar: ANSIChar): Boolean; overload;
      class function IsUppercase(const aString: ANSIString): Boolean; overload;
      class function NotEmpty(const aString: ANSIString): Boolean;

      // Comparing with other strings
      class function Compare(const A, B: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): TCompareResult;
      class function CompareText(const A, B: ANSIString): TCompareResult;
      class function MatchesAny(const aString: ANSIString; aValues: array of ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function MatchesAnyText(const aString: ANSIString; aValues: array of ANSIString): Boolean; overload;
      class function SameString(const A, B: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean;
      class function SameText(const A, B: ANSIString): Boolean;

      // Checking for things in a string
      class function BeginsWith(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWithText(const aString: ANSIString; aChar: ANSIChar): Boolean; overload;
      class function BeginsWithText(const aString: ANSIString; aChar: WIDEChar): Boolean; overload;
      class function BeginsWithText(const aString, aSubstring: ANSIString): Boolean; overload;
      class function Contains(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ContainsText(const aString: ANSIString; aChar: ANSIChar): Boolean; overload;
      class function ContainsText(const aString: ANSIString; aChar: WIDEChar): Boolean; overload;
      class function ContainsText(const aString, aSubstring: ANSIString): Boolean; overload;
      class function EndsWith(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWithText(const aString: ANSIString; aChar: ANSIChar): Boolean; overload;
      class function EndsWithText(const aString: ANSIString; aChar: WIDEChar): Boolean; overload;
      class function EndsWithText(const aString, aSubstring: ANSIString): Boolean; overload;

      // Finding things in a string
      class function Find(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString, aSubstring: ANSIString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindText(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString, aSubstring: ANSIString; var aPos: Integer): Boolean; overload;
      class function FindNext(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString, aSubstring: ANSIString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNextText(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString, aSubstring: ANSIString; var aPos: Integer): Boolean; overload;
      class function FindPrevious(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString, aSubstring: ANSIString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPreviousText(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString, aSubstring: ANSIString; var aPos: Integer): Boolean; overload;
      class function FindLast(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString, aSubstring: ANSIString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLastText(const aString: ANSIString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString: ANSIString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString, aSubstring: ANSIString; var aPos: Integer): Boolean; overload;
      class function FindAll(const aString: ANSIString; aChar: ANSIChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString: ANSIString; aChar: WIDEChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString, aSubstring: ANSIString; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAllText(const aString: ANSIString; aChar: ANSIChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString: ANSIString; aChar: WIDEChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString, aSubstring: ANSIString; var aPos: TCharIndexArray): Integer; overload;

      // Adding to a string
      class function Append(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function Append(const aString, aSuffix: ANSIString): ANSIString; overload;
      class function Append(const aString, aSuffix: ANSIString; aSeparator: ANSIChar): ANSIString; overload;
      class function Append(const aString, aSuffix, aSeparator: ANSIString): ANSIString; overload;
      class function Insert(const aString: ANSIString; aPos: Integer; const aChar: ANSIChar): ANSIString; overload;
      class function Insert(const aString: ANSIString; aPos: Integer; const aInfix: ANSIString): ANSIString; overload;
      class function Insert(const aString: ANSIString; aPos: Integer; const aInfix: ANSIString; aSeparator: ANSIChar): ANSIString; overload;
      class function Insert(const aString: ANSIString; aPos: Integer; const aInfix, aSeparator: ANSIString): ANSIString; overload;
      class function Prepend(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function Prepend(const aString, aPrefix: ANSIString): ANSIString; overload;
      class function Prepend(const aString, aPrefix: ANSIString; aSeparator: ANSIChar): ANSIString; overload;
      class function Prepend(const aString, aPrefix, aSeparator: ANSIString): ANSIString; overload;
      class function Embrace(const aString: ANSIString; aBrace: ANSIChar = '('): ANSIString; overload;
      class function Embrace(const aString: ANSIString; aBrace: WIDEChar): ANSIString; overload;
      class function Enquote(const aString: ANSIString; aQuote: ANSIChar = ''''; aEscape: ANSIChar = ''''): ANSIString; overload;
      class function Enquote(const aString: ANSIString; aQuote: WIDEChar): ANSIString; overload;
      class function Enquote(const aString: ANSIString; aQuote, aEscape: WIDEChar): ANSIString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: ANSIChar = ' '): ANSIString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: WIDEChar): ANSIString; overload;
      class function PadLeft(const aString: ANSIString; aLength: Integer; aChar: ANSIChar = ' '): ANSIString; overload;
      class function PadLeft(const aString: ANSIString; aLength: Integer; aChar: WIDEChar): ANSIString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: ANSIChar = ' '): ANSIString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: WIDEChar): ANSIString; overload;
      class function PadRight(const aString: ANSIString; aLength: Integer; aChar: ANSIChar = ' '): ANSIString; overload;
      class function PadRight(const aString: ANSIString; aLength: Integer; aChar: WIDEChar): ANSIString; overload;

      // TODO: This is supposed to be a general purpose String library, so
      //        this particular function really belongs in an XML framework!
      class function Tag(const aString, aTag: ANSIString): ANSIString;

      // Deleting parts of a string (in-place)
      class procedure Delete(var aString: ANSIString; aIndex, aLength: Integer); overload;
      class procedure DeleteRange(var aString: ANSIString; aIndex, aEndIndex: Integer); overload;
      class function Delete(var aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: ANSIString; aChar: ANSIChar): Boolean; overload;
      class function DeleteText(var aString: ANSIString; aChar: WIDEChar): Boolean; overload;
      class function DeleteText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;
      class function DeleteAll(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAllText(var aString: ANSIString; aChar: ANSIChar): Integer; overload;
      class function DeleteAllText(var aString: ANSIString; aChar: WIDEChar): Integer; overload;
      class function DeleteAllText(var aString: ANSIString; const aSubstring: ANSIString): Integer; overload;
      class function DeleteLast(var aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLastText(var aString: ANSIString; aChar: ANSIChar): Boolean; overload;
      class function DeleteLastText(var aString: ANSIString; aChar: WIDEChar): Boolean; overload;
      class function DeleteLastText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;
      class procedure DeleteLeft(var aString: ANSIString; aCount: Integer); overload;
      class function DeleteLeft(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLeftText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;
      class procedure DeleteRight(var aString: ANSIString; aCount: Integer); overload;
      class function DeleteRight(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteRightText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;

      // Removing parts of a string (modified result)
      class function Remove(const aString: ANSIString; aIndex, aLength: Integer): ANSIString; overload;
      class function Remove(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Remove(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Remove(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveText(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function RemoveText(const aString: ANSIString; aChar: WIDEChar): ANSIString; overload;
      class function RemoveText(const aString, aSubstring: ANSIString): ANSIString; overload;
      class function RemoveAll(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveAll(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveAll(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveAllText(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function RemoveAllText(const aString: ANSIString; aChar: WIDEChar): ANSIString; overload;
      class function RemoveAllText(const aString, aSubstring: ANSIString): ANSIString; overload;
      class function RemoveLast(const aString: ANSIString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveLast(const aString: ANSIString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveLast(const aString, aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function RemoveLastText(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function RemoveLastText(const aString: ANSIString; aChar: WIDEChar): ANSIString; overload;
      class function RemoveLastText(const aString, aSubstring: ANSIString): ANSIString; overload;

      // Extracting parts of a string
      class function Extract(var aString: ANSIString; aIndex, aLength: Integer): ANSIString; overload;
      class function Extract(var aString: ANSIString; aIndex, aLength: Integer; var aExtract: ANSIString): Boolean; overload;
      class function ExtractLeft(var aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function ExtractLeft(var aString: ANSIString; aCount: Integer; var aExtract: ANSIString): Boolean; overload;
      class function ExtractLeft(var aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractLeft(var aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractLeft(var aString: ANSIString; const aDelimiter: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractLeft(var aString: ANSIString; aDelimiter: ANSIChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: ANSIString; aDelimiter: WIDEChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: ANSIString; const aDelimiter: ANSIString; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeftText(var aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractLeftText(var aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractLeftText(var aString: ANSIString; const aDelimiter: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractLeftText(var aString: ANSIString; aDelimiter: ANSIChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: ANSIString; aDelimiter: WIDEChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: ANSIString; const aDelimiter: ANSIString; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRight(var aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function ExtractRight(var aString: ANSIString; aCount: Integer; var aExtract: ANSIString): Boolean; overload;
      class function ExtractRightFrom(var aString: ANSIString; aIndex: Integer): ANSIString; overload;
      class function ExtractRightFrom(var aString: ANSIString; aIndex: Integer; var aExtract: ANSIString): Boolean; overload;
      class function ExtractRight(var aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractRight(var aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractRight(var aString: ANSIString; const aDelimiter: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ExtractRight(var aString: ANSIString; aDelimiter: ANSIChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: ANSIString; aDelimiter: WIDEChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: ANSIString; const aDelimiter: ANSIString; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRightText(var aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractRightText(var aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractRightText(var aString: ANSIString; const aDelimiter: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): ANSIString; overload;
      class function ExtractRightText(var aString: ANSIString; aDelimiter: ANSIChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: ANSIString; aDelimiter: WIDEChar; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: ANSIString; const aDelimiter: ANSIString; var aExtract: ANSIString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractQuotedValue(var aString: ANSIString; const aDelimiter: ANSIChar): ANSIString;

      // Consuming a string
      class function ConsumeLeft(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeLeftText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;
      class function ConsumeRight(var aString: ANSIString; const aSubstring: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeRightText(var aString: ANSIString; const aSubstring: ANSIString): Boolean; overload;

      // Copying parts of a string
      class function Copy(const aString: ANSIString; aStartPos, aLength: Integer): ANSIString; overload;
      class function Copy(const aString: ANSIString; aStartPos, aLength: Integer; var aCopy: ANSIString): Boolean; overload;
      class function CopyFrom(const aString: ANSIString; aIndex: Integer): ANSIString; overload;
      class function CopyFrom(const aString: ANSIString; aIndex: Integer; var aCopy: ANSIString): Boolean; overload;
      class function CopyRange(const aString: ANSIString; aStartPos, aEndPos: Integer): ANSIString; overload;
      class function CopyRange(const aString: ANSIString; aStartPos, aEndPos: Integer; var aCopy: ANSIString): Boolean; overload;
      class function CopyLeft(const aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function CopyLeft(const aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyLeft(const aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyLeft(const aString, aDelimiter: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyLeft(const aString: ANSIString; aCount: Integer; var aCopy: ANSIString): Boolean; overload;
      class function CopyLeft(const aString: ANSIString; aDelimiter: ANSIChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString: ANSIString; aDelimiter: WIDEChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString, aDelimiter: ANSIString; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeftText(const aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyLeftText(const aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyLeftText(const aString, aDelimiter: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyLeftText(const aString: ANSIString; aDelimiter: ANSIChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString: ANSIString; aDelimiter: WIDEChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString, aDelimiter: ANSIString; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRight(const aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function CopyRight(const aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyRight(const aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyRight(const aString, aDelimiter: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function CopyRight(const aString: ANSIString; aCount: Integer; var aCopy: ANSIString): Boolean; overload;
      class function CopyRight(const aString: ANSIString; aDelimiter: ANSIChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString: ANSIString; aDelimiter: WIDEChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString, aDelimiter: ANSIString; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRightText(const aString: ANSIString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyRightText(const aString: ANSIString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyRightText(const aString, aDelimiter: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): ANSIString; overload;
      class function CopyRightText(const aString: ANSIString; aDelimiter: ANSIChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString: ANSIString; aDelimiter: WIDEChar; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString, aDelimiter: ANSIString; var aCopy: ANSIString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;

      // Changing pieces of a string
      class function Replace(const aString: ANSIString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString: ANSIString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString, aSubstring, aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function Replace(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceText(const aString: ANSIString; aChar, aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceText(const aString: ANSIString; aChar, aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceText(const aString, aSubstring: ANSIString; aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceText(const aString, aSubstring: ANSIString; aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceText(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: ANSIString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString: ANSIString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar, aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar, aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceAllText(const aString: ANSIString; const aSubstring: ANSIString; aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceLast(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: ANSIString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString: ANSIString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: ANSIString; aCaseMode: TCaseSensitivity = csCaseSensitive): ANSIString; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar, aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar, aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceLastText(const aString, aSubstring: ANSIString; aReplacement: ANSIChar): ANSIString; overload;
      class function ReplaceLastText(const aString, aSubstring: ANSIString; aReplacement: WIDEChar): ANSIString; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: ANSIString): ANSIString; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar, aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar, aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar: ANSIChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString: ANSIString; aChar: WIDEChar; const aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: ANSIString; aReplacement: ANSIChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: ANSIString; aReplacement: WIDEChar; var aResult: ANSIString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: ANSIString; var aResult: ANSIString): Boolean; overload;

      // Removing parts of a string
      class function Trim(const aString: ANSIString): ANSIString; overload;
      class function Trim(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function Trim(const aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function LTrim(const aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function LTrim(const aString: ANSIString): ANSIString; overload;
      class function LTrim(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function RTrim(const aString: ANSIString; aCount: Integer): ANSIString; overload;
      class function RTrim(const aString: ANSIString): ANSIString; overload;
      class function RTrim(const aString: ANSIString; aChar: ANSIChar): ANSIString; overload;
      class function RTrim(const aString: ANSIString; aChar: WIDEChar): ANSIString; overload;

      class function Unbrace(const aString: ANSIString): ANSIString; overload;
      class function Unbrace(const aString: ANSIString; var aResult: ANSIString): Boolean; overload;
      class function Unquote(const aString: ANSIString): ANSIString; overload;
      class function Unquote(const aString: ANSIString; var aResult: ANSIString): Boolean; overload;

      // Case conversions
      class function Lowercase(aChar: ANSIChar): ANSIChar; overload;
      class function Lowercase(const aString: ANSIString): ANSIString; overload;
      class function Startcase(const aString: ANSIString): ANSIString;
      class function Uppercase(aChar: ANSIChar): ANSIChar; overload;
      class function Uppercase(const aString: ANSIString): ANSIString; overload;
    end;



implementation

  uses
  { vcl: }
  {$ifdef DELPHI2009__}
    ANSIStrings,
  {$endif}
  { deltics: }
    Deltics.Contracts,
    Deltics.Exchange,
    Deltics.Math,
    Deltics.Pointers,
    Deltics.ReverseBytes,
    Deltics.Strings,
    Deltics.Strings.UTF8,
    Deltics.Strings.WIDE,
    Deltics.Strings.Utils;





{ ANSIFn ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Parse: ANSIParserClass;
  begin
    result := ANSIParser;
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AddressOfByte(aBase: Pointer;
                                      aByteIndex: Integer): PANSIChar;
  var
    ibase: IntPointer absolute aBase;
  begin
      result := PAnsiChar(ByteOffset(aBase, aByteIndex));
//    if aByteIndex > 0 then
//      result := ibase + Cardinal(aByteIndex))
//    else
//      result := PAnsiChar(ibase - Cardinal(Abs(aByteIndex)));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AddressOfIndex(const aString: ANSIString;
                                             aIndex: Integer): PANSIChar;
  begin
    result := @aString[aIndex];
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastCopy(const aString: ANSIString;
                                        aDest: PANSIChar);
  begin
    CopyMemory(aDest, PANSIChar(aString), Length(aString));
  end;
*)

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastCopy(const aString: ANSIString;
                                        aDest: PANSIChar;
                                        aLen: Integer);
  begin
    CopyMemory(aDest, PANSIChar(aString), aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastCopy(const aString: ANSIString;
                                  var   aDest: ANSIString;
                                        aDestIndex: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PANSIChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastCopy(const aString: ANSIString;
                                  var   aDest: ANSIString;
                                        aDestIndex: Integer;
                                        aLen: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PANSIChar(aString), aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastMove(var aString: ANSIString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aCount: Integer);
  begin
    CopyMemory(AddressOfIndex(aString, aToIndex),
               AddressOfIndex(aString, aFromIndex), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.FastWrite(const aString: ANSIString;
                                   var   aDest: PANSIChar;
                                         aLen: Integer);
  var
    strLen: Integer;
  begin
    if NOT HasLength(aString, strLen) then
      EXIT;

    if aLen > strLen then
      aLen := strLen;

    CopyMemory(aDest, PANSIChar(aString), aLen);
    aDest := AddressOfIndex(aDest, aLen + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CheckCase(const aString: ANSIString;
                                        aCaseFn: TANSITestCharFn): Boolean;
  var
    i: Integer;
    bAlpha: Boolean;
    pc: PANSIChar;
  begin
    result  := FALSE;
    bAlpha  := FALSE;

    pc := PANSIChar(aString);
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
  class procedure ANSIFn.CopyToBuffer(const aString: ANSIString;
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

    FastCopy(aString, AddressOfByte(aBuffer, aOffset), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Coalesce(const aString: ANSIString;
                                 const aDefault: ANSIString): ANSIString;
  begin
    if (aString <> '') then
      result := aString
    else
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.HasLength(const aString: ANSIString; var aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.HasIndex(const aString: ANSIString;
                                       aIndex: Integer): Boolean;
  begin
    result := (aIndex > 0) and (aIndex <= Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.HasIndex(const aString: ANSIString;
                                       aIndex: Integer;
                                   var aChar: ANSIChar): Boolean;
  begin
    aChar   := #0;
    result  := (aIndex > 0) and (aIndex <= Length(aString));
    if result then
      aChar := PANSIChar(aString)[aIndex - 1];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IIf(      aValue: Boolean;
                               const aWhenTrue: ANSIString;
                               const aWhenFalse: ANSIString): ANSIString;
  begin
    if aValue then
      result := aWhenTrue
    else
      result := aWhenFalse;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IndexOf(const aString: ANSIString;
                                      aValues: array of ANSIString;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    for result := 0 to High(aValues) do
      if ANSI.SameString(aString, aValues[result], aCaseMode) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IndexOfText(const aString: ANSIString;
                                          aValues: array of ANSIString): Integer;
  begin
    for result := 0 to High(aValues) do
      if ANSI.SameText(aString, aValues[result]) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Reverse(const aString: ANSIString): ANSIString;
  var
    i, strLen: Integer;
    c: ANSIChar;
    pc, prc: PANSIChar;
  begin
    if NOT HasLength(aString, strLen) then
      EXIT;

    result := aString;
    pc   := PANSIChar(result);
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
  class function ANSIFn.Split(const aString: ANSIString;
                                    aChar: ANSIChar;
                              var   aLeft, aRight: ANSIString): Boolean;
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
  class function ANSIFn.Split(const aString: ANSIString;
                                    aChar: WIDEChar;
                              var   aLeft, aRight: ANSIString): Boolean;
  begin
    result := Split(aString, ANSI(aChar), aLeft, aRight);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Split(const aString: ANSIString;
                              const aDelim: ANSIString;
                              var   aLeft, aRight: ANSIString): Boolean;
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
  class function ANSIFn.Split(const aString: ANSIString;
                                    aChar: ANSIChar;
                              var   aParts: TANSIStringArray): Boolean;
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
  class function ANSIFn.Split(const aString: ANSIString;
                                    aChar: WIDEChar;
                              var   aParts: TANSIStringArray): Boolean;
  begin
    result := Split(aString, ANSI(aChar), aParts);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Split(const aString: ANSIString;
                              const aDelim: ANSIString;
                              var   aParts: TANSIStringArray): Boolean;
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
  class function ANSIFn.Encode(const aString: String): ANSIString;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := aString;
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromANSI(const aBuffer: PAnsiChar;
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
  class function ANSIFn.FromString(const aString: String): ANSIString;
  begin
  {$ifdef UNICODE}
    result := FromWIDE(aString);
  {$else}
    result := aString;
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromUTF8(const aString: UTF8String): ANSIString;
  begin
    // TODO: Can we do this more directly / efficiently ?
    result := ANSI.FromWIDE(WIDE.FromUTF8(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromUTF8(const aBuffer: PUTF8Char;
                                       aMaxLen: Integer): ANSIString;
  begin
    Require('aMaxLen', aMaxLen).IsGreaterThanOrEqual(-1);

    // TODO: Can we do this more directly / efficiently ?
    result := ANSI.FromWIDE(WIDE.FromUTF8(aBuffer, aMaxLen));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromWIDE(const aString: UnicodeString): ANSIString;
  begin
    result := FromWIDE(PWIDEChar(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromWIDE(const aBuffer: PWIDEChar;
                                       aMaxLen: Integer): ANSIString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := WIDEFn.Len(PWideChar(aBuffer));
      if len < aMaxLen then
        aMaxLen := len;
    end
    else
      aMaxLen := -1;

    len := WideCharToMultiByte(CP_ACP, 0, aBuffer, aMaxLen, NIL, 0, NIL, NIL);
    if aMaxLen = -1 then
      Dec(len);

    SetLength(result, len);
    WideCharToMultiByte(CP_ACP, 0, aBuffer, aMaxLen, PANSIChar(result), System.Length(result), NIL, NIL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AllocUTF8(const aSource: ANSIString): PUTF8Char;
  begin
    result := UTF8.Alloc(UTF8.FromANSI(aSource));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.CopyToBuffer(const aString: ANSIString;
                                            aBuffer: Pointer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.CopyToBuffer(const aString: ANSIString;
                                            aBuffer: Pointer;
                                            aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.CopyToBufferOffset(const aString: ANSIString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.CopyToBufferOffset(const aString: ANSIString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer;
                                                  aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromBuffer(aBuffer: PANSIChar; aLen: Integer = -1): ANSIString;
  {
    Copies an ANSI string (null terminated) from a specified buffer.

    The length of the string should be specified if the length is known or is required
     to be less than the known length of the ANSI string in the buffer.

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
    CopyMemory(PANSIChar(result), aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FromBuffer(aBuffer: PWIDEChar; aLen: Integer = -1): ANSIString; 
  begin
    result := FromWIDE(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Len(aBuffer: PANSIChar): Integer;
  begin
  {$ifdef DELPHIXE4__}
    result := ANSIStrings.StrLen(aBuffer);
  {$else}
    result := SysUtils.StrLen(aBuffer);
  {$endif}
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsAlpha(aChar: ANSIChar): Boolean;
  begin
    result := IsCharAlphaA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsAlpha(const aString: ANSIString): Boolean;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.IsAlphaNumeric(aChar: ANSIChar): Boolean;
  begin
    result := IsCharAlphaNumericA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsAlphaNumeric(const aString: ANSIString): Boolean;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.IsEmpty(const aString: ANSIString): Boolean;
  begin
    result := Length(aString) = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsLowercase(const aChar: ANSIChar): Boolean;
  begin
    result := IsCharLowerA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsLowercase(const aString: ANSIString): Boolean;
  begin
    result := CheckCase(aString, IsCharLowerA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsNull(aChar: ANSIChar): Boolean;
  begin
    result := (aChar = #0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsNumeric(aChar: ANSIChar): Boolean;
  begin
    result := IsCharAlphaNumericA(aChar) and NOT IsCharAlphaA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsNumeric(const aString: ANSIString): Boolean;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.IsUppercase(const aChar: ANSIChar): Boolean;
  begin
    result := IsCharUpperA(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsUppercase(const aString: ANSIString): Boolean;
  begin
    result := CheckCase(aString, IsCharUpperA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.NotEmpty(const aString: ANSIString): Boolean;
  begin
    result := (aString <> '');
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Compare(const A, B: ANSIString;
                                      aCaseMode: TCaseSensitivity): TCompareResult;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PANSIChar(A), Length(A),
                             PANSIChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CompareText(const A, B: ANSIString): TCompareResult;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PANSIChar(A), Length(A),
                             PANSIChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.MatchesAny(const aString: ANSIString;
                                         aValues: array of ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := IndexOf(aString, aValues, aCaseMode) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.MatchesAnyText(const aString: ANSIString;
                                             aValues: array of ANSIString): Boolean;
  begin
    result := IndexOf(aString, aValues, csIgnoreCase) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.SameString(const A, B: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PANSIChar(A), Length(A),
                             PANSIChar(B), Length(B)) = CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.SameText(const A, B: ANSIString): Boolean;
  begin
    result := CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PANSIChar(A), Length(A),
                             PANSIChar(B), Length(B)) = CSTR_EQUAL;
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Concat(const aArray: array of ANSIString): ANSIString;
  var
    i: Integer;
    len: Integer;
    pResult: PANSIChar;
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

      pResult := PANSIChar(result);
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
  class function ANSIFn.Concat(const aArray: array of ANSIString;
                              const aSeparator: ANSIString): ANSIString;
  var
    p: PANSIChar;

    procedure DoValue(const aIndex: Integer);
    var
      value: ANSIString;
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

    procedure DoWithChar(const aChar: ANSIChar);
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

      p := PANSIChar(result);

      case sepLen of
        1 : DoWithChar(aSeparator[1]);
      else
        DoWithString(sepLen);
      end;

      DoValue(High(aArray));
    end;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Format(const aString: ANSIString;
                               const aArgs: array of const): ANSIString;
  begin
  {$ifdef DELPHI2009__}
    result := ANSIStrings.Format(aString, aArgs);
  {$else}
    result := SysUtils.Format(aString, aArgs);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Embrace(const aString: ANSIString;
                                      aBrace: ANSIChar): ANSIString;
  var
    dest: PANSIChar absolute result;
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
      '(' : dest[strLen + 1] := ANSIChar(')');
      '{' : dest[strLen + 1] := ANSIChar('}');
      '[' : dest[strLen + 1] := ANSIChar(']');
      '<' : dest[strLen + 1] := ANSIChar('>');
    else
      dest[strLen + 1] := aBrace;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Embrace(const aString: ANSIString;
                                      aBrace: WIDEChar): ANSIString;
  begin
    result := Embrace(aString, ANSI(aBrace));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Enquote(const aString: ANSIString;
                                      aQuote: ANSIChar;
                                      aEscape: ANSIChar): ANSIString;
  var
    dest: PANSIChar absolute result;
    i, j: Integer;
    strLen: Integer;
    pc: PANSIChar;
  begin
    j := 1;

    if HasLength(aString, strLen) then
    begin
      SetLength(result, (strLen * 2) + 2);

      pc  := PANSIChar(aString);
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
  class function ANSIFn.Enquote(const aString: ANSIString;
                                      aQuote: WIDEChar): ANSIString;
  begin
    result := Enquote(aString, ANSI(aQuote), ANSI(aQuote));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Enquote(const aString: ANSIString;
                                      aQuote: WIDEChar;
                                      aEscape: WIDEChar): ANSIString;
  begin
    result := Enquote(aString, ANSI(aQuote), ANSI(aEscape));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: ANSIChar): ANSIString;
  begin
    result := PadLeft(ANSI(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WIDEChar): ANSIString;
  begin
    result := PadLeft(ANSI(aValue), aLength, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadLeft(const aString: ANSIString;
                                   aLength: Integer;
                                   aChar: ANSIChar): ANSIString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PANSIChar;
  begin
    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
    begin
      result := aString;
      EXIT;
    end;

    SetLength(result, aLength);

    p := PANSIChar(result);
    for i := 0 to Pred(pad) do
      p[i] := aChar;

    Inc(p, pad);
    FastCopy(aString, p, len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadLeft(const aString: ANSIString;
                                   aLength: Integer;
                                   aChar: WIDEChar): ANSIString;
  begin
    result := PadLeft(aString, aLength, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: ANSIChar): ANSIString;
  begin
    result := PadRight(ANSI(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WIDEChar): ANSIString;
  begin
    result := PadRight(ANSI(aValue), aLength, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadRight(const aString: ANSIString;
                                   aLength: Integer;
                                   aChar: ANSIChar): ANSIString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PANSIChar;
  begin
    result := aString;

    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
      EXIT;

    SetLength(result, aLength);

    p := PANSIChar(result);
    Inc(p, len);

    for i := 0 to Pred(pad) do
      p[i] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.PadRight(const aString: ANSIString;
                                   aLength: Integer;
                                   aChar: WIDEChar): ANSIString;
  begin
    result := PadRight(aString, aLength, ANSI(aChar));
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.BeginsWith(const aString: ANSIString;
                                         aChar: ANSIChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.BeginsWith(const aString: ANSIString;
                                         aChar: WIDEChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.BeginsWith(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := (subLen <= System.Length(aString))
          and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PANSIChar(aString), subLen,
                              PANSIChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.BeginsWithText(const aString: ANSIString;
                                             aChar: ANSIChar): Boolean;
  begin
    Require('aChar', aChar).IsNotNull;

    result := (aString <> '')
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PANSIChar(aString), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.BeginsWithText(const aString: ANSIString;
                                             aChar: WIDEChar): Boolean;
  begin
    result := BeginsWithText(aString, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.BeginsWithText(const aString: ANSIString;
                                       const aSubstring: ANSIString): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := (subLen <= System.Length(aString))
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PANSIChar(aString), subLen,
                              PANSIChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Contains(const aString: ANSIString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Contains(const aString: ANSIString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, ANSI(aChar), notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Contains(const aString: ANSIString;
                                 const aSubstring: ANSIString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ContainsText(const aString: ANSIString;
                                           aChar: ANSIChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ContainsText(const aString: ANSIString;
                                           aChar: WIDEChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, ANSI(aChar), notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ContainsText(const aString: ANSIString;
                                     const aSubstring: ANSIString): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWith(const aString: ANSIString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PANSIChar absolute aString;
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;
    Require('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    case aCaseMode of

      csCaseSensitive : result := HasLength(aString, strLen)
                              and (chars[strLen - 1] = aChar);

      csIgnoreCase    : result := HasLength(aString, strLen)
                              and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                                  PANSIChar(ByteOffset(Pointer(aString), strLen - 1)), 1,
                                                  @aChar, 1) = CSTR_EQUAL);
    else
      result := FALSE;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWith(const aString: ANSIString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result  := EndsWith(aString, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWith(const aString: ANSIString;
                                 const aSubstring: ANSIString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    strLen := Length(aString);
    result := (subLen <= strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PANSIChar(ByteOffset(Pointer(aString), strLen - subLen)), subLen,
                              PANSIChar(aSubstring), subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWithText(const aString: ANSIString;
                                           aChar: ANSIChar): Boolean;
  var
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;

    result := HasLength(aString, strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PANSIChar(ByteOffset(Pointer(aString), strLen - 1)), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWithText(const aString: ANSIString;
                                           aChar: WIDEChar): Boolean;
  begin
    result := EndsWithText(aString, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.EndsWithText(const aString: ANSIString;
                                     const aSubstring: ANSIString): Boolean;
  var
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    strLen := Length(aString);
    result := (subLen <= strLen)
          and (CompareStringA(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PANSIChar(ByteOffset(Pointer(aString), strLen - subLen)), subLen,
                              PANSIChar(aSubstring), subLen) = CSTR_EQUAL);
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Find(const aString: ANSIString;
                                   aChar: ANSIChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Find(const aString: ANSIString;
                                   aChar: WIDEChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, ANSI(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Find(const aString: ANSIString;
                             const aSubstring: ANSIString;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindText(const aString: ANSIString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindText(const aString: ANSIString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, ANSI(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindText(const aString: ANSIString;
                                 const aSubstring: ANSIString;
                                 var   aPos: Integer): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLast(const aString: ANSIString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLast(const aString: ANSIString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindLast(aString, ANSI(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLast(const aString: ANSIString;
                                 const aSubstring: ANSIString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLastText(const aString: ANSIString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLastText(const aString: ANSIString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, ANSI(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindLastText(const aString: ANSIString;
                                     const aSubstring: ANSIString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindLast(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindNext(const aString: ANSIString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    pos: Integer;
    len: Integer;
    first: PANSIChar;
    curr: PANSIChar;
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
      curr  := PANSIChar(ByteOffset(first, pos));
      Dec(len, pos);

      if (aCaseMode = csCaseSensitive) or (NOT ANSI.IsAlpha(aChar)) then
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
  class function ANSIFn.FindNext(const aString: ANSIString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindNext(aString, ANSI(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindNext(const aString: ANSIString;
                                 const aSubstring: ANSIString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    pos: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PANSIChar;
    curr: PANSIChar;
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

      first := PANSIChar(aString);
      curr  := PANSIChar(ByteOffset(first, pos));
      Dec(strLen, pos + subLen - 1);

      for i := 1 to strLen do
      begin
        result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PANSIChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function ANSIFn.FindNextText(const aString: ANSIString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindNextText(const aString: ANSIString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, ANSI(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindNextText(const aString: ANSIString;
                                     const aSubstring: ANSIString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindPrevious(const aString: ANSIString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    pos: Integer;
    first: PANSIChar;
    curr: PANSIChar;
  begin
    Require('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if (aPos < 1) or NOT HasLength(aString, len) then
        EXIT;

      pos   := Min(aPos, len + 1);
      first := PANSIChar(aString);
      curr  := PANSIChar(ByteOffset(first, pos - 2));
      len   := pos - 1;

      if (aCaseMode = csCaseSensitive) or (NOT ANSI.IsAlpha(aChar)) then
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
  class function ANSIFn.FindPrevious(const aString: ANSIString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindPrevious(aString, ANSI(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindPrevious(const aString: ANSIString;
                                     const aSubstring: ANSIString;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PANSIChar;
    curr: PANSIChar;
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
      first := PANSIChar(aString);
      curr  := PANSIChar(ByteOffset(first, aPos - 1));

      for i := 1 to aPos do
      begin
        result := CompareStringA(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PANSIChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function ANSIFn.FindPreviousText(const aString: ANSIString;
                                               aChar: ANSIChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindPreviousText(const aString: ANSIString;
                                               aChar: WIDEChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, ANSI(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindPreviousText(const aString: ANSIString;
                                         const aSubstring: ANSIString;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindAll(const aString: ANSIString;
                                      aChar: ANSIChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    len: Integer;
    firstChar: PANSIChar;
    currChar: PANSIChar;
  begin
    Require('aChar', aChar).IsNotNull;

    result := 0;
    SetLength(aPos, 0);

    len  := System.Length(aString);

    if (len = 0) then
      EXIT;

    SetLength(aPos, len);
    firstChar := PANSIChar(aString);
    currChar  := firstChar;

    if (aCaseMode = csCaseSensitive) or (NOT ANSI.IsAlpha(aChar)) then
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
  class function ANSIFn.FindAll(const aString: ANSIString;
                                      aChar: WIDEChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := FindAll(aString, ANSI(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindAll(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    currChar: PANSIChar;
    firstChar: PANSIChar;
    pstr: PANSIChar;
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
    pstr      := PANSIChar(aSubstring);
    firstChar := PANSIChar(aString);
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
  class function ANSIFn.FindAllText(const aString: ANSIString;
                                          aChar: ANSIChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindAllText(const aString: ANSIString;
                                          aChar: WIDEChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, ANSI(aChar), aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.FindAllText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.Delete(var aString: ANSIString;
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
  class procedure ANSIFn.DeleteRange(var aString: ANSIString;
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
  class function ANSIFn.Delete(var aString: ANSIString;
                                   aChar: ANSIChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Delete(var aString: ANSIString;
                                   aChar: WIDEChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Delete(aString, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Delete(var   aString: ANSIString;
                               const aSubstring: ANSIString;
                                     aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := Find(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteText(var aString: ANSIString;
                                       aChar: ANSIChar): Boolean;
  begin
    result := Delete(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteText(var aString: ANSIString;
                                       aChar: WIDEChar): Boolean;
  begin
    result := Delete(aString, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteText(var   aString: ANSIString;
                                   const aSubstring: ANSIString): Boolean;
  begin
    result := Delete(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteAll(var   aString: ANSIString;
                                  const aSubstring: ANSIString;
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
  class function ANSIFn.DeleteAll(var aString: ANSIString;
                                      aChar: ANSIChar;
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
  class function ANSIFn.DeleteAll(var aString: ANSIString;
                                      aChar: WIDEChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := DeleteAll(aString, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteAllText(var aString: ANSIString;
                                          aChar: ANSIChar): Integer;
  begin
    result := DeleteAll(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteAllText(var aString: ANSIString;
                                          aChar: WIDEChar): Integer;
  begin
    result := DeleteAll(aString, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteAllText(var   aString: ANSIString;
                                      const aSubstring: ANSIString): Integer;
  begin
    result := DeleteAll(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLast(var aString: ANSIString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLast(var aString: ANSIString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, ANSI(aChar), idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLast(var   aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLastText(var aString: ANSIString;
                                           aChar: ANSIChar): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLastText(var aString: ANSIString;
                                           aChar: WIDEChar): Boolean;
  begin
    result := Delete(aString, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLastText(var   aString: ANSIString;
                                       const aSubstring: ANSIString): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, csIgnoreCase);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.DeleteLeft(var aString: ANSIString;
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
  class function ANSIFn.DeleteLeft(var   aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteLeft(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteLeftText(var   aString: ANSIString;
                                    const aSubstring: ANSIString): Boolean;
  begin
    result := DeleteLeft(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure ANSIFn.DeleteRight(var aString: ANSIString;
                                     aCount: Integer);
  var
    len: Integer;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    if (aCount > 0) and HasLength(aString, len) then
      SetLength(aString, len - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteRight(var   aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteRight(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.DeleteRightText(var   aString: ANSIString;
                                    const aSubstring: ANSIString): Boolean;
  begin
    result := DeleteRight(aString, aSubstring, csIgnoreCase);
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Remove(const aString: ANSIString;
                                     aIndex: Integer;
                                     aLength: Integer): ANSIString;
  begin
    result := aString;
    System.Delete(result, aIndex, aLength);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Remove(const aString: ANSIString;
                                     aChar: ANSIChar;
                                     aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    Delete(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Remove(const aString: ANSIString;
                                     aChar: WIDEChar;
                                     aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    Delete(result, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Remove(const aString, aSubstring: ANSIString;
                                     aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    Delete(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveText(const aString: ANSIString;
                                         aChar: ANSIChar): ANSIString;
  begin
    result := aString;
    Delete(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveText(const aString: ANSIString;
                                         aChar: WIDEChar): ANSIString;
  begin
    result := aString;
    Delete(result, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveText(const aString, aSubstring: ANSIString): ANSIString;
  begin
    result := aString;
    Delete(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAll(const aString, aSubstring: ANSIString;
                                        aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAll(const aString: ANSIString;
                                        aChar: ANSIChar;
                                        aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteAll(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAll(const aString: ANSIString;
                                        aChar: WIDEChar;
                                        aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteAll(result, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAllText(const aString: ANSIString;
                                            aChar: ANSIChar): ANSIString;
  begin
    result := aString;
    DeleteAll(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAllText(const aString: ANSIString;
                                            aChar: WIDEChar): ANSIString;
  begin
    result := aString;
    DeleteAll(result, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveAllText(const aString, aSubstring: ANSIString): ANSIString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLast(const aString: ANSIString;
                                         aChar: ANSIChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteLast(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLast(const aString: ANSIString;
                                         aChar: WIDEChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteLast(result, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLast(const aString, aSubstring: ANSIString;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLastText(const aString: ANSIString;
                                             aChar: ANSIChar): ANSIString;
  begin
    result := aString;
    DeleteLast(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLastText(const aString: ANSIString;
                                             aChar: WIDEChar): ANSIString;
  begin
    result := aString;
    DeleteLast(result, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RemoveLastText(const aString, aSubstring: ANSIString): ANSIString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, csIgnoreCase);
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Extract(var aString: ANSIString;
                                    aIndex: Integer;
                                    aLength: Integer): ANSIString;
  begin
    if NOT Extract(aString, aIndex, aLength, result) then
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Extract(var aString: ANSIString;
                                    aIndex: Integer;
                                    aLength: Integer;
                                var aExtract: ANSIString): Boolean;
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
  class function ANSIFn.ExtractLeft(var aString: ANSIString;
                                     aCount: Integer): ANSIString;
  begin
    ExtractLeft(aString, aCount, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var aString: ANSIString;
                                     aCount: Integer;
                                 var aExtract: ANSIString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aExtract  := System.Copy(aString, 1, aCount);
    result    := NOT IsEmpty(aExtract);

    if result then
      System.Delete(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var  aString: ANSIString;
                                      aDelimiter: ANSIChar;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var  aString: ANSIString;
                                      aDelimiter: WIDEChar;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var   aString: ANSIString;
                                 const aDelimiter: ANSIString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var  aString: ANSIString;
                                      aDelimiter: ANSIChar;
                                 var  aExtract: ANSIString;
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
  class function ANSIFn.ExtractLeft(var  aString: ANSIString;
                                      aDelimiter: WIDEChar;
                                 var  aExtract: ANSIString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractLeft(aString, ANSI(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeft(var   aString: ANSIString;
                                 const aDelimiter: ANSIString;
                                 var   aExtract: ANSIString;
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
  class function ANSIFn.ExtractLeftText(var  aString: ANSIString;
                                          aDelimiter: ANSIChar;
                                          aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeftText(var  aString: ANSIString;
                                          aDelimiter: WIDEChar;
                                          aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeftText(var   aString: ANSIString;
                                     const aDelimiter: ANSIString;
                                           aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeftText(var  aString: ANSIString;
                                          aDelimiter: ANSIChar;
                                     var  aExtract: ANSIString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeftText(var  aString: ANSIString;
                                          aDelimiter: WIDEChar;
                                     var  aExtract: ANSIString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, ANSI(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractLeftText(var   aString: ANSIString;
                                     const aDelimiter: ANSIString;
                                     var   aExtract: ANSIString;
                                           aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var aString: ANSIString; aCount: Integer): ANSIString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    SetLength(aString, Length(aString) - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var aString: ANSIString;
                                     aCount: Integer;
                                 var aExtract: ANSIString): Boolean;
  begin
    aExtract := ExtractRight(aString, aCount);
    result   := (aExtract <> '');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightFrom(var aString: ANSIString;
                                         aIndex: Integer): ANSIString;
  begin
    ExtractRightFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightFrom(var aString: ANSIString;
                                         aIndex: Integer;
                                     var aExtract: ANSIString): Boolean;
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
  class function ANSIFn.ExtractRight(var aString: ANSIString;
                                     aDelimiter: ANSIChar;
                                     aDelimiterOption: TExtractDelimiterOption;
                                     aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var aString: ANSIString;
                                     aDelimiter: WIDEChar;
                                     aDelimiterOption: TExtractDelimiterOption;
                                     aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractRight(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var   aString: ANSIString;
                                 const aDelimiter: ANSIString;
                                       aDelimiterOption: TExtractDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var  aString: ANSIString;
                                      aDelimiter: ANSIChar;
                                 var  aExtract: ANSIString;
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
  class function ANSIFn.ExtractRight(var  aString: ANSIString;
                                      aDelimiter: WIDEChar;
                                 var  aExtract: ANSIString;
                                      aDelimiterOption: TExtractDelimiterOption;
                                      aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractRight(aString, ANSI(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRight(var   aString: ANSIString;
                                 const aDelimiter: ANSIString;
                                 var   aExtract: ANSIString;
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
  class function ANSIFn.ExtractRightText(var  aString: ANSIString;
                                          aDelimiter: ANSIChar;
                                          aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightText(var  aString: ANSIString;
                                          aDelimiter: WIDEChar;
                                          aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractRight(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightText(var   aString: ANSIString;
                                     const aDelimiter: ANSIString;
                                           aDelimiterOption: TExtractDelimiterOption): ANSIString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightText(var  aString: ANSIString;
                                          aDelimiter: ANSIChar;
                                     var  aExtract: ANSIString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightText(var  aString: ANSIString;
                                          aDelimiter: WIDEChar;
                                     var  aExtract: ANSIString;
                                          aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, ANSI(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractRightText(var   aString: ANSIString;
                                     const aDelimiter: ANSIString;
                                     var   aExtract: ANSIString;
                                           aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ExtractQuotedValue(var   aString: ANSIString;
                                           const aDelimiter: ANSIChar): ANSIString;
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
  class function ANSIFn.ConsumeLeft(var   aString: ANSIString;
                                    const aSubstring: ANSIString;
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
  class function ANSIFn.ConsumeLeftText(var   aString: ANSIString;
                                        const aSubstring: ANSIString): Boolean;
  var
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := BeginsWith(aString, aSubstring, csIgnoreCase);
    if result then
      System.Delete(aString, 1, subLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ConsumeRight(var   aString: ANSIString;
                                     const aSubstring: ANSIString;
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
  class function ANSIFn.ConsumeRightText(var   aString: ANSIString;
                                         const aSubstring: ANSIString): Boolean;
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
  class function ANSIFn.Copy(const aString: ANSIString;
                                   aStartPos, aLength: Integer): ANSIString;
  begin
    Copy(aString, aStartPos, aLength, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Copy(const aString: ANSIString;
                                   aStartPos, aLength: Integer;
                             var   aCopy: ANSIString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aStartPos, aLength);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyFrom(const aString: ANSIString;
                                       aIndex: Integer): ANSIString;
  begin
    CopyFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyFrom(const aString: ANSIString;
                                       aIndex: Integer;
                                 var   aCopy: ANSIString): Boolean;
  begin
    Require('aIndex', aIndex).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aIndex, Length(aString) - aIndex + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRange(const aString: ANSIString;
                                        aStartPos: Integer;
                                        aEndPos: Integer): ANSIString;
  begin
    CopyRange(aString, aStartPos, aEndPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRange(const aString: ANSIString;
                                        aStartPos: Integer;
                                        aEndPos: Integer;
                                  var   aCopy: ANSIString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsNotLessThan(1);

    aCopy   := System.Copy(aString, aStartPos, aEndPos - aStartPos + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aCount: Integer): ANSIString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aDelimiter: ANSIChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aDelimiter: WIDEChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                              const aDelimiter: ANSIString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aCount: Integer;
                              var   aCopy: ANSIString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aDelimiter: ANSIChar;
                              var   aCopy: ANSIString;
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
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                                    aDelimiter: WIDEChar;
                              var   aCopy: ANSIString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyLeft(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeft(const aString: ANSIString;
                              const aDelimiter: ANSIString;
                              var   aCopy: ANSIString;
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
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                        aDelimiter: ANSIChar;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                        aDelimiter: WIDEChar;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                  const aDelimiter: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                        aDelimiter: ANSIChar;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                        aDelimiter: WIDEChar;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyLeftText(const aString: ANSIString;
                                  const aDelimiter: ANSIString;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aCount: Integer): ANSIString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aDelimiter: ANSIChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aDelimiter: WIDEChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyRight(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                              const aDelimiter: ANSIString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): ANSIString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aCount: Integer;
                              var   aCopy: ANSIString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aDelimiter: ANSIChar;
                              var   aCopy: ANSIString;
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
  class function ANSIFn.CopyRight(const aString: ANSIString;
                                    aDelimiter: WIDEChar;
                              var   aCopy: ANSIString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyRight(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRight(const aString: ANSIString;
                              const aDelimiter: ANSIString;
                              var   aCopy: ANSIString;
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
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                        aDelimiter: ANSIChar;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                        aDelimiter: WIDEChar;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyRight(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                  const aDelimiter: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): ANSIString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                        aDelimiter: ANSIChar;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                        aDelimiter: WIDEChar;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.CopyRightText(const aString: ANSIString;
                                  const aDelimiter: ANSIString;
                                  var   aCopy: ANSIString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;



















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: ANSIChar;
                                      aReplacement: ANSIChar;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: WIDEChar;
                                      aReplacement: WIDEChar;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, ANSI(aChar), ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: ANSIChar;
                                const aReplacement: ANSIString;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: WIDEChar;
                                const aReplacement: ANSIString;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aReplacement: ANSIChar;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aReplacement: WIDEChar;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aSubstring, ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                const aReplacement: ANSIString;
                                      aCaseMode: TCaseSensitivity): ANSIString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: ANSIChar;
                                      aReplacement: ANSIChar;
                                var   aResult: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;
    result := (aChar <> aReplacement) and Find(aString, aChar, p, aCaseMode);
    if result then
      PANSIChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: WIDEChar;
                                      aReplacement: WIDEChar;
                                var   aResult: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), ANSI(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: ANSIChar;
                                const aReplacement: ANSIString;
                                var   aResult: ANSIString;
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
        else if (aChar <> PANSIChar(aReplacement)[0]) then
          PANSIChar(aResult)[p - 1] := PANSIChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := Remove(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                      aChar: WIDEChar;
                                const aReplacement: ANSIString;
                                var   aResult: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aReplacement: ANSIChar;
                                var   aResult: ANSIString;
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
        result := (aReplacement <> PANSIChar(aSubString)[0]);

      if result then
        PANSIChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                      aReplacement: WIDEChar;
                                var   aResult: ANSIString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, aSubstring, ANSI(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Replace(const aString: ANSIString;
                                const aSubstring: ANSIString;
                                const aReplacement: ANSIString;
                                var   aResult: ANSIString;
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
          PANSIChar(aResult)[p - 1] := PANSIChar(aReplacement)[0]
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
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar): ANSIString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar): ANSIString;
  begin
    result := Replace(aString, ANSI(aChar), ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: ANSIChar;
                                    const aReplacement: ANSIString): ANSIString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: WIDEChar;
                                    const aReplacement: ANSIString): ANSIString;
  begin
    result := Replace(aString, ANSI(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: ANSIChar): ANSIString;
  begin
    result := Replace(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: WIDEChar): ANSIString;
  begin
    result := Replace(aString, aSubstring, ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                    const aReplacement: ANSIString): ANSIString;
  begin
    result := Replace(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                    var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                    var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: ANSIChar;
                                    const aReplacement: ANSIString;
                              var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                          aChar: WIDEChar;
                                    const aReplacement: ANSIString;
                              var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: ANSIChar;
                                    var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, aSubString, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: WIDEChar;
                                    var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, aSubstring, ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceText(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                    const aReplacement: ANSIString;
                              var   aResult: ANSIString): Boolean;
  begin
    result := Replace(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;




//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: ANSIChar;
                                         aReplacement: ANSIChar;
                                   var   aResult: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    p: TCharIndexArray;
  begin
    aResult := aString;

    result := (aChar <> aReplacement) and (FindAll(aString, aChar, p, aCaseMode) > 0);
    if result then
      for i := Low(p) to High(p) do
        PANSIChar(aResult)[p[i] - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: WIDEChar;
                                         aReplacement: WIDEChar;
                                   var   aResult: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, ANSI(aChar), ANSI(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: ANSIChar;
                                   const aReplacement: ANSIString;
                                   var   aResult: ANSIString;
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
        PANSIChar(aResult)[pa[i] - 1] := PANSIChar(aReplacement)[0];
    end
    else
      aResult := RemoveAll(aString, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: WIDEChar;
                                   const aReplacement: ANSIString;
                                   var   aResult: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, ANSI(aChar), aReplacement, aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aReplacement: ANSIChar;
                                   var   aResult: ANSIString;
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
        PANSIChar(aResult)[p - 1] := aReplacement;
      end;

      SetLength(aResult, strLen + (occurs * nudge));
    end
    else for i := 0 to Pred(occurs) do
      PANSIChar(aResult)[pa[i] - 1] := PANSIChar(aReplacement)[0];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aReplacement: WIDEChar;
                                   var   aResult: ANSIString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, ANSI(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                   const aReplacement: ANSIString;
                                   var   aResult: ANSIString;
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
          PANSIChar(aResult)[p - 1] := PANSIChar(aReplacement)[0];
        end;

        if nudge < 0 then
          SetLength(aResult, strLen + (occurs * nudge));
      end
      else if (replaceLen = 1) then
      begin
        for i := 0 to Pred(occurs) do
          PANSIChar(aResult)[pa[i] - 1] := PANSIChar(aReplacement)[0];
      end
      else for i := 0 to Pred(occurs) do
        FastCopy(aReplacement, aResult, pa[i], replaceLen);
    end
    else
      aResult := RemoveAll(aString, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: ANSIChar;
                                         aReplacement: ANSIChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: WIDEChar;
                                         aReplacement: WIDEChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, ANSI(aChar), ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: ANSIChar;
                                   const aReplacement: ANSIString;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                         aChar: WIDEChar;
                                   const aReplacement: ANSIString;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, ANSI(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aReplacement: ANSIChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                         aReplacement: WIDEChar;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAll(const aString: ANSIString;
                                   const aSubstring: ANSIString;
                                   const aReplacement: ANSIString;
                                         aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: ANSIChar;
                                             aReplacement: ANSIChar;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: WIDEChar;
                                             aReplacement: WIDEChar;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, ANSI(aChar), ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: ANSIChar;
                                       const aReplacement: ANSIString;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: WIDEChar;
                                       const aReplacement: ANSIString;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, ANSI(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                             aReplacement: ANSIChar;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                             aReplacement: WIDEChar;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                       const aReplacement: ANSIString;
                                       var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: ANSIChar;
                                             aReplacement: ANSIChar): ANSIString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: WIDEChar;
                                             aReplacement: WIDEChar): ANSIString;
  begin
    ReplaceAll(aString, ANSI(aChar), ANSI(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: ANSIChar;
                                       const aReplacement: ANSIString): ANSIString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                             aChar: WIDEChar;
                                       const aReplacement: ANSIString): ANSIString;
  begin
    ReplaceAll(aString, ANSI(aChar), aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                             aReplacement: ANSIChar): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                             aReplacement: WIDEChar): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, ANSI(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceAllText(const aString: ANSIString;
                                       const aSubstring: ANSIString;
                                       const aReplacement: ANSIString): ANSIString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;



//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                    var   aResult: ANSIString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := (aChar <> aReplacement) and FindLast(aString, aChar, p, aCaseMode);
    if result then
      PANSIChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                    var   aResult: ANSIString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, ANSI(aChar), ANSI(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: ANSIChar;
                                    const aReplacement: ANSIString;
                                    var   aResult: ANSIString;
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
        else if (aChar <> PANSIChar(aReplacement)[0]) then
          PANSIChar(aResult)[p - 1] := PANSIChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: WIDEChar;
                                    const aReplacement: ANSIString;
                                    var   aResult: ANSIString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, ANSI(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: ANSIChar;
                                    var   aResult: ANSIString;
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
        result := (aReplacement <> PANSIChar(aSubString)[0]);

      if result then
        PANSIChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: WIDEChar;
                                    var   aResult: ANSIString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, ANSI(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                    const aReplacement: ANSIString;
                                    var   aResult: ANSIString;
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
          PANSIChar(aResult)[p - 1] := PANSIChar(aReplacement)[0]
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
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, ANSI(aChar), ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: ANSIChar;
                                    const aReplacement: ANSIString;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                          aChar: WIDEChar;
                                    const aReplacement: ANSIString;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: ANSIChar;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                          aReplacement: WIDEChar;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aSubstring, ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLast(const aString: ANSIString;
                                    const aSubstring: ANSIString;
                                    const aReplacement: ANSIString;
                                          aCaseMode: TCaseSensitivity): ANSIString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: ANSIChar;
                                              aReplacement: ANSIChar): ANSIString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: WIDEChar;
                                              aReplacement: WIDEChar): ANSIString;
  begin
    result := ReplaceLast(aString, ANSI(aChar), ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: ANSIChar;
                                        const aReplacement: ANSIString): ANSIString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: WIDEChar;
                                        const aReplacement: ANSIString): ANSIString;
  begin
    result := ReplaceLast(aString, ANSI(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                              aReplacement: ANSIChar): ANSIString;
  begin
    result := ReplaceLast(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                              aReplacement: WIDEChar): ANSIString;
  begin
    result := ReplaceLast(aString, aSubstring, ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                        const aReplacement: ANSIString): ANSIString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: ANSIChar;
                                              aReplacement: ANSIChar;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: WIDEChar;
                                              aReplacement: WIDEChar;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, ANSI(aChar), ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: ANSIChar;
                                        const aReplacement: ANSIString;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                              aChar: WIDEChar;
                                        const aReplacement: ANSIString;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, ANSI(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                              aReplacement: ANSIChar;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, aSubString, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                              aReplacement: WIDEChar;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.ReplaceLastText(const aString: ANSIString;
                                        const aSubstring: ANSIString;
                                        const aReplacement: ANSIString;
                                        var   aResult: ANSIString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;



















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.StringOf(aChar: ANSIChar; aCount: Integer): ANSIString;
  var
    i: Integer;
  begin
    SetLength(result, aCount);

    for i := Pred(aCount) downto 0 do
      result[i + 1] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.StringOf(aChar: WIDEChar;
                                 aCount: Integer): ANSIString;
  begin
    result := StringOf(ANSI(aChar), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.StringOf(const aString: ANSIString; aCount: Integer): ANSIString;
  var
    i: Integer;
    strLen: Integer;
    pr: PANSIChar;
  begin
    if HasLength(aString, strLen) and (aCount > 0) then
    begin
      SetLength(result, strLen * aCount);

      pr := PANSIChar(result);

      for i := 1 to aCount do
        FastWrite(aString, pr, strLen);
    end
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AsBoolean(const aString: ANSIString): Boolean;
  begin
    result := Parse.AsBoolean(PANSIChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AsBoolean(const aString: ANSIString;
                                        aDefault: Boolean): Boolean;
  begin
    result := Parse.AsBoolean(PANSIChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AsInteger(const aString: ANSIString): Integer;
  begin
    result := Parse.AsInteger(PANSIChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.AsInteger(const aString: ANSIString;
                                        aDefault: Integer): Integer;
  begin
    result := Parse.AsInteger(PANSIChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsBoolean(const aString: ANSIString): Boolean;
  begin
    result := Parse.IsBoolean(PANSIChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsBoolean(const aString: ANSIString;
                                  var   aValue: Boolean): Boolean;
  begin
    result := Parse.IsBoolean(PANSIChar(aString), Length(aString), aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsInteger(const aString: ANSIString): Boolean;
  begin
    result := Parse.IsInteger(PANSIChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.IsInteger(const aString: ANSIString;
                                  var   aValue: Integer): Boolean;
  begin
    result := Parse.IsInteger(PANSIChar(aString), Length(aString), aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Append(const aString: ANSIString;
                                    aChar: ANSIChar): ANSIString;
  begin
    result := aString;
    SetLength(result, Length(result) + 1);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Append(const aString, aSuffix: ANSIString): ANSIString;
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
  class function ANSIFn.Append(const aString: ANSIString;
                               const aSuffix: ANSIString;
                                     aSeparator: ANSIChar): ANSIString;
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

        PANSIChar(result)[strLen] := aSeparator;

        FastCopy(aSuffix, result, strLen + 2, sfxLen);
      end;
    end
    else
      result := aSuffix
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   class function ANSIFn.Append(const aString: ANSIString;
                                const aSuffix: ANSIString;
                                const aSeparator: ANSIString): ANSIString;
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
  class function ANSIFn.Insert(const aString: ANSIString;
                                    aPos: Integer;
                              const aChar: ANSIChar): ANSIString;
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
  class function ANSIFn.Insert(const aString: ANSIString;
                                    aPos: Integer;
                              const aInfix: ANSIString): ANSIString;
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
    ANSI.CopyToBuffer(aInfix, ifxlen, Pointer(result), bufPos);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Insert(const aString: ANSIString;
                                    aPos: Integer;
                              const aInfix: ANSIString;
                                    aSeparator: ANSIChar): ANSIString;
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
    ANSI.CopyToBuffer(aInfix, ifxLen, Pointer(result), aPos);

    result[aPos]              := aSeparator;
    result[aPos + ifxLen + 1] := aSeparator;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Insert(const aString: ANSIString;
                                    aPos: Integer;
                              const aInfix: ANSIString;
                              const aSeparator: ANSIString): ANSIString;
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
      ANSI.CopyToBuffer(aInfix, ifxLen, Pointer(result), bufPos + sepLen);

      // Copy the separator into the space either side of the infix
      ANSI.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos);
      ANSI.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos + ifxLen + sepLen);
    end
    else
      result := Insert(aString, aPos, aInfix);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Prepend(const aString: ANSIString;
                                     aChar: ANSIChar): ANSIString;
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
  class function ANSIFn.Prepend(const aString: ANSIString;
                               const aPrefix: ANSIString): ANSIString;
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

        CopyToBuffer(aPrefix, pfxLen, PANSIChar(result), 0);
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Prepend(const aString: ANSIString;
                               const aPrefix: ANSIString;
                                     aSeparator: ANSIChar): ANSIString;
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

        CopyToBuffer(aPrefix, pfxLen, PANSIChar(result), 0);

        result[pfxLen + 1] := aSeparator;
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Prepend(const aString: ANSIString;
                               const aPrefix: ANSIString;
                               const aSeparator: ANSIString): ANSIString;
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

        CopyToBuffer(aPrefix,     pfxLen, PANSIChar(result), 0);
        CopyToBuffer(aSeparator,  sepLen, PANSIChar(result), pfxLen);
      end
      else
        result := Prepend(aString, aPrefix);
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Tag(const aString, aTag: ANSIString): ANSIString;
  var
    tlen: Integer;
    rlen: Integer;
    blen: Integer;
    p: PANSIChar;
    buf: PByte absolute p;
  begin
    tlen := Length(aTag);
    if tlen = 0 then
      EXIT;

    blen := Length(aString);

    rlen := blen + (tlen * 2) + 5;
    SetLength(result, rlen);

    p := PANSIChar(result);
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
  class function ANSIFn.LTrim(const aString: ANSIString): ANSIString;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.LTrim(const aString: ANSIString;
                                    aChar: ANSIChar): ANSIString;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.LTrim(const aString: ANSIString;
                                    aCount: Integer): ANSIString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := aString;
    DeleteLeft(result, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RTrim(const aString: ANSIString): ANSIString;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.RTrim(const aString: ANSIString;
                                        aChar: ANSIChar): ANSIString;
  var
    chars: PANSIChar absolute aString;
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
  class function ANSIFn.RTrim(const aString: ANSIString;
                                        aChar: WIDEChar): ANSIString;
  begin
    result := RTrim(aString, ANSI(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.RTrim(const aString: ANSIString;
                                        aCount: Integer): ANSIString;
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
  class function ANSIFn.Trim(const aString: ANSIString): ANSIString;
  begin
    result := RTrim(LTrim(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Trim(const aString: ANSIString;
                                   aChar: ANSIChar): ANSIString;
  begin
    result := RTrim(LTrim(aString, aChar), aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Trim(const aString: ANSIString;
                                   aCount: Integer): ANSIString;
  begin
    result := aString;
    DeleteLeft(result, aCount);
    DeleteRight(result, aCount);
  end;




  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Unbrace(const aString: ANSIString): ANSIString;
  begin
    Unbrace(aString, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Unbrace(const aString: ANSIString;
                                var   aResult: ANSIString): Boolean;
  const
    MATCH_SET : set of ANSIChar = ['!','@','#','%','&','*','-','_',
                                   '+','=',':','/','?','\','|','~'];
  var
    strLen, rlen: Integer;
    firstChar: ANSIChar;
    lastChar: ANSIChar;
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

    firstChar := PANSIChar(aString)[0];
    lastChar  := PANSIChar(aString)[strLen - 1];

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
  class function ANSIFn.Unquote(const aString: ANSIString): ANSIString;
  begin
    Unquote(aString, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Unquote(const aString: ANSIString;
                                var   aResult: ANSIString): Boolean;
  var
    strLen: Integer;
    qc: ANSIChar;
    prc, psc, last: PANSIChar;
  begin
    result  := FALSE;
    aResult := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    qc := PANSIChar(aString)[0];
    if (PANSIChar(aString)[strLen - 1] <> qc)
     or ((qc <> '''') and (qc <> '"') and (qc <> '`')) then
      EXIT;

    prc   := PANSIChar(aResult);
    psc   := PANSIChar(aString);
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
          raise Exception.CreateFmt('Quoted string ''%s'' contains incorrectly escaped quotes', [STR.FromANSI(aString)]);
      end
      else
        Inc(psc);

      Inc(prc);
    end;

    SetLength(aResult, Integer(prc) - Integer(PANSIChar(aResult)));
    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Startcase(const aString: ANSIString): ANSIString;
  var
    i: Integer;
    len: Integer;
    prev: ANSIChar;
    prevAlpha: Boolean;
    ch: ANSIChar;
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
  class function ANSIFn.Lowercase(aChar: ANSIChar): ANSIChar;
  begin
    result := aChar;
    CharLowerBuffA(@result, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Lowercase(const aString: ANSIString): ANSIString;
  begin
    result := aString;
    if result <> '' then
      CharLowerBuffA(PANSIChar(result), Length(result));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Uppercase(aChar: ANSIChar): ANSIChar;
  begin
    result := aChar;
    CharUpperBuffA(@result, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function ANSIFn.Uppercase(const aString: ANSIString): ANSIString;
  begin
    result := aString;
    if result <> '' then
      CharUpperBuffA(PANSIChar(result), Length(result));
  end;







end.
