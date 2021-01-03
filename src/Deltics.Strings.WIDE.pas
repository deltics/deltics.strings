
{$i deltics.strings.inc}


  unit Deltics.Strings.WIDE;


interface

  uses
    Windows,
    Deltics.Strings.Parsers.WIDE,
    Deltics.Strings.StringList,
    Deltics.Strings.Types;

  type
    WIDEFn = class
    private
      class function AddressOfByte(aBase: Pointer; aByteIndex: Integer): PWIDEChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AddressOfIndex(var aString: UnicodeString; aIndex: Integer): PWIDEChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; aDest: PWIDEChar); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; aDest: PWIDEChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; var aDest: UnicodeString; aDestIndex: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; var aDest: UnicodeString; aDestIndex: Integer; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastMove(var aString: UnicodeString; aFromIndex, aToIndex, aCount: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class function CheckCase(const aString: UnicodeString; aCaseFn: TWIDETestCharFn): Boolean;
      class procedure CopyToBuffer(const aString: UnicodeString; aMaxChars: Integer; aBuffer: Pointer; aByteOffset: Integer); overload;
//      class function Replace(aScope: TStringScope; const aString, aFindStr, aReplaceStr: UnicodeString; aCaseMode: TCaseSensitivity): UnicodeString; overload;
//      class function Replace(aScope: TStringScope; const aString, aFindStr, aReplaceStr: UnicodeString; var aCount: Integer; aCaseMode: TCaseSensitivity): UnicodeString; overload;

    public
      class function Parse: WIDEParserClass; {$ifdef InlineMethods} inline; {$endif}

      // Transcoding
      class function Encode(const aString: String): UnicodeString;
      class function FromANSI(const aString: ANSIString): UnicodeString; overload;
      class function FromANSI(aBuffer: PANSIChar; aMaxLen: Integer = -1): UnicodeString; overload;
      class function FromString(const aString: String): UnicodeString;
      class function FromUTF8(const aString: UTF8String): UnicodeString; overload;
      class function FromUTF8(aBuffer: PUTF8Char; aMaxLen: Integer = -1): UnicodeString; overload;
      class function FromWIDE(aBuffer: PWideChar; aMaxLen: Integer = -1): UnicodeString; overload;

      // Buffer (SZ pointer) routines
      class function AllocUTF8(const aSource: UnicodeString): PUTF8Char;
      class procedure CopyToBuffer(const aString: UnicodeString; aBuffer: Pointer); overload;
      class procedure CopyToBuffer(const aString: UnicodeString; aBuffer: Pointer; aMaxChars: Integer); overload;
      class procedure CopyToBufferOffset(const aString: UnicodeString; aBuffer: Pointer; aByteOffset: Integer); overload;
      class procedure CopyToBufferOffset(const aString: UnicodeString; aBuffer: Pointer; aByteOffset: Integer; aMaxChars: Integer); overload;
      class function FromBuffer(aBuffer: PANSIChar; aLen: Integer = -1): UnicodeString; overload;
      class function FromBuffer(aBuffer: PWIDEChar; aLen: Integer = -1): UnicodeString; overload;
      class function Len(aBuffer: PWIDEChar): Integer;

      // Misc utilities
      class function Coalesce(const aString, aDefault: UnicodeString): UnicodeString; overload;
      class function HasLength(const aString: UnicodeString; var aLength: Integer): Boolean;
      class function HasIndex(const aString: UnicodeString; aIndex: Integer): Boolean; overload;
      class function HasIndex(const aString: UnicodeString; aIndex: Integer; var aChar: WIDEChar): Boolean; overload;
      class function IIf(aValue: Boolean; const aWhenTrue, aWhenFalse: UnicodeString): UnicodeString; overload;
      class function IndexOf(const aString: UnicodeString; aValues: array of UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function IndexOfText(const aString: UnicodeString; aValues: array of UnicodeString): Integer; overload;
      class function Reverse(const aString: UnicodeString): UnicodeString;
      class function Split(const aString: UnicodeString; const aChar: ANSIChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString: UnicodeString; const aChar: WIDEChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString, aDelim: UnicodeString; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString: UnicodeString; const aChar: ANSIChar; var aParts: TWIDEStringArray): Integer; overload;
      class function Split(const aString: UnicodeString; const aChar: WIDEChar; var aParts: TWIDEStringArray): Integer; overload;
      class function Split(const aString, aDelim: UnicodeString; var aParts: TWIDEStringArray): Integer; overload;

      // Assembling a string
      class function Concat(const aArray: array of UnicodeString): UnicodeString; overload;
      class function Concat(const aArray: array of UnicodeString; const aSeparator: UnicodeString): UnicodeString; overload;
      class function Format(const aString: UnicodeString; const aArgs: array of const): UnicodeString;
      class function StringOf(aChar: ANSIChar; aCount: Integer): UnicodeString; overload;
      class function StringOf(aChar: WIDEChar; aCount: Integer): UnicodeString; overload;
      class function StringOf(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;

      // Type conversions
      class function AsBoolean(const aString: UnicodeString): Boolean; overload;
      class function AsBoolean(const aString: UnicodeString; aDefault: Boolean): Boolean; overload;
      class function AsInteger(const aString: UnicodeString): Integer; overload;
      class function AsInteger(const aString: UnicodeString; aDefault: Integer): Integer; overload;
      class function IsBoolean(const aString: UnicodeString): Boolean; overload;
      class function IsBoolean(const aString: UnicodeString; var aValue: Boolean): Boolean; overload;
      class function IsInteger(const aString: UnicodeString): Boolean; overload;
      class function IsInteger(const aString: UnicodeString; var aValue: Integer): Boolean; overload;

      // Testing things about a string
      class function IsAlpha(aChar: WIDEChar): Boolean; overload;
      class function IsAlpha(const aString: UnicodeString): Boolean; overload;
      class function IsAlphaNumeric(aChar: WIDEChar): Boolean; overload;
      class function IsAlphaNumeric(const aString: UnicodeString): Boolean; overload;
      class function IsEmpty(const aString: UnicodeString): Boolean; overload;
      class function IsLowercase(const aChar: WIDEChar): Boolean; overload;
      class function IsLowercase(const aString: UnicodeString): Boolean; overload;
      class function IsNull(aChar: WIDEChar): Boolean;
      class function IsNumeric(aChar: WIDEChar): Boolean; overload;
      class function IsNumeric(const aString: UnicodeString): Boolean; overload;
      class function IsSurrogate(aChar: WIDEChar): Boolean;
      class function IsUppercase(const aChar: WIDEChar): Boolean; overload;
      class function IsUppercase(const aString: UnicodeString): Boolean; overload;
      class function NotEmpty(const aString: UnicodeString): Boolean;

      // Comparing with other strings
      class function Compare(const A, B: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): TCompareResult;
      class function CompareText(const A, B: UnicodeString): TCompareResult;
      class function MatchesAny(const aString: UnicodeString; aValues: array of UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function MatchesAnyText(const aString: UnicodeString; aValues: array of UnicodeString): Boolean; overload;
      class function SameString(const A, B: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean;
      class function SameText(const A, B: UnicodeString): Boolean;

      // Checking for things in a string
      class function BeginsWith(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWithText(const aString: UnicodeString; aChar: ANSIChar): Boolean; overload;
      class function BeginsWithText(const aString: UnicodeString; aChar: WIDEChar): Boolean; overload;
      class function BeginsWithText(const aString, aSubstring: UnicodeString): Boolean; overload;
      class function Contains(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ContainsText(const aString: UnicodeString; aChar: ANSIChar): Boolean; overload;
      class function ContainsText(const aString: UnicodeString; aChar: WIDEChar): Boolean; overload;
      class function ContainsText(const aString, aSubstring: UnicodeString): Boolean; overload;
      class function EndsWith(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWithText(const aString: UnicodeString; aChar: ANSIChar): Boolean; overload;
      class function EndsWithText(const aString: UnicodeString; aChar: WIDEChar): Boolean; overload;
      class function EndsWithText(const aString, aSubstring: UnicodeString): Boolean; overload;

      // Finding things in a string
      class function Find(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindText(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindNext(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNextText(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindPrevious(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPreviousText(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindLast(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLastText(const aString: UnicodeString; aChar: ANSIChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString: UnicodeString; aChar: WIDEChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindAll(const aString: UnicodeString; aChar: ANSIChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString: UnicodeString; aChar: WIDEChar; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString, aSubstring: UnicodeString; var aPos: TCharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAllText(const aString: UnicodeString; aChar: ANSIChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString: UnicodeString; aChar: WIDEChar; var aPos: TCharIndexArray): Integer; overload;
      class function FindAllText(const aString, aSubstring: UnicodeString; var aPos: TCharIndexArray): Integer; overload;

      // Adding to a string
      class function Append(const aString: UnicodeString; aChar: ANSIChar): UnicodeString; overload;
      class function Append(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString; aSeparator: ANSIChar): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString; aSeparator: WIDEChar): UnicodeString; overload;
      class function Append(const aString, aSuffix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; aChar: ANSIChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; aChar: WIDEChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix: UnicodeString): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix: UnicodeString; aSeparator: WIDEChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Prepend(const aString: UnicodeString; aChar: ANSIChar): UnicodeString; overload;
      class function Prepend(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString; aSeparator: ANSIChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString; aSeparator: WIDEChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Embrace(const aString: UnicodeString; aBrace: ANSIChar): UnicodeString; overload;
      class function Embrace(const aString: UnicodeString; aBrace: WIDEChar = '('): UnicodeString; overload;
      class function Enquote(const aString: UnicodeString; aQuote: ANSIChar): UnicodeString; overload;
      class function Enquote(const aString: UnicodeString; aQuote: ANSIChar; aEscape: ANSIChar): UnicodeString; overload;
      class function Enquote(const aString: UnicodeString; aQuote: WIDEChar = ''''; aEscape: WIDEChar = ''''): UnicodeString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: ANSIChar): UnicodeString; overload;
      class function PadLeft(const aValue: Integer; aLength: Integer; aChar: WIDEChar = ' '): UnicodeString; overload;
      class function PadLeft(const aString: UnicodeString; aLength: Integer; aChar: ANSIChar): UnicodeString; overload;
      class function PadLeft(const aString: UnicodeString; aLength: Integer; aChar: WIDEChar = ' '): UnicodeString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: ANSIChar): UnicodeString; overload;
      class function PadRight(const aValue: Integer; aLength: Integer; aChar: WIDEChar = ' '): UnicodeString; overload;
      class function PadRight(const aString: UnicodeString; aLength: Integer; aChar: ANSIChar): UnicodeString; overload;
      class function PadRight(const aString: UnicodeString; aLength: Integer; aChar: WIDEChar = ' '): UnicodeString; overload;

      // TODO: This is supposed to be a general purpose String library, so
      //        this particular function really belongs in an XML framework!
      class function Tag(const aString, aTag: UnicodeString): UnicodeString;

      // Deleting parts of a string (modifying in-place)
      class procedure Delete(var aString: UnicodeString; aIndex: Integer); overload;
      class procedure Delete(var aString: UnicodeString; aIndex, aLength: Integer); overload;
      class procedure DeleteRange(var aString: UnicodeString; aIndex, aEndIndex: Integer); overload;
      class function Delete(var aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class function DeleteAll(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; aChar: ANSIChar): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; aChar: WIDEChar): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; const aSubstring: UnicodeString): Integer; overload;
      class function DeleteLast(var aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; aChar: ANSIChar): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; aChar: WIDEChar): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class procedure DeleteLeft(var aString: UnicodeString; aCount: Integer); overload;
      class function DeleteLeft(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLeftText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class procedure DeleteRight(var aString: UnicodeString; aCount: Integer); overload;
      class function DeleteRight(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteRightText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;

      // Removing parts of a string (modified result)
      class function Remove(const aString: UnicodeString; aIndex, aLength: Integer): UnicodeString; overload;
      class function Remove(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Remove(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Remove(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveText(const aString: UnicodeString; aChar: ANSIChar): UnicodeString; overload;
      class function RemoveText(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function RemoveText(const aString, aSubstring: UnicodeString): UnicodeString; overload;
      class function RemoveAll(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAll(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAll(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAllText(const aString: UnicodeString; aChar: ANSIChar): UnicodeString; overload;
      class function RemoveAllText(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function RemoveAllText(const aString, aSubstring: UnicodeString): UnicodeString; overload;
      class function RemoveLast(const aString: UnicodeString; aChar: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLast(const aString: UnicodeString; aChar: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLast(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLastText(const aString: UnicodeString; aChar: ANSIChar): UnicodeString; overload;
      class function RemoveLastText(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function RemoveLastText(const aString, aSubstring: UnicodeString): UnicodeString; overload;

      // Consuming a string
      class function ConsumeLeft(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeRight(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;

      // Extracting parts of a string
      class function Extract(var aString: UnicodeString; aIndex, aLength: Integer): UnicodeString; overload;
      class function Extract(var aString: UnicodeString; aIndex, aLength: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aCount: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: ANSIChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: WIDEChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: ANSIChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: WIDEChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aCount: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractRightFrom(var aString: UnicodeString; aIndex: Integer): UnicodeString; overload;
      class function ExtractRightFrom(var aString: UnicodeString; aIndex: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: ANSIChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: WIDEChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: ANSIChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: WIDEChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractQuotedValue(var aString: UnicodeString; const aDelimiter: WIDEChar): UnicodeString;

      // Copying parts of a string
      class function Copy(const aString: UnicodeString; aStartPos, aLength: Integer): UnicodeString; overload;
      class function Copy(const aString: UnicodeString; aStartPos, aLength: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyFrom(const aString: UnicodeString; aIndex: Integer): UnicodeString; overload;
      class function CopyFrom(const aString: UnicodeString; aIndex: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyRange(const aString: UnicodeString; aStartPos, aEndPos: Integer): UnicodeString; overload;
      class function CopyRange(const aString: UnicodeString; aStartPos, aEndPos: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aCount: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: ANSIChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: WIDEChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: ANSIChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: WIDEChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aCount: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: ANSIChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: WIDEChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: ANSIChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: WIDEChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: ANSIChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: WIDEChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;

      // Changing pieces of a string
      class function Replace(const aString: UnicodeString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: ANSIChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: WIDEChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: ANSIChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: WIDEChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;

      // Returning strings with parts removed
      class function LTrim(const aString: UnicodeString): UnicodeString; overload;
      class function LTrim(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function LTrim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function Trim(const aString: UnicodeString): UnicodeString; overload;
      class function Trim(const aString: UnicodeString; aChar: WIDEChar): UnicodeString; overload;
      class function Trim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function Unbrace(const aString: UnicodeString): UnicodeString;
      class function Unquote(const aString: UnicodeString): UnicodeString;

      // Case conversions
      class function Camelcase(const aString: UnicodeString; aInitialLower: Boolean = FALSE): UnicodeString;
      class function Lowercase(aChar: WIDEChar): WIDEChar; overload;
      class function Lowercase(const aString: UnicodeString): UnicodeString; overload;
      class function Skewercase(const aString: UnicodeString): UnicodeString;
      class function Snakecase(const aString: UnicodeString): UnicodeString;
      class function Startcase(const aString: UnicodeString): UnicodeString;
      class function Titlecase(const aString: UnicodeString): UnicodeString; overload;
      class function Titlecase(const aString: UnicodeString; const aLower: TWIDEStringArray): UnicodeString; overload;
      class function Titlecase(const aString: UnicodeString; aLower: TWIDEStringList): UnicodeString; overload;
      class function Uppercase(aChar: WIDEChar): WIDEChar; overload;
      class function Uppercase(const aString: UnicodeString): UnicodeString; overload;
    end;


implementation

  uses
    SysUtils,
    Deltics.Contracts,
    Deltics.Exchange,
    Deltics.Math,
    Deltics.Pointers,
    Deltics.ReverseBytes,
    Deltics.Strings,
    Deltics.Strings.Encoding,
    Deltics.Strings.Utils;


  const
    ERRFMT_ORPHAN_DELETIONLEAVES_N = 'Deletion leaves surrogate orphan at index %d';


  const
    MIN_HiSurrogate : WIDEChar = #$D800;
    MAX_HiSurrogate : WIDEChar = #$DBFF;
    MIN_LoSurrogate : WIDEChar = #$DC00;
    MAX_LoSurrogate : WIDEChar = #$DFFF;
    MIN_Surrogate   : WIDEChar = #$DC00;
    MAX_Surrogate   : WIDEChar = #$DFFF;

  var
    LowercaseWordsForTitlecase: TWIDEStringList = NIL;


  function IsHiSurrogate(aChar: WIDEChar): Boolean;
  begin
    result := (aChar >= MIN_HiSurrogate) and (aChar <= MAX_HiSurrogate);
  end;

  function IsLoSurrogate(aChar: WIDEChar): Boolean;
  begin
    result := (aChar >= MIN_LoSurrogate) and (aChar <= MAX_LoSurrogate);
  end;

  function LoSurrogateStrategy(aChar: WIDEChar): TUnicodeSurrogateStrategy; overload;
  begin
    result := UnicodeSurrogateStrategy;
    if (result <> ssIgnore) and NOT IsLoSurrogate(aChar) then
      result := ssIgnore;
  end;

  function LoSurrogateStrategy(const aString: UnicodeString; aIndex: Integer): TUnicodeSurrogateStrategy; overload;
  var
    c: WIDEChar;
  begin
    result := UnicodeSurrogateStrategy;
    if (result <> ssIgnore) and (   NOT WIDE.HasIndex(aString, aIndex, c)
                                 or NOT IsLoSurrogate(c)) then
      result := ssIgnore;
  end;

  function HiSurrogateStrategy(aChar: WIDEChar): TUnicodeSurrogateStrategy; overload;
  begin
    result := UnicodeSurrogateStrategy;
    if (result <> ssIgnore) and NOT IsHiSurrogate(aChar) then
      result := ssIgnore;
  end;

  function HiSurrogateStrategy(const aString: UnicodeString; aIndex: Integer): TUnicodeSurrogateStrategy; overload;
  var
    c: WIDEChar;
  begin
    result := UnicodeSurrogateStrategy;
    if (result <> ssIgnore) and (   NOT WIDE.HasIndex(aString, aIndex, c)
                                 or NOT IsHiSurrogate(c)) then
      result := ssIgnore;
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWIDEString.Contains(const aNeed: TContainNeeds;
                                      aChars: array of WIDEChar;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    notUsed: Integer;
    foundOne: Boolean;
  begin
    foundOne := FALSE;

    for i := Low(aChars) to High(aChars) do
    begin
      result := Find(aChars[i], notUsed, aCaseMode);

      if StringsUtil.HasContainsResult(aNeed, result, foundOne) then
        EXIT;
    end;

    StringsUtil.CheckContainsResult(aNeed, result, foundOne);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWIDEString.Contains(const aNeed: TContainNeeds;
                                      aStrings: array of UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    notUsed: Integer;
    foundOne: Boolean;
  begin
    foundOne := FALSE;

    for i := Low(aStrings) to High(aStrings) do
    begin
      result := Find(aStrings[i], notUsed, aCaseMode);

      if StringsUtil.HasContainsResult(aNeed, result, foundOne) then
        EXIT;
    end;

    StringsUtil.CheckContainsResult(aNeed, result, foundOne);
  end;
*)







{ WIDEFn ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AddressOfByte(aBase: Pointer;
                                      aByteIndex: Integer): PWIDEChar;
  var
    ibase: IntPointer absolute aBase;
  begin
    if aByteIndex > 0 then
      result := PWideChar(ibase + Cardinal(aByteIndex))
    else
      result := PWideChar(ibase - Cardinal(Abs(aByteIndex)));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AddressOfIndex(var aString: UnicodeString;
                                           aIndex: Integer): PWIDEChar;
  begin
    result := @aString[aIndex];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.FastCopy(const aString: UnicodeString;
                                        aDest: PWIDEChar);
  begin
    CopyMemory(aDest, PWIDEChar(aString), Length(aString) * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.FastCopy(const aString: UnicodeString;
                                        aDest: PWIDEChar;
                                        aLen: Integer);
  begin
    CopyMemory(aDest, PWIDEChar(aString), aLen * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.FastCopy(const aString: UnicodeString;
                                  var   aDest: UnicodeString;
                                        aDestIndex: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PWIDEChar(aString), Length(aString) * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.FastCopy(const aString: UnicodeString;
                                  var   aDest: UnicodeString;
                                        aDestIndex: Integer;
                                        aLen: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PWIDEChar(aString), aLen * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.FastMove(var aString: UnicodeString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aCount: Integer);
  begin
    CopyMemory(AddressOfIndex(aString, aToIndex),
               AddressOfIndex(aString, aFromIndex), aCount * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CheckCase(const aString: UnicodeString;
                                        aCaseFn: TWIDETestCharFn): Boolean;
  var
    i: Integer;
    bAlpha: Boolean;
    pc: PWIDEChar;
  begin
    result  := FALSE;
    bAlpha  := FALSE;

    pc := PWIDEChar(aString);
    for i := 0 to Pred(Length(aString)) do
    begin
      if Windows.IsCharAlphaW(pc^) then
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
  class procedure WIDEFn.CopyToBuffer(const aString: UnicodeString;
                                            aMaxChars: Integer;
                                            aBuffer: Pointer;
                                            aByteOffset: Integer);
  var
    len: Integer;
  begin
    Require('aBuffer', aBuffer).IsAssigned;
    Require('aMaxChars', aMaxChars).IsPositiveOrZero;

    if  (aMaxChars = 0)
     or NOT HasLength(aString, len) then
      EXIT;

    if (aMaxChars < len) then
      len := aMaxChars;

    FastCopy(aString, AddressOfByte(aBuffer, aByteOffset), len);
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(      aScope: TStringScope;
                                const aString: UnicodeString;
                                const aFindStr: UnicodeString;
                                const aReplaceStr: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  var
    notUsed: Integer;
  begin
    result := Replace(aScope, aString, aFindStr, aReplaceStr, notUsed, aCaseMode);
  end;

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(      aScope: TStringScope;
                                const aString: UnicodeString;
                                const aFindStr: UnicodeString;
                                const aReplaceStr: UnicodeString;
                                var   aCount: Integer;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  var
    i: Integer;
    pa: TCharIndexArray;
    pr, ps, px: PWIDEChar;
    p, flen, xlen, rlen, clen: Integer;
  begin
    if (aScope = ssFirst) then
    begin
      SetLength(pa, 1);
      if WIDE.Find(aString, aFindStr, p, aCaseMode) then
        pa[0] := p
      else
        SetLength(pa, 0);
    end
    else
      WIDE.FindAll(aString, aFindStr, pa, aCaseMode);

    aCount := Length(pa);

    case aCount of
      0 : begin
            result := aString;
            EXIT;
          end;

      1 : { NO-OP };
    else
      if (aScope = ssLast) then
      begin
        pa[0] := pa[Length(pa) - 1];
        SetLength(pa, 1);
      end;
    end;

    flen := Length(aFindStr);
    xlen := Length(aReplaceStr);
    rlen := Length(aString) + (Length(pa) * ((xlen - flen)));
    SetLength(result, rlen);

    pr := PWIDEChar(result);
    ps := PWIDEChar(aString);
    px := PWIDEChar(aReplaceStr);

    CopyMemory(pr, ps, (pa[0] - 1) * 2);
    Inc(pr, pa[0] - 1);
    Inc(ps, flen);

    if (xlen > 0) then
    begin
      CopyMemory(pr, px, xlen * 2);
      Inc(pr, xlen);
    end;

    Inc(ps, pa[0] - 1);

    for i := 1 to Pred(Length(pa)) do
    begin
      clen := pa[i] - (pa[i - 1] + flen);
      if (clen > 0) then
      begin
        CopyMemory(pr, ps, clen * 2);
        Inc(pr, clen);
      end;

      if (xlen > 0) then
      begin
        CopyMemory(pr, px, xlen * 2);
        Inc(pr, xlen);
      end;

      Inc(ps, clen + flen);
    end;

    if (pr - PWIDEChar(result)) < rlen then
    begin
      clen := Length(aString) - (ps - PWIDEChar(aString));
      CopyMemory(pr, ps, clen * 2);
    end;
  end;
*)






  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Coalesce(const aString, aDefault: UnicodeString): UnicodeString;
  begin
    if (aString <> '') then
      result := aString
    else
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.HasLength(const aString: UnicodeString;
                                  var   aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.HasIndex(const aString: UnicodeString;
                                       aIndex: Integer): Boolean;
  begin
    result := (aIndex > 0) and (aIndex <= Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.HasIndex(const aString: UnicodeString;
                                       aIndex: Integer;
                                   var aChar: WIDEChar): Boolean;
  begin
    aChar  := #0;
    result := (aIndex > 0) and (aIndex <= Length(aString));
    if result then
      aChar := PWIDEChar(aString)[aIndex - 1];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.MatchesAny(const aString: UnicodeString;
                                         aValues: array of UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := IndexOf(aString, aValues, aCaseMode) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.MatchesAnyText(const aString: UnicodeString;
                                             aValues: array of UnicodeString): Boolean;
  begin
    result := IndexOf(aString, aValues, csIgnoreCase) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Iif(      aValue: Boolean;
                            const aWhenTrue: UnicodeString;
                            const aWhenFalse: UnicodeString): UnicodeString;
  begin
    if aValue then
      result := aWhenTrue
    else
      result := aWhenFalse;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IndexOf(const aString: UnicodeString;
                                      aValues: array of UnicodeString;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    for result := 0 to High(aValues) do
      if WIDE.SameString(aString, aValues[result], aCaseMode) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IndexOfText(const aString: UnicodeString;
                                          aValues: array of UnicodeString): Integer;
  begin
    for result := 0 to High(aValues) do
      if WIDE.SameText(aString, aValues[result]) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Reverse(const aString: UnicodeString): UnicodeString;
  var
    i, strLen: Integer;
    c: WIDEChar;
    pc, prc: PWIDEChar;
    loSurrogate: Boolean;
  begin
    if NOT HasLength(aString, strLen) then
      EXIT;

    result := aString;
    pc   := PWIDEChar(result);
    prc  := @result[strLen];
    loSurrogate := FALSE;

    for i := 1 to strLen div 2 do
    begin
      c := pc^;

      if loSurrogate then
      begin
        Inc(prc);
        prc^  := pc^;
        pc^   := c;
        Dec(prc);
        Dec(prc);
        Inc(pc);

        loSurrogate := FALSE;
      end
      else if IsHiSurrogate(c) then
      begin
        Dec(prc);
        prc^  := pc^;
        pc^   := c;

        Inc(pc);
        Dec(prc);

        if i = (strLen div 2) then
        begin
          c := prc^;
          Inc(prc);
          prc^  := pc^;
          pc^   := c;
        end
        else
          loSurrogate := TRUE;
      end
      else
      begin
        pc^  := prc^;
        prc^ := c;

        Inc(pc);
        Dec(prc);
      end;
    end;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Encode(const aString: String): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := aString;
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromString(const aString: String): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := aString;
  {$else}
    result := FromANSI(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromANSI(const aString: ANSIString): UnicodeString;
  begin
    result := FromANSI(PANSIChar(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromANSI(aBuffer: PANSIChar;
                                 aMaxLen: Integer): UnicodeString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) or (aBuffer = NIL)  then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := ANSIFn.Len(PAnsiChar(aBuffer));
      if len < aMaxLen then
        aMaxLen := len;
    end
    else
      aMaxLen := -1;

    len := MultiByteToWideChar(CP_ACP, 0, aBuffer, aMaxLen, NIL, 0);

    // If aMaxLen is -1 then the reported length INCLUDES the null terminator
    //  which is automatically part of result

    if (aMaxLen = -1) then
      Dec(len);

    SetLength(result, len);
    MultiByteToWideChar(CP_ACP, 0, aBuffer, aMaxLen, @result[1], len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromUTF8(aBuffer: PUTF8Char;
                                 aMaxLen: Integer): UnicodeString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) or (aBuffer = NIL) then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := ANSIFn.Len(PAnsiChar(aBuffer));
      if len < aMaxLen then
        aMaxLen := len;
    end
    else
      aMaxLen := -1;

    len := MultiByteToWideChar(CP_UTF8, 0, PANSIChar(aBuffer), aMaxLen, NIL, 0);

    // If aMaxLen is -1 then the reported length INCLUDES the null terminator
    //  which is automatically part of result

    if (aMaxLen = -1) then
      Dec(len);

    SetLength(result, len);
    MultiByteToWideChar(CP_UTF8, 0, PANSIChar(aBuffer), aMaxLen, @result[1], len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromUTF8(const aString: UTF8String): UnicodeString;
  begin
    result := FromUTF8(PUTF8Char(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromWIDE(aBuffer: PWideChar;
                                 aMaxLen: Integer): UnicodeString;
  begin
    if aMaxLen = -1 then
      aMaxLen := Len(aBuffer)
    else
      aMaxLen := Min(aMaxLen, Len(aBuffer));

    SetLength(result, aMaxLen);
    CopyMemory(@result[1], aBuffer, aMaxLen * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AllocUTF8(const aSource: UnicodeString): PUTF8Char;
  var
    len: Integer;
    s: UTF8String;
  begin
    s := UTF8.FromWIDE(aSource);

    len     := Length(s) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PUTF8Char(s), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Len(aBuffer: PWIDEChar): Integer;
  {$ifdef UNICODE}
    begin
      result := SysUtils.StrLen(aBuffer);
    end;
  {$else}
    var
      p: PWIDEChar;
    begin
      p := aBuffer;
      while p^ <> WIDEChar(0) do
        Inc(p);

      result := (p - aBuffer);
    end;
  {$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.CopyToBuffer(const aString: UnicodeString;
                                            aBuffer: Pointer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.CopyToBuffer(const aString: UnicodeString;
                                            aBuffer: Pointer;
                                            aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.CopyToBufferOffset(const aString: UnicodeString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.CopyToBufferOffset(const aString: UnicodeString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer;
                                                  aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, aByteOffset);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromBuffer(aBuffer: PANSIChar;
                                   aLen: Integer): UnicodeString;
  begin
    result := WIDE.FromANSI(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FromBuffer(aBuffer: PWIDEChar;
                                   aLen: Integer): UnicodeString;
  begin
    Require('aLen', aLen).IsNotLessThan(-1);

    if aLen = -1 then
      aLen := Len(aBuffer);

    SetLength(result, 0);
    if aLen = 0 then
      EXIT;

    case aBuffer[0] of
      BOMCHAR_UTF16LE : begin
                          if aLen = 1 then
                            EXIT;

                          SetLength(result, aLen - 1);
                          CopyMemory(@result[1], @aBuffer[1], (aLen - 1) * 2);
                        end;

      BOMCHAR_UTF16BE : begin
                          if aLen = 1 then
                            EXIT;

                          SetLength(result, aLen - 1);
                          CopyMemory(@result[1], @aBuffer[1], (aLen - 1) * 2);
                          ReverseBytes(System.PWord(@result[1]), aLen - 1);
                        end;
    else
      SetLength(result, aLen);
      CopyMemory(@result[1], @aBuffer[0], aLen * 2);
    end;
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Concat(const aArray: array of UnicodeString): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pResult: PWIDEChar;
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

      pResult := PWIDEChar(result);
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
          WIDE.CopyToBuffer(aArray[i], pResult);
          Inc(pResult, len);
        end;
      end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Concat(const aArray: array of UnicodeString;
                              const aSeparator: UnicodeString): UnicodeString;
  var
    p: PWIDEChar;

    procedure DoValue(const aIndex: Integer);
    var
      value: UnicodeString;
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
        WIDE.CopyToBuffer(value, p);
        Inc(p, len);
      end;
    end;

    procedure DoWithChar(const aChar: WIDEChar);
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

        WIDE.CopyToBuffer(aSeparator, p);
        Inc(p, aLength);
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

      p := PWIDEChar(result);

      case sepLen of
        1 : DoWithChar(aSeparator[1]);
      else
        DoWithString(sepLen);
      end;

      DoValue(High(aArray));
    end;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Format(const aString: UnicodeString;
                               const aArgs: array of const): UnicodeString;
  begin
    result := WIDEFormat(aString, aArgs);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.StringOf(aChar: ANSIChar;
                                 aCount: Integer): UnicodeString;
  begin
    result := StringOf(WIDE(aChar), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.StringOf(aChar: WIDEChar;
                                 aCount: Integer): UnicodeString;
  var
    i: Integer;
    pc: PWIDEChar;
  begin
    SetLength(result, aCount);

    pc := PWIDECHar(result);

    for i := 1 to aCount do
    begin
      pc^ := aChar;
      Inc(pc);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.StringOf(const aString: UnicodeString;
                                       aCount: Integer): UnicodeString;
  var
    i: Integer;
    chars: Integer;
    bytes: Integer;
    pr: PWIDEChar;
  begin
    chars := System.Length(aString);
    SetLength(result, chars * aCount);

    bytes := chars * 2;
    pr    := PWIDEChar(result);

    for i := 1 to aCount do
    begin
      CopyMemory(pr, PWIDEChar(aString), bytes);
      Inc(pr, chars);
    end;
  end;













  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWith(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PWIDEChar absolute aString;
  begin
    Require('aChar', aChar).IsNotNull;
    Require('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    case aCaseMode of

      csCaseSensitive : result := (aString <> '')
                              and (chars[0] = aChar);

      csIgnoreCase    : result := (aString <> '')
                              and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                                                  chars, 1,
                                                  @aChar, 1) = CSTR_EQUAL);
    else
      result := FALSE; // To avoid warning
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWith(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, WIDE(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWith(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    len: Integer;
  begin
    Require('aSubString', aSubString).IsNotEmpty;

    len := System.Length(aSubstring);

    result := (len <= System.Length(aString))
          and (CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PWIDEChar(aString), len,
                              PWIDEChar(aSubstring), len) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWithText(const aString: UnicodeString;
                                             aChar: WIDEChar): Boolean;
  begin
    Require('aChar', aChar).IsNotNull;

    result := (aString <> '')
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWIDEChar(aString), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWithText(const aString: UnicodeString;
                                             aChar: ANSIChar): Boolean;
  begin
    result := BeginsWithText(aString, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.BeginsWithText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  var
    len: Integer;
  begin
    Require('aSubString', aSubString).IsNotEmpty;

    len := System.Length(aSubstring);

    result := (len <= System.Length(aString))
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWIDEChar(aString), len,
                              PWIDEChar(aSubstring), len) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Contains(const aString: UnicodeString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Contains(const aString: UnicodeString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Contains(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ContainsText(const aString: UnicodeString;
                                           aChar: ANSIChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ContainsText(const aString: UnicodeString;
                                           aChar: WIDEChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ContainsText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWith(const aString: UnicodeString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, WIDE(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWith(const aString: UnicodeString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PWIDEChar absolute aString;
    len: Integer;
  begin
    Require('aChar', aChar).IsNotNull;
    Require('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    result := FALSE;
    if NOT HasLength(aString, len) then
      EXIT;

    case aCaseMode of

      csCaseSensitive : result := (chars[len - 1] = aChar);

      csIgnoreCase    : result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                                PWIDEChar(@chars[len - 1]), 1,
                                                @aChar, 1) = CSTR_EQUAL;
    else
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWith(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    str: PWIDEChar absolute aString;
    subStr: PWIDEChar absolute aSubstring;
    len: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := FALSE;
    if NOT HasLength(aString, len) then
      EXIT;

    result := (subLen <= len)
          and (CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PWIDEChar(@str[len - subLen]), subLen,
                              subStr, subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWithText(const aString: UnicodeString;
                                           aChar: ANSIChar): Boolean;
  begin
    result := EndsWith(aString, WIDE(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWithText(const aString: UnicodeString;
                                           aChar: WIDEChar): Boolean;
  begin
    result := EndsWith(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.EndsWithText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString): Boolean;
  var
    str: PWIDEChar absolute aString;
    subStr: PWIDEChar absolute aSubstring;
    len: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := FALSE;
    if NOT HasLength(aString, len) then
      EXIT;

    result := (subLen <= len)
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWIDEChar(@str[len - subLen]), subLen,
                              subStr, subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Find(const aString: UnicodeString;
                                   aChar: ANSIChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Find(const aString: UnicodeString;
                                   aChar: WIDEChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Find(const aString: UnicodeString;
                             const aSubstring: UnicodeString;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindText(const aString: UnicodeString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindText(const aString: UnicodeString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindText(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLast(const aString: UnicodeString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLast(const aString: UnicodeString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLast(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLastText(const aString: UnicodeString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLastText(const aString: UnicodeString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindLastText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindNext(const aString: UnicodeString;
                                       aChar: ANSIChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindNext(aString, WIDE(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindNext(const aString: UnicodeString;
                                       aChar: WIDEChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    first: PWIDEChar;
    curr: PWIDEChar;
  begin
    Require('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if aPos < 0 then
        aPos := 0;

      if  (NOT HasLength(aString, len))
       or (aPos >= len) then
        EXIT;

      first := Pointer(aString);
      curr  := PWIDEChar(Memory.ByteOffset(first, aPos * 2));
      Dec(len, aPos - 1);

      if (aCaseMode = csCaseSensitive) or (NOT WIDE.IsAlpha(aChar)) then
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
          result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
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
  class function WIDEFn.FindNext(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PWIDEChar;
    curr: PWIDEChar;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if aPos < 0 then
        aPos := 0;

      if  (NOT HasLength(aString, strLen))
       or (aPos + subLen > strLen) then
        EXIT;

      first := PWIDEChar(aString);
      curr  := PWIDEChar(Memory.ByteOffset(first, aPos * 2));
      Dec(strLen, aPos + subLen - 1);

      for i := 1 to strLen do
      begin
        result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PWIDEChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function WIDEFn.FindNextText(const aString: UnicodeString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindNextText(const aString: UnicodeString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindNextText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindPrevious(const aString: UnicodeString;
                                           aChar: ANSIChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindPrevious(aString, WIDE(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindPrevious(const aString: UnicodeString;
                                           aChar: WIDEChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    pos: Integer;
    first: PWIDEChar;
    curr: PWIDEChar;
  begin
    Require('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if (aPos < 1) or NOT HasLength(aString, len) then
        EXIT;

      pos   := Min(aPos, len + 1);
      first := PWIDEChar(aString);
      curr  := PWIDEChar(Memory.ByteOffset(first, 2 * (aPos - 2)));
      len   := pos - 1;

      if (aCaseMode = csCaseSensitive) or (NOT WIDE.IsAlpha(aChar)) then
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
          result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
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
  class function WIDEFn.FindPrevious(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PWIDEChar;
    curr: PWIDEChar;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if  (aPos < 1)
       or (NOT HasLength(aString, strLen)) then
        EXIT;

      aPos  := Min(aPos - 1, strLen - subLen + 1);
      first := PWIDEChar(aString);
      curr  := PWIDEChar(Memory.ByteOffset(first, 2 * (aPos - 1)));

      for i := 1 to aPos do
      begin
        result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PWIDEChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function WIDEFn.FindPreviousText(const aString: UnicodeString;
                                               aChar: ANSIChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindPreviousText(const aString: UnicodeString;
                                               aChar: WIDEChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindPreviousText(const aString: UnicodeString;
                                         const aSubstring: UnicodeString;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindAll(const aString: UnicodeString;
                                      aChar: ANSIChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := FindAll(aString, WIDE(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindAll(const aString: UnicodeString;
                                      aChar: WIDEChar;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    len: Integer;
    firstChar: PWIDEChar;
    currChar: PWIDEChar;
  begin
    Require('aChar', aChar).IsNotNull;

    result := 0;
    SetLength(aPos, 0);

    if NOT HasLength(aString, len) then
      EXIT;

    SetLength(aPos, len);
    firstChar := PWIDEChar(aString);
    currChar  := firstChar;

    if (aCaseMode = csCaseSensitive) or (NOT WIDE.IsAlpha(aChar)) then
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
        if CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
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
  class function WIDEFn.FindAll(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                var   aPos: TCharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    currChar: PWIDEChar;
    firstChar: PWIDEChar;
    pstr: PWIDEChar;
    strLen: Integer;
    subLen: Integer;
  begin
    Require('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := 0;
    SetLength(aPos, 0);

    strLen  := System.Length(aString);
    if (strLen = 0) or (subLen > strLen)then
      EXIT;

    SetLength(aPos, strLen);
    pstr      := PWIDEChar(aSubstring);
    firstChar := PWIDEChar(aString);
    currChar  := firstChar;

    for i := (strLen - subLen) downto 0 do
    begin
      if (Windows.CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
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
  class function WIDEFn.FindAllText(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindAllText(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.FindAllText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    var   aPos: TCharIndexArray): Integer;
  begin
    result := FindAll(aString, aSubstring, aPos, csIgnoreCase);
  end;















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AsBoolean(const aString: UnicodeString): Boolean;
  begin
    result := Parse.AsBoolean(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AsBoolean(const aString: UnicodeString;
                                        aDefault: Boolean): Boolean;
  begin
    result := Parse.AsBoolean(PWIDEChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AsInteger(const aString: UnicodeString): Integer;
  begin
    result := Parse.AsInteger(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.AsInteger(const aString: UnicodeString;
                                        aDefault: Integer): Integer;
  begin
    result := Parse.AsInteger(PWIDEChar(aString), Length(aString), aDefault);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsBoolean(const aString: UnicodeString): Boolean;
  begin
    result := Parse.IsBoolean(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsBoolean(const aString: UnicodeString;
                                  var   aValue: Boolean): Boolean;
  begin
    result := Parse.IsBoolean(PWIDEChar(aString), Length(aString), aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsInteger(const aString: UnicodeString): Boolean;
  begin
    result := Parse.IsInteger(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsInteger(const aString: UnicodeString;
                                  var   aValue: Integer): Boolean;
  begin
    result := Parse.IsInteger(PWIDEChar(aString), Length(aString), aValue);
  end;


















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsAlpha(aChar: WIDEChar): Boolean;
  begin
    result := IsCharAlphaW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsAlpha(const aString: UnicodeString): Boolean;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaW(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsAlphaNumeric(aChar: WIDEChar): Boolean;
  begin
    result := IsCharAlphaNumericW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsAlphaNumeric(const aString: UnicodeString): Boolean;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaNumericW(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsEmpty(const aString: UnicodeString): Boolean;
  begin
    result := Length(aString) = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsLowercase(const aChar: WIDEChar): Boolean;
  begin
    result := IsCharLowerW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsLowercase(const aString: UnicodeString): Boolean;
  begin
    result := CheckCase(aString, IsCharLowerW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsNull(aChar: WIDEChar): Boolean;
  begin
    result := aChar = WIDEChar(#0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsNumeric(aChar: WIDEChar): Boolean;
  begin
    result := IsCharAlphaNumericW(aChar) and NOT IsCharAlphaW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsNumeric(const aString: UnicodeString): Boolean;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    len: Integer;
    hasDP: Boolean;
  begin
    result := FALSE;

    if NOT HasLength(aString, len) then
      EXIT;

    hasDP := FALSE;
    for i := 0 to Pred(len) do
    begin
      if (chars[i] = '.') then
      begin
        if hasDP then
          EXIT;

        hasDP := TRUE;
      end;

      if NOT (IsCharAlphaNumericW(chars[i]) and NOT IsCharAlphaW(chars[i])) then
        EXIT;
    end;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsSurrogate(aChar: WIDEChar): Boolean;
  begin
    result := IsHiSurrogate(aChar) or IsLoSurrogate(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsUppercase(const aChar: WIDEChar): Boolean;
  begin
    result := IsCharUpperW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.IsUppercase(const aString: UnicodeString): Boolean;
  begin
    result := CheckCase(aString, IsCharUpperW);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.NotEmpty(const aString: UnicodeString): Boolean;
  begin
    result := (aString <> '');
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Compare(const A, B: UnicodeString;
                                      aCaseMode: TCaseSensitivity): TCompareResult;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PWIDEChar(A), Length(A),
                             PWIDEChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CompareText(const A, B: UnicodeString): TCompareResult;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PWIDEChar(A), Length(A),
                             PWIDEChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.SameString(const A, B: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PWIDEChar(A), Length(A),
                             PWIDEChar(B), Length(B)) = CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.SameText(const A, B: UnicodeString): Boolean;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PWIDEChar(A), Length(A),
                             PWIDEChar(B), Length(B)) = CSTR_EQUAL;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Append(const aString: UnicodeString;
                                     aChar: ANSIChar): UnicodeString;
  var
    ch: WIDEChar;
  begin
    result := aString;
    ch     := WIDE(aChar);

    SetLength(result, Length(result) + 1);
    result[Length(result)] := ch;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Append(const aString: UnicodeString;
                                     aChar: WIDEChar): UnicodeString;
  begin
    result := aString;
    SetLength(result, Length(result) + 1);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Append(const aString, aSuffix: UnicodeString): UnicodeString;
  var
    orgLen: Integer;
    sfxlen: Integer;
  begin
    if HasLength(aString, orgLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxLen) then
      begin
        SetLength(result, orgLen + sfxlen);
        FastCopy(aSuffix, result, orgLen + 1);
      end;
    end
    else
      result := aSuffix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Append(const aString: UnicodeString;
                               const aSuffix: UnicodeString;
                                     aSeparator: ANSIChar): UnicodeString;
  begin
    result := Append(aString, aSuffix, WIDE(aSeparator));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Append(const aString: UnicodeString;
                               const aSuffix: UnicodeString;
                                     aSeparator: WIDEChar): UnicodeString;
  var
    orgLen: Integer;
    sfxLen: Integer;
  begin
    Require('aSeparator', aSeparator).IsNotNull;

    if HasLength(aString, orgLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxlen) then
      begin
        SetLength(result, orgLen + sfxLen + 1);

        PWIDEChar(result)[orgLen] := aSeparator;

        FastCopy(aSuffix, result, orgLen + 2);
      end;
    end
    else
      result := aSuffix
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   class function WIDEFn.Append(const aString: UnicodeString;
                                const aSuffix: UnicodeString;
                                const aSeparator: UnicodeString): UnicodeString;
  var
    orgLen: Integer;
    sepLen: Integer;
    sfxLen: Integer;
  begin
    if HasLength(aString, orgLen) then
    begin
      result := aString;

      if HasLength(aSuffix, sfxlen) then
      begin
        if HasLength(aSeparator, sepLen) then
        begin
          SetLength(result, orgLen + sepLen + sfxLen);

          FastCopy(aSeparator, result, orgLen + 1);
          FastCopy(aSuffix, result, orgLen + sepLen + 1);
        end
        else
        begin
          SetLength(result, orgLen + sfxLen);

          FastCopy(aSeparator, result, orgLen + 1);
        end;
      end;
    end
    else
      result := aSuffix
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                                     aChar: ANSIChar): UnicodeString;
  begin
    result := Insert(aString, aPos, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                                     aChar: WIDEChar): UnicodeString;
  var
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;

    result := aString;

    if  NOT HasLength(aString, strLen)
     or NOT HasIndex(aString, aPos) then
      EXIT;

    SetLength(result, strLen + 1);

    if aPos < strLen then
      FastMove(result, aPos, aPos + 1, strLen - aPos + 1);

    result[aPos] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                               const aInfix: UnicodeString): UnicodeString;
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
    WIDE.CopyToBuffer(aInfix, ifxlen, Pointer(result), bufPos * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Insert(const aString: UnicodeString;
                                    aPos: Integer;
                              const aInfix: UnicodeString;
                                    aSeparator: WIDEChar): UnicodeString;
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
    WIDE.CopyToBuffer(aInfix, ifxLen, Pointer(result), aPos * 2);

    result[aPos]              := aSeparator;
    result[aPos + ifxLen + 1] := aSeparator;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                               const aInfix: UnicodeString;
                               const aSeparator: UnicodeString): UnicodeString;
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
      WIDE.CopyToBuffer(aInfix, ifxLen, Pointer(result), (bufPos + sepLen) * 2);

      // Copy the separator into the space either side of the infix
      WIDE.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos * 2);
      WIDE.CopyToBuffer(aSeparator, sepLen, Pointer(result), (bufPos + ifxLen + sepLen) * 2);
    end
    else
      result := Insert(aString, aPos, aInfix);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                      aChar: ANSIChar): UnicodeString;
  begin
    result := Prepend(aString, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                      aChar: WIDEChar): UnicodeString;
  var
    dest: PWIDEChar absolute result;
    strLen: Integer;
  begin
    Require('aChar', aChar).IsNotNull;

    if HasLength(aString, strLen) then
    begin
      result := aString;

      SetLength(result, strLen + 1);
      FastMove(result, 1, 2, strLen);
    end
    else
      SetLength(result, 1);

    dest[0] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString): UnicodeString;
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

        FastMove(result, 1, pfxLen + 1, strLen);
        FastCopy(aPrefix, result, 1);
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                      aSeparator: ANSIChar): UnicodeString;
  begin
    result := Prepend(aString, aPrefix, WIDE(aSeparator));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                      aSeparator: WIDEChar): UnicodeString;
  var
    dest: PWIDEChar absolute result;
    strLen: Integer;
    pfxLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      result := aString;

      if HasLength(aPrefix, pfxLen) then
      begin
        SetLength(result, strLen + pfxLen + 1);

        FastMove(result, 1, pfxLen + 2, strLen);
        FastCopy(aPrefix, result, 1);

        dest[pfxLen] := aSeparator;
      end;
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                const aSeparator: UnicodeString): UnicodeString;
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

        FastMove(result, 1, pfxLen + sepLen + 1, strLen);
        FastCopy(aPrefix, result, 1);
        FastCopy(aSeparator, result, pfxLen + 1);
      end
      else
        result := Prepend(aString, aPrefix);
    end
    else
      result := aPrefix;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Embrace(const aString: UnicodeString;
                                      aBrace: ANSIChar): UnicodeString;
  begin
    result := Embrace(aString, WIDE(aBrace));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Embrace(const aString: UnicodeString;
                                      aBrace: WIDEChar): UnicodeString;
  var
    strLen: Integer;
  begin
    if HasLength(aString, strLen) then
    begin
      SetLength(result, strLen + 2);
      FastCopy(aString, result, 2);
    end
    else
      SetLength(result, 2);

    PWIDECHar(result)[0] := aBrace;

    case aBrace of
      '(' : PWIDEChar(result)[strLen + 1] := WIDEChar(')');
      '{' : PWIDEChar(result)[strLen + 1] := WIDEChar('}');
      '[' : PWIDEChar(result)[strLen + 1] := WIDEChar(']');
      '<' : PWIDEChar(result)[strLen + 1] := WIDEChar('>');
    else
      PWIDEChar(result)[strLen + 1] := aBrace;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Enquote(const aString: UnicodeString;
                                      aQuote: ANSIChar): UnicodeString;
  begin
    result := Enquote(aString, WIDE(aQuote), WIDE(aQuote));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Enquote(const aString: UnicodeString;
                                      aQuote: ANSIChar;
                                      aEscape: ANSIChar): UnicodeString;
  begin
    result := Enquote(aString, WIDE(aQuote), WIDE(aEscape));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Enquote(const aString: UnicodeString;
                                      aQuote: WIDEChar;
                                      aEscape: WIDEChar): UnicodeString;
  var
    i, j: Integer;
    strlen: Integer;
    pc: PWIDEChar;
  begin
    strlen := System.Length(aString);
    SetLength(result, (strlen * 2) + 2);

    j := 2;

    if strlen > 0 then
    begin
      pc  := PWIDEChar(aString);
      for i := 1 to strlen do
      begin
        if (pc^ = aQuote) then
        begin
          result[j] := aEscape;
          Inc(j);
        end;

        result[j] := pc^;
        Inc(j);

        Inc(pc);
      end;
    end;

    result[1] := aQuote;
    result[j] := aQuote;
    SetLength(result, j);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: ANSIChar): UnicodeString;
  begin
    result := PadLeft(WIDE(aValue), aLength, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadLeft(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WIDEChar): UnicodeString;
  begin
    result := PadLeft(WIDE(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadLeft(const aString: UnicodeString;
                                   aLength: Integer;
                                   aChar: ANSIChar): UnicodeString;
  begin
    result := PadLeft(aString, aLength, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadLeft(const aString: UnicodeString;
                                      aLength: Integer;
                                      aChar: WIDEChar): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PWIDEChar;
  begin
    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
    begin
      result := aString;
      EXIT;
    end;

    SetLength(result, aLength);

    p := PWIDEChar(result);
    for i := 0 to Pred(pad) do
      p[i] := aChar;

    Inc(p, pad);
    FastCopy(aString, p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: ANSIChar): UnicodeString;
  begin
    result := PadRight(WIDE(aValue), aLength, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadRight(const aValue: Integer;
                                   aLength: Integer;
                                   aChar: WIDEChar): UnicodeString;
  begin
    result := PadRight(WIDE(aValue), aLength, aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadRight(const aString: UnicodeString;
                                   aLength: Integer;
                                   aChar: ANSIChar): UnicodeString;
  begin
    result := PadRight(aString, aLength, WIDE(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.PadRight(const aString: UnicodeString;
                                   aLength: Integer;
                                   aChar: WIDEChar): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PWIDEChar;
  begin
    result := aString;

    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
      EXIT;

    SetLength(result, aLength);

    p := PWIDEChar(result);
    Inc(p, len);

    for i := 0 to Pred(pad) do
      p[i] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Parse: WIDEParserClass;
  begin
    result := WIDEParser;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aChar: ANSIChar;
                              var   aLeft, aRight: UnicodeString): Boolean;
  begin
    result := Split(aString, WIDE(aChar), aLeft, aRight);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aChar: WIDEChar;
                              var   aLeft, aRight: UnicodeString): Boolean;
  var
    p: Integer;
    source: UnicodeString;
  begin
    Require('aChar', aChar).IsNotSurrogate;

    source  := aString;
    aLeft   := source;
    aRight  := '';

    result  := Find(source, aChar, p);
    if NOT result then
      EXIT;

    SetLength(aLeft, p - 1);
    aRight := Copy(source, p + 1, System.Length(Source) - p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aDelim: UnicodeString;
                              var   aLeft, aRight: UnicodeString): Boolean;
  var
    p: Integer;
    delimLen: Integer;
  begin
    aLeft   := aString;
    aRight  := '';

    result  := Find(aString, aDelim, p);
    if NOT result then
      EXIT;

    delimLen := Length(aDelim);

    SetLength(aLeft, p - 1);
    aRight := Copy(aString, p + delimLen, System.Length(aString) - p - (delimLen - 1));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aChar: ANSIChar;
                              var   aParts: TWIDEStringArray): Integer;
  begin
    result := Split(aString, WIDE(aChar), aParts);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aChar: WIDEChar;
                              var   aParts: TWIDEStringArray): Integer;
  var
    i: Integer;
    p: TCharIndexArray;
    plen: Integer;
  begin
    Require('aChar', aChar).IsNotSurrogate;

    result := 0;
    SetLength(aParts, 0);

    if FindAll(aString, aChar, p) = 0 then
    begin
      if aString <> '' then
      begin
        SetLength(aParts, 1);
        aParts[0] := aString;
        result    := 1;
      end;

      EXIT;
    end;

    plen := System.Length(p);
    SetLength(aParts, plen + 1);

    aParts[0] := Copy(aString, 1, p[0] - 1);
    for i := 1 to Pred(plen) do
      aParts[i] := Copy(aString, p[i - 1] + 1, p[i] - p[i - 1] - 1);

    i := p[Pred(plen)] + 1;
    aParts[plen] := Copy(aString, i, System.Length(aString) - i + 1);

    result := Length(aParts);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Split(const aString: UnicodeString;
                              const aDelim: UnicodeString;
                              var   aParts: TWIDEStringArray): Integer;
  var
    i: Integer;
    p: TCharIndexArray;
    plen, delimLen: Integer;
  begin
    Require('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);

    result := 0;
    SetLength(aParts, 0);

    if FindAll(aString, aDelim, p) = 0 then
    begin
      if aString <> '' then
      begin
        SetLength(aParts, 1);
        aParts[0] := aString;
        result    := 1;
      end;

      EXIT;
    end;

    plen := System.Length(p);
    SetLength(aParts, plen + 1);

    aParts[0] := self.Copy(aString, 1, p[0] - 1);
    for i := 1 to Pred(plen) do
      aParts[i] := self.Copy(aString, p[i - 1] + delimLen, p[i] - p[i - 1] - delimLen);

    i := p[Pred(plen)] + delimLen;
    aParts[plen] := self.Copy(aString, i, System.Length(aString) - i + delimLen);

    result := Length(aParts);
  end;













  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.Delete(var aString: UnicodeString;
                                    aIndex: Integer);
  begin
    Require('aIndex', aIndex).IsValidIndexForString(aString);

    case LoSurrogateStrategy(aString, aIndex + 1) of
      ssAvoid : System.Delete(aString, aIndex, 2);
      ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex + 1]);
    else
      case HiSurrogateStrategy(aString, aIndex - 1) of
        ssAvoid : System.Delete(aString, aIndex - 1, 2);
        ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
      else
        System.Delete(aString, aIndex, 1);
      end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.Delete(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer);
  begin
    Require('aIndex', aIndex).IsValidIndexForString(aString);
    Require('aLength', aLength).IsPositiveOrZero;

    case aLength of
      0 : { NO-OP };
      1 : Delete(aString, aIndex);
    else
      case LoSurrogateStrategy(aString, aIndex) of
        ssAvoid : Dec(aIndex);
        ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
      end;

      case HiSurrogateStrategy(aString, aIndex + aLength - 1) of
        ssAvoid : Inc(aLength);
        ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex + aLength]);
      end;

      System.Delete(aString, aIndex, aLength);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.DeleteRange(var aString: UnicodeString;
                                         aIndex: Integer;
                                         aEndIndex: Integer);
  begin
    Require('aIndex', aIndex).IsValidIndexForString(aString);
    Require('aEndIndex', aEndIndex).IsValidIndexForString(aString);

    if aIndex > aEndIndex then
      Exchange(aIndex, aEndIndex);

    case LoSurrogateStrategy(aString, aIndex) of
      ssAvoid : Dec(aIndex);
      ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
    end;

    case HiSurrogateStrategy(aString, aEndIndex) of
      ssAvoid : Inc(aEndIndex);
      ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aEndIndex + 1]);
    end;

    System.Delete(aString, aIndex, aEndIndex - aIndex + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Delete(var aString: UnicodeString;
                                   aChar: ANSIChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, WIDE(aChar), idx, aCaseMode);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Delete(var aString: UnicodeString;
                                   aChar: WIDEChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Delete(var   aString: UnicodeString;
                               const aSubstring: UnicodeString;
                                     aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := Find(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteText(var aString: UnicodeString;
                                       aChar: ANSIChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, WIDE(aChar), idx, csIgnoreCase);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteText(var aString: UnicodeString;
                                       aChar: WIDEChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteText(var   aString: UnicodeString;
                                   const aSubstring: UnicodeString): Boolean;
  begin
    result := Delete(aString, aSubstring, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteAll(var   aString: UnicodeString;
                                  const aSubstring: UnicodeString;
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
  class function WIDEFn.DeleteAll(var aString: UnicodeString;
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
  class function WIDEFn.DeleteAll(var aString: UnicodeString;
                                      aChar: WIDEChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := DeleteAll(aString, ANSI(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteAllText(var aString: UnicodeString;
                                          aChar: ANSIChar): Integer;
  begin
    result := DeleteAll(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteAllText(var aString: UnicodeString;
                                          aChar: WIDEChar): Integer;
  begin
    result := DeleteAll(aString, ANSI(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteAllText(var   aString: UnicodeString;
                                      const aSubstring: UnicodeString): Integer;
  begin
    result := DeleteAll(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLast(var aString: UnicodeString;
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
  class function WIDEFn.DeleteLast(var aString: UnicodeString;
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
  class function WIDEFn.DeleteLast(var   aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, aCaseMode);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLastText(var aString: UnicodeString;
                                           aChar: ANSIChar): Boolean;
  begin
    result := Delete(aString, WIDE(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLastText(var aString: UnicodeString;
                                           aChar: WIDEChar): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLastText(var   aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, csIgnoreCase);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.DeleteLeft(var aString: UnicodeString;
                                        aCount: Integer);
  var
    len: Integer;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    if (aCount <= 0) or NOT HasLength(aString, len) then
      EXIT;

    Dec(len, aCount);

    if len > 0 then
    begin
      case LoSurrogateStrategy(PWIDEChar(aString)[aCount]) of
        ssIgnore  : System.Delete(aString, 1, aCount);
        ssAvoid   : System.Delete(aString, 1, aCount + 1);
        ssError   : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aCount + 1]);
      end;
    end
    else
      aString := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLeft(var   aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteLeft(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteLeftText(var   aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  begin
    result := DeleteLeft(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WIDEFn.DeleteRight(var aString: UnicodeString;
                                         aCount: Integer);
  var
    len: Integer;
  begin
    if (aCount <= 0) or NOT HasLength(aString, len) then
      EXIT;

    SetLength(aString, len - aCount);

    case HiSurrogateStrategy(aString, len) of
      ssAvoid : SetLength(aString, len - 1);
      ssError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [len - 1]);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteRight(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteRight(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.DeleteRightText(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString): Boolean;
  begin
    result := DeleteRight(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Remove(const aString: UnicodeString;
                                     aIndex: Integer;
                                     aLength: Integer): UnicodeString;
  begin
    result := aString;
    System.Delete(result, aIndex, aLength);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Remove(const aString: UnicodeString;
                                     aChar: ANSIChar;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, WIDE(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Remove(const aString: UnicodeString;
                                     aChar: WIDEChar;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Remove(const aString, aSubstring: UnicodeString;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveText(const aString: UnicodeString;
                                         aChar: ANSIChar): UnicodeString;
  begin
    result := aString;
    Delete(result, WIDE(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveText(const aString: UnicodeString;
                                         aChar: WIDEChar): UnicodeString;
  begin
    result := aString;
    Delete(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    Delete(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAll(const aString, aSubstring: UnicodeString;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAll(const aString: UnicodeString;
                                        aChar: ANSIChar;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, WIDE(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAll(const aString: UnicodeString;
                                        aChar: WIDEChar;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAllText(const aString: UnicodeString;
                                            aChar: ANSIChar): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, WIDE(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAllText(const aString: UnicodeString;
                                            aChar: WIDEChar): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveAllText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLast(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, WIDE(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLast(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLast(const aString, aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLastText(const aString: UnicodeString;
                                             aChar: ANSIChar): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, WIDE(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLastText(const aString: UnicodeString;
                                             aChar: WIDEChar): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RemoveLastText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, csIgnoreCase);
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Extract(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer): UnicodeString;
  begin
    if NOT Extract(aString, aIndex, aLength, result) then
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Extract(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer;
                                var aExtract: UnicodeString): Boolean;
  var
    strLen: Integer;
  begin
    Require('aLength', aLength).IsPositiveOrZero;

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
  class function WIDEFn.ExtractLeft(var aString: UnicodeString;
                                        aCount: Integer): UnicodeString;
  begin
    ExtractLeft(aString, aCount, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var aString: UnicodeString;
                                        aCount: Integer;
                                    var aExtract: UnicodeString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aExtract  := System.Copy(aString, 1, aCount);
    result    := NOT IsEmpty(aExtract);

    if result then
      System.Delete(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: WIDEChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: ANSIChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, WIDE(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var   aString: UnicodeString;
                                    const aDelimiter: UnicodeString;
                                          aDelimiterOption: TExtractDelimiterOption;
                                          aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: WIDEChar;
                                    var  aExtract: UnicodeString;
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
  class function WIDEFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: ANSIChar;
                                    var  aExtract: UnicodeString;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractLeft(aString, WIDE(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeft(var   aString: UnicodeString;
                                    const aDelimiter: UnicodeString;
                                    var   aExtract: UnicodeString;
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
  class function WIDEFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: WIDEChar;
                                             aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: ANSIChar;
                                             aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, WIDE(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeftText(var   aString: UnicodeString;
                                        const aDelimiter: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: WIDEChar;
                                        var  aExtract: UnicodeString;
                                             aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: ANSIChar;
                                        var  aExtract: UnicodeString;
                                             aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, WIDE(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractLeftText(var   aString: UnicodeString;
                                        const aDelimiter: UnicodeString;
                                        var   aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractQuotedValue(var   aString: UnicodeString;
                                           const aDelimiter: WIDEChar): UnicodeString;
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
  class function WIDEFn.ExtractRight(var aString: UnicodeString; aCount: Integer): UnicodeString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    SetLength(aString, Length(aString) - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRight(var aString: UnicodeString;
                                         aCount: Integer;
                                     var aExtract: UnicodeString): Boolean;
  begin
    aExtract := ExtractRight(aString, aCount);
    result   := (aExtract <> '');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightFrom(var aString: UnicodeString;
                                             aIndex: Integer): UnicodeString;
  begin
    ExtractRightFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightFrom(var aString: UnicodeString;
                                             aIndex: Integer;
                                         var aExtract: UnicodeString): Boolean;
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
  class function WIDEFn.ExtractRight(var aString: UnicodeString;
                                         aDelimiter: WIDEChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRight(var aString: UnicodeString;
                                         aDelimiter: ANSIChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, WIDE(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRight(var   aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                           aDelimiterOption: TExtractDelimiterOption;
                                           aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRight(var  aString: UnicodeString;
                                          aDelimiter: WIDEChar;
                                     var  aExtract: UnicodeString;
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
  class function WIDEFn.ExtractRight(var  aString: UnicodeString;
                                          aDelimiter: ANSIChar;
                                     var  aExtract: UnicodeString;
                                          aDelimiterOption: TExtractDelimiterOption;
                                          aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractRight(aString, WIDE(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRight(var   aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                     var   aExtract: UnicodeString;
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
  class function WIDEFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: WIDEChar;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: ANSIChar;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, WIDE(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightText(var   aString: UnicodeString;
                                         const aDelimiter: UnicodeString;
                                               aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: WIDEChar;
                                         var  aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: ANSIChar;
                                         var  aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, WIDE(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ExtractRightText(var   aString: UnicodeString;
                                         const aDelimiter: UnicodeString;
                                         var   aExtract: UnicodeString;
                                               aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ConsumeLeft(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString;
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
  class function WIDEFn.ConsumeRight(var   aString: UnicodeString;
                                     const aSubstring: UnicodeString;
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
  class function WIDEFn.Copy(const aString: UnicodeString;
                                   aStartPos, aLength: Integer): UnicodeString;
  begin
    Copy(aString, aStartPos, aLength, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Copy(const aString: UnicodeString;
                                   aStartPos, aLength: Integer;
                             var   aCopy: UnicodeString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsGreaterThan(0);

    aCopy   := System.Copy(aString, aStartPos, aLength);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyFrom(const aString: UnicodeString;
                                       aIndex: Integer): UnicodeString;
  begin
    CopyFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyFrom(const aString: UnicodeString;
                                       aIndex: Integer;
                                 var   aCopy: UnicodeString): Boolean;
  begin
    Require('aIndex', aIndex).IsGreaterThan(0);

    aCopy   := System.Copy(aString, aIndex, Length(aString) - aIndex + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRange(const aString: UnicodeString;
                                        aStartPos: Integer;
                                        aEndPos: Integer): UnicodeString;
  begin
    CopyRange(aString, aStartPos, aEndPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRange(const aString: UnicodeString;
                                        aStartPos: Integer;
                                        aEndPos: Integer;
                                  var   aCopy: UnicodeString): Boolean;
  begin
    Require('aStartPos', aStartPos).IsGreaterThan(0);
    Require('aEndPos', aEndPos).IsGreaterThanOrEqual(aStartPos, 'aStartPos');

    if (aStartPos = aEndPos) then
      aCopy := ''
    else
      aCopy   := System.Copy(aString, aStartPos, aEndPos - aStartPos + 1);

    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                       aCount: Integer): UnicodeString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                    aDelimiter: ANSIChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                    aDelimiter: WIDEChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                              const aDelimiter: UnicodeString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                    aCount: Integer;
                              var   aCopy: UnicodeString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                    aDelimiter: ANSIChar;
                              var   aCopy: UnicodeString;
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
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                       aDelimiter: WIDEChar;
                                 var   aCopy: UnicodeString;
                                       aDelimiterOption: TCopyDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyLeft(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeft(const aString: UnicodeString;
                                 const aDelimiter: UnicodeString;
                                 var   aCopy: UnicodeString;
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
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                        aDelimiter: ANSIChar;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                        aDelimiter: WIDEChar;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                        aDelimiter: ANSIChar;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                        aDelimiter: WIDEChar;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyLeftText(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aCount: Integer): UnicodeString;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aDelimiter: ANSIChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aDelimiter: WIDEChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, ANSI(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                              const aDelimiter: UnicodeString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aCount: Integer;
                              var   aCopy: UnicodeString): Boolean;
  begin
    Require('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aDelimiter: ANSIChar;
                              var   aCopy: UnicodeString;
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
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                                    aDelimiter: WIDEChar;
                              var   aCopy: UnicodeString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyRight(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRight(const aString: UnicodeString;
                              const aDelimiter: UnicodeString;
                              var   aCopy: UnicodeString;
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
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                        aDelimiter: ANSIChar;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                        aDelimiter: WIDEChar;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, ANSI(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                        aDelimiter: ANSIChar;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                        aDelimiter: WIDEChar;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, ANSI(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.CopyRightText(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;

























  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: ANSIChar;
                                      aReplacement: ANSIChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: WIDEChar;
                                      aReplacement: WIDEChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, ANSI(aChar), ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: ANSIChar;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: WIDEChar;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: ANSIChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: WIDEChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, ANSI(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: WIDEChar;
                                      aReplacement: WIDEChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;
    result := (aChar <> aReplacement) and Find(aString, aChar, p, aCaseMode);
    if result then
      PWIDEChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: ANSIChar;
                                      aReplacement: ANSIChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, WIDE(aChar), WIDE(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: WIDEChar;
                                const aReplacement: UnicodeString;
                                var   aResult: UnicodeString;
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
        else if (aChar <> PWIDEChar(aReplacement)[0]) then
          PWIDEChar(aResult)[p - 1] := PWIDEChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                      aChar: ANSIChar;
                                const aReplacement: UnicodeString;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, WIDE(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: WIDEChar;
                                var   aResult: UnicodeString;
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
      strLen := Length(aString);
      subLen := Length(aSubstring);

      if subLen > 1 then
      begin
        FastMove(aResult, p + subLen, p + 1, strLen - (p + subLen - 1));
        SetLength(aResult, strLen - (subLen - 1));
      end
      else
        result := (aReplacement <> PWIDEChar(aSubString)[0]);

      if result then
        PWIDEChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: ANSIChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, aSubstring, WIDE(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                const aReplacement: UnicodeString;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := Find(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      strLen := Length(aString);
      subLen := Length(aSubstring);

      if HasLength(aReplacement, replaceLen) then
      begin
        result := NOT (aReplacement = aSubstring);
        if NOT result then
          EXIT;

        if replaceLen > subLen then
          SetLength(aResult, strLen + replaceLen - subLen);

        if replaceLen <> subLen then
          FastMove(aResult, p + subLen, p + replaceLen, strLen - (p + subLen - 1));

        if (replaceLen = 1) then
          PWIDEChar(aResult)[p - 1] := PWIDEChar(aReplacement)[0]
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
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar): UnicodeString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar): UnicodeString;
  begin
    result := Replace(aString, ANSI(aChar), ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, ANSI(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: ANSIChar): UnicodeString;
  begin
    result := Replace(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WIDEChar): UnicodeString;
  begin
    result := Replace(aString, aSubstring, ANSI(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, ANSI(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: ANSIChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubString, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WIDEChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubstring, ANSI(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;




//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                         aReplacement: WIDEChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    p: TCharIndexArray;
  begin
    aResult := aString;

    result := (aChar <> aReplacement) and (FindAll(aString, aChar, p, aCaseMode) > 0);
    if result then
      for i := Low(p) to High(p) do
        PWIDEChar(aResult)[p[i] - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                         aReplacement: ANSIChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, WIDE(aChar), WIDE(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
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
        PWIDEChar(aResult)[pa[i] - 1] := PWIDEChar(aReplacement)[0];
    end
    else
      aResult := RemoveAll(aString, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, WIDE(aChar), aReplacement, aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: WIDEChar;
                                   var   aResult: UnicodeString;
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
        PWIDEChar(aResult)[p - 1] := aReplacement;
      end;

      SetLength(aResult, strLen + (occurs * nudge));
    end
    else for i := 0 to Pred(occurs) do
      PWIDEChar(aResult)[pa[i] - 1] := PWIDEChar(aReplacement)[0];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: ANSIChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, WIDE(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
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
          FastMove(aResult, p + subLen, p + 1, strLen - p);
          PWIDEChar(aResult)[p - 1] := PWIDEChar(aReplacement)[0];
        end;

        if nudge < 0 then
          SetLength(aResult, strLen + (occurs * nudge));
      end
      else if (replaceLen = 1) then
      begin
        for i := 0 to Pred(occurs) do
          PWIDEChar(aResult)[pa[i] - 1] := PWIDEChar(aReplacement)[0];
      end
      else for i := 0 to Pred(occurs) do
        FastCopy(aReplacement, aResult, pa[i], replaceLen);
    end
    else
      aResult := RemoveAll(aString, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                         aReplacement: WIDEChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                         aReplacement: ANSIChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, WIDE(aChar), WIDE(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: ANSIChar;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, WIDE(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WIDEChar;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: ANSIChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, WIDE(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: WIDEChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WIDEChar;
                                             aReplacement: WIDEChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: ANSIChar;
                                             aReplacement: ANSIChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, WIDE(aChar), WIDE(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: ANSIChar;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, WIDE(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WIDEChar;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: ANSIChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, WIDE(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: WIDEChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: ANSIChar;
                                             aReplacement: ANSIChar): UnicodeString;
  begin
    ReplaceAll(aString, WIDE(aChar), WIDE(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WIDEChar;
                                             aReplacement: WIDEChar): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: ANSIChar;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, WIDE(aChar), aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WIDEChar;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: ANSIChar): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, WIDE(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: WIDEChar): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;



//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Require('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := (aChar <> aReplacement) and FindLast(aString, aChar, p, aCaseMode);
    if result then
      PWIDEChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, WIDE(aChar), WIDE(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                    const aReplacement: UnicodeString;
                                    var   aResult: UnicodeString;
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
        else if (aChar <> PWIDEChar(aReplacement)[0]) then
          PWIDEChar(aResult)[p - 1] := PWIDEChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                    const aReplacement: UnicodeString;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, WIDE(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WIDEChar;
                                    var   aResult: UnicodeString;
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
        result := (aReplacement <> PWIDEChar(aSubString)[0]);

      if result then
        PWIDEChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: ANSIChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, WIDE(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                                    var   aResult: UnicodeString;
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
          PWIDEChar(aResult)[p - 1] := PWIDEChar(aReplacement)[0]
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
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                          aReplacement: ANSIChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, WIDE(aChar), WIDE(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                          aReplacement: WIDEChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: ANSIChar;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, WIDE(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WIDEChar;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: ANSIChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, WIDE(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WIDEChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: ANSIChar;
                                              aReplacement: ANSIChar): UnicodeString;
  begin
    result := ReplaceLast(aString, WIDE(aChar), WIDE(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WIDEChar;
                                              aReplacement: WIDEChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: ANSIChar;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, WIDE(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WIDEChar;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: ANSIChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubString, WIDE(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: WIDEChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: ANSIChar;
                                              aReplacement: ANSIChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, WIDE(aChar), WIDE(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WIDEChar;
                                              aReplacement: WIDEChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: ANSIChar;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, WIDE(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WIDEChar;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: ANSIChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubString, WIDE(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: WIDEChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Tag(const aString, aTag: UnicodeString): UnicodeString;
  {
    Returns a specified string enclosed in an XML style tag.

    e.g. Tag('Man Bites Dog', 'h1')  =>  '<h1>Man Bites Dog</h1>'

    NOTE: This is very crude and limited and will at some point be removed
           with this or similar facilities provided in a more comprehensive
           and capable XML framework.
  }
  var
    tlen: Integer;
    rlen: Integer;
    blen: Integer;
    p: PWIDEChar;
    buf: PByte absolute p;
  begin
    tlen := Length(aTag);
    if tlen = 0 then
      EXIT;

    blen := Length(aString);

    rlen := blen + (tlen * 2) + 5;
    SetLength(result, rlen);

    p := PWIDEChar(result);
    p[0]        := '<';
    p[tlen + 1] := '>';

    p[tlen + blen + 2] := '<';
    p[tlen + blen + 3] := '/';
    p[rlen - 1]        := '>';

    // Up to this point we have used tlen and blen to calculate
    //  CHAR offsets, but for the BYTE offset calculations we
    //  need to double them (efficiently, using bit-shift)

    tlen := tlen shl 1;

    if blen > 0 then
    begin
      blen := blen shl 1;
      WIDEFn.CopyToBuffer(aString, blen, buf, tlen + 4);
    end;

    WIDEFn.CopyToBuffer(aTag, tlen, buf, 2);
    WIDEFn.CopyToBuffer(aTag, tlen, buf, tlen + blen + 8);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.LTrim(const aString: UnicodeString): UnicodeString;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := 0;
    while (i < strLen) and (chars[i] <= #32) do
      Inc(i);

    if (i < strLen) then
      result := Remove(aString, 1, i)
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.LTrim(const aString: UnicodeString;
                                    aChar: WIDEChar): UnicodeString;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := 0;
    while (i < strLen) and (chars[i] = aChar) do
      Inc(i);

    if (i < strLen) then
      result := Remove(aString, 1, i)
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.LTrim(const aString: UnicodeString;
                                    aCount: Integer): UnicodeString;
  begin
    if (aCount > 0) and (aString <> '') then
      result := Copy(aString, aCount + 1, Length(aString) - aCount)
    else
      result := aString;
  end;



  class function WIDEFn.RTrim(const aString: UnicodeString): UnicodeString;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := Pred(strLen);
    while (i > 0) and (chars[i] <= #32) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RTrim(const aString: UnicodeString;
                                    aChar: WIDEChar): UnicodeString;
  var
    chars: PWIDEChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if NOT HasLength(aString, strLen) then
      EXIT;

    i := Pred(strLen);
    while (i >= 0) and (chars[i] = aChar) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.RTrim(const aString: UnicodeString;
                                    aCount: Integer): UnicodeString;
  begin
    result := aString;

    if (aCount > 0) and (aString <> '') then
      SetLength(result, Length(result) - aCount);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Trim(const aString: UnicodeString): UnicodeString;
  begin
    result := LTrim(RTrim(aString));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Trim(const aString: UnicodeString;
                                   aChar: WIDEChar): UnicodeString;
  begin
    result := LTrim(RTrim(aString, aChar), aChar);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Trim(const aString: UnicodeString;
                                   aCount: Integer): UnicodeString;
  begin
    result := LTrim(RTrim(aString, aCount), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Unbrace(const aString: UnicodeString): UnicodeString;
  const
    MATCH_SET : set of ANSIChar = ['!','@','#','%','&','*','-','_',
                                   '+','=',':','/','?','\','|','~'];
  var
    rlen: Integer;
    firstChar: WIDEChar;
    lastChar: WIDEChar;
  begin
    result := aString;

    rlen := Length(aString) - 2;
    if rlen < 0 then
      EXIT;

    // First determine whether the string is braced - if not we return the
    //  original string

    firstChar := aString[1];
    lastChar  := aString[Length(aString)];

    if (Ord(firstChar) > 127) or (Ord(lastChar) > 127) then
      EXIT;

    case firstChar of
      '{' : if lastChar <> '}' then EXIT;
      '<' : if lastChar <> '>' then EXIT;
      '(' : if lastChar <> ')' then EXIT;
      '[' : if lastChar <> ']' then EXIT;
    else
      if NOT (ANSIChar(firstChar) in MATCH_SET)
          or (lastChar <> firstChar) then
        EXIT;
    end;

    if rlen > 0 then
      result := System.Copy(aString, 2, rlen)
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Unquote(const aString: UnicodeString): UnicodeString;
  var
    i, j, maxi: Integer;
    qc: WIDEChar;
  begin
    if Length(aString) < 2 then
      EXIT;

    qc := aString[1];
    if (aString[Length(aString)] <> qc)
     or ((qc <> '''') and (qc <> '"') and (qc <> '`')) then
    begin
      result := aString;
      EXIT;
    end;

    SetLength(result, Length(aString) - 2);

    i     := 2;
    maxi  := System.Length(aString) - 1;
    j     := 1;

    while i <= maxi do
    begin
      result[j] := aString[i];
      if (aString[i] = qc) then
      begin
        if (aString[i + 1] = qc) then
          Inc(i, 2)
        else
          raise Exception.Create('Quoted string ''' + aString + ''' contains incorrectly escaped quotes');
      end
      else
        Inc(i);

      Inc(j);
    end;

    SetLength(result, j - 1);
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Camelcase(const aString: UnicodeString;
                                        aInitialLower: Boolean): UnicodeString;
  var
    chars: PWIDEChar absolute result;
  begin
    result := Trim(Startcase(aString));

    if result = '' then
      EXIT;

    while ReplaceAll(result, '  ', ' ', result) do;

    result := ReplaceAll(result, ' ', '');

    if aInitialLower then
      chars[0] := Lowercase(chars[0])
    else
      chars[0] := Uppercase(chars[0]);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Lowercase(aChar: WIDEChar): WIDEChar;
  var
    p: PWIDEChar;
    l: Cardinal absolute p;
  begin
    l := MAKELONG(Word(aChar), 0);
    p := Windows.CharLowerW(p);

    result := WIDEChar(LOWORD(l));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Lowercase(const aString: UnicodeString): UnicodeString;
  begin
    result := aString;
    if result <> '' then
      CharLowerBuffW(PWIDEChar(result), Length(result));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Skewercase(const aString: UnicodeString): UnicodeString;
  begin
    result := Trim(aString);

    if result = '' then
      EXIT;

    while ReplaceAll(result, '  ', ' ', result) do;

    result := ReplaceAll(result, ' ', '-');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Snakecase(const aString: UnicodeString): UnicodeString;
  begin
    result := Trim(aString);

    if result = '' then
      EXIT;

    while ReplaceAll(result, '  ', ' ', result) do;

    result := ReplaceAll(result, ' ', '_');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Startcase(const aString: UnicodeString): UnicodeString;
  {
    Applies a naive start-case transformation to a specified string.

    The rules for this start-case implementation are simply this:

      - The first alpha character in the string is uppercase.

       - All alpha characters preceded by non-alpha character other than '
          (single-quote / apostrophe) are uppercase.

      - All alpha characters preceded by an alpha character are lowercase.
  }
  var
    i: Integer;
    len: Integer;
    prev: WIDEChar;
    prevAlpha: Boolean;
    ch: WIDEChar;
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
  class function WIDEFn.Titlecase(const aString: UnicodeString): UnicodeString;
  begin
    result := Titlecase(aString, LowercaseWordsForTitlecase)
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Titlecase(const aString: UnicodeString;
                                  const aLower: TWIDEStringArray): UnicodeString;
  begin
    // TODO:
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Titlecase(const aString: UnicodeString;
                                        aLower: TWIDEStringList): UnicodeString;
  var
    i: Integer;
    pieces: TWIDEStringArray;
    p: TCharIndexArray;
  begin
    result := WIDE.Startcase(aString);

    WIDE.Split(result, ' ', pieces);

    FindAll(result, ' ', p);

    for i := 0 to High(p) - 1 do
      if   WIDE.IsAlphaNumeric(result[p[i] - 1])
       and (aLower.IndexOf(pieces[i + 1]) <> -1) then
        result[p[i] + 1] := WIDE.Lowercase(result[p[i] + 1]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Uppercase(aChar: WIDEChar): WIDEChar;
  var
    p: PWIDEChar;
    l: Cardinal absolute p;
  begin
    l := MAKELONG(Word(aChar), 0);
    p := Windows.CharUpperW(p);

    result := WIDEChar(LOWORD(l));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEFn.Uppercase(const aString: UnicodeString): UnicodeString;
  begin
    result := aString;
    if result <> '' then
      CharUpperBuffW(PWIDEChar(result), Length(result));
  end;













initialization
  LowercaseWordsForTitlecase := TWIDEStringList.Create;
  LowercaseWordsForTitlecase.Sorted := TRUE;

  LowercaseWordsForTitlecase.Add('a');
  LowercaseWordsForTitlecase.Add('am');
  LowercaseWordsForTitlecase.Add('an');
  LowercaseWordsForTitlecase.Add('and');
  LowercaseWordsForTitlecase.Add('are');
  LowercaseWordsForTitlecase.Add('as');
  LowercaseWordsForTitlecase.Add('at');
  LowercaseWordsForTitlecase.Add('for');
  LowercaseWordsForTitlecase.Add('from');
  LowercaseWordsForTitlecase.Add('in');
  LowercaseWordsForTitlecase.Add('is');
  LowercaseWordsForTitlecase.Add('of');
  LowercaseWordsForTitlecase.Add('on');
  LowercaseWordsForTitlecase.Add('the');
  LowercaseWordsForTitlecase.Add('this');
  LowercaseWordsForTitlecase.Add('to');
  LowercaseWordsForTitlecase.Add('upon');

finalization
  LowercaseWordsForTitlecase.Free;
end.
