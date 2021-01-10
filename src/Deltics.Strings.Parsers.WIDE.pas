
{$i deltics.strings.inc}


  unit Deltics.Strings.Parsers.Wide;


interface

  uses
    Deltics.Strings.Types;


  type
    WideParser = class
    public
      class function AsBoolean(aBuffer: PWideChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(aBuffer: PWideChar; aLen: Integer; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: UnicodeString; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PWideChar; aLen: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PWideChar; aLen: Integer; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: UnicodeString): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: UnicodeString; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}

      class function IsBoolean(aBuffer: PWideChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(aBuffer: PWideChar; aLen: Integer; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: UnicodeString; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PWideChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PWideChar; aLen: Integer; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: UnicodeString; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
    end;
    WideParserClass = class of WideParser;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Deltics.Strings.Parsers.Wide.AsBoolean,
    Deltics.Strings.Parsers.Wide.AsInteger;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsInteger(aBuffer: PWideChar;
                                      aLen: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [Wide(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsInteger(aBuffer: PWideChar;
                                      aLen: Integer;
                                      aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsInteger(const aString: UnicodeString): Integer;
  begin
    if NOT ParseInteger(PWideChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsInteger(const aString: UnicodeString;
                                            aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(PWideChar(aString), Length(aString), result) then
      result := aDefault;
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsBoolean(aBuffer: PWideChar;
                                      aLen: Integer): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [Wide(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsBoolean(aBuffer: PWideChar;
                                      aLen: Integer;
                                      aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsBoolean(const aString: UnicodeString): Boolean;
  begin
    if NOT ParseBoolean(PWideChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.AsBoolean(const aString: UnicodeString;
                                            aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(PWideChar(aString), Length(aString), result) then
      result := aDefault;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsBoolean(aBuffer: PWideChar;
                                      aLen: Integer): Boolean;
  begin
    result := CheckBoolean(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsBoolean(    aBuffer: PWideChar;
                                          aLen: Integer;
                                      var aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsBoolean(const aString: UnicodeString): Boolean;
  begin
    result := CheckBoolean(PWideChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsBoolean(const aString: UnicodeString;
                                      var   aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(PWideChar(aString), Length(aString), aValue);
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsInteger(aBuffer: PWideChar; aLen: Integer): Boolean;
  begin
    result := CheckInteger(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsInteger(    aBuffer: PWideChar;
                                          aLen: Integer;
                                      var aValue: Integer): Boolean;
  begin
    result := ParseInteger(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsInteger(const aString: UnicodeString): Boolean;
  begin
    result := CheckInteger(PWideChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WideParser.IsInteger(const aString: UnicodeString;
                                      var   aValue: Integer): Boolean;
  begin
    result := ParseInteger(PWideChar(aString), Length(aString), aValue);
  end;






end.
