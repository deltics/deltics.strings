
{$i deltics.strings.inc}

  unit Test.Utf8Functions;

interface

  uses
    Deltics.Smoketest;


  type
    Utf8Functions = class(TTest)
      procedure AppendChar;
      procedure AppendString;
      procedure StringOf;
    end;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    Consts;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf8Functions.AppendChar;
  var
    sut: Utf8String;
  begin
    sut := Utf8.Append('abc', 'd');

    Test('sut').AssertUtf8(sut).Equals('abcd');
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf8Functions.AppendString;
  var
    sut: Utf8String;
  begin
    sut := Utf8.Append('abc', 'def');

    Test('sut').AssertUtf8(sut).Equals('abcdef');
  end;


  {-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - --}
  procedure Utf8Functions.StringOf;
  var
    sut: Utf8String;
  begin
    sut := Utf8.StringOf('a', 5);

    Test('sut').AssertUtf8(sut).Equals('aaaaa');
  end;



end.
