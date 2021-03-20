
{$apptype CONSOLE}

  program test;





uses
  Deltics.Smoketest,
  Deltics.Strings in '..\src\Deltics.Strings.pas',
  Deltics.Strings.Fns.Ansi in '..\src\Deltics.Strings.Fns.Ansi.pas',
  Deltics.Strings.Fns.Utf8 in '..\src\Deltics.Strings.Fns.Utf8.pas',
  Deltics.Strings.Fns.Utf32 in '..\src\Deltics.Strings.Fns.Utf32.pas',
  Deltics.Strings.Fns.Wide in '..\src\Deltics.Strings.Fns.Wide.pas',
  Deltics.Strings.Types in '..\src\Deltics.Strings.Types.pas',
  Deltics.Strings.Utils in '..\src\Deltics.Strings.Utils.pas',
  TestConsts in 'TestConsts.pas',
  Test.Runtime in 'Test.Runtime.pas',
  Test.AllocRoutines in 'Test.AllocRoutines.pas',
  Test.Transcoding in 'Test.Transcoding.pas',
  Test.Utils in 'Test.Utils.pas',
  Test.DeleteLeft in 'Test.DeleteLeft.pas',
  Test.Utf32Functions in 'Test.Utf32Functions.pas',
  Test.Utf8Functions in 'Test.Utf8Functions.pas';

begin
  TestRun.Test(RuntimeTests, DELPHI_VERSION);
  TestRun.Test([AllocTests,
                TranscodingTests,
                UtilsTests]);
  TestRun.Test([DeleteLeft]);
  TestRun.Test(Utf8Functions);
  TestRun.Test(Utf32Functions);
end.
