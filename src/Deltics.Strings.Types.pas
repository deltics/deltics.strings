
{$i deltics.strings.inc}


  unit Deltics.Strings.Types;


interface

  uses
    Classes,
    SysUtils;


  type
  {$ifdef UNICODE}
    Utf8String    = System.Utf8String;
    UnicodeString = System.UnicodeString;
  {$else}
    Utf8String    = type AnsiString;
    UnicodeString = type WideString;
  {$endif}

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
    Utf8Char    = type AnsiChar;
    PUtf8Char   = ^Utf8Char;

    ASCIIString = type AnsiString;
    ASCIIChar   = type Utf8Char;

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

implementation




end.
