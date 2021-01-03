
  unit Test.Utils;

interface

  uses
    Deltics.Smoketest;


  type
    UtilsTests = class(TTest)
      procedure CopyCharsWithAnsiString;
      procedure CopyCharsWithUnicodeString;
    end;



implementation

  uses
    Deltics.Contracts,
    Deltics.Strings;


{ UtilsTests }

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
