
  unit Test.Strings.UTF8;

interface

  uses
    Deltics.Smoketest;


  type
    TUTF8FnTests = class(TTest)
    end;


    TUTF8Tests = class(TTest)
      procedure Transcoding;
    end;



implementation

  uses
    Math,
    Deltics.Strings,
    Test.Strings;


  var
    STR: UTF8String;
    SUB_THE: UTF8String;
    SUB_FOX: UTF8String;
    SUB_QUICK: UTF8String;
    SUB_BROWN: UTF8String;

  type
    TVECTORS = array of TUTF8StringAB;


  procedure PrepareVectors(const SRC: array of TWIDEStringAB; var VEC: TVECTORS);
  var
    i: Integer;
  begin
    SetLength(VEC, Length(SRC));
    for i := 0 to Pred(Length(SRC)) do
    begin
      VEC[i].A := UTF8.FromWide(SRC[i].A);
      VEC[i].B := UTF8.FromWide(SRC[i].B);
    end;
  end;




{ TUTF8Tests ------------------------------------------------------------------------------------- }

  procedure TUTF8Tests.Transcoding;
  const
    ENCODED: array [0..2] of Byte = (Byte('â'), Byte('„'), Byte('¢'));
  var
    tm: UTF8String;
  begin
    tm := UTF8.Encode('™');

    Test('UTF8.Encode(''™'')').Expect(Addr(tm[1])).Equals(@ENCODED[0], 3);

    Test('ANSI.FromUTF8()').Expect(ANSI.FromUTF8(tm)).Equals('™');
    Test('WIDE.FromUTF8()').Expect(WIDE.FromUTF8(tm)).Equals('™');

    TestUTF8('UTF8.Encode!').Expect(UTF8.Encode(SRCS)).Equals(SRCU);
    Test('STR.FromUTF8!').Expect(Deltics.Strings.STR.FromUTF8(SRCU)).Equals(SRCS);

    TestUTF8('FromANSI!').Expect(UTF8.FromANSI(SRCA)).Equals(SRCU);
    TestUTF8('FromWide!').Expect(UTF8.FromWide(SRCW)).Equals(SRCU);
  end;





initialization
  STR := UTF8.Encode('The quick, quick fox!  I said: The quick fox!');

  SUB_THE     := UTF8.Encode('The');
  SUB_FOX     := UTF8.Encode('fox!');
  SUB_QUICK   := UTF8.Encode('quick');
  SUB_BROWN   := UTF8.Encode('brown');


end.

