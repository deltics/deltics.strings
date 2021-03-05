
{$i deltics.strings.inc}


  unit Deltics.Strings.Types;


interface

  uses
    Classes,
    SysUtils,
    Deltics.StringTypes;


  {$i deltics.stringtypes.aliases.inc}

  type
    TStringProcessingFlag = (
                             rsFromStart,
                             rsFromEnd,
                             rsIgnoreCase
                            );
    TReplaceStringFlag  = rsFromStart..rsIgnoreCase;
    TReplaceStringFlags = set of TReplaceStringFlag;

    SurrogateAction = (
                       saError,   // An EUnicodeOrphanSurrogate exception is raised if a string operation results in an orphan surrogate
                       saIgnore,  // String operations may result in orphan surrogates
                       saDelete   // String operations will ensure that surrogates are not orphaned
                      );

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
