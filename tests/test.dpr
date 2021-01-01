
{$apptype CONSOLE}

  program test;

{%File '    ANSI.DeleteLeft(sa, 1)', ''}

uses
  Deltics.Smoketest,
  Deltics.Strings in '..\src\Deltics.Strings.pas',
  Deltics.Strings.ANSI in '..\src\Deltics.Strings.ANSI.pas',
  Deltics.Strings.UTF8 in '..\src\Deltics.Strings.UTF8.pas',
  Deltics.Strings.WIDE in '..\src\Deltics.Strings.WIDE.pas',
  Deltics.Strings.Encoding in '..\src\Deltics.Strings.Encoding.pas',
  Deltics.Strings.Encoding.ASCII in '..\src\Deltics.Strings.Encoding.ASCII.pas',
  Deltics.Strings.Encoding.UTF8 in '..\src\Deltics.Strings.Encoding.UTF8.pas',
  Deltics.Strings.Encoding.UTF16 in '..\src\Deltics.Strings.Encoding.UTF16.pas',
  Deltics.Strings.Encoding.UTF32 in '..\src\Deltics.Strings.Encoding.UTF32.pas',
  Deltics.Strings.Parsers.ANSI in '..\src\Deltics.Strings.Parsers.ANSI.pas',
  Deltics.Strings.Parsers.ANSI.AsBoolean in '..\src\Deltics.Strings.Parsers.ANSI.AsBoolean.pas',
  Deltics.Strings.Parsers.ANSI.AsDatetime in '..\src\Deltics.Strings.Parsers.ANSI.AsDatetime.pas',
  Deltics.Strings.Parsers.ANSI.AsInteger in '..\src\Deltics.Strings.Parsers.ANSI.AsInteger.pas',
  Deltics.Strings.Parsers.WIDE in '..\src\Deltics.Strings.Parsers.WIDE.pas',
  Deltics.Strings.Parsers.WIDE.AsBoolean in '..\src\Deltics.Strings.Parsers.WIDE.AsBoolean.pas',
  Deltics.Strings.Parsers.WIDE.AsDatetime in '..\src\Deltics.Strings.Parsers.WIDE.AsDatetime.pas',
  Deltics.Strings.Parsers.WIDE.AsInteger in '..\src\Deltics.Strings.Parsers.WIDE.AsInteger.pas',
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
  Test.DeleteLeft in 'Test.DeleteLeft.pas';

begin
  TestRun.Test(RuntimeTests, DELPHI_VERSION);
  TestRun.Test([AllocTests,
                TranscodingTests,
                UtilsTests]);
  TestRun.Test([DeleteLeft]);
end.
