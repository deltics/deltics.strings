
{$i deltics.strings.inc}


  unit Deltics.Strings.Types;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Strings.Encoding;


  type
  {$ifdef UNICODE}
    UTF8String      = System.UTF8String;
    UnicodeString   = System.UnicodeString;
  {$else}
    UTF8String    = type ANSIString;
    UnicodeString = type WideString;
  {$endif}

    TANSICharSet = set of ANSIChar;

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
    UTF8Char    = type ANSIChar;
    PUTF8Char   = ^UTF8Char;

    ASCIIString = type ANSIString;
    ASCIIChar   = type UTF8Char;

    TCharIndexArray   = array of Integer;
    TANSIStringArray  = array of ANSIString;
    TUTF8StringArray  = array of UTF8String;
    TWIDEStringArray  = array of UnicodeString;

  {$ifdef UNICODE}
    TStringArray = TWIDEStringArray;
  {$else}
    TStringArray = TANSIStringArray;
  {$endif}

    TANSICharArray  = array of ANSIChar;
    TUTF8CharArray  = array of UTF8Char;
    TWIDECharArray  = array of WIDEChar;

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


    TANSITestCharFn = function(aChar: ANSIChar): LongBool; stdcall;
    TWIDETestCharFn = function(aChar: WIDEChar): LongBool; stdcall;


    IANSIStringBuilder = interface
    ['{BA0B6994-0769-4145-95F2-2A112662E6AC}']
    end;

    IWIDEStringBuilder = interface
    ['{B75835B8-7D6C-4DE7-9743-CB7DF02ABFD9}']
    end;



  {$ifdef UNICODE}
    IStringBuilder = IWIDEStringBuilder;
  {$else}
    IStringBuilder = IANSIStringBuilder;
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
