
{$i deltics.strings.inc}


  unit Deltics.Strings.Types;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Strings.Types.BOM,
    Deltics.Strings.Types.Core;


  type
    Utf8String    = Deltics.Strings.Types.Core.Utf8String;
    UnicodeString = Deltics.Strings.Types.Core.UnicodeString;

    Utf8Char    = Deltics.Strings.Types.Core.Utf8Char;
    PUtf8Char   = Deltics.Strings.Types.Core.PUtf8Char;

    AsciiString = Deltics.Strings.Types.Core.AsciiString;
    AsciiChar   = Deltics.Strings.Types.Core.AsciiChar;

    TAnsiCharSet = set of AnsiChar;

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
    TCharIndexArray   = array of Integer;
    TAnsiStringArray  = array of AnsiString;
    TUtf8StringArray  = array of Utf8String;
    TWideStringArray  = array of UnicodeString;

  {$ifdef UNICODE}
    TStringArray = TWideStringArray;
  {$else}
    TStringArray = TAnsiStringArray;
  {$endif}

    TAnsiCharArray  = array of AnsiChar;
    TUtf8CharArray  = array of Utf8Char;
    TWideCharArray  = array of WideChar;

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


  type
    Utf8Bom     = Deltics.Strings.Types.BOM.Utf8Bom;
    Utf16Bom    = Deltics.Strings.Types.BOM.Utf16Bom;
    Utf16LEBom  = Deltics.Strings.Types.BOM.Utf16LEBom;
    Utf32Bom    = Deltics.Strings.Types.BOM.Utf32Bom;
    Utf32LEBom  = Deltics.Strings.Types.BOM.Utf32LEBom;




implementation




end.
