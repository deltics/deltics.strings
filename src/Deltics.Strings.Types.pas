
{$i deltics.strings.inc}


  unit Deltics.Strings.Types;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Unicode;


  type
  // Codepoint
    Codepoint         = Deltics.Unicode.Codepoint;
    PCodepoint        = Deltics.Unicode.PCodepoint;

  // Bom types
    TBom        = Deltics.Unicode.TBom;

    Utf8Bom     = Deltics.Unicode.Utf8Bom;
    Utf16Bom    = Deltics.Unicode.Utf16Bom;
    Utf16LEBom  = Deltics.Unicode.Utf16LEBom;
    Utf32Bom    = Deltics.Unicode.Utf32Bom;
    Utf32LEBom  = Deltics.Unicode.Utf32LEBom;

  // String types
   {AnsiString}
    AsciiString       = Deltics.Unicode.AsciiString;
    UnicodeString     = Deltics.Unicode.UnicodeString;
    Utf8String        = Deltics.Unicode.Utf8String;
   {WideString}

  // Char types
   {AnsiChar}
    AsciiChar         = Deltics.Unicode.AsciiChar;
    Utf8Char          = Deltics.Unicode.Utf8Char;
    Utf16Char         = Deltics.Unicode.Utf16Char;
    Utf32Char         = Deltics.Unicode.Utf32Char;
   {WideChar}

   {PAnsiChar}
    PAsciiChar        = Deltics.Unicode.PAsciiChar;
    PUtf8Char         = Deltics.Unicode.PUtf8Char;
    PUtf16Char        = Deltics.Unicode.PUtf16Char;
    PUtf32Char        = Deltics.Unicode.PUtf32Char;
   {PWideChar}

  // Char array types
    AsciiArray      = Deltics.Unicode.AsciiArray;
    AnsiCharArray   = Deltics.Unicode.AnsiCharArray;
    CharArray       = Deltics.Unicode.CharArray;
    Utf8Array       = Deltics.Unicode.Utf8Array;
    Utf16Array      = Deltics.Unicode.Utf16Array;
    Utf32Array      = Deltics.Unicode.Utf32Array;
    WideCharArray   = Deltics.Unicode.WideCharArray;
    CodepointArray  = Deltics.Unicode.CodepointArray;

  // String array types
    AnsiStringArray     = Deltics.Unicode.AnsiStringArray;
    AsciiStringArray    = Deltics.Unicode.AsciiStringArray;
    StringArray         = Deltics.Unicode.StringArray;
    UnicodeStringArray  = Deltics.Unicode.UnicodeStringArray;
    Utf8StringArray     = Deltics.Unicode.Utf8StringArray;
    WideStringArray     = Deltics.Unicode.WideStringArray;


    AnsiCharSet = set of AnsiChar;

    TStringProcessingFlag = (
                             rsFromStart,
                             rsFromEnd,
                             rsIgnoreCase
                            );
    TReplaceStringFlag  = rsFromStart..rsIgnoreCase;
    TReplaceStringFlags = set of TReplaceStringFlag;

    TUnicodeSurrogateStrategy = (
                                 ssError,   // An EUnicodeOrphanSurrogate exception is raised if a string operation results in an orphan surrogate
                                 ssIgnore,  // String operations may result in orphan surrogates
                                 ssAvoid    // String operations will ensure that surrogates are not orphaned
                                );

    EUnicode                  = class(Exception);
    EUnicodeDataloss          = class(EUnicode);
    EUnicodeRequiresMultibyte = class(EUnicode);
    EUnicodeOrphanSurrogate   = class(EUnicode);

  const
    ssFromStart   = rsFromStart;
    ssFromEnd     = rsFromEnd;
    ssIgnoreCase  = rsIgnoreCase;

    isLesser  = -1;
    isEqual   = 0;
    isGreater = 1;


  type
    CharIndexArray   = array of Integer;


    TAlphaCase  = (
                   acNotAlpha,
                   acLower,
                   acUpper
                  );

    TCaseSensitivity = (
                        csCaseSensitive,
                        csIgnoreCase
                       );

    TCopyDelimiterOption = (
                            doExcludeOptionalDelimiter,
                            doExcludeRequiredDelimiter,
                            doIncludeOptionalDelimiter,
                            doIncludeRequiredDelimiter
                           );

    TExtractDelimiterOption = (
                               doLeaveOptionalDelimiter,
                               doLeaveRequiredDelimiter,
                               doDeleteOptionalDelimiter,
                               doDeleteRequiredDelimiter,
                               doExtractOptionalDelimiter,
                               doExtractRequiredDelimiter
                              );

    TCompareResult = isLesser..isGreater;

    TContainNeeds = (
                     cnAny,
                     cnEvery,
                     cnOneOf
                    );

    TStringScope = (
                    ssAll,
                    ssFirst,
                    ssLast
                   );


    TAnsiTestCharFn = function(aChar: AnsiChar): LongBool; stdcall;
    TWideTestCharFn = function(aChar: WideChar): LongBool; stdcall;


    IAnsiStringBuilder = interface
    ['{BA0B6994-0769-4145-95F2-2A112662E6AC}']
    end;

    IWideStringBuilder = interface
    ['{B75835B8-7D6C-4DE7-9743-CB7DF02ABFD9}']
    end;



  {$ifdef UNICODE}
    IStringBuilder = IWideStringBuilder;
  {$else}
    IStringBuilder = IAnsiStringBuilder;
  {$endif}


  const
    CopyDelimiterOptional = [
                             doExcludeOptionalDelimiter,
                             doIncludeOptionalDelimiter
                            ];

    ExtractDelimiterOptional = [
                                doLeaveOptionalDelimiter,
                                doDeleteOptionalDelimiter,
                                doExtractOptionalDelimiter
                               ];


implementation




end.
