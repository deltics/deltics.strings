
  unit Test.Utils;

interface

  uses
    Deltics.Smoketest;


  type
    UtilsTests = class(TTest)
      procedure CopyCharsCopiesAnsiChars;
      procedure CopyCharsCopiesWideChars;
    end;



implementation

  uses
    Deltics.Strings,
    Deltics.Strings.Utils;


{ UtilsTests }

  procedure UtilsTests.CopyCharsCopiesAnsiChars;
  var
    s: AnsiString;
  begin
    s := 'The quick brown fox';

    Utils.CopyChars(s, 5, 11, 5);

    AssertEqual('Characters are copied correctly', s, ANSI('The quick quick fox'));
  end;


  procedure UtilsTests.CopyCharsCopiesWideChars;
  var
    s: UnicodeString;
  begin
    s := 'The quick brown fox';

    Utils.CopyChars(s, 5, 11, 5);

    AssertEqual('Characters are copied correctly', s, 'The quick quick fox');
  end;




end.
