
  unit Test.Transcoding;


interface

  uses
    Deltics.Smoketest;


  type
    TranscodingTests = class(TTest)
      procedure STRFromAnsiTranscodesToString;
      procedure STRFromAnsiBufferTranscodesToString;
      procedure STRFromPartialAnsiBufferTranscodesToStringOfCorrectLength;
      procedure STRFromUtf8TranscodesToString;
      procedure STRFromUtf8BufferTranscodesToString;
      procedure STRFromPartialUtf8BufferTranscodesToStringOfCorrectLength;
      procedure STRFromWideTranscodesToString;
      procedure STRFromWideBufferTranscodesToString;
      procedure STRFromPartialWideBufferTranscodesToStringOfCorrectLength;

      procedure ANSIEncodeYieldsAnsi;
      procedure ANSIFromStringTranscodesToAnsi;
      procedure ANSIFromAnsiBufferYieldsAnsi;
      procedure ANSIFromPartialAnsiBufferYieldsAnsi;
      procedure ANSIFromOverrunAnsiBufferYieldsAnsi;
      procedure ANSIFromEmptyAnsiBufferYieldsEmptyAnsiString;
      procedure ANSIFromAnsiBufferWithZeroLengthYieldsEmptyAnsiString;
      procedure ANSIFromBufferWithNILAnsiBufferYieldsEmptyAnsiString;
      procedure ANSIFromBufferWithZeroLengthAnsiBufferYieldsEmptyAnsiString;
      procedure ANSIFromBufferWithAnsiBufferYieldsAnsiString;
      procedure ANSIFromBufferWithAnsiBufferAndLengthYieldsTrimmedAnsiString;
      procedure ANSIFromBufferWithNILWideBufferYieldsEmptyAnsiString;
      procedure ANSIFromBufferWithZeroLengthWideBufferYieldsEmptyAnsiString;
      procedure ANSIFromBufferWithWideBufferYieldsAnsiString;
      procedure ANSIFromBufferWithWideBufferAndLengthYieldsTrimmedAnsiString;
      procedure ANSIFromUtf8YieldsAnsi;
      procedure ANSIFromUtf8BufferYieldsAnsi;
      procedure ANSIFromPartialUtf8BufferYieldsAnsi;
      procedure ANSIFromOverrunUtf8BufferYieldsAnsi;
      procedure ANSIFromEmptyUtf8BufferYieldsEmptyAnsiString;
      procedure ANSIFromUtf8BufferWithZeroLengthYieldsEmptyAnsiString;
      procedure ANSIFromWideYieldsAnsi;
      procedure ANSIFromWideBufferYieldsAnsi;
      procedure ANSIFromPartialWideBufferYieldsAnsi;
      procedure ANSIFromOverrunWideBufferYieldsAnsi;
      procedure ANSIFromEmptyWideBufferYieldsEmptyAnsiString;
      procedure ANSIFromWideBufferWithZeroLengthYieldsEmptyAnsiString;

      procedure WIDEEncodeYieldsWide;
      procedure WIDEFromStringTranscodesToWide;
      procedure WIDEFromAnsiYieldsWide;
      procedure WIDEFromAnsiBufferYieldsWide;
      procedure WIDEFromPartialAnsiBufferYieldsWide;
      procedure WIDEFromOverrunAnsiBufferYieldsWide;
      procedure WIDEFromEmptyAnsiBufferYieldsEmptyWideString;
      procedure WIDEFromAnsiBufferWithZeroLengthYieldsEmptyWideString;
      procedure WIDEFromUtf8YieldsWide;
      procedure WIDEFromUtf8BufferYieldsWide;
      procedure WIDEFromPartialUtf8BufferYieldsWide;
      procedure WIDEFromOverrunUtf8BufferYieldsWide;
      procedure WIDEFromEmptyUtf8BufferYieldsEmptyWideString;
      procedure WIDEFromUtf8BufferWithZeroLengthYieldsEmptyWideString;
      procedure WIDEFromWideBufferYieldsWide;
      procedure WIDEFromPartialWideBufferYieldsWide;
      procedure WIDEFromOverrunWideBufferYieldsWide;
      procedure WIDEFromEmptyWideBufferYieldsEmptyWideString;
      procedure WIDEFromWideBufferWithZeroLengthYieldsEmptyWideString;
    end;



implementation

  uses
    Deltics.Contracts,
    Deltics.Strings,
    Consts;


{ TTranscodingTests ------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromAnsiTranscodesToString;
  begin
    Test('STR.FromAnsi({SRCA})', [SRCA]).Assert(STR.FromAnsi(SRCA)).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromAnsiBufferTranscodesToString;
  begin
    Test('STR.FromAnsi(PANSIChar({SRCA}))', [SRCA]).Assert(STR.FromAnsi(@SRCA[1])).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialAnsiBufferTranscodesToStringOfCorrectLength;
  begin
    Test('STR.FromAnsi(PANSIChar({SRCA}), 3)', [SRCA]).Assert(STR.FromAnsi(@SRCA[1], 3)).Equals(Copy(SRCS, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromUtf8TranscodesToString;
  begin
    Test('STR.FromUtf8({SRCU})', [SRCU]).Assert(STR.FromUtf8(SRCU)).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromUtf8BufferTranscodesToString;
  begin
    Test('STR.FromUtf8(PUtf8Char({SRCU}))', [SRCU]).Assert(STR.FromUtf8(@SRCU[1])).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialUtf8BufferTranscodesToStringOfCorrectLength;
  begin
    Test('STR.FromUtf8(PUtf8Char({SRCU}), 3)', [SRCU]).Assert(STR.FromUtf8(@SRCU[1], 3)).Equals(Copy(SRCS, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromWideTranscodesToString;
  begin
    Test('STR.FromWide({SRCW})', [SRCW]).Assert(STR.FromWide(SRCW)).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromWideBufferTranscodesToString;
  begin
    Test('STR.FromWide(PWideChar({SRCW}))', [SRCW]).Assert(STR.FromWide(@SRCW[1])).Equals(SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialWideBufferTranscodesToStringOfCorrectLength;
  begin
    Test('STR.FromWide(PWideChar({SRCW}), 3)', [SRCW]).Assert(STR.FromWide(@SRCW[1], 3)).Equals(Copy(SRCS, 1, 3));
  end;




{ Transcoding to ANSI String --------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIEncodeYieldsAnsi;
  begin
    Test('ANSI.Encode({SRCS})', [SRCS]).Assert(ANSI.Encode(SRCS)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromStringTranscodesToANSI;
  begin
    Test('ANSI.FromString({SRCS})', [SRCS]).Assert(ANSI.FromString(SRCS)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromAnsiBufferYieldsAnsi;
  begin
    Test('ANSI.FromAnsi(PAnsiChar({SRCA}))', [SRCA]).Assert(ANSI.FromAnsi(@SRCA[1])).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialAnsiBufferYieldsAnsi;
  begin
    Test('ANSI.FromAnsi(PAnsiChar({SRCA}), 3)', [SRCA]).Assert(ANSI.FromAnsi(@SRCA[1], 3)).Equals(Copy(SRCA, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunAnsiBufferYieldsAnsi;
  begin
    Test('ANSI.FromAnsi(PAnsiChar({SRCA}), 12)', [SRCA]).Assert(ANSI.FromAnsi(@SRCA[1], 12)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyAnsiBufferYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromAnsi(PAnsiChar({EMPTYA}), 10)', [EMPTYA]).Assert(ANSI.FromAnsi(@EMPTYA[1], 10)).Equals(EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromAnsiBufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromAnsi(PAnsiChar({SRCA}), 0)', [SRCA]).Assert(ANSI.FromAnsi(@SRCA[1], 0)).Equals(EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithNILAnsiBufferYieldsEmptyAnsiString;
  const
    BUF: PANSIChar = NIL;
  begin
    Test('ANSI.FromBuffer(NIL)').Assert(ANSI.FromBuffer(BUF)).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithZeroLengthAnsiBufferYieldsEmptyAnsiString;
  var
    buf: PANSIChar;
  begin
    GetMem(buf, 1);
    try
      buf[0] := #0;

      Test('ANSI.FromBuffer([#0])').Assert(ANSI.FromBuffer(buf)).Equals('');
    finally
      FreeMem(buf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithAnsiBufferYieldsAnsiString;
  var
    s: ANSIString;
  begin
    s := 'Some string';

    Test('ANSI.FromBuffer(''Some string'')').Assert(ANSI.FromBuffer(PANSIChar(s))).Equals('Some string');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithAnsiBufferAndLengthYieldsTrimmedAnsiString;
  var
    s: ANSIString;
  begin
    s := 'Some string';

    Test('ANSI.FromBuffer(''Some string'', 4)').Assert(ANSI.FromBuffer(PANSIChar(s), 4)).Equals('Some');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithNILWideBufferYieldsEmptyAnsiString;
  const
    BUF: PWideChar = NIL;
  begin
    Test('ANSI.FromBuffer(NIL)').Assert(ANSI.FromBuffer(BUF)).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithZeroLengthWideBufferYieldsEmptyAnsiString;
  var
    buf: PWideChar;
  begin
    GetMem(buf, 1);
    try
      buf[0] := #0;

      Test('ANSI.FromBuffer([#0])').Assert(ANSI.FromBuffer(buf)).Equals('');
    finally
      FreeMem(buf);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithWideBufferYieldsAnsiString;
  var
    s: WideString;
  begin
    s := 'Some string';

    Test('ANSI.FromBuffer(''Some string'')').Assert(ANSI.FromBuffer(PWideChar(s))).Equals('Some string');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromBufferWithWideBufferAndLengthYieldsTrimmedAnsiString;
  var
    s: WideString;
  begin
    s := 'Some string';

    Test('ANSI.FromBuffer(''Some string'', 4)').Assert(ANSI.FromBuffer(PWideChar(s), 4)).Equals('Some');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8YieldsAnsi;
  begin
    Test('ANSI.FromUtf8({SRCU})', [SRCU]).Assert(ANSI.FromUtf8(SRCU)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8BufferYieldsAnsi;
  begin
    Test('ANSI.FromUtf8(PUtf8Char({SRCU}))', [SRCU]).Assert(ANSI.FromUtf8(@SRCU[1])).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialUtf8BufferYieldsAnsi;
  begin
    Test('ANSI.FromUtf8(PUtf8Char({SRCU}), 3)', [SRCU]).Assert(ANSI.FromUtf8(@SRCU[1], 3)).Equals(Copy(SRCA, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunUtf8BufferYieldsAnsi;
  begin
    Test('ANSI.FromUtf8(PUtf8Char({SRCU}), 12)', [SRCU]).Assert(ANSI.FromUtf8(@SRCU[1], 12)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyUtf8BufferYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromUtf8(PUtf8Char({EMPTYU}), 10)', [EMPTYU]).Assert(ANSI.FromUtf8(@EMPTYU[1], 10)).Equals(EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8BufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromUtf8(PUtf8Char({SRCU}), 0)', [SRCU]).Assert(ANSI.FromUtf8(@SRCU[1], 0)).Equals(EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideYieldsAnsi;
  begin
    Test('ANSI.FromWide({SRCW})', [SRCW]).Assert(ANSI.FromWide(SRCW)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideBufferYieldsAnsi;
  begin
    Test('ANSI.FromWide(PWideChar({SRCW}))', [SRCW]).Assert(ANSI.FromWide(@SRCW[1])).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialWideBufferYieldsAnsi;
  begin
    Test('ANSI.FromWide(PWideChar({SRCW}), 3)', [SRCW]).Assert(ANSI.FromWide(@SRCW[1], 3)).Equals(Copy(SRCA, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunWideBufferYieldsAnsi;
  begin
    Test('ANSI.FromWide(PWideChar({SRCW}), 12)', [SRCW]).Assert(ANSI.FromWide(@SRCW[1], 12)).Equals(SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyWideBufferYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromWide(PWideChar({EMPTYW}))', [EMPTYW]).Assert(ANSI.FromWide(@EMPTYW[1], 10)).Equals(EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideBufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    Test('ANSI.FromWide(PWideChar({SRCW}), 0)', [SRCW]).Assert(ANSI.FromWide(@SRCW[1], 0)).Equals(EMPTYA);
  end;






{ Transcoding to WIDE String --------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEEncodeYieldsWide;
  begin
    Test('WIDE.Encode({SRCS})', [SRCS]).Assert(WIDE.Encode(SRCS)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromStringTranscodesToWide;
  begin
    Test('WIDE.FromString({SRCS})', [SRCS]).Assert(WIDE.FromString(SRCS)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiYieldsWide;
  begin
    Test('WIDE.FromAnsi({SRCA})', [SRCA]).Assert(WIDE.FromAnsi(SRCA)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiBufferYieldsWide;
  begin
    Test('WIDE.FromAnsi(PAnsiChar({SRCA}))', [SRCA]).Assert(WIDE.FromAnsi(@SRCA[1])).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialAnsiBufferYieldsWide;
  begin
    Test('WIDE.FromAnsi(PAnsiChar({SRCA}), 3)', [SRCA]).Assert(WIDE.FromAnsi(@SRCA[1], 3)).Equals(Copy(SRCW, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunAnsiBufferYieldsWide;
  begin
    Test('WIDE.FromAnsi(PAnsiChar({SRCA}), 12)', [SRCA]).Assert(WIDE.FromAnsi(@SRCA[1], 12)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyAnsiBufferYieldsEmptyWideString;
  begin
    Test('WIDE.FromAnsi(PAnsiChar({EMPTYA}))', [EMPTYA]).Assert(WIDE.FromAnsi(@EMPTYA[1], 10)).Equals(EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiBufferWithZeroLengthYieldsEmptyWideString;
  begin
    Test('WIDE.FromAnsi(PAnsiChar({SRCA}), 0)', [SRCA]).Assert(WIDE.FromAnsi(@SRCA[1], 0)).Equals(EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8YieldsWide;
  begin
    Test('WIDE.FromUtf8({SRCU})', [SRCU]).Assert(WIDE.FromUtf8(SRCU)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8BufferYieldsWide;
  begin
    Test('WIDE.FromUtf8(PUtf8Char({SRCU}))', [SRCU]).Assert(WIDE.FromUtf8(@SRCU[1])).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialUtf8BufferYieldsWide;
  begin
    Test('WIDE.FromUtf8(PUtf8Char({SRCU}), 3)', [SRCU]).Assert(WIDE.FromUtf8(@SRCU[1], 3)).Equals(Copy(SRCW, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunUtf8BufferYieldsWide;
  begin
    Test('WIDE.FromUtf8(PUtf8Char({SRCU}), 12)', [SRCU]).Assert(WIDE.FromUtf8(@SRCU[1], 12)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyUtf8BufferYieldsEmptyWideString;
  begin
    Test('WIDE.FromUtf8(PUtf8Char({EMPTYU}), 10)', [EMPTYU]).Assert(WIDE.FromUtf8(@EMPTYU[1], 10)).Equals(EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8BufferWithZeroLengthYieldsEmptyWideString;
  begin
    Test('WIDE.FromUtf8(PUtf8Char({SRCU}), 0)', [SRCU]).Assert(WIDE.FromUtf8(@SRCU[1], 0)).Equals(EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromWideBufferYieldsWide;
  begin
    Test('WIDE.FromWide(PWideChar({SRCW}))', [SRCW]).Assert(WIDE.FromWide(@SRCW[1])).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialWideBufferYieldsWide;
  begin
    Test('WIDE.FromWide(PWideChar({SRCW}), 3)', [SRCW]).Assert(WIDE.FromWide(@SRCW[1], 3)).Equals(Copy(SRCW, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunWideBufferYieldsWide;
  begin
    Test('WIDE.FromWide(PWideChar({SRCW}), 12)', [SRCW]).Assert(WIDE.FromWide(@SRCW[1], 12)).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyWideBufferYieldsEmptyWideString;
  begin
    Test('WIDE.FromWide(PWideChar({EMPTYW}), 10)', [EMPTYW]).Assert(WIDE.FromWide(@EMPTYW[1], 10)).Equals(EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromWideBufferWithZeroLengthYieldsEmptyWideString;
  begin
    Test('WIDE.FromWide(PWideChar({SRCW}), 0)', [SRCW]).Assert(WIDE.FromWide(@SRCW[1], 0)).Equals(EMPTYW);
  end;



end.
