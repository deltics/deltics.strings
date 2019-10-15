
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
    Test.Consts;


{ TTranscodingTests ------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromAnsiTranscodesToString;
  begin
    AssertEqual('STR.FromAnsi transcodes to String', STR.FromAnsi(SRCA), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromAnsiBufferTranscodesToString;
  begin
    AssertEqual('STR.FromAnsi buffer transcodes to String', STR.FromAnsi(@SRCA[1]), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialAnsiBufferTranscodesToStringOfCorrectLength;
  begin
    AssertEqual('STR.FromAnsi partial buffer transcodes to String of correct length', STR.FromAnsi(PAnsiChar(@SRCA[1]), 3), Copy(SRCS, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromUtf8TranscodesToString;
  begin
    AssertEqual('STR.FromUtf8 transcodes to String', STR.FromUtf8(SRCU), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromUtf8BufferTranscodesToString;
  begin
    AssertEqual('STR.FromUtf8 buffer transcodes to String', STR.FromUtf8(PUtf8Char(@SRCU[1])), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialUtf8BufferTranscodesToStringOfCorrectLength;
  begin
    AssertEqual('STR.FromUtf8 partial buffer transcodes to String of correct length', STR.FromUtf8(PUtf8Char(@SRCU[1]), 3), Copy(SRCS, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromWideTranscodesToString;
  begin
    AssertEqual('STR.FromWide transcodes to String', STR.FromWide(SRCW), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromWideBufferTranscodesToString;
  begin
    AssertEqual('STR.FromWide buffer transcodes to String', STR.FromWide(PWideChar(@SRCW[1])), SRCS);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.STRFromPartialWideBufferTranscodesToStringOfCorrectLength;
  begin
    AssertEqual('STR.FromWide partial buffer transcodes to String of correct length', STR.FromWide(PWideChar(@SRCW[1]), 3), Copy(SRCS, 1, 3));
  end;




{ Transcoding to ANSI String --------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIEncodeYieldsAnsi;
  begin
    AssertEqual('ANSI.Encode yields Ansi', ANSI.Encode(SRCS), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromStringTranscodesToANSI;
  begin
    AssertEqual('ANSI.FromString transcodes to ANSI', ANSI.FromString(SRCS), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromAnsiBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromAnsi (buffer) yields Ansi', ANSI.FromAnsi(PAnsiChar(@SRCA[1])), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialAnsiBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromAnsi (partial buffer) yields Ansi of correct length', ANSI.FromAnsi(PAnsiChar(@SRCA[1]), 3), Copy(SRCA, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunAnsiBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromAnsi (overrun buffer) yields Ansi of correct length', ANSI.FromAnsi(PAnsiChar(@SRCA[1]), 12), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyAnsiBufferYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromAnsi (empty buffer) yields empty string', ANSI.FromAnsi(PAnsiChar(@EMPTYA[1]), 10), EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromAnsiBufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromAnsi (buffer with zero max length) yields empty string', ANSI.FromAnsi(PAnsiChar(@SRCA[1]), 0), EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8YieldsAnsi;
  begin
    AssertEqual('ANSI.FromUtf8 yields Ansi', ANSI.FromUtf8(SRCU), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8BufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromUtf8 (buffer) yields Ansi', ANSI.FromUtf8(PUtf8Char(@SRCU[1])), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialUtf8BufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromUtf8 (partial buffer) yields Ansi', ANSI.FromUtf8(PUtf8Char(@SRCU[1])), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunUtf8BufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromUtf8 (buffer overrun) yields Ansi of correct length', ANSI.FromUtf8(PUtf8Char(@SRCU[1]), 12), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyUtf8BufferYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromUtf8 (empty buffer) yields empty string', ANSI.FromUtf8(PUtf8Char(@EMPTYU[1]), 10), EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromUtf8BufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromUtf8 (buffer with zero max length) yields empty string', ANSI.FromUtf8(PUtf8Char(@SRCU[1]), 0), EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideYieldsAnsi;
  begin
    AssertEqual('ANSI.FromWide yields Ansi', ANSI.FromWide(SRCW), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromWide (buffer) yields Ansi', ANSI.FromWide(PWideChar(@SRCW[1])), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromPartialWideBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromWide (partial buffer) transcodes to Ansi of correct length', ANSI.FromWide(PWideChar(@SRCW[1]), 3), Copy(SRCA, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromOverrunWideBufferYieldsAnsi;
  begin
    AssertEqual('ANSI.FromWide (buffer overrun) transcodes to Ansi of correct length', ANSI.FromWide(PWideChar(@SRCW[1]), 12), SRCA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromEmptyWideBufferYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromWide (empty wide buffer) yields empty string', ANSI.FromWide(PWideChar(@EMPTYW[1]), 10), EMPTYA);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.ANSIFromWideBufferWithZeroLengthYieldsEmptyAnsiString;
  begin
    AssertEqual('ANSI.FromWide (buffer with zero max length) yields empty string', ANSI.FromWide(PWideChar(@SRCW[1]), 0), EMPTYA);
  end;






{ Transcoding to WIDE String --------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEEncodeYieldsWide;
  begin
    AssertEqual('WIDE.Encode yields Wide', WIDE.Encode(SRCS), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromStringTranscodesToWide;
  begin
    AssertEqual('WIDE.FromString transcodes to WIDE', WIDE.FromString(SRCS), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiYieldsWide;
  begin
    AssertEqual('WIDE.FromAnsi yields Wide', WIDE.FromAnsi(SRCA), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromAnsi (buffer) yields Wide', WIDE.FromAnsi(PAnsiChar(@SRCA[1])), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialAnsiBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromAnsi (partial buffer) yields Wide of correct length', WIDE.FromAnsi(PAnsiChar(@SRCA[1]), 3), Copy(SRCW, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunAnsiBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromAnsi (overrun buffer) yields Wide of correct length', WIDE.FromAnsi(PAnsiChar(@SRCA[1]), 12), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyAnsiBufferYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromAnsi (empty buffer) yields empty string', WIDE.FromAnsi(PAnsiChar(@EMPTYA[1]), 10), EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromAnsiBufferWithZeroLengthYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromAnsi (buffer with zero max length) yields empty string', WIDE.FromAnsi(PAnsiChar(@SRCA[1]), 0), EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8YieldsWide;
  begin
    AssertEqual('WIDE.FromUtf8 yields Wide', WIDE.FromUtf8(SRCU), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8BufferYieldsWide;
  begin
    AssertEqual('WIDE.FromUtf8 (buffer) yields Wide', WIDE.FromUtf8(PUtf8Char(@SRCU[1])), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialUtf8BufferYieldsWide;
  begin
    AssertEqual('WIDE.FromUtf8 (partial buffer) yields Wide', WIDE.FromUtf8(PUtf8Char(@SRCU[1])), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunUtf8BufferYieldsWide;
  begin
    AssertEqual('WIDE.FromUtf8 (buffer overrun) yields Wide of correct length', WIDE.FromUtf8(PUtf8Char(@SRCU[1]), 12), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyUtf8BufferYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromUtf8 (empty buffer) yields empty string', WIDE.FromUtf8(PUtf8Char(@EMPTYU[1]), 10), EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromUtf8BufferWithZeroLengthYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromUtf8 (buffer with zero max length) yields empty string', WIDE.FromUtf8(PUtf8Char(@SRCU[1]), 0), EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromWideBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromWide (buffer) yields Wide', WIDE.FromWide(PWideChar(@SRCW[1])), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromPartialWideBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromWide (partial buffer) transcodes to Ansi of correct length', WIDE.FromWide(PWideChar(@SRCW[1]), 3), Copy(SRCW, 1, 3));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromOverrunWideBufferYieldsWide;
  begin
    AssertEqual('WIDE.FromWide (buffer overrun) transcodes to Ansi of correct length', WIDE.FromWide(PWideChar(@SRCW[1]), 12), SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromEmptyWideBufferYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromWide (empty wide buffer) yields empty string', WIDE.FromWide(PWideChar(@EMPTYW[1]), 10), EMPTYW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TranscodingTests.WIDEFromWideBufferWithZeroLengthYieldsEmptyWideString;
  begin
    AssertEqual('WIDE.FromWide (buffer with zero max length) yields empty string', WIDE.FromWide(PWideChar(@SRCW[1]), 0), EMPTYW);
  end;



end.
