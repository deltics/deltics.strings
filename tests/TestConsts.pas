
  unit TestConsts;

interface

  uses
    Deltics.Strings;


  type
    TAnsiStringAB = record
      A: AnsiString;
      B: AnsiString;
    end;

    TAnsiCharAB = record
      A: AnsiChar;
      B: AnsiChar;
    end;

    TWideStringAB = record
      A: UnicodeString;
      B: UnicodeString;
    end;

    TWideCharAB = record
      A: WideChar;
      B: WideChar;
    end;

    TStringAB = record
      A: String;
      B: String;
    end;

    TUtf8StringAB = record
      A: Utf8String;
      B: Utf8String;
    end;


  const
    SRCS: String        = 'Unicode™';
    SRCA: AnsiString    = 'Unicode™';
    SRCW: UnicodeString = 'Unicode™';

    SRCASCII: ASCIIString = 'Unicode?';

    EMPTYS: String        = '';
    EMPTYA: AnsiString    = '';
    EMPTYW: UnicodeString = '';

  var
    SRCU: Utf8String;
    EMPTYU: Utf8String = '';


implementation



initialization
  SRCU := Utf8.Encode('Unicode™');
end.
