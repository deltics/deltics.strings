
{$i deltics.strings.inc}


  unit Deltics.Strings.Fns.Wide;


interface

  uses
    Windows,
    Deltics.Strings.Types;

  type
    WideFn = class
    private
      class function AddressOfIndex(var aString: UnicodeString; aIndex: Integer): PWideChar; overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; aDest: PWideChar); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; aDest: PWideChar; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; var aDest: UnicodeString; aDestIndex: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastCopy(const aString: UnicodeString; var aDest: UnicodeString; aDestIndex: Integer; aLen: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class procedure FastMove(var aString: UnicodeString; aFromIndex, aToIndex, aCount: Integer); overload; {$ifdef InlineMethods} inline; {$endif}
      class function CheckCase(const aString: UnicodeString; aCaseFn: TWideTestCharFn): Boolean;
      class procedure CopyToBuffer(const aString: UnicodeString; aMaxChars: Integer; aBuffer: Pointer; aByteOffset: Integer); overload;
//      class function Replace(aScope: TStringScope; const aString, aFindStr, aReplaceStr: UnicodeString; aCaseMode: TCaseSensitivity): UnicodeString; overload;
//      class function Replace(aScope: TStringScope; const aString, aFindStr, aReplaceStr: UnicodeString; var aCount: Integer; aCaseMode: TCaseSensitivity): UnicodeString; overload;

    public
      // Arrays
      class function AsArray(const aItems: array of UnicodeString): UnicodeStringArray;

      // Transcoding
      class function Encode(const aString: String): UnicodeString;
      class function FromAnsi(const aChar: AnsiChar): WideChar; overload;
      class function FromAnsi(const aString: AnsiString): UnicodeString; overload;
      class function FromAnsi(aBuffer: PAnsiChar; aMaxLen: Integer = -1): UnicodeString; overload;
      class function FromString(const aString: String): UnicodeString;
      class function FromUtf8(const aString: Utf8String): UnicodeString; overload;
      class function FromUtf8(aBuffer: PUtf8Char; aMaxLen: Integer = -1): UnicodeString; overload;
      class function FromWide(aBuffer: PWideChar; aMaxLen: Integer = -1): UnicodeString; overload;

      // Buffer (SZ pointer) routines
      class function AllocUtf8(const aSource: UnicodeString): PUtf8Char;
      class procedure CopyToBuffer(const aString: UnicodeString; aBuffer: Pointer); overload;
      class procedure CopyToBuffer(const aString: UnicodeString; aBuffer: Pointer; aMaxChars: Integer); overload;
      class procedure CopyToBufferOffset(const aString: UnicodeString; aBuffer: Pointer; aByteOffset: Integer); overload;
      class procedure CopyToBufferOffset(const aString: UnicodeString; aBuffer: Pointer; aByteOffset: Integer; aMaxChars: Integer); overload;
      class function FromBuffer(aBuffer: PAnsiChar; aLen: Integer = -1): UnicodeString; overload;
      class function FromBuffer(aBuffer: PWideChar; aLen: Integer = -1): UnicodeString; overload;
      class function Len(aBuffer: PWideChar): Integer;

      // Misc utilities
      class function Coalesce(const aString, aDefault: UnicodeString): UnicodeString; overload;
      class function IsEmpty(const aString: UnicodeString): Boolean; overload;
      class function IsEmpty(const aString: UnicodeString; var aLength: Integer): Boolean; overload;
      class function IsNotEmpty(const aString: UnicodeString): Boolean; overload;
      class function IsNotEmpty(const aString: UnicodeString; var aLength: Integer): Boolean; overload;
      class function HasIndex(const aString: UnicodeString; aIndex: Integer): Boolean; overload;
      class function HasIndex(const aString: UnicodeString; aIndex: Integer; var aChar: WideChar): Boolean; overload;
      class function IIf(aValue: Boolean; const aWhenTrue, aWhenFalse: UnicodeString): UnicodeString; overload;
      class function IndexOf(const aString: UnicodeString; aValues: array of UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function IndexOfText(const aString: UnicodeString; aValues: array of UnicodeString): Integer; overload;
      class function Reverse(const aString: UnicodeString): UnicodeString;
      class function Split(const aString: UnicodeString; const aChar: AnsiChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString: UnicodeString; const aChar: WideChar; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString, aDelim: UnicodeString; var aLeft, aRight: UnicodeString): Boolean; overload;
      class function Split(const aString: UnicodeString; const aChar: AnsiChar; var aParts: UnicodeStringArray): Integer; overload;
      class function Split(const aString: UnicodeString; const aChar: WideChar; var aParts: UnicodeStringArray): Integer; overload;
      class function Split(const aString, aDelim: UnicodeString; var aParts: UnicodeStringArray): Integer; overload;
    {$ifdef UNICODE}
      class function Split(const aString, aDelim: String; var aParts: StringArray): Integer; overload;
    {$endif}

      // Assembling a string
      class function Concat(const aArray: array of UnicodeString): UnicodeString; overload;
      class function Concat(const aArray: array of UnicodeString; const aSeparator: UnicodeString): UnicodeString; overload;
      class function Format(const aString: UnicodeString; const aArgs: array of const): UnicodeString;
      class function StringOf(aChar: AnsiChar; aCount: Integer): UnicodeString; overload;
      class function StringOf(aChar: WideChar; aCount: Integer): UnicodeString; overload;
      class function StringOf(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;

      // Testing things about a string
      class function IsAlpha(aChar: WideChar): Boolean; overload;
      class function IsAlpha(const aString: UnicodeString): Boolean; overload;
      class function IsAlphaNumeric(aChar: WideChar): Boolean; overload;
      class function IsAlphaNumeric(const aString: UnicodeString): Boolean; overload;
      class function IsHiSurrogate(const aChar: WideChar): Boolean;
      class function IsLoSurrogate(const aChar: WideChar): Boolean;
      class function IsLowercase(const aChar: WideChar): Boolean; overload;
      class function IsLowercase(const aString: UnicodeString): Boolean; overload;
      class function IsNull(aChar: WideChar): Boolean;
      class function IsNumeric(aChar: WideChar): Boolean; overload;
      class function IsNumeric(const aString: UnicodeString): Boolean; overload;
      class function IsSurrogate(const aChar: WideChar): Boolean;
      class function IsUppercase(const aChar: WideChar): Boolean; overload;
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
      class function BeginsWith(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWith(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function BeginsWithText(const aString: UnicodeString; aChar: AnsiChar): Boolean; overload;
      class function BeginsWithText(const aString: UnicodeString; aChar: WideChar): Boolean; overload;
      class function BeginsWithText(const aString, aSubstring: UnicodeString): Boolean; overload;
      class function Contains(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Contains(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ContainsText(const aString: UnicodeString; aChar: AnsiChar): Boolean; overload;
      class function ContainsText(const aString: UnicodeString; aChar: WideChar): Boolean; overload;
      class function ContainsText(const aString, aSubstring: UnicodeString): Boolean; overload;
      class function EndsWith(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWith(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function EndsWithText(const aString: UnicodeString; aChar: AnsiChar): Boolean; overload;
      class function EndsWithText(const aString: UnicodeString; aChar: WideChar): Boolean; overload;
      class function EndsWithText(const aString, aSubstring: UnicodeString): Boolean; overload;

      // Finding things in a string
      class function Find(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString: UnicodeString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Find(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindText(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString: UnicodeString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindNext(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString: UnicodeString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNext(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindNextText(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString: UnicodeString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindNextText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindPrevious(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString: UnicodeString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPrevious(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindPreviousText(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString: UnicodeString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindPreviousText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindLast(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString: UnicodeString; aChar: WideChar; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLast(const aString, aSubstring: UnicodeString; var aPos: Integer; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function FindLastText(const aString: UnicodeString; aChar: AnsiChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString: UnicodeString; aChar: WideChar; var aPos: Integer): Boolean; overload;
      class function FindLastText(const aString, aSubstring: UnicodeString; var aPos: Integer): Boolean; overload;
      class function FindAll(const aString: UnicodeString; aChar: AnsiChar; var aPos: CharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString: UnicodeString; aChar: WideChar; var aPos: CharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAll(const aString, aSubstring: UnicodeString; var aPos: CharIndexArray; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function FindAllText(const aString: UnicodeString; aChar: AnsiChar; var aPos: CharIndexArray): Integer; overload;
      class function FindAllText(const aString: UnicodeString; aChar: WideChar; var aPos: CharIndexArray): Integer; overload;
      class function FindAllText(const aString, aSubstring: UnicodeString; var aPos: CharIndexArray): Integer; overload;

      // Adding to a string
      class function Append(const aString: UnicodeString; aChar: AnsiChar): UnicodeString; overload;
      class function Append(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString; aSeparator: AnsiChar): UnicodeString; overload;
      class function Append(const aString, aSuffix: UnicodeString; aSeparator: WideChar): UnicodeString; overload;
      class function Append(const aString, aSuffix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; aChar: AnsiChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; aChar: WideChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix: UnicodeString): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix: UnicodeString; aSeparator: WideChar): UnicodeString; overload;
      class function Insert(const aString: UnicodeString; aPos: Integer; const aInfix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Prepend(const aString: UnicodeString; aChar: AnsiChar): UnicodeString; overload;
      class function Prepend(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString; aSeparator: AnsiChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix: UnicodeString; aSeparator: WideChar): UnicodeString; overload;
      class function Prepend(const aString, aPrefix, aSeparator: UnicodeString): UnicodeString; overload;
      class function Embrace(const aString: UnicodeString; aBrace: AnsiChar): UnicodeString; overload;
      class function Embrace(const aString: UnicodeString; aBrace: WideChar = '('): UnicodeString; overload;
      class function Enquote(const aString: UnicodeString; aQuote: AnsiChar): UnicodeString; overload;
      class function Enquote(const aString: UnicodeString; aQuote: WideChar = ''''; aEscape: WideChar = ''''): UnicodeString; overload;
      class function PadLeft(const aString: UnicodeString; aLength: Integer; aChar: AnsiChar): UnicodeString; overload;
      class function PadLeft(const aString: UnicodeString; aLength: Integer; aChar: WideChar = ' '): UnicodeString; overload;
      class function PadRight(const aString: UnicodeString; aLength: Integer; aChar: AnsiChar): UnicodeString; overload;
      class function PadRight(const aString: UnicodeString; aLength: Integer; aChar: WideChar = ' '): UnicodeString; overload;

      // TODO: This is supposed to be a general purpose String library, so
      //        this particular function really belongs in an XML framework!
      class function Tag(const aString, aTag: UnicodeString): UnicodeString;

      // Deleting parts of a string (modifying in-place)
      class procedure Delete(var aString: UnicodeString; aIndex: Integer); overload;
      class procedure Delete(var aString: UnicodeString; aIndex, aLength: Integer); overload;
      class procedure DeleteRange(var aString: UnicodeString; aIndex, aEndIndex: Integer); overload;
      class function Delete(var aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Delete(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class function DeleteAll(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAll(var aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; aChar: AnsiChar): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; aChar: WideChar): Integer; overload;
      class function DeleteAllText(var aString: UnicodeString; const aSubstring: UnicodeString): Integer; overload;
      class function DeleteLast(var aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLast(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; aChar: AnsiChar): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; aChar: WideChar): Boolean; overload;
      class function DeleteLastText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class procedure DeleteLeft(var aString: UnicodeString; aCount: Integer); overload;
      class function DeleteLeft(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteLeftText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;
      class procedure DeleteRight(var aString: UnicodeString; aCount: Integer); overload;
      class function DeleteRight(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function DeleteRightText(var aString: UnicodeString; const aSubstring: UnicodeString): Boolean; overload;

      // Removing parts of a string (modified result)
      class function Remove(const aString: UnicodeString; aIndex, aLength: Integer): UnicodeString; overload;
      class function Remove(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Remove(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Remove(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveText(const aString: UnicodeString; aChar: AnsiChar): UnicodeString; overload;
      class function RemoveText(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function RemoveText(const aString, aSubstring: UnicodeString): UnicodeString; overload;
      class function RemoveAll(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAll(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAll(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveAllText(const aString: UnicodeString; aChar: AnsiChar): UnicodeString; overload;
      class function RemoveAllText(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function RemoveAllText(const aString, aSubstring: UnicodeString): UnicodeString; overload;
      class function RemoveLast(const aString: UnicodeString; aChar: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLast(const aString: UnicodeString; aChar: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLast(const aString, aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function RemoveLastText(const aString: UnicodeString; aChar: AnsiChar): UnicodeString; overload;
      class function RemoveLastText(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function RemoveLastText(const aString, aSubstring: UnicodeString): UnicodeString; overload;

      // Consuming a string
      class function ConsumeLeft(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ConsumeRight(var aString: UnicodeString; const aSubstring: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;

      // Extracting parts of a string
      class function Extract(var aString: UnicodeString; aIndex, aLength: Integer): UnicodeString; overload;
      class function Extract(var aString: UnicodeString; aIndex, aLength: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aCount: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: AnsiChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; aDelimiter: WideChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeft(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: AnsiChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; aDelimiter: WideChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractLeftText(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aCount: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractRightFrom(var aString: UnicodeString; aIndex: Integer): UnicodeString; overload;
      class function ExtractRightFrom(var aString: UnicodeString; aIndex: Integer; var aExtract: UnicodeString): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: AnsiChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; aDelimiter: WideChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRight(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; const aDelimiter: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): UnicodeString; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: AnsiChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; aDelimiter: WideChar; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractRightText(var aString: UnicodeString; const aDelimiter: UnicodeString; var aExtract: UnicodeString; aDelimiterOption: TExtractDelimiterOption = doLeaveOptionalDelimiter): Boolean; overload;
      class function ExtractQuotedValue(var aString: UnicodeString; const aDelimiter: WideChar): UnicodeString;

      // Copying parts of a string
      class function Copy(const aString: UnicodeString; aStartPos, aLength: Integer): UnicodeString; overload;
      class function Copy(const aString: UnicodeString; aStartPos, aLength: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyFrom(const aString: UnicodeString; aIndex: Integer): UnicodeString; overload;
      class function CopyFrom(const aString: UnicodeString; aIndex: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyRange(const aString: UnicodeString; aStartPos, aEndPos: Integer): UnicodeString; overload;
      class function CopyRange(const aString: UnicodeString; aStartPos, aEndPos: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyLeft(const aString: UnicodeString; aCount: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: AnsiChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString: UnicodeString; aDelimiter: WideChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeft(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: AnsiChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString: UnicodeString; aDelimiter: WideChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyLeftText(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function CopyRight(const aString: UnicodeString; aCount: Integer; var aCopy: UnicodeString): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: AnsiChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString: UnicodeString; aDelimiter: WideChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRight(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter; aDelimiterCase: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: AnsiChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: WideChar; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString, aDelimiter: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): UnicodeString; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: AnsiChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString: UnicodeString; aDelimiter: WideChar; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;
      class function CopyRightText(const aString, aDelimiter: UnicodeString; var aCopy: UnicodeString; aDelimiterOption: TCopyDelimiterOption = doExcludeOptionalDelimiter): Boolean; overload;

      // Changing pieces of a string
      class function Replace(const aString: UnicodeString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function Replace(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAll(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar, aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceAllText(const aString: UnicodeString; const aSubstring: UnicodeString; aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceAllText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): Boolean; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar, aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring: UnicodeString; aReplacement: WideChar; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLast(const aString, aSubstring, aReplacement: UnicodeString; aCaseMode: TCaseSensitivity = csCaseSensitive): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: WideChar): UnicodeString; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: UnicodeString): UnicodeString; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar, aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: AnsiChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString: UnicodeString; aChar: WideChar; const aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: AnsiChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring: UnicodeString; aReplacement: WideChar; var aResult: UnicodeString): Boolean; overload;
      class function ReplaceLastText(const aString, aSubstring, aReplacement: UnicodeString; var aResult: UnicodeString): Boolean; overload;

      // Returning strings with parts removed
      class function LTrim(const aString: UnicodeString): UnicodeString; overload;
      class function LTrim(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function LTrim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function RTrim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function Trim(const aString: UnicodeString): UnicodeString; overload;
      class function Trim(const aString: UnicodeString; aChar: WideChar): UnicodeString; overload;
      class function Trim(const aString: UnicodeString; aCount: Integer): UnicodeString; overload;
      class function Unbrace(const aString: UnicodeString): UnicodeString;
      class function Unquote(const aString: UnicodeString): UnicodeString;

      // Case conversions
      class function Camelcase(const aString: UnicodeString; aInitialLower: Boolean = FALSE): UnicodeString;
      class function Lowercase(aChar: WideChar): WideChar; overload;
      class function Lowercase(const aString: UnicodeString): UnicodeString; overload;
      class function Skewercase(const aString: UnicodeString): UnicodeString;
      class function Snakecase(const aString: UnicodeString): UnicodeString;
      class function Startcase(const aString: UnicodeString): UnicodeString;
      class function Titlecase(const aString: UnicodeString): UnicodeString; overload;
      class function Titlecase(const aString: UnicodeString; const aLower: UnicodeStringArray): UnicodeString; overload;
      class function Uppercase(aChar: WideChar): WideChar; overload;
      class function Uppercase(const aString: UnicodeString): UnicodeString; overload;
    end;


implementation

  uses
    SysUtils,
    Deltics.Contracts,
    Deltics.Exchange,
    Deltics.Math,
    Deltics.Memory,
    Deltics.ReverseBytes,
    Deltics.Strings.Fns.Ansi,
    Deltics.Strings.Fns.utf8,
    Deltics.Strings.Utils,
    Deltics.Unicode;


  type
    Ansi = AnsiFn;
    Utf8 = Utf8Fn;
    Wide = WideFn;

  const
    ERRFMT_ORPHAN_DELETIONLEAVES_N = 'Deletion leaves surrogate orphan at index %d';


  const
    MIN_HiSurrogate : WideChar = #$d800;
    MAX_HiSurrogate : WideChar = #$dbff;
    MIN_LoSurrogate : WideChar = #$dc00;
    MAX_LoSurrogate : WideChar = #$dfff;

  var
    LowercaseWordsForTitlecase: UnicodeStringArray;


  function WhenLoSurrogate(const aChar: WideChar; const aAction: SurrogateAction): SurrogateAction; overload;
  begin
    result := aAction;
    if (result <> saIgnore) and NOT Unicode.IsLoSurrogate(aChar) then
      result := saIgnore;
  end;

  function WhenLoSurrogate(const aString: UnicodeString; const aIndex: Integer; const aAction: SurrogateAction): SurrogateAction; overload;
  var
    c: WideChar;
  begin
    result := aAction;
    if (result <> saIgnore) and (   NOT Wide.HasIndex(aString, aIndex, c)
                                 or NOT Unicode.IsLoSurrogate(c)) then
      result := saIgnore;
  end;

  function WhenHiSurrogate(const aChar: WideChar; const aAction: SurrogateAction): SurrogateAction; overload;
  begin
    result := aAction;
    if (result <> saIgnore) and NOT Unicode.IsHiSurrogate(aChar) then
      result := saIgnore;
  end;

  function WhenHiSurrogate(const aString: UnicodeString; const aIndex: Integer; const aAction: SurrogateAction): SurrogateAction; overload;
  var
    c: WideChar;
  begin
    result := aAction;
    if (result <> saIgnore) and (   NOT Wide.HasIndex(aString, aIndex, c)
                                 or NOT Unicode.IsHiSurrogate(c)) then
      result := saIgnore;
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TWideString.Contains(const aNeed: TContainNeeds;
                                      aChars: array of WideChar;
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
  function TWideString.Contains(const aNeed: TContainNeeds;
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







{ WideFn ------------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.AddressOfIndex(var aString: UnicodeString;
                                           aIndex: Integer): PWideChar;
  begin
    result := @aString[aIndex];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.FastCopy(const aString: UnicodeString;
                                        aDest: PWideChar);
  begin
    CopyMemory(aDest, PWideChar(aString), Length(aString) * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.FastCopy(const aString: UnicodeString;
                                        aDest: PWideChar;
                                        aLen: Integer);
  begin
    CopyMemory(aDest, PWideChar(aString), aLen * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.FastCopy(const aString: UnicodeString;
                                  var   aDest: UnicodeString;
                                        aDestIndex: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PWideChar(aString), Length(aString) * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.FastCopy(const aString: UnicodeString;
                                  var   aDest: UnicodeString;
                                        aDestIndex: Integer;
                                        aLen: Integer);
  begin
    CopyMemory(AddressOfIndex(aDest, aDestIndex), PWideChar(aString), aLen * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.FastMove(var aString: UnicodeString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aCount: Integer);
  begin
    CopyMemory(AddressOfIndex(aString, aToIndex),
               AddressOfIndex(aString, aFromIndex), aCount * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CheckCase(const aString: UnicodeString;
                                        aCaseFn: TWideTestCharFn): Boolean;
  var
    i: Integer;
    bAlpha: Boolean;
    pc: PWideChar;
  begin
    result  := FALSE;
    bAlpha  := FALSE;

    pc := PWideChar(aString);
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
  class procedure WideFn.CopyToBuffer(const aString: UnicodeString;
                                            aMaxChars: Integer;
                                            aBuffer: Pointer;
                                            aByteOffset: Integer);
  var
    len: Integer;
  begin
    Contract.Requires('aBuffer', aBuffer).IsAssigned;
    Contract.Requires('aMaxChars', aMaxChars).IsPositiveOrZero;

    if (aMaxChars = 0)
     or IsEmpty(aString, len) then
      EXIT;

    if (aMaxChars < len) then
      len := aMaxChars;

    FastCopy(aString, Memory.Offset(aBuffer, aByteOffset), len);
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(      aScope: TStringScope;
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
  class function WideFn.Replace(      aScope: TStringScope;
                                const aString: UnicodeString;
                                const aFindStr: UnicodeString;
                                const aReplaceStr: UnicodeString;
                                var   aCount: Integer;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  var
    i: Integer;
    pa: CharIndexArray;
    pr, ps, px: PWideChar;
    p, flen, xlen, rlen, clen: Integer;
  begin
    if (aScope = ssFirst) then
    begin
      SetLength(pa, 1);
      if Wide.Find(aString, aFindStr, p, aCaseMode) then
        pa[0] := p
      else
        SetLength(pa, 0);
    end
    else
      Wide.FindAll(aString, aFindStr, pa, aCaseMode);

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

    pr := PWideChar(result);
    ps := PWideChar(aString);
    px := PWideChar(aReplaceStr);

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

    if (pr - PWideChar(result)) < rlen then
    begin
      clen := Length(aString) - (ps - PWideChar(aString));
      CopyMemory(pr, ps, clen * 2);
    end;
  end;
*)






  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Coalesce(const aString, aDefault: UnicodeString): UnicodeString;
  begin
    if (aString <> '') then
      result := aString
    else
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsEmpty(const aString: UnicodeString): Boolean;
  begin
    result := Length(aString) = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsEmpty(const aString: UnicodeString;
                                var   aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength = 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsNotEmpty(const aString: UnicodeString): Boolean;
  begin
    result := Length(aString) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsNotEmpty(const aString: UnicodeString;
                                   var   aLength: Integer): Boolean;
  begin
    aLength := Length(aString);
    result  := aLength > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.HasIndex(const aString: UnicodeString;
                                       aIndex: Integer): Boolean;
  begin
    result := (aIndex > 0) and (aIndex <= Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.HasIndex(const aString: UnicodeString;
                                       aIndex: Integer;
                                   var aChar: WideChar): Boolean;
  begin
    aChar  := #0;
    result := (aIndex > 0) and (aIndex <= Length(aString));
    if result then
      aChar := PWideChar(aString)[aIndex - 1];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.MatchesAny(const aString: UnicodeString;
                                         aValues: array of UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := IndexOf(aString, aValues, aCaseMode) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.MatchesAnyText(const aString: UnicodeString;
                                             aValues: array of UnicodeString): Boolean;
  begin
    result := IndexOf(aString, aValues, csIgnoreCase) <> -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IIf(      aValue: Boolean;
                            const aWhenTrue: UnicodeString;
                            const aWhenFalse: UnicodeString): UnicodeString;
  begin
    if aValue then
      result := aWhenTrue
    else
      result := aWhenFalse;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IndexOf(const aString: UnicodeString;
                                      aValues: array of UnicodeString;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    for result := 0 to High(aValues) do
      if Wide.SameString(aString, aValues[result], aCaseMode) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IndexOfText(const aString: UnicodeString;
                                          aValues: array of UnicodeString): Integer;
  begin
    for result := 0 to High(aValues) do
      if Wide.SameText(aString, aValues[result]) then
        EXIT;

    result := -1;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Reverse(const aString: UnicodeString): UnicodeString;
  var
    i, strLen: Integer;
    c: WideChar;
    pc, prc: PWideChar;
    loSurrogate: Boolean;
  begin
    if IsEmpty(aString, strLen) then
      EXIT;

    result  := aString;
    pc      := PWideChar(result);
    prc     := @result[strLen];

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
  class function WideFn.Encode(const aString: String): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := aString;
  {$else}
    result := FromAnsi(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromString(const aString: String): UnicodeString;
  begin
  {$ifdef UNICODE}
    result := aString;
  {$else}
    result := FromAnsi(aString);
  {$endif}
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromAnsi(const aChar: AnsiChar): WideChar;
  begin
    result := Unicode.AnsiCharToWide(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromAnsi(const aString: AnsiString): UnicodeString;
  begin
    result := FromAnsi(PAnsiChar(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromAnsi(aBuffer: PAnsiChar;
                                 aMaxLen: Integer): UnicodeString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) or (aBuffer = NIL)  then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := Ansi.Len(PAnsiChar(aBuffer));
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
  class function WideFn.FromUtf8(aBuffer: PUtf8Char;
                                 aMaxLen: Integer): UnicodeString;
  var
    len: Integer;
  begin
    result := '';
    if (aMaxLen = 0) or (aBuffer = NIL) then
      EXIT;

    if (aMaxLen > 0) then
    begin
      len := AnsiFn.Len(PAnsiChar(aBuffer));
      if len < aMaxLen then
        aMaxLen := len;
    end
    else
      aMaxLen := -1;

    len := MultiByteToWideChar(CP_Utf8, 0, PAnsiChar(aBuffer), aMaxLen, NIL, 0);

    // If aMaxLen is -1 then the reported length INCLUDES the null terminator
    //  which is automatically part of result

    if (aMaxLen = -1) then
      Dec(len);

    SetLength(result, len);
    MultiByteToWideChar(CP_Utf8, 0, PAnsiChar(aBuffer), aMaxLen, @result[1], len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromUtf8(const aString: Utf8String): UnicodeString;
  begin
    result := FromUtf8(PUtf8Char(aString), System.Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromWide(aBuffer: PWideChar;
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
  class function WideFn.AllocUtf8(const aSource: UnicodeString): PUtf8Char;
  var
    len: Integer;
    s: Utf8String;
  begin
    s := Utf8.FromWide(aSource);

    len     := Length(s) + 1;
    result  := AllocMem(len);

    CopyMemory(result, PUtf8Char(s), len);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Len(aBuffer: PWideChar): Integer;
  {$ifdef UNICODE}
    begin
      result := SysUtils.StrLen(aBuffer);
    end;
  {$else}
    var
      p: PWideChar;
    begin
      p := aBuffer;
      while p^ <> WideChar(0) do
        Inc(p);

      result := (p - aBuffer);
    end;
  {$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.CopyToBuffer(const aString: UnicodeString;
                                            aBuffer: Pointer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.CopyToBuffer(const aString: UnicodeString;
                                            aBuffer: Pointer;
                                            aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, 0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.CopyToBufferOffset(const aString: UnicodeString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer);
  begin
    CopyToBuffer(aString, Length(aString), aBuffer, aByteOffset);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.CopyToBufferOffset(const aString: UnicodeString;
                                                  aBuffer: Pointer;
                                                  aByteOffset: Integer;
                                                  aMaxChars: Integer);
  begin
    CopyToBuffer(aString, aMaxChars, aBuffer, aByteOffset);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromBuffer(aBuffer: PAnsiChar;
                                   aLen: Integer): UnicodeString;
  begin
    result := Wide.FromAnsi(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FromBuffer(aBuffer: PWideChar;
                                   aLen: Integer): UnicodeString;
  begin
    Contract.Requires('aLen', aLen).IsNotLessThan(-1);

    if aLen = -1 then
      aLen := Len(aBuffer);

    SetLength(result, aLen);
    if aLen = 0 then
      EXIT;

    Memory.Copy(aBuffer, aLen, Pointer(result));
    while (result[aLen] = #$0000) do
      SetLength(result, Length(result) - 1);
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Concat(const aArray: array of UnicodeString): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pResult: PWideChar;
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

      pResult := PWideChar(result);
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
          Wide.CopyToBuffer(aArray[i], pResult);
          Inc(pResult, len);
        end;
      end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Concat(const aArray: array of UnicodeString;
                              const aSeparator: UnicodeString): UnicodeString;
  var
    p: PWideChar;

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
        Wide.CopyToBuffer(value, p);
        Inc(p, len);
      end;
    end;

    procedure DoWithChar(const aChar: WideChar);
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

        Wide.CopyToBuffer(aSeparator, p);
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

      p := PWideChar(result);

      case sepLen of
        1 : DoWithChar(aSeparator[1]);
      else
        DoWithString(sepLen);
      end;

      DoValue(High(aArray));
    end;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Format(const aString: UnicodeString;
                               const aArgs: array of const): UnicodeString;
  begin
    result := WideFormat(aString, aArgs);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.StringOf(aChar: AnsiChar;
                                 aCount: Integer): UnicodeString;
  begin
    result := StringOf(FromAnsi(aChar), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.StringOf(aChar: WideChar;
                                 aCount: Integer): UnicodeString;
  var
    i: Integer;
    pc: PWideChar;
  begin
    SetLength(result, aCount);

    pc := PWideCHar(result);

    for i := 1 to aCount do
    begin
      pc^ := aChar;
      Inc(pc);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.StringOf(const aString: UnicodeString;
                                       aCount: Integer): UnicodeString;
  var
    i: Integer;
    chars: Integer;
    bytes: Integer;
    pr: PWideChar;
  begin
    chars := System.Length(aString);
    SetLength(result, chars * aCount);

    bytes := chars * 2;
    pr    := PWideChar(result);

    for i := 1 to aCount do
    begin
      CopyMemory(pr, PWideChar(aString), bytes);
      Inc(pr, chars);
    end;
  end;













  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.BeginsWith(const aString: UnicodeString;
                                         aChar: WideChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PWideChar absolute aString;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;
    Contract.Requires('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

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
  class function WideFn.BeginsWith(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, FromAnsi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.BeginsWith(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    len: Integer;
  begin
    Contract.Requires('aSubString', aSubString).IsNotEmpty;

    len := System.Length(aSubstring);

    result := (len <= System.Length(aString))
          and (CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PWideChar(aString), len,
                              PWideChar(aSubstring), len) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.BeginsWithText(const aString: UnicodeString;
                                             aChar: WideChar): Boolean;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    result := (aString <> '')
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWideChar(aString), 1,
                              @aChar, 1) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.BeginsWithText(const aString: UnicodeString;
                                             aChar: AnsiChar): Boolean;
  begin
    result := BeginsWithText(aString, FromAnsi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.BeginsWithText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  var
    len: Integer;
  begin
    Contract.Requires('aSubString', aSubString).IsNotEmpty;

    len := System.Length(aSubstring);

    result := (len <= System.Length(aString))
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWideChar(aString), len,
                              PWideChar(aSubstring), len) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Contains(const aString: UnicodeString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Contains(const aString: UnicodeString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Contains(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ContainsText(const aString: UnicodeString;
                                           aChar: AnsiChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ContainsText(const aString: UnicodeString;
                                           aChar: WideChar): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aChar, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ContainsText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString): Boolean;
  var
    notUsed: Integer;
  begin
    result := Find(aString, aSubstring, notUsed, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWith(const aString: UnicodeString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, FromAnsi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWith(const aString: UnicodeString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    chars: PWideChar absolute aString;
    len: Integer;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;
    Contract.Requires('aCaseMode', aCaseMode in [csCaseSensitive, csIgnoreCase]);

    result := FALSE;
    if IsEmpty(aString, len) then
      EXIT;

    case aCaseMode of
      csCaseSensitive : result := (chars[len - 1] = aChar);

      csIgnoreCase    : result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                                PWideChar(@chars[len - 1]), 1,
                                                @aChar, 1) = CSTR_EQUAL;
    else
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWith(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    str: PWideChar absolute aString;
    subStr: PWideChar absolute aSubstring;
    len: Integer;
    subLen: Integer;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := FALSE;
    if IsEmpty(aString, len) then
      EXIT;

    result := (subLen <= len)
          and (CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                              PWideChar(@str[len - subLen]), subLen,
                              subStr, subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWithText(const aString: UnicodeString;
                                           aChar: AnsiChar): Boolean;
  begin
    result := EndsWith(aString, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWithText(const aString: UnicodeString;
                                           aChar: WideChar): Boolean;
  begin
    result := EndsWith(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.EndsWithText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString): Boolean;
  var
    str: PWideChar absolute aString;
    subStr: PWideChar absolute aSubstring;
    len: Integer;
    subLen: Integer;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := FALSE;
    if IsEmpty(aString, len) then
      EXIT;

    result := (subLen <= len)
          and (CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                              PWideChar(@str[len - subLen]), subLen,
                              subStr, subLen) = CSTR_EQUAL);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Find(const aString: UnicodeString;
                                   aChar: AnsiChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Find(const aString: UnicodeString;
                                   aChar: WideChar;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Find(const aString: UnicodeString;
                             const aSubstring: UnicodeString;
                             var   aPos: Integer;
                                   aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := 0;
    result  := FindNext(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindText(const aString: UnicodeString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindText(const aString: UnicodeString;
                                       aChar: WideChar;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindText(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer): Boolean;
  begin
    aPos   := 0;
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLast(const aString: UnicodeString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLast(const aString: UnicodeString;
                                       aChar: WideChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLast(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLastText(const aString: UnicodeString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLastText(const aString: UnicodeString;
                                           aChar: WideChar;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindLastText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer): Boolean;
  begin
    aPos    := Length(aString) + 1;
    result  := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindNext(const aString: UnicodeString;
                                       aChar: AnsiChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindNext(aString, FromAnsi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindNext(const aString: UnicodeString;
                                       aChar: WideChar;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    first: PWideChar;
    curr: PWideChar;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    first  := NIL;
    curr   := NIL;
    result := FALSE;
    try
      if aPos < 1 then
        aPos := 1;

      if  (IsEmpty(aString, len))
       or (aPos >= len) then
        EXIT;

      first := PWideChar(aString);
      curr  := @aString[aPos - 1];
      Dec(len, aPos - 1);

      if (aCaseMode = csCaseSensitive) or (NOT Wide.IsAlpha(aChar)) then
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
  class function WideFn.FindNext(const aString: UnicodeString;
                                 const aSubstring: UnicodeString;
                                 var   aPos: Integer;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PWideChar;
    curr: PWideChar;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if aPos < 0 then
        aPos := 0;

      if  (IsEmpty(aString, strLen))
       or (aPos + subLen > strLen) then
        EXIT;

      first := PWideChar(aString);
      curr  := @aString[aPos];
      Dec(strLen, subLen - 1);

      for i := aPos to strLen do
      begin
        result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PWideChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function WideFn.FindNextText(const aString: UnicodeString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindNextText(const aString: UnicodeString;
                                           aChar: WideChar;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindNextText(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer): Boolean;
  begin
    result := FindNext(aString, aSubstring, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindPrevious(const aString: UnicodeString;
                                           aChar: AnsiChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := FindPrevious(aString, FromAnsi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindPrevious(const aString: UnicodeString;
                                           aChar: WideChar;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    len: Integer;
    pos: Integer;
    first: PWideChar;
    curr: PWideChar;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if (aPos < 1) or IsEmpty(aString, len) then
        EXIT;

      pos   := Min(aPos, len + 1);
      first := PWideChar(aString);
      curr  := @aString[aPos - 1];
      len   := pos - 1;

      if (aCaseMode = csCaseSensitive) or (NOT Wide.IsAlpha(aChar)) then
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
  class function WideFn.FindPrevious(const aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                     var   aPos: Integer;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    strLen: Integer;
    subLen: Integer;
    first: PWideChar;
    curr: PWideChar;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    curr   := NIL;
    first  := NIL;
    result := FALSE;
    try
      if  (aPos < 1)
       or (IsEmpty(aString, strLen)) then
        EXIT;

      aPos  := Min(aPos - 1, strLen - subLen + 1);
      first := PWideChar(aString);
      curr  := @aString[aPos - 1];

      for i := 1 to aPos do
      begin
        result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                                 curr, subLen,
                                 PWideChar(aSubstring), subLen) = CSTR_EQUAL;
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
  class function WideFn.FindPreviousText(const aString: UnicodeString;
                                               aChar: AnsiChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindPreviousText(const aString: UnicodeString;
                                               aChar: WideChar;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindPreviousText(const aString: UnicodeString;
                                         const aSubstring: UnicodeString;
                                         var   aPos: Integer): Boolean;
  begin
    result := FindPrevious(aString, aSubstring, aPos, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindAll(const aString: UnicodeString;
                                      aChar: AnsiChar;
                                var   aPos: CharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := FindAll(aString, FromAnsi(aChar), aPos, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindAll(const aString: UnicodeString;
                                      aChar: WideChar;
                                var   aPos: CharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    len: Integer;
    firstChar: PWideChar;
    currChar: PWideChar;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    result := 0;
    SetLength(aPos, 0);

    if IsEmpty(aString, len) then
      EXIT;

    SetLength(aPos, len);
    firstChar := PWideChar(aString);
    currChar  := firstChar;

    if (aCaseMode = csCaseSensitive) or (NOT Wide.IsAlpha(aChar)) then
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
  class function WideFn.FindAll(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                var   aPos: CharIndexArray;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    currChar: PWideChar;
    firstChar: PWideChar;
    pstr: PWideChar;
    strLen: Integer;
    subLen: Integer;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := 0;
    SetLength(aPos, 0);

    strLen  := System.Length(aString);
    if (strLen = 0) or (subLen > strLen)then
      EXIT;

    SetLength(aPos, strLen);
    pstr      := PWideChar(aSubstring);
    firstChar := PWideChar(aString);
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
  class function WideFn.FindAllText(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                    var   aPos: CharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindAllText(const aString: UnicodeString;
                                          aChar: WideChar;
                                    var   aPos: CharIndexArray): Integer;
  begin
    result := FindAll(aString, aChar, aPos, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.FindAllText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    var   aPos: CharIndexArray): Integer;
  begin
    result := FindAll(aString, aSubstring, aPos, csIgnoreCase);
  end;















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.AsArray(const aItems: array of UnicodeString): UnicodeStringArray;
  var
    i: Integer;
  begin
    SetLength(result, Length(aItems));
    for i := 0 to High(aItems) do
      result[i] := aItems[i];
  end;















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsAlpha(aChar: WideChar): Boolean;
  begin
    result := IsCharAlphaW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsAlpha(const aString: UnicodeString): Boolean;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if IsEmpty(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaW(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsAlphaNumeric(aChar: WideChar): Boolean;
  begin
    result := IsCharAlphaNumericW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsAlphaNumeric(const aString: UnicodeString): Boolean;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    len: Integer;
  begin
    result := FALSE;

    if IsEmpty(aString, len) then
      EXIT;

    for i := 0 to Pred(len) do
      if NOT IsCharAlphaNumericW(chars[i]) then
        EXIT;

    result := TRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsHiSurrogate(const aChar: WideChar): Boolean;
  begin
    result := (aChar >= MIN_HiSurrogate) and (aChar <= MAX_HiSurrogate);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsLoSurrogate(const aChar: WideChar): Boolean;
  begin
    result := (aChar >= MIN_LoSurrogate) and (aChar <= MAX_LoSurrogate);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsLowercase(const aChar: WideChar): Boolean;
  begin
    result := IsCharLowerW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsLowercase(const aString: UnicodeString): Boolean;
  begin
    result := CheckCase(aString, IsCharLowerW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsNull(aChar: WideChar): Boolean;
  begin
    result := aChar = WideChar(#0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsNumeric(aChar: WideChar): Boolean;
  begin
    result := IsCharAlphaNumericW(aChar) and NOT IsCharAlphaW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsNumeric(const aString: UnicodeString): Boolean;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    len: Integer;
    hasDP: Boolean;
    signAllowed: Boolean;
    digitExpected: Boolean;
    digitRequired: Boolean;
  begin
    result := FALSE;

    if IsEmpty(aString, len) then
      EXIT;

    hasDP         := FALSE;
    digitRequired := TRUE;
    digitExpected := FALSE;
    signAllowed   := TRUE;

    for i := 0 to Pred(len) do
    begin
      case chars[i] of
        '.' : if digitExpected or hasDP then
                EXIT
              else
              begin
                hasDP         := TRUE;
                digitExpected := TRUE;
              end;

        '+', '-'  : if digitExpected or NOT signAllowed then
                      EXIT
                    else
                    begin
                      signAllowed   := FALSE;
                      digitExpected := TRUE;
                      digitRequired := TRUE;
                    end;

        'e', 'E'  : if digitExpected then
                      EXIT
                    else
                    begin
                      signAllowed   := TRUE;
                      digitRequired := TRUE;
                    end;

        '0'..'9'  : begin
                      digitExpected := FALSE;
                      digitRequired := FALSE;
                      signAllowed   := FALSE;
                    end;
      else
        EXIT;
      end;
    end;

    result := NOT digitRequired;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsSurrogate(const aChar: WideChar): Boolean;
  begin
    result := IsHiSurrogate(aChar) or IsLoSurrogate(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsUppercase(const aChar: WideChar): Boolean;
  begin
    result := IsCharUpperW(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.IsUppercase(const aString: UnicodeString): Boolean;
  begin
    result := CheckCase(aString, IsCharUpperW);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.NotEmpty(const aString: UnicodeString): Boolean;
  begin
    result := (aString <> '');
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Compare(const A, B: UnicodeString;
                                      aCaseMode: TCaseSensitivity): TCompareResult;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PWideChar(A), Length(A),
                             PWideChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CompareText(const A, B: UnicodeString): TCompareResult;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PWideChar(A), Length(A),
                             PWideChar(B), Length(B)) - CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.SameString(const A, B: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, CASEMODE_FLAG[aCaseMode],
                             PWideChar(A), Length(A),
                             PWideChar(B), Length(B)) = CSTR_EQUAL;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.SameText(const A, B: UnicodeString): Boolean;
  begin
    result := CompareStringW(LOCALE_USER_DEFAULT, NORM_IGNORECASE,
                             PWideChar(A), Length(A),
                             PWideChar(B), Length(B)) = CSTR_EQUAL;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Append(const aString: UnicodeString;
                                     aChar: AnsiChar): UnicodeString;
  begin
    result := aString;
    SetLength(result, Length(result) + 1);
    result[Length(result)] := FromAnsi(aChar);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Append(const aString: UnicodeString;
                                     aChar: WideChar): UnicodeString;
  begin
    Contract.Requires('aChar', aChar).IsNotSurrogate;

    result := aString;
    SetLength(result, Length(result) + 1);
    result[Length(result)] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Append(const aString, aSuffix: UnicodeString): UnicodeString;
  var
    orgLen: Integer;
    sfxlen: Integer;
  begin
    if IsEmpty(aString, orgLen) then
    begin
      result := aSuffix;
      EXIT;
    end;

    result := aString;

    if IsNotEmpty(aSuffix, sfxLen) then
    begin
      SetLength(result, orgLen + sfxlen);
      FastCopy(aSuffix, result, orgLen + 1);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Append(const aString: UnicodeString;
                               const aSuffix: UnicodeString;
                                     aSeparator: AnsiChar): UnicodeString;
  begin
    result := Append(aString, aSuffix, FromAnsi(aSeparator));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Append(const aString: UnicodeString;
                               const aSuffix: UnicodeString;
                                     aSeparator: WideChar): UnicodeString;
  var
    orgLen: Integer;
    sfxLen: Integer;
  begin
    Contract.Requires('aSeparator', aSeparator).IsNotNull;

    if IsEmpty(aString, orgLen) then
    begin
      result := aSuffix;
      EXIT;
    end;

    result := aString;

    if IsNotEmpty(aSuffix, sfxlen) then
    begin
      SetLength(result, orgLen + sfxLen + 1);

      PWideChar(result)[orgLen] := aSeparator;

      FastCopy(aSuffix, result, orgLen + 2);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
   class function WideFn.Append(const aString: UnicodeString;
                                const aSuffix: UnicodeString;
                                const aSeparator: UnicodeString): UnicodeString;
  var
    orgLen: Integer;
    sepLen: Integer;
    sfxLen: Integer;
  begin
    if IsEmpty(aString, orgLen) then
    begin
      result := aSuffix;
      EXIT;
    end;

    result := aString;

    if IsEmpty(aSuffix, sfxlen) then
      EXIT;

    if IsNotEmpty(aSeparator, sepLen) then
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


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                                     aChar: AnsiChar): UnicodeString;
  begin
    result := Insert(aString, aPos, FromAnsi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Insert(const aString: UnicodeString;
                                     aPos: Integer;
                                     aChar: WideChar): UnicodeString;
  var
    strLen: Integer;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    result := aString;

    if  IsEmpty(aString, strLen)
     or NOT HasIndex(aString, aPos) then
      EXIT;

    SetLength(result, strLen + 1);

    if aPos < strLen then
      FastMove(result, aPos, aPos + 1, strLen - aPos + 1);

    result[aPos] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Insert(const aString: UnicodeString;
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
    Wide.CopyToBuffer(aInfix, ifxlen, Pointer(result), bufPos * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Insert(const aString: UnicodeString;
                                    aPos: Integer;
                              const aInfix: UnicodeString;
                                    aSeparator: WideChar): UnicodeString;
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
    Wide.CopyToBuffer(aInfix, ifxLen, Pointer(result), aPos * 2);

    result[aPos]              := aSeparator;
    result[aPos + ifxLen + 1] := aSeparator;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Insert(const aString: UnicodeString;
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

    if IsNotEmpty(aSeparator, sepLen) then
    begin
      SetLength(result, strLen + ifxLen + (2 * sepLen));

      bufPos := Pred(aPos);

      // Shift the previous end of the string to make room for the infix
      Utils.CopyChars(result, bufPos, bufPos + ifxLen + (2 * sepLen), strLen - aPos + 1);

      // Copy the infix into the space left by shifting the previous end of the string
      Wide.CopyToBuffer(aInfix, ifxLen, Pointer(result), (bufPos + sepLen) * 2);

      // Copy the separator into the space either side of the infix
      Wide.CopyToBuffer(aSeparator, sepLen, Pointer(result), bufPos * 2);
      Wide.CopyToBuffer(aSeparator, sepLen, Pointer(result), (bufPos + ifxLen + sepLen) * 2);
    end
    else
      result := Insert(aString, aPos, aInfix);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Prepend(const aString: UnicodeString;
                                      aChar: AnsiChar): UnicodeString;
  begin
    result := Prepend(aString, FromAnsi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Prepend(const aString: UnicodeString;
                                      aChar: WideChar): UnicodeString;
  var
    dest: PWideChar absolute result;
    strLen: Integer;
  begin
    Contract.Requires('aChar', aChar).IsNotNull;

    if IsNotEmpty(aString, strLen) then
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
  class function WideFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString): UnicodeString;
  var
    strLen: Integer;
    pfxLen: Integer;
  begin
    if IsNotEmpty(aString, strLen) then
    begin
      result := aString;

      if IsNotEmpty(aPrefix, pfxLen) then
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
  class function WideFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                      aSeparator: AnsiChar): UnicodeString;
  begin
    result := Prepend(aString, aPrefix, FromAnsi(aSeparator));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                      aSeparator: WideChar): UnicodeString;
  var
    dest: PWideChar absolute result;
    strLen: Integer;
    pfxLen: Integer;
  begin
    if IsNotEmpty(aString, strLen) then
    begin
      result := aString;

      if IsNotEmpty(aPrefix, pfxLen) then
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
  class function WideFn.Prepend(const aString: UnicodeString;
                                const aPrefix: UnicodeString;
                                const aSeparator: UnicodeString): UnicodeString;
  var
    strLen: Integer;
    pfxLen: Integer;
    sepLen: Integer;
  begin
    if IsNotEmpty(aString, strLen) then
    begin
      result := aString;

      if IsEmpty(aPrefix, pfxLen) then
        EXIT;

      if IsNotEmpty(aSeparator, sepLen) then
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
  class function WideFn.Embrace(const aString: UnicodeString;
                                      aBrace: AnsiChar): UnicodeString;
  begin
    result := Embrace(aString, FromAnsi(aBrace));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Embrace(const aString: UnicodeString;
                                      aBrace: WideChar): UnicodeString;
  var
    strLen: Integer;
  begin
    Contract.Requires('aBrace', aBrace).IsNotSurrogate;

    if IsNotEmpty(aString, strLen) then
    begin
      SetLength(result, strLen + 2);
      FastCopy(aString, result, 2);
    end
    else
      SetLength(result, 2);

    PWideCHar(result)[0] := aBrace;

    case aBrace of
      '(' : PWideChar(result)[strLen + 1] := WideChar(')');
      '{' : PWideChar(result)[strLen + 1] := WideChar('}');
      '[' : PWideChar(result)[strLen + 1] := WideChar(']');
      '<' : PWideChar(result)[strLen + 1] := WideChar('>');
    else
      PWideChar(result)[strLen + 1] := aBrace;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Enquote(const aString: UnicodeString;
                                      aQuote: AnsiChar): UnicodeString;
  begin
    result := Enquote(aString, FromAnsi(aQuote), FromAnsi(aQuote));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Enquote(const aString: UnicodeString;
                                      aQuote: WideChar;
                                      aEscape: WideChar): UnicodeString;
  var
    i, j: Integer;
    strlen: Integer;
    pc: PWideChar;
  begin
    strlen := System.Length(aString);
    SetLength(result, (strlen * 2) + 2);

    j := 2;

    if strlen > 0 then
    begin
      pc  := PWideChar(aString);
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
  class function WideFn.PadLeft(const aString: UnicodeString;
                                      aLength: Integer;
                                      aChar: AnsiChar): UnicodeString;
  begin
    result := PadLeft(aString, aLength, FromAnsi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.PadLeft(const aString: UnicodeString;
                                      aLength: Integer;
                                      aChar: WideChar): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PWideChar;
  begin
    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
    begin
      result := aString;
      EXIT;
    end;

    SetLength(result, aLength);

    p := PWideChar(result);
    for i := 0 to Pred(pad) do
      p[i] := aChar;

    Inc(p, pad);
    FastCopy(aString, p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.PadRight(const aString: UnicodeString;
                                       aLength: Integer;
                                       aChar: AnsiChar): UnicodeString;
  begin
    result := PadRight(aString, aLength, FromAnsi(aChar));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.PadRight(const aString: UnicodeString;
                                       aLength: Integer;
                                       aChar: WideChar): UnicodeString;
  var
    i: Integer;
    len: Integer;
    pad: Integer;
    p: PWideChar;
  begin
    result := aString;

    len := Length(aString);
    pad := aLength - len;

    if pad <= 0 then
      EXIT;

    SetLength(result, aLength);

    p := PWideChar(result);
    Inc(p, len);

    for i := 0 to Pred(pad) do
      p[i] := aChar;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Split(const aString: UnicodeString;
                              const aChar: AnsiChar;
                              var   aLeft, aRight: UnicodeString): Boolean;
  begin
    result := Split(aString, FromAnsi(aChar), aLeft, aRight);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Split(const aString: UnicodeString;
                              const aChar: WideChar;
                              var   aLeft, aRight: UnicodeString): Boolean;
  var
    p: Integer;
    source: UnicodeString;
  begin
    Contract.Requires('aChar', aChar).IsNotSurrogate;

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
  class function WideFn.Split(const aString: UnicodeString;
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
  class function WideFn.Split(const aString: UnicodeString;
                              const aChar: AnsiChar;
                              var   aParts: UnicodeStringArray): Integer;
  begin
     result := Split(aString, FromAnsi(aChar), aParts);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Split(const aString: UnicodeString;
                              const aChar: WideChar;
                              var   aParts: UnicodeStringArray): Integer;
  var
    i: Integer;
    p: CharIndexArray;
    plen: Integer;
  begin
    Contract.Requires('aChar', aChar).IsNotSurrogate;

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
  class function WideFn.Split(const aString: UnicodeString;
                              const aDelim: UnicodeString;
                              var   aParts: UnicodeStringArray): Integer;
  var
    i: Integer;
    p: CharIndexArray;
    plen, delimLen: Integer;
  begin
    Contract.Requires('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);

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


{$ifdef UNICODE}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Split(const aString: String;
                              const aDelim: String;
                              var   aParts: StringArray): Integer;
  var
    i: Integer;
    p: CharIndexArray;
    plen, delimLen: Integer;
  begin
    Contract.Requires('aDelim', aDelim).IsNotEmpty.GetLength(delimLen);

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
{$endif}










  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.Delete(var aString: UnicodeString;
                                    aIndex: Integer);
  begin
    Contract.Requires('aIndex', aIndex).IsValidIndexFor(aString);

    case WhenLoSurrogate(aString, aIndex + 1, saDelete) of
      saDelete : System.Delete(aString, aIndex, 2);
      saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex + 1]);
    else
      case WhenHiSurrogate(aString, aIndex - 1, saDelete) of
        saDelete : System.Delete(aString, aIndex - 1, 2);
        saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
      else
        System.Delete(aString, aIndex, 1);
      end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.Delete(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer);
  begin
    Contract.Requires('aIndex', aIndex).IsValidIndexFor(aString);
    Contract.Requires('aLength', aLength).IsPositiveOrZero;

    case aLength of
      0 : { NO-OP };
      1 : Delete(aString, aIndex);
    else
      case WhenLoSurrogate(aString, aIndex, saDelete) of
        saDelete : Dec(aIndex);
        saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
      end;

      case WhenHiSurrogate(aString, aIndex + aLength - 1, saDelete) of
        saDelete : Inc(aLength);
        saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex + aLength]);
      end;

      System.Delete(aString, aIndex, aLength);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.DeleteRange(var aString: UnicodeString;
                                         aIndex: Integer;
                                         aEndIndex: Integer);
  begin
    Contract.Requires('aIndex', aIndex).IsValidIndexFor(aString);
    Contract.Requires('aEndIndex', aEndIndex).IsValidIndexFor(aString);

    if aIndex > aEndIndex then
      Exchange(aIndex, aEndIndex);

    case WhenLoSurrogate(aString, aIndex, saDelete) of
      saDelete : Dec(aIndex);
      saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aIndex - 1]);
    end;

    case WhenHiSurrogate(aString, aEndIndex, saDelete) of
      saDelete : Inc(aEndIndex);
      saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aEndIndex + 1]);
    end;

    System.Delete(aString, aIndex, aEndIndex - aIndex + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Delete(var aString: UnicodeString;
                                   aChar: AnsiChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, FromAnsi(aChar), idx, aCaseMode);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Delete(var aString: UnicodeString;
                                   aChar: WideChar;
                                   aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Delete(var   aString: UnicodeString;
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
  class function WideFn.DeleteText(var aString: UnicodeString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, FromAnsi(aChar), idx, csIgnoreCase);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteText(var aString: UnicodeString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := Find(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteText(var   aString: UnicodeString;
                                   const aSubstring: UnicodeString): Boolean;
  begin
    result := Delete(aString, aSubstring, csIgnoreCase);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteAll(var   aString: UnicodeString;
                                  const aSubstring: UnicodeString;
                                        aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    idx: CharIndexArray;
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
  class function WideFn.DeleteAll(var aString: UnicodeString;
                                      aChar: AnsiChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  var
    i: Integer;
    idx: CharIndexArray;
  begin
    result := FindAll(aString, FromAnsi(aChar), idx, aCaseMode);
    if result = 0 then
      EXIT;

    for i := 0 to Pred(Length(idx)) do
      Delete(aString, idx[i] - i, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteAll(var aString: UnicodeString;
                                      aChar: WideChar;
                                      aCaseMode: TCaseSensitivity): Integer;
  begin
    result := DeleteAll(aString, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteAllText(var aString: UnicodeString;
                                          aChar: AnsiChar): Integer;
  begin
    result := DeleteAll(aString, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteAllText(var aString: UnicodeString;
                                          aChar: WideChar): Integer;
  begin
    result := DeleteAll(aString, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteAllText(var   aString: UnicodeString;
                                      const aSubstring: UnicodeString): Integer;
  begin
    result := DeleteAll(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLast(var aString: UnicodeString;
                                       aChar: AnsiChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, FromAnsi(aChar), idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLast(var aString: UnicodeString;
                                       aChar: WideChar;
                                       aCaseMode: TCaseSensitivity): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, aCaseMode);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLast(var   aString: UnicodeString;
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
  class function WideFn.DeleteLastText(var aString: UnicodeString;
                                           aChar: AnsiChar): Boolean;
  begin
    result := Delete(aString, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLastText(var aString: UnicodeString;
                                           aChar: WideChar): Boolean;
  var
    idx: Integer;
  begin
    result := FindLast(aString, aChar, idx, csIgnoreCase);
    if result then
      Delete(aString, idx, 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLastText(var   aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  var
    pos: Integer;
  begin
    result := FindLast(aString, aSubstring, pos, csIgnoreCase);
    if result then
      System.Delete(aString, pos, Length(aSubstring));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.DeleteLeft(var aString: UnicodeString;
                                        aCount: Integer);
  var
    len: Integer;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    if (aCount <= 0) or IsEmpty(aString, len) then
      EXIT;

    Dec(len, aCount);

    if len > 0 then
    begin
      case WhenLoSurrogate(PWideChar(aString)[aCount], saDelete) of
        saIgnore  : System.Delete(aString, 1, aCount);
        saDelete   : System.Delete(aString, 1, aCount + 1);
        saError   : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [aCount + 1]);
      end;
    end
    else
      aString := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLeft(var   aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteLeft(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteLeftText(var   aString: UnicodeString;
                                       const aSubstring: UnicodeString): Boolean;
  begin
    result := DeleteLeft(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure WideFn.DeleteRight(var aString: UnicodeString;
                                         aCount: Integer);
  var
    len: Integer;
  begin
    if (aCount <= 0) or IsEmpty(aString, len) then
      EXIT;

    SetLength(aString, len - aCount);

    case WhenHiSurrogate(aString, len, saDelete) of
      saDelete : SetLength(aString, len - 1);
      saError : raise EUnicodeOrphanSurrogate.CreateFmt(ERRFMT_ORPHAN_DELETIONLEAVES_N, [len - 1]);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteRight(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := EndsWith(aString, aSubstring, aCaseMode);
    if result then
      DeleteRight(aString, Length(aSubstring));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.DeleteRightText(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString): Boolean;
  begin
    result := DeleteRight(aString, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Remove(const aString: UnicodeString;
                                     aIndex: Integer;
                                     aLength: Integer): UnicodeString;
  begin
    result := aString;
    System.Delete(result, aIndex, aLength);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Remove(const aString: UnicodeString;
                                     aChar: AnsiChar;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, FromAnsi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Remove(const aString: UnicodeString;
                                     aChar: WideChar;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Remove(const aString, aSubstring: UnicodeString;
                                     aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    Delete(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveText(const aString: UnicodeString;
                                         aChar: AnsiChar): UnicodeString;
  begin
    result := aString;
    Delete(result, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveText(const aString: UnicodeString;
                                         aChar: WideChar): UnicodeString;
  begin
    result := aString;
    Delete(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    Delete(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAll(const aString, aSubstring: UnicodeString;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAll(const aString: UnicodeString;
                                        aChar: AnsiChar;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, FromAnsi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAll(const aString: UnicodeString;
                                        aChar: WideChar;
                                        aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAllText(const aString: UnicodeString;
                                            aChar: AnsiChar): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAllText(const aString: UnicodeString;
                                            aChar: WideChar): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveAllText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    DeleteAll(result, aSubstring, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLast(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, FromAnsi(aChar), aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLast(const aString: UnicodeString;
                                         aChar: WideChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLast(const aString, aSubstring: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLastText(const aString: UnicodeString;
                                             aChar: AnsiChar): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, FromAnsi(aChar), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLastText(const aString: UnicodeString;
                                             aChar: WideChar): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aChar, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RemoveLastText(const aString, aSubstring: UnicodeString): UnicodeString;
  begin
    result := aString;
    DeleteLast(result, aSubstring, csIgnoreCase);
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Extract(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer): UnicodeString;
  begin
    if NOT Extract(aString, aIndex, aLength, result) then
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Extract(var aString: UnicodeString;
                                    aIndex: Integer;
                                    aLength: Integer;
                                var aExtract: UnicodeString): Boolean;
  var
    strLen: Integer;
  begin
    Contract.Requires('aLength', aLength).IsPositiveOrZero;

    aExtract := '';
    result   := FALSE;

    if  (aLength = 0)
     or IsEmpty(aString, strLen) then
      EXIT;

    Contract.Requires('aIndex', aIndex).IsValidIndexFor(aString);
    Contract.Requires('aIndex + aLength - 1', aIndex + aLength - 1).IsValidIndexFor(aString);

    aExtract := self.Copy(aString, aIndex, aLength);
    Delete(aString, aIndex, aLength);

    result := NOT IsEmpty(aExtract);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var aString: UnicodeString;
                                        aCount: Integer): UnicodeString;
  begin
    ExtractLeft(aString, aCount, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var aString: UnicodeString;
                                        aCount: Integer;
                                    var aExtract: UnicodeString): Boolean;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    aExtract  := System.Copy(aString, 1, aCount);
    result    := NOT IsEmpty(aExtract);

    if result then
      System.Delete(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: WideChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: AnsiChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, FromAnsi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var   aString: UnicodeString;
                                    const aDelimiter: UnicodeString;
                                          aDelimiterOption: TExtractDelimiterOption;
                                          aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: WideChar;
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
  class function WideFn.ExtractLeft(var  aString: UnicodeString;
                                         aDelimiter: AnsiChar;
                                    var  aExtract: UnicodeString;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractLeft(aString, FromAnsi(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeft(var   aString: UnicodeString;
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
  class function WideFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: WideChar;
                                             aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: AnsiChar;
                                             aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, FromAnsi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeftText(var   aString: UnicodeString;
                                        const aDelimiter: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: WideChar;
                                        var  aExtract: UnicodeString;
                                             aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeftText(var  aString: UnicodeString;
                                             aDelimiter: AnsiChar;
                                        var  aExtract: UnicodeString;
                                             aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, FromAnsi(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractLeftText(var   aString: UnicodeString;
                                        const aDelimiter: UnicodeString;
                                        var   aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractLeft(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractQuotedValue(var   aString: UnicodeString;
                                           const aDelimiter: WideChar): UnicodeString;
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
  class function WideFn.ExtractRight(var aString: UnicodeString; aCount: Integer): UnicodeString;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    SetLength(aString, Length(aString) - aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var aString: UnicodeString;
                                         aCount: Integer;
                                     var aExtract: UnicodeString): Boolean;
  begin
    aExtract := ExtractRight(aString, aCount);
    result   := (aExtract <> '');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightFrom(var aString: UnicodeString;
                                             aIndex: Integer): UnicodeString;
  begin
    ExtractRightFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightFrom(var aString: UnicodeString;
                                             aIndex: Integer;
                                         var aExtract: UnicodeString): Boolean;
  var
    strLen: Integer;
  begin
    Contract.Requires('aIndex', aIndex).IsPositiveOrZero;

    result := IsNotEmpty(aString, strLen) and (aIndex < strLen);
    if result then
    begin
      aExtract := System.Copy(aString, aIndex + 1, strLen - aIndex);
      SetLength(aString, aIndex);
    end
    else
      aExtract := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var aString: UnicodeString;
                                         aDelimiter: WideChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var aString: UnicodeString;
                                         aDelimiter: AnsiChar;
                                         aDelimiterOption: TExtractDelimiterOption;
                                         aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, FromAnsi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var   aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                           aDelimiterOption: TExtractDelimiterOption;
                                           aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var  aString: UnicodeString;
                                          aDelimiter: WideChar;
                                     var  aExtract: UnicodeString;
                                          aDelimiterOption: TExtractDelimiterOption;
                                          aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
    strLen: Integer;
  begin
    result := IsNotEmpty(aString, strLen)
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
  class function WideFn.ExtractRight(var  aString: UnicodeString;
                                          aDelimiter: AnsiChar;
                                     var  aExtract: UnicodeString;
                                          aDelimiterOption: TExtractDelimiterOption;
                                          aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := ExtractRight(aString, FromAnsi(aDelimiter), aExtract, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRight(var   aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                     var   aExtract: UnicodeString;
                                           aDelimiterOption: TExtractDelimiterOption;
                                           aDelimiterCase: TCaseSensitivity): Boolean;
  var
    pos: Integer;
    strLen, delimLen: Integer;
  begin
    result := IsNotEmpty(aString, strLen)
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
  class function WideFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: WideChar;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: AnsiChar;
                                              aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, FromAnsi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightText(var   aString: UnicodeString;
                                         const aDelimiter: UnicodeString;
                                               aDelimiterOption: TExtractDelimiterOption): UnicodeString;
  begin
    ExtractRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: WideChar;
                                         var  aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightText(var  aString: UnicodeString;
                                              aDelimiter: AnsiChar;
                                         var  aExtract: UnicodeString;
                                              aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, FromAnsi(aDelimiter), aExtract, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ExtractRightText(var   aString: UnicodeString;
                                         const aDelimiter: UnicodeString;
                                         var   aExtract: UnicodeString;
                                               aDelimiterOption: TExtractDelimiterOption): Boolean;
  begin
    result := ExtractRight(aString, aDelimiter, aExtract, aDelimiterOption, csIgnoreCase);
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ConsumeLeft(var   aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen: Integer;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := BeginsWith(aString, aSubstring, aCaseMode);
    if result then
      System.Delete(aString, 1, subLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ConsumeRight(var   aString: UnicodeString;
                                     const aSubstring: UnicodeString;
                                           aCaseMode: TCaseSensitivity): Boolean;
  var
    subLen, strLen: Integer;
  begin
    Contract.Requires('aSubstring', aSubstring).IsNotEmpty.GetLength(subLen);

    result := IsNotEmpty(aString, strLen)
          and EndsWith(aString, aSubstring, aCaseMode);

    if result and (strLen > 0) then
      SetLength(aString, strLen - subLen);
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Copy(const aString: UnicodeString;
                                   aStartPos, aLength: Integer): UnicodeString;
  begin
    Copy(aString, aStartPos, aLength, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Copy(const aString: UnicodeString;
                                   aStartPos, aLength: Integer;
                             var   aCopy: UnicodeString): Boolean;
  begin
    Contract.Requires('aStartPos', aStartPos).IsGreaterThan(0);

    aCopy   := System.Copy(aString, aStartPos, aLength);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyFrom(const aString: UnicodeString;
                                       aIndex: Integer): UnicodeString;
  begin
    CopyFrom(aString, aIndex, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyFrom(const aString: UnicodeString;
                                       aIndex: Integer;
                                 var   aCopy: UnicodeString): Boolean;
  begin
    Contract.Requires('aIndex', aIndex).IsGreaterThan(0);

    aCopy   := System.Copy(aString, aIndex, Length(aString) - aIndex + 1);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRange(const aString: UnicodeString;
                                        aStartPos: Integer;
                                        aEndPos: Integer): UnicodeString;
  begin
    CopyRange(aString, aStartPos, aEndPos, result);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRange(const aString: UnicodeString;
                                        aStartPos: Integer;
                                        aEndPos: Integer;
                                  var   aCopy: UnicodeString): Boolean;
  begin
    Contract.Requires('aStartPos', aStartPos).IsGreaterThan(0);
    Contract.Requires('aEndPos', aEndPos).IsGreaterThanOrEqual(aStartPos, 'aStartPos');

    if (aStartPos = aEndPos) then
      aCopy := ''
    else
      aCopy   := System.Copy(aString, aStartPos, aEndPos - aStartPos + 1);

    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                       aCount: Integer): UnicodeString;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                    aDelimiter: AnsiChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, FromAnsi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                    aDelimiter: WideChar;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                              const aDelimiter: UnicodeString;
                                    aDelimiterOption: TCopyDelimiterOption;
                                    aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                    aCount: Integer;
                              var   aCopy: UnicodeString): Boolean;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                       aDelimiter: AnsiChar;
                                 var   aCopy: UnicodeString;
                                       aDelimiterOption: TCopyDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyLeft(aString, FromAnsi(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                       aDelimiter: WideChar;
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
  class function WideFn.CopyLeft(const aString: UnicodeString;
                                 const aDelimiter: UnicodeString;
                                 var   aCopy: UnicodeString;
                                       aDelimiterOption: TCopyDelimiterOption;
                                       aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p, delimLen: Integer;
  begin
    Contract.Requires('aDelimiter', aDelimiter).IsNotEmpty.GetLength(delimLen);

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
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                        aDelimiter: AnsiChar;
                                        aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                           aDelimiter: WideChar;
                                           aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                           aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyLeft(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                           aDelimiter: AnsiChar;
                                     var   aCopy: UnicodeString;
                                           aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, FromAnsi(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                           aDelimiter: WideChar;
                                     var   aCopy: UnicodeString;
                                           aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyLeftText(const aString: UnicodeString;
                                     const aDelimiter: UnicodeString;
                                     var   aCopy: UnicodeString;
                                           aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyLeft(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aCount: Integer): UnicodeString;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    result := System.Copy(aString, Length(aString) - aCount + 1, aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aDelimiter: AnsiChar;
                                        aDelimiterOption: TCopyDelimiterOption;
                                        aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, FromAnsi(aDelimiter), result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aDelimiter: WideChar;
                                        aDelimiterOption: TCopyDelimiterOption;
                                        aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption;
                                        aDelimiterCase: TCaseSensitivity): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aCount: Integer;
                                  var   aCopy: UnicodeString): Boolean;
  begin
    Contract.Requires('aCount', aCount).IsPositiveOrZero;

    aCopy   := System.Copy(aString, Length(aString) - aCount + 1, aCount);
    result  := Length(aCopy) > 0;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aDelimiter: AnsiChar;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption;
                                        aDelimiterCase: TCaseSensitivity): Boolean;
  begin
    result := CopyRight(aString, FromAnsi(aDelimiter), aCopy, aDelimiterOption, aDelimiterCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRight(const aString: UnicodeString;
                                        aDelimiter: WideChar;
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
  class function WideFn.CopyRight(const aString: UnicodeString;
                                  const aDelimiter: UnicodeString;
                                  var   aCopy: UnicodeString;
                                        aDelimiterOption: TCopyDelimiterOption;
                                        aDelimiterCase: TCaseSensitivity): Boolean;
  var
    p, delimLen: Integer;
  begin
    Contract.Requires('aDelimiter', aDelimiter).IsNotEmpty.GetLength(delimLen);

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
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                            aDelimiter: AnsiChar;
                                            aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, FromAnsi(aDelimiter), result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                            aDelimiter: WideChar;
                                            aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                      const aDelimiter: UnicodeString;
                                            aDelimiterOption: TCopyDelimiterOption): UnicodeString;
  begin
    CopyRight(aString, aDelimiter, result, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                            aDelimiter: AnsiChar;
                                      var   aCopy: UnicodeString;
                                            aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, FromAnsi(aDelimiter), aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                            aDelimiter: WideChar;
                                      var   aCopy: UnicodeString;
                                            aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.CopyRightText(const aString: UnicodeString;
                                      const aDelimiter: UnicodeString;
                                      var   aCopy: UnicodeString;
                                            aDelimiterOption: TCopyDelimiterOption): Boolean;
  begin
    result := CopyRight(aString, aDelimiter, aCopy, aDelimiterOption, csIgnoreCase);
  end;

























  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: AnsiChar;
                                      aReplacement: AnsiChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, FromAnsi(aChar), FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: WideChar;
                                      aReplacement: WideChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: AnsiChar;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: WideChar;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: AnsiChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: WideChar;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                const aReplacement: UnicodeString;
                                      aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    Replace(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: WideChar;
                                      aReplacement: WideChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Contract.Requires('aReplacement', aReplacement).IsNotNull;

    aResult := aString;
    result := (aChar <> aReplacement) and Find(aString, aChar, p, aCaseMode);
    if result then
      PWideChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: AnsiChar;
                                      aReplacement: AnsiChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: WideChar;
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
      if IsNotEmpty(aReplacement, replaceLen) then
      begin
        if (replaceLen > 1) then
        begin
          strLen := Length(aString);
          SetLength(aResult, strLen + replaceLen - 1);

          FastMove(aResult, p + 1, p + replaceLen, strLen - p);
          FastCopy(aReplacement, aResult, p, replaceLen);
        end
        else if (aChar <> PWideChar(aReplacement)[0]) then
          PWideChar(aResult)[p - 1] := PWideChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                      aChar: AnsiChar;
                                const aReplacement: UnicodeString;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, FromAnsi(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: WideChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen: Integer;
  begin
    Contract.Requires('aReplacement', aReplacement).IsNotNull;

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
        result := (aReplacement <> PWideChar(aSubString)[0]);

      if result then
        PWideChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
                                const aSubstring: UnicodeString;
                                      aReplacement: AnsiChar;
                                var   aResult: UnicodeString;
                                      aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := Replace(aString, aSubstring, FromAnsi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Replace(const aString: UnicodeString;
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

      if IsNotEmpty(aReplacement, replaceLen) then
      begin
        result := NOT (aReplacement = aSubstring);
        if NOT result then
          EXIT;

        if replaceLen > subLen then
          SetLength(aResult, strLen + replaceLen - subLen);

        if replaceLen <> subLen then
          FastMove(aResult, p + subLen, p + replaceLen, strLen - (p + subLen - 1));

        if (replaceLen = 1) then
          PWideChar(aResult)[p - 1] := PWideChar(aReplacement)[0]
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
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar): UnicodeString;
  begin
    result := Replace(aString, FromAnsi(aChar), FromAnsi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WideChar;
                                          aReplacement: WideChar): UnicodeString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, FromAnsi(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WideChar;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: AnsiChar): UnicodeString;
  begin
    result := Replace(aString, aSubString, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WideChar): UnicodeString;
  begin
    result := Replace(aString, aSubstring, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString): UnicodeString;
  begin
    result := Replace(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                          aChar: WideChar;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: AnsiChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubString, FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WideChar;
                                    var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceText(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                              var   aResult: UnicodeString): Boolean;
  begin
    result := Replace(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;




//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WideChar;
                                         aReplacement: WideChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i: Integer;
    p: CharIndexArray;
  begin
    aResult := aString;

    result := (aChar <> aReplacement) and (FindAll(aString, aChar, p, aCaseMode) > 0);
    if result then
      for i := Low(p) to High(p) do
        PWideChar(aResult)[p[i] - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                         aReplacement: AnsiChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WideChar;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: CharIndexArray;
    strLen, replaceLen: Integer;
    occurs, nudge: Integer;
  begin
    aResult := aString;

    result := IsNotEmpty(aString, strLen);
    if NOT result then
      EXIT;

    occurs := FindAll(aString, aChar, pa, aCaseMode);
    result := occurs > 0;
    if NOT result then
      EXIT;

    if IsNotEmpty(aReplacement, replaceLen) then
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
        PWideChar(aResult)[pa[i] - 1] := PWideChar(aReplacement)[0];
    end
    else
      aResult := RemoveAll(aString, aChar, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, FromAnsi(aChar), aReplacement, aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: WideChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: CharIndexArray;
    strLen, subLen: Integer;
    occurs, nudge: Integer;
  begin
    Contract.Requires('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := IsNotEmpty(aString, strLen);
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
        PWideChar(aResult)[p - 1] := aReplacement;
      end;

      SetLength(aResult, strLen + (occurs * nudge));
    end
    else for i := 0 to Pred(occurs) do
      PWideChar(aResult)[pa[i] - 1] := PWideChar(aReplacement)[0];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: AnsiChar;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, FromAnsi(aReplacement), aResult);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                   const aReplacement: UnicodeString;
                                   var   aResult: UnicodeString;
                                         aCaseMode: TCaseSensitivity): Boolean;
  var
    i, p: Integer;
    pa: CharIndexArray;
    strLen, subLen, replaceLen: Integer;
    occurs, nudge: Integer;
  begin
    aResult := aString;

    result := IsNotEmpty(aString, strLen);
    if NOT result then
      EXIT;

    occurs := FindAll(aString, aSubstring, pa, aCaseMode);
    result := occurs > 0;
    if NOT result then
      EXIT;

    subLen := Length(aSubstring);

    if IsNotEmpty(aReplacement, replaceLen) then
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
          PWideChar(aResult)[p - 1] := PWideChar(aReplacement)[0];
        end;

        if nudge < 0 then
          SetLength(aResult, strLen + (occurs * nudge));
      end
      else if (replaceLen = 1) then
      begin
        for i := 0 to Pred(occurs) do
          PWideChar(aResult)[pa[i] - 1] := PWideChar(aReplacement)[0];
      end
      else for i := 0 to Pred(occurs) do
        FastCopy(aReplacement, aResult, pa[i], replaceLen);
    end
    else
      aResult := RemoveAll(aString, aSubstring, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WideChar;
                                         aReplacement: WideChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                         aReplacement: AnsiChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, FromAnsi(aChar), FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: AnsiChar;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, FromAnsi(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                         aChar: WideChar;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: AnsiChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                         aReplacement: WideChar;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAll(const aString: UnicodeString;
                                   const aSubstring: UnicodeString;
                                   const aReplacement: UnicodeString;
                                         aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WideChar;
                                             aReplacement: WideChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: AnsiChar;
                                             aReplacement: AnsiChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: AnsiChar;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, FromAnsi(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WideChar;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: AnsiChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: WideChar;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                       const aReplacement: UnicodeString;
                                       var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceAll(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: AnsiChar;
                                             aReplacement: AnsiChar): UnicodeString;
  begin
    ReplaceAll(aString, FromAnsi(aChar), FromAnsi(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WideChar;
                                             aReplacement: WideChar): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: AnsiChar;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, FromAnsi(aChar), aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                             aChar: WideChar;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, aChar, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: AnsiChar): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, FromAnsi(aReplacement), result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                             aReplacement: WideChar): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceAllText(const aString: UnicodeString;
                                       const aSubstring: UnicodeString;
                                       const aReplacement: UnicodeString): UnicodeString;
  begin
    ReplaceAll(aString, aSubstring, aReplacement, result, csIgnoreCase);
  end;



//


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
  begin
    Contract.Requires('aReplacement', aReplacement).IsNotNull;

    aResult := aString;

    result := (aChar <> aReplacement) and FindLast(aString, aChar, p, aCaseMode);
    if result then
      PWideChar(aResult)[p - 1] := aReplacement;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WideChar;
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
      if IsNotEmpty(aReplacement, replaceLen) then
      begin
        if (replaceLen > 1) then
        begin
          strLen := Length(aString);
          SetLength(aResult, strLen + replaceLen - 1);
          FastMove(aResult, p + 1, p + replaceLen, strLen - p);
          FastCopy(aReplacement, aResult, p, replaceLen);
        end
        else if (aChar <> PWideChar(aReplacement)[0]) then
          PWideChar(aResult)[p - 1] := PWideChar(aReplacement)[0]
        else
          result := FALSE;
      end
      else
        aResult := RemoveLast(aString, aChar, aCaseMode);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                    const aReplacement: UnicodeString;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), aReplacement, aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WideChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen: Integer;
  begin
    Contract.Requires('aReplacement', aReplacement).IsNotNull;

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
        result := (aReplacement <> PWideChar(aSubString)[0]);

      if result then
        PWideChar(aResult)[p - 1] := aReplacement;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: AnsiChar;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, FromAnsi(aReplacement), aResult, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                                    var   aResult: UnicodeString;
                                          aCaseMode: TCaseSensitivity): Boolean;
  var
    p: Integer;
    strLen, subLen, replaceLen: Integer;
  begin
    aResult := aString;

    result := IsNotEmpty(aString, strLen);
    if NOT result then
      EXIT;

    result := FindLast(aString, aSubstring, p, aCaseMode);
    if result then
    begin
      subLen := Length(aSubstring);

      if IsNotEmpty(aReplacement, replaceLen) then
      begin
        result := NOT (aReplacement = aSubstring);
        if NOT result then
          EXIT;

        if replaceLen > subLen then
          SetLength(aResult, strLen + replaceLen - subLen);

        if (replaceLen <> subLen) and (p + subLen <= strLen) then
          FastMove(aResult, p + subLen, p + replaceLen, strLen - (p + subLen - 1));

        if (replaceLen = 1) then
          PWideChar(aResult)[p - 1] := PWideChar(aReplacement)[0]
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
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                          aReplacement: AnsiChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, FromAnsi(aChar), FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WideChar;
                                          aReplacement: WideChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: AnsiChar;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, FromAnsi(aChar), aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                          aChar: WideChar;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aChar, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: AnsiChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, FromAnsi(aReplacement), result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                          aReplacement: WideChar;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLast(const aString: UnicodeString;
                                    const aSubstring: UnicodeString;
                                    const aReplacement: UnicodeString;
                                          aCaseMode: TCaseSensitivity): UnicodeString;
  begin
    ReplaceLast(aString, aSubstring, aReplacement, result, aCaseMode);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: AnsiChar;
                                              aReplacement: AnsiChar): UnicodeString;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), FromAnsi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WideChar;
                                              aReplacement: WideChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: AnsiChar;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WideChar;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: AnsiChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubString, FromAnsi(aReplacement), csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: WideChar): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                        const aReplacement: UnicodeString): UnicodeString;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, csIgnoreCase);
  end;



//

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: AnsiChar;
                                              aReplacement: AnsiChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WideChar;
                                              aReplacement: WideChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: AnsiChar;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, FromAnsi(aChar), aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                              aChar: WideChar;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aChar, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: AnsiChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubString, FromAnsi(aReplacement), aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                              aReplacement: WideChar;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.ReplaceLastText(const aString: UnicodeString;
                                        const aSubstring: UnicodeString;
                                        const aReplacement: UnicodeString;
                                        var   aResult: UnicodeString): Boolean;
  begin
    result := ReplaceLast(aString, aSubstring, aReplacement, aResult, csIgnoreCase);
  end;


















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Tag(const aString, aTag: UnicodeString): UnicodeString;
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
    p: PWideChar;
    buf: PByte absolute p;
  begin
    tlen := Length(aTag);
    if tlen = 0 then
      EXIT;

    blen := Length(aString);

    rlen := blen + (tlen * 2) + 5;
    SetLength(result, rlen);

    p := PWideChar(result);
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
      WideFn.CopyToBuffer(aString, blen, buf, tlen + 4);
    end;

    WideFn.CopyToBuffer(aTag, tlen, buf, 2);
    WideFn.CopyToBuffer(aTag, tlen, buf, tlen + blen + 8);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.LTrim(const aString: UnicodeString): UnicodeString;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if IsEmpty(aString, strLen) then
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
  class function WideFn.LTrim(const aString: UnicodeString;
                                    aChar: WideChar): UnicodeString;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if IsEmpty(aString, strLen) then
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
  class function WideFn.LTrim(const aString: UnicodeString;
                                    aCount: Integer): UnicodeString;
  begin
    if (aCount > 0) and (aString <> '') then
      result := Copy(aString, aCount + 1, Length(aString) - aCount)
    else
      result := aString;
  end;



  class function WideFn.RTrim(const aString: UnicodeString): UnicodeString;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if IsEmpty(aString, strLen) then
      EXIT;

    i := Pred(strLen);
    while (i > 0) and (chars[i] <= #32) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RTrim(const aString: UnicodeString;
                                    aChar: WideChar): UnicodeString;
  var
    chars: PWideChar absolute aString;
    i: Integer;
    strLen: Integer;
  begin
    result := aString;

    if IsEmpty(aString, strLen) then
      EXIT;

    i := Pred(strLen);
    while (i >= 0) and (chars[i] = aChar) do
      Dec(i);

    SetLength(result, i + 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.RTrim(const aString: UnicodeString;
                                    aCount: Integer): UnicodeString;
  begin
    result := aString;

    if (aCount > 0) and (aString <> '') then
      SetLength(result, Length(result) - aCount);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Trim(const aString: UnicodeString): UnicodeString;
  begin
    result := LTrim(RTrim(aString));
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Trim(const aString: UnicodeString;
                                   aChar: WideChar): UnicodeString;
  begin
    result := LTrim(RTrim(aString, aChar), aChar);
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Trim(const aString: UnicodeString;
                                   aCount: Integer): UnicodeString;
  begin
    result := LTrim(RTrim(aString, aCount), aCount);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Unbrace(const aString: UnicodeString): UnicodeString;
  const
    MATCH_SET : set of AnsiChar = ['!','@','#','%','&','*','-','_',
                                   '+','=',':','/','?','\','|','~'];
  var
    rlen: Integer;
    firstChar: WideChar;
    lastChar: WideChar;
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
      if NOT (AnsiChar(firstChar) in MATCH_SET)
          or (lastChar <> firstChar) then
        EXIT;
    end;

    if rlen > 0 then
      result := System.Copy(aString, 2, rlen)
    else
      result := '';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Unquote(const aString: UnicodeString): UnicodeString;
  var
    i, j, maxi: Integer;
    qc: WideChar;
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
  class function WideFn.Camelcase(const aString: UnicodeString;
                                        aInitialLower: Boolean): UnicodeString;
  var
    chars: PWideChar absolute result;
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
  class function WideFn.Lowercase(aChar: WideChar): WideChar;
  var
    p: PWideChar;
    l: Cardinal absolute p;
  begin
    l := MAKELONG(Word(aChar), 0);
    p := Windows.CharLowerW(p);

    result := WideChar(LOWORD(l));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Lowercase(const aString: UnicodeString): UnicodeString;
  begin
    result := aString;
    if result <> '' then
      CharLowerBuffW(PWideChar(result), Length(result));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Skewercase(const aString: UnicodeString): UnicodeString;
  begin
    result := Trim(aString);

    if result = '' then
      EXIT;

    while ReplaceAll(result, '  ', ' ', result) do;

    result := ReplaceAll(result, ' ', '-');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Snakecase(const aString: UnicodeString): UnicodeString;
  begin
    result := Trim(aString);

    if result = '' then
      EXIT;

    while ReplaceAll(result, '  ', ' ', result) do;

    result := ReplaceAll(result, ' ', '_');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Startcase(const aString: UnicodeString): UnicodeString;
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
    prev: WideChar;
    prevAlpha: Boolean;
    ch: WideChar;
  begin
    result := aString;

    if IsEmpty(result, len) then
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
  class function WideFn.Titlecase(const aString: UnicodeString): UnicodeString;
  begin
    result := Titlecase(aString, LowercaseWordsForTitlecase);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Titlecase(const aString: UnicodeString;
                                  const aLower: UnicodeStringArray): UnicodeString;

    function ForceLower(const aString: UnicodeString): Boolean;
    var
      i: Integer;
    begin
      result := TRUE;
      for i := Low(aLower) to High(aLower) do
        if SameText(aString, aLower[i]) then
          EXIT;

      result := FALSE;
    end;

  var
    i: Integer;
    pieces: UnicodeStringArray;
    p: CharIndexArray;
  begin
    result := Wide.Startcase(aString);

    Wide.Split(result, ' ', pieces);

    FindAll(result, ' ', p);

    for i := 0 to High(p) - 1 do
      if   Wide.IsAlphaNumeric(result[p[i] - 1])
       and ForceLower(pieces[i + 1]) then
        result[p[i] + 1] := Wide.Lowercase(result[p[i] + 1]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Uppercase(aChar: WideChar): WideChar;
  var
    p: PWideChar;
    l: Cardinal absolute p;
  begin
    l := MAKELONG(Word(aChar), 0);
    p := Windows.CharUpperW(p);

    result := WideChar(LOWORD(l));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideFn.Uppercase(const aString: UnicodeString): UnicodeString;
  begin
    result := aString;
    if result <> '' then
      CharUpperBuffW(PWideChar(result), Length(result));
  end;













initialization
  LowercaseWordsForTitlecase := Wide.AsArray([
    'a',
    'am',
    'an',
    'and',
    'are',
    'as',
    'at',
    'for',
    'from',
    'in',
    'is',
    'of',
    'on',
    'the',
    'this',
    'to',
    'upon'
  ]);

end.
