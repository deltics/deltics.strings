
{$i deltics.strings.inc}

  unit Test.AllocRoutines;

interface

  uses
    Deltics.Smoketest;


  type
    AllocTests = class(TTest)
      procedure StrAllocAnsiAllocatesNewAnsiBuffer;
      procedure StrAllocUtf8AllocatesNewUtf8Buffer;
      procedure StrAllocWideAllocatesNewWideBuffer;
    end;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Test.Consts;


{ TAllocTests ------------------------------------------------------------------------------------ }

  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure AllocTests.StrAllocAnsiAllocatesNewAnsiBuffer;
  var
    buffer: PAnsiChar;
  begin
    buffer := STR.AllocAnsi(SRCS);
    try
      Test('STR.AllocAnsi returns a buffer').Assert(Assigned(buffer));
      Test('ANSI.Len({buffer})', [buffer]).Assert(Ansi.Len(buffer)).Equals(Length(SRCA));
      Test('Buffer ({buffer}) contains correctly encoded ANSI string', [buffer]).Assert(CompareMem(buffer, @SRCA[1], Length(SRCA)));

    finally
      FreeMem(buffer);
    end;
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure AllocTests.StrAllocUtf8AllocatesNewUtf8Buffer;
  var
    pUtf8: PUtf8Char;
  begin
    pUtf8 := STR.AllocUtf8(SRCS);
    try
      Test('STR.AllocUtf8 allocates a buffer').Assert(Assigned(pUtf8));
      Test('Utf8.Len() of buffer').Assert(Utf8.Len(pUtf8)).Equals(Length(SRCU));
      Test('Allocated buffer contains Utf8 encoded string').Assert(CompareMem(pUtf8, @SRCU[1], Length(SRCU)));

    finally
      FreeMem(pUtf8);
    end;
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure AllocTests.StrAllocWideAllocatesNewWideBuffer;
  var
    pWide: PWideChar;
  begin
    pWide := STR.AllocWide(SRCS);
    try
      Test('STR.AllocWide allocates a buffer').Assert(Assigned(pWide));
      Test('WIDE.Len() of buffer').Assert(Wide.Len(pWide)).Equals(Length(SRCW));
      Test('Allocated buffer contains Wide encoded string').Assert(CompareMem(pWide, @SRCW[1], Length(SRCW)));

    finally
      FreeMem(pWide);
    end;
  end;



end.
