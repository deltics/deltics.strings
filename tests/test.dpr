
{$apptype CONSOLE}

  program test;



uses
  Deltics.Smoketest,
  Deltics.Strings in '..\src\Deltics.Strings.pas',
  Deltics.Strings.Ansi in '..\src\Deltics.Strings.Ansi.pas',
  Deltics.Strings.Utf8 in '..\src\Deltics.Strings.Utf8.pas',
  Deltics.Strings.Wide in '..\src\Deltics.Strings.Wide.pas',
  Deltics.Strings.Encoding in '..\src\Deltics.Strings.Encoding.pas',
  Deltics.Strings.Encoding.Bom in '..\src\Deltics.Strings.Encoding.Bom.pas',
  Deltics.Strings.Encoding.Ascii in '..\src\Deltics.Strings.Encoding.Ascii.pas',
  Deltics.Strings.Encoding.Utf8 in '..\src\Deltics.Strings.Encoding.Utf8.pas',
  Deltics.Strings.Encoding.Utf16 in '..\src\Deltics.Strings.Encoding.Utf16.pas',
  Deltics.Strings.Encoding.Utf32 in '..\src\Deltics.Strings.Encoding.Utf32.pas',
  Deltics.Strings.Parsers.Ansi in '..\src\Deltics.Strings.Parsers.Ansi.pas',
  Deltics.Strings.Parsers.Ansi.AsBoolean in '..\src\Deltics.Strings.Parsers.Ansi.AsBoolean.pas',
  Deltics.Strings.Parsers.Ansi.AsDatetime in '..\src\Deltics.Strings.Parsers.Ansi.AsDatetime.pas',
  Deltics.Strings.Parsers.Ansi.AsInteger in '..\src\Deltics.Strings.Parsers.Ansi.AsInteger.pas',
  Deltics.Strings.Parsers.Wide in '..\src\Deltics.Strings.Parsers.Wide.pas',
  Deltics.Strings.Parsers.Wide.AsBoolean in '..\src\Deltics.Strings.Parsers.Wide.AsBoolean.pas',
  Deltics.Strings.Parsers.Wide.AsDatetime in '..\src\Deltics.Strings.Parsers.Wide.AsDatetime.pas',
  Deltics.Strings.Parsers.Wide.AsInteger in '..\src\Deltics.Strings.Parsers.Wide.AsInteger.pas',
  Deltics.Strings.StringBuilder in '..\src\Deltics.Strings.StringBuilder.pas',
  Deltics.Strings.StringList in '..\src\Deltics.Strings.StringList.pas',
  Deltics.Strings.Templates in '..\src\Deltics.Strings.Templates.pas',
  Deltics.Strings.Types in '..\src\Deltics.Strings.Types.pas',
  Deltics.Strings.Utils in '..\src\Deltics.Strings.Utils.pas',
  Test.Consts in 'Test.Consts.pas' {/  Test.Strings.STR in 'Test.Strings.STR.pas',},
  Test.Runtime in 'Test.Runtime.pas',
  Test.AllocRoutines in 'Test.AllocRoutines.pas',
  Test.Transcoding in 'Test.Transcoding.pas',
  Test.Utils in 'Test.Utils.pas',
  Test.DeleteLeft in 'Test.DeleteLeft.pas',
  Test.Encoding in 'Test.Encoding.pas';

begin
  TestRun.Test(RuntimeTests, DELPHI_VERSION);
  TestRun.Test([AllocTests,
                TranscodingTests,
                UtilsTests]);
  TestRun.Test([DeleteLeft]);
  TestRun.Test(EncodingTests);
end.
