
{$i deltics.strings.parsers.inc}

  unit Deltics.Strings.Parsers.Ansi;


interface

  uses
    Deltics.Strings.Types;


  type
    AnsiParser = class
    public
      class function AsBoolean(aBuffer: PAnsiChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(aBuffer: PAnsiChar; aLen: Integer; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: AnsiString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: AnsiString; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PAnsiChar; aLen: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PAnsiChar; aLen: Integer; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: AnsiString): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: AnsiString; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}

      class function IsBoolean(aBuffer: PAnsiChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(aBuffer: PAnsiChar; aLen: Integer; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: AnsiString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: AnsiString; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PAnsiChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PAnsiChar; aLen: Integer; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: AnsiString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: AnsiString; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
    end;
    AnsiParserClass = class of AnsiParser;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Deltics.Strings.Parsers.Ansi.AsBoolean,
    Deltics.Strings.Parsers.Ansi.AsInteger;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsInteger(aBuffer: PAnsiChar;
                                      aLen: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [Ansi(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsInteger(aBuffer: PAnsiChar;
                                      aLen: Integer;
                                      aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsInteger(const aString: AnsiString): Integer;
  begin
    if NOT ParseInteger(PAnsiChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsInteger(const aString: AnsiString;
                                            aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(PAnsiChar(aString), Length(aString), result) then
      result := aDefault;
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsBoolean(aBuffer: PAnsiChar;
                                      aLen: Integer): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [Ansi(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsBoolean(aBuffer: PAnsiChar;
                                      aLen: Integer;
                                      aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsBoolean(const aString: AnsiString): Boolean;
  begin
    if NOT ParseBoolean(PAnsiChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.AsBoolean(const aString: AnsiString;
                                            aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(PAnsiChar(aString), Length(aString), result) then
      result := aDefault;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsBoolean(aBuffer: PAnsiChar;
                                      aLen: Integer): Boolean;
  begin
    result := CheckBoolean(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsBoolean(    aBuffer: PAnsiChar;
                                          aLen: Integer;
                                      var aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsBoolean(const aString: AnsiString): Boolean;
  begin
    result := CheckBoolean(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsBoolean(const aString: AnsiString;
                                      var   aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(PAnsiChar(aString), Length(aString), aValue);
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsInteger(aBuffer: PAnsiChar; aLen: Integer): Boolean;
  begin
    result := CheckInteger(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsInteger(    aBuffer: PAnsiChar;
                                          aLen: Integer;
                                      var aValue: Integer): Boolean;
  begin
    result := ParseInteger(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsInteger(const aString: AnsiString): Boolean;
  begin
    result := CheckInteger(PAnsiChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function AnsiParser.IsInteger(const aString: AnsiString;
                                      var   aValue: Integer): Boolean;
  begin
    result := ParseInteger(PAnsiChar(aString), Length(aString), aValue);
  end;





end.


