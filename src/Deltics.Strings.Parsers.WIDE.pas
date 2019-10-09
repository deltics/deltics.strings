
{$i deltics.strings.inc}


  unit Deltics.Strings.Parsers.WIDE;


interface

  uses
    Deltics.Strings.Types;


  type
    WIDEParser = class
    public
      class function AsBoolean(aBuffer: PWIDEChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(aBuffer: PWIDEChar; aLen: Integer; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsBoolean(const aString: UnicodeString; aDefault: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PWIDEChar; aLen: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(aBuffer: PWIDEChar; aLen: Integer; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: UnicodeString): Integer; overload; {$ifdef InlineMethods} inline; {$endif}
      class function AsInteger(const aString: UnicodeString; aDefault: Integer): Integer; overload; {$ifdef InlineMethods} inline; {$endif}

      class function IsBoolean(aBuffer: PWIDEChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(aBuffer: PWIDEChar; aLen: Integer; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsBoolean(const aString: UnicodeString; var aValue: Boolean): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PWIDEChar; aLen: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(aBuffer: PWIDEChar; aLen: Integer; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: UnicodeString): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
      class function IsInteger(const aString: UnicodeString; var aValue: Integer): Boolean; overload; {$ifdef InlineMethods} inline; {$endif}
    end;
    WIDEParserClass = class of WIDEParser;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Deltics.Strings.Parsers.WIDE.AsBoolean,
    Deltics.Strings.Parsers.WIDE.AsInteger;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsInteger(aBuffer: PWIDEChar;
                                      aLen: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [WIDE.FromBuffer(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsInteger(aBuffer: PWIDEChar;
                                      aLen: Integer;
                                      aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsInteger(const aString: UnicodeString): Integer;
  begin
    if NOT ParseInteger(PWIDEChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid integer expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsInteger(const aString: UnicodeString;
                                            aDefault: Integer): Integer;
  begin
    if NOT ParseInteger(PWIDEChar(aString), Length(aString), result) then
      result := aDefault;
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsBoolean(aBuffer: PWIDEChar;
                                      aLen: Integer): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [WIDE.FromBuffer(aBuffer, aLen)]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsBoolean(aBuffer: PWIDEChar;
                                      aLen: Integer;
                                      aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(aBuffer, aLen, result) then
      result := aDefault;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsBoolean(const aString: UnicodeString): Boolean;
  begin
    if NOT ParseBoolean(PWIDEChar(aString), Length(aString), result) then
      raise EConvertError.CreateFmt('''%s'' is not a valid boolean expression', [aString]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.AsBoolean(const aString: UnicodeString;
                                            aDefault: Boolean): Boolean;
  begin
    if NOT ParseBoolean(PWIDEChar(aString), Length(aString), result) then
      result := aDefault;
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsBoolean(aBuffer: PWIDEChar;
                                      aLen: Integer): Boolean;
  begin
    result := CheckBoolean(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsBoolean(    aBuffer: PWIDEChar;
                                          aLen: Integer;
                                      var aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsBoolean(const aString: UnicodeString): Boolean;
  begin
    result := CheckBoolean(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsBoolean(const aString: UnicodeString;
                                      var   aValue: Boolean): Boolean;
  begin
    result := ParseBoolean(PWIDEChar(aString), Length(aString), aValue);
  end;








  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsInteger(aBuffer: PWIDEChar; aLen: Integer): Boolean;
  begin
    result := CheckInteger(aBuffer, aLen);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsInteger(    aBuffer: PWIDEChar;
                                          aLen: Integer;
                                      var aValue: Integer): Boolean;
  begin
    result := ParseInteger(aBuffer, aLen, aValue);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsInteger(const aString: UnicodeString): Boolean;
  begin
    result := CheckInteger(PWIDEChar(aString), Length(aString));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  class function WIDEParser.IsInteger(const aString: UnicodeString;
                                      var   aValue: Integer): Boolean;
  begin
    result := ParseInteger(PWIDEChar(aString), Length(aString), aValue);
  end;






end.
