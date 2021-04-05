
{$i deltics.strings.inc}

  unit Test.Utf8Functions;

interface

  uses
    Deltics.Smoketest;


  type
    Utf8Functions = class(TTest)
      procedure AppendChar;
      procedure AppendString;
      procedure Split;
      procedure StringOf;
    end;




implementation

  uses
    SysUtils,
    Deltics.Strings,
    TestConsts;


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
  procedure Utf8Functions.Split;
  var
    s: Utf8String;
    a: Utf8StringArray;
  begin
    s := 'a;b;c';
    Utf8.Split(s, ';', a);

    Test('a.Length').Assert(Length(a)).Equals(3);
    Test('a[0]').AssertUtf8(a[0]).Equals('a');
    Test('a[1]').AssertUtf8(a[1]).Equals('b');
    Test('a[2]').AssertUtf8(a[2]).Equals('c');

    s := '1a2a3';
    Utf8.Split(s, 'a', a);

    Test('a.Length').Assert(Length(a)).Equals(3);
    Test('a[0]').AssertUtf8(a[0]).Equals('1');
    Test('a[1]').AssertUtf8(a[1]).Equals('2');
    Test('a[2]').AssertUtf8(a[2]).Equals('3');

    s := 'a2a';
    Utf8.Split(s, 'a', a);

    Test('a.Length').Assert(Length(a)).Equals(3);
    Test('a[0]').AssertUtf8(a[0]).Equals('');
    Test('a[1]').AssertUtf8(a[1]).Equals('2');
    Test('a[2]').AssertUtf8(a[2]).Equals('');

    s := '1a2a3';
    Utf8.Split(s, 'A', a);

    Test('a.Length').Assert(Length(a)).Equals(1);
    Test('a[0]').AssertUtf8(a[0]).Equals('1a2a3');
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
