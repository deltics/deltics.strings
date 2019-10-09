
{$i deltics.strings.inc}


  unit Deltics.Strings.Utils;


interface

  uses
    Windows,
    Deltics.Strings.Types;


  const
    CASEMODE_FLAG: array[csCaseSensitive..csIgnoreCase] of Cardinal = (0, NORM_IGNORECASE);

  type
    StringsUtil = class
      class procedure CheckContainsResult(const aNeed: TContainNeeds; var aResult: Boolean; var aFoundOne: Boolean);
      class function HasContainsResult(const aNeed: TContainNeeds; var aResult: Boolean; var aFoundOne: Boolean): Boolean;
    end;



implementation


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function StringsUtil.HasContainsResult(const aNeed: TContainNeeds;
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


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class procedure StringsUtil.CheckContainsResult(const aNeed: TContainNeeds;
                                                  var   aResult: Boolean;
                                                  var   aFoundOne: Boolean);
  begin
    case aNeed of
      cnAny   : aResult := FALSE;
      cnEvery : aResult := TRUE;
      cnOneOf : aResult := (aFoundOne = TRUE);
    end;
  end;





end.
