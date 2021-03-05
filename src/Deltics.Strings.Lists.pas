{
  * X11 (MIT) LICENSE *

  Copyright © 2013 Jolyon Smith

  Permission is hereby granted, free of charge, to any person obtaining a copy of
   this software and associated documentation files (the "Software"), to deal in
   the Software without restriction, including without limitation the rights to
   use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
   of the Software, and to permit persons to whom the Software is furnished to do
   so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.


  * GPL and Other Licenses *

  The FSF deem this license to be compatible with version 3 of the GPL.
   Compatability with other licenses should be verified by reference to those
   other license terms.


  * Contact Details *

  Original author : Jolyon Smith
  skype           : deltics
  e-mail          : <EXTLINK mailto: jsmith@deltics.co.nz>jsmith@deltics.co.nz</EXTLINK>
  website         : <EXTLINK http://www.deltics.co.nz>www.deltics.co.nz</EXTLINK>
}

{$i deltics.strings.lists.inc}

  unit Deltics.Strings.Lists;


interface

  uses
    Deltics.Strings.Lists.Ansi,
    Deltics.Strings.Lists.String_,
    Deltics.Strings.Lists.Utf8,
    Deltics.Strings.Lists.Wide,
    Deltics.Strings.Types;


  type
  {$ifdef UNICODE}
    TAnsiStringList     = Deltics.Strings.Lists.Ansi.TAnsiStringList;
    TAnsiStrings        = Deltics.Strings.Lists.Ansi.TAnsiStrings;

    TUnicodeStringList  = Deltics.Strings.Lists.String_.TStringList;
    TUnicodeStrings     = Deltics.Strings.Lists.String_.TStrings;
  {$else}
    TAnsiStringList     = Deltics.Strings.Lists.String_.TStringList;
    TAnsiStrings        = Deltics.Strings.Lists.String_.TStrings;

    TUnicodeStringList  = Deltics.Strings.Lists.Wide.TWideStringList;
    TUnicodeStrings     = Deltics.Strings.Lists.Wide.TWideStrings;
  {$endif}

    TWideStringList     = Deltics.Strings.Lists.Wide.TWideStringList;
    TWideStrings        = Deltics.Strings.Lists.Wide.TWideStrings;

    TStringList         = Deltics.Strings.Lists.String_.TStringList;
    IStringList         = Deltics.Strings.Lists.String_.IStringList;


  {$ifdef TYPE_HELPERS}
  type
    TStringListHelper = class helper for TStringList
    public
      procedure Add(const aArray: StringArray); overload;
      function AsArray: StringArray;
    end;
  {$endif TYPE_HELPERS}



implementation



{$ifdef TypeHelpers}
  procedure TStringListHelper.Add(const aArray: StringArray);
  var
    i: Integer;
  begin
    for i := 0 to High(aArray) do
      Add(aArray[i]);
  end;



  function TStringListHelper.AsArray: StringArray;
  var
    i: Integer;
  begin
    SetLength(result, Count);

    for i := 0 to Pred(Count) do
      result[i] := self[i];
  end;
{$endif}


end.
