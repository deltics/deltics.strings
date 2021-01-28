
{$i deltics.strings.inc}

  unit Deltics.Strings.Types.Core;


interface

  type
  {$ifdef UNICODE}
    Utf8String    = System.Utf8String;
    UnicodeString = System.UnicodeString;
  {$else}
    Utf8String    = type AnsiString;
    UnicodeString = type WideString;
  {$endif}

    Utf8Char    = type AnsiChar;
    PUtf8Char   = ^Utf8Char;

    ASCIIString = type AnsiString;
    ASCIIChar   = type Utf8Char;


implementation



end.
