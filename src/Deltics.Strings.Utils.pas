
{$i deltics.strings.inc}

{$ifdef debugDelticsStringsUtils}
  {$debuginfo ON}
{$endif}

  unit Deltics.Strings.Utils;


interface

  uses
    Windows,
    Deltics.Strings.Types;


  const
    CASEMODE_FLAG: array[csCaseSensitive..csIgnoreCase] of Cardinal = (0, NORM_IGNORECASE);

  type
    Utils = class
      class procedure CheckContainsResult(const aNeed: TContainNeeds; var aResult: Boolean; var aFoundOne: Boolean);
      class procedure CopyChars(var aString: AnsiString; aFromIndex: Integer; aToIndex: Integer; aNumChars: Integer); overload;
      class procedure CopyChars(var aString: UnicodeString; aFromIndex: Integer; aToIndex: Integer; aNumChars: Integer); overload;
      class procedure CopyUtf8Chars(var aString: Utf8String; aFromIndex: Integer; aToIndex: Integer; aNumChars: Integer); overload;
      class function HasContainsResult(const aNeed: TContainNeeds; var aResult: Boolean; var aFoundOne: Boolean): Boolean;
    end;



implementation

  uses
    Deltics.Contracts;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utils.CheckContainsResult(const aNeed: TContainNeeds;
                                            var   aResult: Boolean;
                                            var   aFoundOne: Boolean);
  begin
    case aNeed of
      cnAny   : aResult := FALSE;
      cnEvery : aResult := TRUE;
      cnOneOf : aResult := (aFoundOne = TRUE);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utils.CopyChars(var aString: AnsiString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aNumChars: Integer);
  var
    src: PAnsiChar;
    dest: PAnsiChar;
  begin
    Contract.Requires('aString', aString).IsNotEmpty;
    Contract.Requires('aFromIndex', aFromIndex).IsValidIndexFor(aString);
    Contract.Requires('aFromIndex + aNumChars - 1', aFromIndex + aNumChars - 1).IsValidIndexFor(aString);

    src   := @aString[aFromIndex];
    dest  := @aString[aToIndex];

    CopyMemory(dest, src, aNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utils.CopyChars(var aString: UnicodeString;
                                      aFromIndex: Integer;
                                      aToIndex: Integer;
                                      aNumChars: Integer);
  var
    src: PWideChar;
    dest: PWideChar;
  begin
    Contract.Requires('aString', aString).IsNotEmpty;
    Contract.Requires('aFromIndex', aFromIndex).IsValidIndexFor(aString);
    Contract.Requires('aToIndex + aNumChars - 1', aToIndex + aNumChars - 1).IsValidIndexFor(aString);

    src   := @aString[aFromIndex];
    dest  := @aString[aToIndex];

    CopyMemory(dest, src, aNumChars * 2);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure Utils.CopyUtf8Chars(var aString: Utf8String;
                                          aFromIndex: Integer;
                                          aToIndex: Integer;
                                          aNumChars: Integer);
  var
    src: PUtf8Char;
    dest: PUtf8Char;
  begin
    Contract.Requires('aString', aString).IsNotEmpty;
    Contract.Requires('aFromIndex', aFromIndex).IsValidIndexFor(aString);
    Contract.Requires('aFromIndex + aNumChars - 1', aFromIndex + aNumChars - 1).IsValidIndexFor(aString);

    src   := PUtf8Char(@aString[aFromIndex]);
    dest  := PUtf8Char(@aString[aToIndex]);

    CopyMemory(dest, src, aNumChars);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function Utils.HasContainsResult(const aNeed: TContainNeeds;
                                         var   aResult: Boolean;
                                         var   aFoundOne: Boolean): Boolean;
  begin
    result := TRUE;

    case aNeed of
      cnAny   : if aResult then
                  EXIT;

      cnEvery : if NOT aResult then
                  EXIT;

      cnOneOf : if aResult then
                begin
                  if {already} aFoundOne then
                  begin
                    aResult := FALSE;
                    EXIT;
                  end
                  else
                    aFoundOne := TRUE;
                end;
    end;

    result := FALSE;
  end;




end.
