
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
    AssertEqual('sizeof(Char) is {expected} bytes', sizeof(Char), {$ifdef UNICODE} 2 {$else} 1 {$endif});
  end;


  procedure RuntimeTests.SizeOfAnsiCharIsOneByte;
  begin
    AssertEqual('sizeof(AnsiChar) is 1 byte', sizeof(AnsiChar), 1);
  end;


  procedure RuntimeTests.SizeOfUtf8CharIsOneByte;
  begin
    AssertEqual('sizeof(Utf8Char) is 1 byte', sizeof(Utf8Char), 1);
  end;


  procedure RuntimeTests.SizeOfWideCharIsTwoBytes;
  begin
    AssertEqual('sizeof(WideChar) is 2 bytes', sizeof(WideChar), 2);
  end;


  procedure RuntimeTests.STRIsImplementedCorrectly;
  begin
  {$ifdef __DELPHI2007}
    Assert('STR implements Ansi routines', STR.InheritsFrom(Deltics.Strings.ANSI.ANSIFn), 'STR does not inherit from ANSIFn');
  {$endif}
  {$ifdef DELPHI2009__}
    Assert('STR implements Wide routines', STR.InheritsFrom(Deltics.Strings.WIDE.WIDEFn), 'STR does not inherit from WIDEFn');
  {$endif}
  end;


  procedure RuntimeTests.UNICODEIsDefinedCorrectly;
  begin
  {$ifdef __DELPHI2007}
    Assert('UNICODE is not $defined', {$ifdef UNICODE}FALSE{$else}TRUE{$endif});
  {$endif}
  {$ifdef DELPHI2009__}
    Assert('UNICODE is $defined!', {$ifdef UNICODE}TRUE{$else}FALSE{$endif});
  {$endif}
  end;




end.
