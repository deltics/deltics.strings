
{$i deltics.strings.inc}

  unit Test.Runtime;

interface

  uses
    Deltics.Smoketest,
    Deltics.Strings;


  type
    RuntimeTests = class(TTest)
      procedure SizeOfCharIsCorrect;
      procedure SizeOfUtf8CharIsOneByte;
      procedure SizeOfAnsiCharIsOneByte;
      procedure SizeOfWideCharIsTwoBytes;
      procedure UNICODEIsDefinedCorrectly;
      procedure STRIsImplementedCorrectly;
    end;



implementation

  uses
  {$ifdef __DELPHI2007}
    Deltics.Strings.ANSI;
  {$else}
    Deltics.Strings.WIDE;
  {$endif}


{ TRuntimeTests ---------------------------------------------------------------------------------- }

  procedure RuntimeTests.SizeOfCharIsCorrect;
  begin
    Test('sizeof(Char)').Assert(sizeof(Char)).Equals({$ifdef UNICODE} 2 {$else} 1 {$endif});
  end;


  procedure RuntimeTests.SizeOfAnsiCharIsOneByte;
  begin
    Test('SizeOf(AnsiChar)').Assert(sizeof(AnsiChar)).Equals(1);
  end;


  procedure RuntimeTests.SizeOfUtf8CharIsOneByte;
  begin
    Test('sizeof(Utf8Char)').Assert(sizeof(Utf8Char)).Equals(1);
  end;


  procedure RuntimeTests.SizeOfWideCharIsTwoBytes;
  begin
    Test('sizeof(WideChar)').Assert(sizeof(WideChar)).Equals(2);
  end;


  procedure RuntimeTests.STRIsImplementedCorrectly;
  begin
  {$ifdef __DELPHI2007}
    Test('STR.InheritsFrom(ANSIFn)').Assert(STR.InheritsFrom(Deltics.Strings.ANSI.ANSIFn));
  {$endif}
  {$ifdef DELPHI2009__}
    Test('STR.InheritsFrom(WIDEFn)').Assert(STR.InheritsFrom(Deltics.Strings.WIDE.WIDEFn));
  {$endif}
  end;


  procedure RuntimeTests.UNICODEIsDefinedCorrectly;
  begin
  {$ifdef __DELPHI2007}
    Test('UNICODE is not $DEFINEd').Assert({$ifdef UNICODE}FALSE{$else}TRUE{$endif});
  {$endif}
  {$ifdef DELPHI2009__}
    Test('UNICODE is $DEFINEd').Assert({$ifdef UNICODE}TRUE{$else}FALSE{$endif});
  {$endif}
  end;




end.
