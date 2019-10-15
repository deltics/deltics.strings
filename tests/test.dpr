
{$APPTYPE CONSOLE}

  program test;

{%File '    Deltics.Strings.Utils;
'}

uses
  Deltics.Smoketest,
  Deltics.Strings in '..\src\Deltics.Strings.pas',
  Deltics.Strings.ANSI in '..\src\Deltics.Strings.ANSI.pas',
  Deltics.Strings.UTF8 in '..\src\Deltics.Strings.UTF8.pas',
  Deltics.Strings.WIDE in '..\src\Deltics.Strings.WIDE.pas',
  Deltics.Strings.Contracts in '..\src\Deltics.Strings.Contracts.pas',
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
  Test.Consts in 'Test.Consts.pas',
  Test.Runtime in 'Test.Runtime.pas',
  Test.AllocRoutines in 'Test.AllocRoutines.pas',
  Test.Transcoding in 'Test.Transcoding.pas',
  Test.Utils in 'Test.Utils.pas';

const
  DELPHI_VERSION = {$ifdef VER80}  '1' {$endif}
                   {$ifdef VER90}  '2' {$endif}
                   {$ifdef VER100} '3' {$endif}
                   {$ifdef VER120} '4' {$endif}
                   {$ifdef VER130} '5' {$endif}
                   {$ifdef VER140} '6' {$endif}
                   {$ifdef VER150} '7' {$endif}
                   {$ifdef VER160} '8' {$endif}

                   {$ifdef VER170} '2005' {$endif}
                   {$ifdef VER180} // See above
                     {$ifdef VER185}
                       '2007'
                     {$else}
                       '2006'
                     {$endif}
                   {$endif}
                   {$ifdef VER200} '2009' {$endif}
                   {$ifdef VER210} '2010' {$endif}

                   {$ifdef VER220} 'xe'  {$endif}
                   {$ifdef VER230} 'xe2' {$endif}
                   {$ifdef VER240} 'xe3' {$endif}
                   {$ifdef VER250} 'xe4' {$endif}
                   {$ifdef VER260} 'xe5' {$endif}
                   {$ifdef VER270} 'xe6' {$endif}
                   {$ifdef VER280} 'xe7' {$endif}
                   {$ifdef VER290} 'xe8' {$endif}

                   {$ifdef VER300} '10'   {$endif}
                   {$ifdef VER310} '10.1' {$endif}
                   {$ifdef VER320} '10.2' {$endif}
                   {$ifdef VER330} '10.3' {$endif};

begin
  TestRun.Test(RuntimeTests, DELPHI_VERSION);
  TestRun.Test([AllocTests,
                TranscodingTests,
                UtilsTests]);
end.
