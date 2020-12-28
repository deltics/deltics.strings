
{$i deltics.strings.inc}


  unit Deltics.Strings.Parsers.WIDE.AsInteger;


interface

  function CheckInteger(aBuffer: PWIDEChar; aLen: Integer): Boolean;
  function ParseInteger(aBuffer: PWIDEChar; aLen: Integer; var aValue: Integer): Boolean;

implementation


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function Init(var aBuffer: PWIDEChar;
                var aLen: Integer;
                var aBase: Integer;
                var aNeg: Boolean): Boolean; {$ifdef DELPHI2006__} inline; {$endif}
  begin
    aBase := 10;
    aNeg  := FALSE;

    while (aLen > 0) and (aBuffer[0] = ' ') do
    begin
      Inc(aBuffer);
      Dec(aLen);
    end;

    while (aLen > 0) and (aBuffer[aLen - 1] = ' ') do
      Dec(aLen);

    case aLen of

      0 : result := FALSE;

      1 : case aBuffer[0] of
            '0'..'9': result := TRUE;
          else
            result := FALSE;
          end;

    else
      result := TRUE;

      case aBuffer[0] of
        '%'     : begin
                    aBase := 2;
                    aNeg  := FALSE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '&'     : begin
                    aBase := 8;
                    aNeg  := FALSE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '$'     : begin
                    aBase := 16;
                    aNeg  := FALSE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '#'     : begin
                    aBase := 10;
                    aNeg  := FALSE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '-'     : begin
                    aNeg := TRUE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '+'     : begin
                    aNeg := FALSE;
                    Inc(aBuffer);
                    Dec(aLen);

                    result := aLen > 0;
                  end;

        '0'     : begin
                    aNeg := FALSE;

                    case aBuffer[1] of
                      'b' : begin
                              aBase := 2;
                              Inc(aBuffer, 2);
                              Dec(aLen, 2);
                            end;

                      'o' : begin
                              aBase := 8;
                              Inc(aBuffer, 2);
                              Dec(aLen, 2);
                            end;

                      'x' : begin
                              aBase := 16;
                              Inc(aBuffer, 2);
                              Dec(aLen, 2);
                            end;

                      '0'..'9': aBase := 10;
                    else
                      result := FALSE;
                      EXIT;
                    end;

                    result := aLen > 0;
                  end;

        '1'..'9': begin
                    aBase := 10;
                    aNeg  := FALSE;
                    EXIT;
                  end;
      else
        result := FALSE;
      end;
    end;

    while (aLen > 0) and (aBuffer[0] = '0') do
    begin
      Inc(aBuffer);
      Dec(aLen);
    end;
  end;









  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function CheckInteger(aBuffer: PWIDEChar;
                        aLen: Integer): Boolean;
  var
    pc: PWIDEChar absolute aBuffer;
    i: Integer;
    neg: Boolean;
    base: Integer;
  begin
    result := Init(aBuffer, aLen, base, neg);
    if NOT result then
      EXIT;

    case base of
       2  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0', '1' : { NO-OP };
              else
                result := FALSE;
                EXIT;
              end;
            end;

       8  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0'..'7' : { NO-OP };
              else
                result := FALSE;
                EXIT;
              end;
            end;

      10  : begin
              for i := 0 to Pred(aLen) do
              begin
                case pc[i] of
                  '0'..'9' : { NO-OP };
                else
                  result := FALSE;
                  EXIT;
                end;
              end;
            end;

      16  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0'..'9' : { NO-OP };
                'a'..'f' : { NO-OP };
                'A'..'F' : { NO-OP };
              else
                result := FALSE;
                EXIT;
              end;
            end;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function ParseInteger(    aBuffer: PWIDEChar;
                            aLen: Integer;
                        var aValue: Integer): Boolean;
  var
    pc: PWIDEChar absolute aBuffer;
    i: Integer;
    neg: Boolean;
    base: Integer;
  begin
    aValue := 0;

    result := Init(aBuffer, aLen, base, neg);
    if NOT result then
    begin
      aValue := -1;
      EXIT;
    end;

    case base of
       2  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0' : aValue  := (aValue * base);
                '1' : aValue  := (aValue * base) + 1;
              else
                result := FALSE;
                EXIT;
              end;
            end;

       8  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0' : aValue  := (aValue * base);
                '1' : aValue  := (aValue * base) + 1;
                '2' : aValue  := (aValue * base) + 2;
                '3' : aValue  := (aValue * base) + 3;
                '4' : aValue  := (aValue * base) + 4;
                '5' : aValue  := (aValue * base) + 5;
                '6' : aValue  := (aValue * base) + 6;
                '7' : aValue  := (aValue * base) + 7;
              else
                result := FALSE;
                EXIT;
              end;
            end;

      10  : begin
              for i := 0 to Pred(aLen) do
              begin
                case pc[i] of
                  '0' : aValue  := (aValue * base);
                  '1' : aValue  := (aValue * base) + 1;
                  '2' : aValue  := (aValue * base) + 2;
                  '3' : aValue  := (aValue * base) + 3;
                  '4' : aValue  := (aValue * base) + 4;
                  '5' : aValue  := (aValue * base) + 5;
                  '6' : aValue  := (aValue * base) + 6;
                  '7' : aValue  := (aValue * base) + 7;
                  '8' : aValue  := (aValue * base) + 8;
                  '9' : aValue  := (aValue * base) + 9;
                else
                  result := FALSE;
                  EXIT;
                end;
              end;

              if neg then
                aValue := -1 * aValue;
            end;

      16  : for i := 0 to Pred(aLen) do
            begin
              case pc[i] of
                '0' : aValue  := (aValue * base);
                '1' : aValue  := (aValue * base) + 1;
                '2' : aValue  := (aValue * base) + 2;
                '3' : aValue  := (aValue * base) + 3;
                '4' : aValue  := (aValue * base) + 4;
                '5' : aValue  := (aValue * base) + 5;
                '6' : aValue  := (aValue * base) + 6;
                '7' : aValue  := (aValue * base) + 7;
                '8' : aValue  := (aValue * base) + 8;
                '9' : aValue  := (aValue * base) + 9;
                'a', 'A' : aValue  := (aValue * base) + 10;
                'b', 'B' : aValue  := (aValue * base) + 11;
                'c', 'C' : aValue  := (aValue * base) + 12;
                'd', 'D' : aValue  := (aValue * base) + 13;
                'e', 'E' : aValue  := (aValue * base) + 14;
                'f', 'F' : aValue  := (aValue * base) + 15;
              else
                result := FALSE;
                EXIT;
              end;
            end;
    end;
  end;







end.
