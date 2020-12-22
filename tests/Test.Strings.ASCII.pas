
  unit Test.Strings.ASCII;

interface

  uses
    Deltics.Smoketest;


  type
    TASCIIFnTests = class(TTest)
      procedure Transcoding;
    end;



implementation

  uses
    Deltics.Strings,
    Test.Strings;





{ TANSIFnTests }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TASCIIFnTests.Transcoding;
  var
    a: ASCIIString;
  begin
    a := ASCII.Encode(SRCS);

    Assert('ASCII.Encode encodes String as ASCII', a = SRCASCII);
    // Fluent:
    // Assert('ASCII.Encode encodes String as ASCII', [SRCS]).Expect(ASCII.Encode(SRCS)).Equals(SRCASCII);
  end;



end.
