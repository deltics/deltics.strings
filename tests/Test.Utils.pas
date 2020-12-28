
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

    Test.RaisesException(EArgumentException);
    Utils.CopyChars(s, 1, 20, 3);

    (*
       To eliminate the duplication of the test specification when asserting for expected
        exceptions, for Smoketest 2.2.0 I'd like to visit the possibility of testing exceptions
        using WITH (yes, I know) and an assertion interface returned from the Assert() with
        methods for noting the failed exception and testing any raised exception, something
        similar to:

      with Test('CopyChars() attempt to copy beyond length of string').AssertException(EArgumentException) do
      try
        Utils.CopyChars(s, 1, 20, 3);
        NoExceptionRaised;
      except
        TestRaisedException;
      end;
    *)
  end;


end.
