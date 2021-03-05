
{$apptype CONSOLE}

  program test;





uses
  Deltics.Smoketest,
  Deltics.Strings in '..\src\Deltics.Strings.pas',
  Deltics.Strings.Encoding in '..\src\Deltics.Strings.Encoding.pas',
  Deltics.Strings.Encoding.Ascii in '..\src\Deltics.Strings.Encoding.Ascii.pas',
  Deltics.Strings.Encoding.Utf8 in '..\src\Deltics.Strings.Encoding.Utf8.pas',
  Deltics.Strings.Encoding.Utf16 in '..\src\Deltics.Strings.Encoding.Utf16.pas',
  Deltics.Strings.Encoding.Utf32 in '..\src\Deltics.Strings.Encoding.Utf32.pas',
  Deltics.Strings.Fns.Ansi in '..\src\Deltics.Strings.Fns.Ansi.pas',
  Deltics.Strings.Fns.Utf8 in '..\src\Deltics.Strings.Fns.Utf8.pas',
  Deltics.Strings.Fns.Utf32 in '..\src\Deltics.Strings.Fns.Utf32.pas',
  Deltics.Strings.Fns.Wide in '..\src\Deltics.Strings.Fns.Wide.pas',
  Deltics.Strings.Lists in '..\src\Deltics.Strings.Lists.pas',
  Deltics.Strings.Lists.Ansi in '..\src\Deltics.Strings.Lists.Ansi.pas',
  Deltics.Strings.Lists.String_ in '..\src\Deltics.Strings.Lists.String_.pas',
  Deltics.Strings.Lists.Utf8 in '..\src\Deltics.Strings.Lists.Utf8.pas',
  Deltics.Strings.Lists.Wide in '..\src\Deltics.Strings.Lists.Wide.pas',
  Deltics.Strings.Parsers.Ansi in '..\src\Deltics.Strings.Parsers.Ansi.pas',
  Deltics.Strings.Parsers.Ansi.AsBoolean in '..\src\Deltics.Strings.Parsers.Ansi.AsBoolean.pas',
  Deltics.Strings.Parsers.Ansi.AsDatetime in '..\src\Deltics.Strings.Parsers.Ansi.AsDatetime.pas',
  Deltics.Strings.Parsers.Ansi.AsInteger in '..\src\Deltics.Strings.Parsers.Ansi.AsInteger.pas',
  Deltics.Strings.Parsers.Wide in '..\src\Deltics.Strings.Parsers.Wide.pas',
  Deltics.Strings.Parsers.Wide.AsBoolean in '..\src\Deltics.Strings.Parsers.Wide.AsBoolean.pas',
  Deltics.Strings.Parsers.Wide.AsDatetime in '..\src\Deltics.Strings.Parsers.Wide.AsDatetime.pas',
  Deltics.Strings.Parsers.Wide.AsInteger in '..\src\Deltics.Strings.Parsers.Wide.AsInteger.pas',
  Deltics.Strings.StringBuilder in '..\src\Deltics.Strings.StringBuilder.pas',
  Deltics.Strings.Types in '..\src\Deltics.Strings.Types.pas',
  Deltics.Strings.Utils in '..\src\Deltics.Strings.Utils.pas',
  Consts in 'Consts.pas',
  Test.Runtime in 'Test.Runtime.pas',
  Test.AllocRoutines in 'Test.AllocRoutines.pas',
  Test.Transcoding in 'Test.Transcoding.pas',
  Test.Utils in 'Test.Utils.pas',
  Test.DeleteLeft in 'Test.DeleteLeft.pas',
  Test.Encoding in 'Test.Encoding.pas',
  Test.Utf32Functions in 'Test.Utf32Functions.pas',
  Test.Utf8Functions in 'Test.Utf8Functions.pas';

begin
  TestRun.Test(RuntimeTests, DELPHI_VERSION);
  TestRun.Test([AllocTests,
                TranscodingTests,
                UtilsTests]);
  TestRun.Test([DeleteLeft]);
  TestRun.Test(EncodingTests);
  TestRun.Test(Utf8Functions);
  TestRun.Test(Utf32Functions);
end.
