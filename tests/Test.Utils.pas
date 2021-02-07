
  unit Test.Utils;

interface

  uses
    Deltics.Smoketest;


  type
    UtilsTests = class(TTest)
      procedure CopyCharsWithAnsiString;
      procedure CopyCharsWithUnicodeString;
      procedure AnsiIsNumericCorrectlyHandlesValues;
      procedure WideIsNumericCorrectlyHandlesValues;
    end;



implementation

  uses
    SysUtils,
    Deltics.Contracts,
    Deltics.Strings;


{ UtilsTests }

  procedure UtilsTests.AnsiIsNumericCorrectlyHandlesValues;

    procedure TestWith(const aValue: AnsiString);
    var
      e: Extended;
    begin
      Test('Ansi.IsNumeric({value}', [aValue]).Assert(Ansi.IsNumeric(aValue)).Equals(TryStrToFloat(Str.FromAnsi(aValue), e));
    end;

  begin
    TestWith('42.0');
    TestWith('4.2e1');
    TestWith('-4.2e-1');
    TestWith('42.');
    TestWith('42');
    TestWith('4.2+e1');
    TestWith('4/2');
    TestWith('abc');
    TestWith('4 e3');
  end;


  procedure UtilsTests.WideIsNumericCorrectlyHandlesValues;

    procedure TestWith(const aValue: UnicodeString);
    var
      e: Extended;
    begin
      Test('Wide.IsNumeric({value}', [aValue]).Assert(Wide.IsNumeric(aValue)).Equals(TryStrToFloat(aValue, e));
    end;

  begin
    TestWith('42.0');
    TestWith('4.2e1');
    TestWith('-4.2e-1');
    TestWith('42.');
    TestWith('42');
    TestWith('4.2+e1');
    TestWith('4/2');
    TestWith('abc');
    TestWith('4/2');
    TestWith('4 e3');
  end;



  procedure UtilsTests.CopyCharsWithAnsiString;
  var
    orgs: AnsiString;
    s: AnsiString;
  begin
    orgs := 'The quick brown fox';
    s    := orgs;

    Utils.CopyChars(s, 5, 11, 5);

    Test('Utils.CopyChars(Ansi:{s}, 5, 11, 5)', [orgs]).Assert(s).Equals(ANSI('The quick quick fox'));
  end;


  procedure UtilsTests.CopyCharsWithUnicodeString;
  var
    orgs: UnicodeString;
    s: UnicodeString;
  begin
    orgs := 'The quick brown fox';
    s    := orgs;

    Utils.CopyChars(s, 5, 11, 5);

    Test('Utils.CopyChars(Unicode:{s}, 5, 11, 5)', [orgs]).Assert(s).Equals('The quick quick fox');

    Utils.CopyChars(s, 1, 17, 3);

    Test('Utils.CopyChars(Unicode:{s}, 1, 17, 3)', [orgs]).Assert(s).Equals('The quick quick The');

    Test.Raises(EArgumentException);
    Utils.CopyChars(s, 1, 20, 3);
  end;



end.
