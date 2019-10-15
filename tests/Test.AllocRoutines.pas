
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
    pAnsi: PAnsiChar;
  begin
    pAnsi := STR.AllocAnsi(SRCS);
    try
      Assert('STR.AllocAnsi allocates a buffer', Assigned(pAnsi));
      AssertEqual('Allocated buffer is expected size', Ansi.Len(pAnsi), Length(SRCA));
      Assert('Allocated buffer contains Ansi encoded string', CompareMem(pAnsi, @SRCA[1], Length(SRCA)));
    finally
      FreeMem(pAnsi);
    end;
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure AllocTests.StrAllocUtf8AllocatesNewUtf8Buffer;
  var
    pUtf8: PUtf8Char;
  begin
    pUtf8 := STR.AllocUtf8(SRCS);
    try
      Assert('STR.AllocUtf8 allocates a buffer', Assigned(pUtf8));
      AssertEqual('Allocated buffer is expected size', Utf8.Len(pUtf8), Length(SRCU));
      Assert('Allocated buffer contains Utf8 encoded string', CompareMem(pUtf8, @SRCU[1], Length(SRCU)));
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
      Assert('STR.AllocWide allocates a buffer', Assigned(pWide));
      AssertEqual('Allocated buffer is expected size', Wide.Len(pWide), Length(SRCW));
      Assert('Allocated buffer contains Wide encoded string', CompareMem(pWide, @SRCW[1], Length(SRCW)));
    finally
      FreeMem(pWide);
    end;
  end;



end.
