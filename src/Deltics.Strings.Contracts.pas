
{$i deltics.strings.inc}

  unit Deltics.Strings.Contracts;


interface

  uses
    Deltics.Contracts,
    Deltics.Strings.Types;


  type
    _StringContracts = class(_CoreContracts)
      class procedure NotASurrogate(aValue: WideChar);
      class procedure NotEmpty(const aValue: AnsiString); overload;
      class procedure NotEmpty(const aValue: AnsiString; var aReturnsLength: Integer); overload;
      class procedure NotEmpty(const aValue: UnicodeString); overload;
      class procedure NotEmpty(const aValue: UnicodeString; var aReturnsLength: Integer); overload;
      class procedure NotNull(aValue: AnsiChar); overload;
      class procedure NotNull(aValue: WideChar); overload;
      class procedure ValidIndex(const aString: AnsiString; aIndex: Integer); overload;
      class procedure ValidIndex(const aString: UnicodeString; aIndex: Integer); overload;
    end;
    StringContracts = class of _StringContracts;


  function Contract: StringContracts; overload; {$ifdef InlineMethods} inline; {$endif}


implementation

  uses
    Deltics.Strings;


  function Contract: StringContracts;
  begin
    result := _StringContracts;
  end;



  class procedure _StringContracts.NotASurrogate(aValue: WideChar);
  begin
    if Wide.IsSurrogate(aValue) then
      raise EContractViolation.Create('Argument cannot be a hi/lo surrogate');
  end;


  class procedure _StringContracts.NotEmpty(const aValue: AnsiString);
  begin
    if aValue = '' then
      raise EContractViolation.Create('Argument cannot be an empty string');
  end;


  class procedure _StringContracts.NotEmpty(const aValue: AnsiString;
                                            var   aReturnsLength: Integer);
  begin
    aReturnsLength := Length(aValue);
    if aReturnsLength = 0 then
      raise EContractViolation.Create('Argument cannot be an empty string');
  end;


  class procedure _StringContracts.NotEmpty(const aValue: UnicodeString);
  begin
    if aValue = '' then
      raise EContractViolation.Create('Argument cannot be an empty string');
  end;


  class procedure _StringContracts.NotEmpty(const aValue: UnicodeString;
                                            var   aReturnsLength: Integer);
  begin
    aReturnsLength := Length(aValue);
    if aReturnsLength = 0 then
      raise EContractViolation.Create('Argument cannot be an empty string');
  end;




  class procedure _StringContracts.NotNull(aValue: AnsiChar);
  begin
    if aValue = #0 then
      raise EContractViolation.Create('Argument cannot be null (#0)');
  end;


  class procedure _StringContracts.NotNull(aValue: WideChar);
  begin
    if aValue = #0 then
      raise EContractViolation.Create('Argument cannot be null (#0)');
  end;


  class procedure _StringContracts.ValidIndex(const aString: AnsiString;
                                                    aIndex: Integer);
  begin
    if (aIndex < 1) or (aIndex > Length(aString)) then
      raise EContractViolation.CreateFmt('Argument %d is not a valid index into string', [aIndex]);
  end;


  class procedure _StringContracts.ValidIndex(const aString: UnicodeString;
                                                    aIndex: Integer);
  begin
    if (aIndex < 1) or (aIndex > Length(aString)) then
      raise EContractViolation.CreateFmt('Argument %d is not a valid index into string', [aIndex]);
  end;


end.
