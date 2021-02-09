
{$i deltics.strings.inc}

  unit Deltics.Strings.Types.Core;


interface

  type
    Codepoint   = type Cardinal;
    PCodepoint  = ^Codepoint;

  {$ifdef UNICODE}
    Utf8String    = System.Utf8String;
    UnicodeString = System.UnicodeString;
  {$else}
    Utf8String    = type AnsiString;
    UnicodeString = type WideString;
  {$endif}

    Utf8Char    = type AnsiChar;
    PUtf8Char   = ^Utf8Char;

    Utf32Char   = Codepoint;
    PUtf32Char  = PCodepoint;

    AsciiString = type Utf8String;
    AsciiChar   = type Utf8Char;


implementation



end.
