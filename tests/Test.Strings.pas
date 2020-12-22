
  unit Test.Strings;

interface

  uses
    Deltics.Smoketest,
    Deltics.Strings;


  type
    TTestStrings = class(TTest)
    published
      procedure SizeOfChar;
    end;


    TANSIStringAB = record
      A: ANSIString;
      B: ANSIString;
    end;

    TANSICharAB = record
      A: ANSIChar;
      B: ANSIChar;
    end;

    TWIDEStringAB = record
      A: UnicodeString;
      B: UnicodeString;
    end;

    TWIDECharAB = record
      A: WideChar;
      B: WideChar;
    end;

    TStringAB = record
      A: String;
      B: String;
    end;

    TUTF8StringAB = record
      A: UTF8String;
      B: UTF8String;
    end;


  const
    SRCS: String        = 'Unicode™';
    SRCA: ANSIString    = 'Unicode™';
    SRCW: UnicodeString = 'Unicode™';

    SRCASCII: ASCIIString = 'Unicode?';
  var
    SRCU: UTF8String;



implementation

//  uses
//    Test.Strings.ANSI,
//    Test.Strings.ASCII,
//    Test.Strings.STR;
//    Test.Strings.UTF8,
//    Test.Strings.WIDE;

{ TTestStrings ----------------------------------------------------------------------------------- }

  procedure TTestStrings.SizeOfChar;
  begin
    AssertEqual('sizeof(Char) is {expected} bytes', sizeof(Char), {$ifdef UNICODE} 2 {$else} 1 {$endif});

    AssertEqual('sizeof(Utf8Char) is 1 byte', sizeof(Utf8Char), 1);
    AssertEqual('sizeof(AnsiChar) is 1 byte', sizeof(AnsiChar), 1);
    AssertEqual('sizeof(WideChar) is 2 bytes', sizeof(WideChar), 2);
  end;




initialization
  SRCU := UTF8.Encode('Unicode™');

//  TestRun.Test([//TANSITests,
                //TWIDETests,
//                TSTRTests
                //TUTF8FnTests,
                //TUTF8Tests,
                //TASCIIFnTests]
//                ]);
end.
