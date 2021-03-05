{
  * X11 (MIT) LICENSE *

  Copyright © 2014 Jolyon Smith

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

{$i deltics.strings.inc}


  unit Deltics.Strings.Lists.String_;


interface

  uses
    Classes,
    Deltics.InterfacedObjects,
    Deltics.Strings.Types;


  type
    TStrings    = Classes.TStrings;
    TStringList = class;
    StringArray = Deltics.Strings.Types.StringArray;


    IStringList = interface
    ['{7623F313-9BC7-4D9C-9F9F-0A8C8E650874}']
      function get_AsArray: StringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): String;
      function get_List: TStringList;
      function get_Name(const aIndex: Integer): String;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: String): String;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: String);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: String; const aValue: String);

      function Add(const aString: String): Integer; overload;
      procedure Add(const aStrings: IStringList); overload;
      procedure Add(const aStrings: TStrings); overload;
      procedure Add(const aStrings: array of String); overload;
      procedure Clear;
      function Clone: IStringList;
      function Contains(const aString: String): Boolean;
      function ContainsName(const aName: String): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: String); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TStringsEnumerator;
    {$endif}
      function IndexOf(const aString: String): Integer;
      function IndexOfName(const aName: String): Integer;
      procedure Insert(const aIndex: Integer; const aString: String); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TStrings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

      property AsArray: StringArray read get_AsArray;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property Count: Integer read get_Count;
      property Items[const aIndex: Integer]: String read get_Item write set_Item; default;
      property List: TStringList read get_List;
      property Names[const aIndex: Integer]: String read get_Name;
      property Sorted: Boolean read get_Sorted write set_Sorted;
      property Unique: Boolean read get_Unique write set_Unique;
      property Values[const aName: String]: String read get_Value write set_Value;
    end;


    TStringlist = class(Classes.TStringList)
    {$ifdef DELPHI7}
    private
      fOwnsObjects: Boolean;
    public
      destructor Destroy; override;
      property OwnsObjects: Boolean read fOwnsObjects write fOwnsObjects;
    {$endif}
    private
      function get_Integer(const aIndex: Integer): Integer;
    public
      function Add(const aString: String): Integer; reintroduce; overload; override;
      function Add(const aString: String; const aInteger: Integer): Integer; reintroduce; overload;
      function Contains(const aString: String): Boolean;
      function ContainsName(const aName: String): Boolean;
      procedure Remove(const aString: String);
      property Integers[const aIndex: Integer]: Integer read get_Integer;
    end;


    TComInterfacedStringList = class(TComInterfacedObject, IStringList)
    private
      fList: TStringList;
      fUnique: Boolean;
      function get_AsArray: StringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): String;
      function get_List: TStringList;
      function get_Name(const aIndex: Integer): String;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: String): String;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: String);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: String; const aValue: String);
      function Add(const aString: String): Integer; overload;
      procedure Add(const aStrings: IStringList); overload;
      procedure Add(const aStrings: TStrings); overload;
      procedure Add(const aStrings: array of String); overload;
      procedure Clear;
      function Clone: IStringList;
      function Contains(const aString: String): Boolean;
      function ContainsName(const aName: String): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: String); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TStringsEnumerator;
    {$endif}
      function IndexOf(const aString: String): Integer;
      function IndexOfName(const aName: String): Integer;
      procedure Insert(const aIndex: Integer; const aString: String); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TStrings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);
    public
      constructor Create;
      destructor Destroy; override;
    end;




implementation

  uses
    RTLConsts,
    Deltics.Strings;



{ TStringList ------------------------------------------------------------------------------------ }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TStringlist.Add(const aString: String): Integer;
  begin
    result := inherited Add(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TStringlist.Add(const aString: String;
                           const aInteger: Integer): Integer;
  begin
    result := AddObject(aString, TObject(aInteger));
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TStringlist.Contains(const aString: String): Boolean;
  begin
    result := (IndexOf(aString) <> -1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TStringlist.ContainsName(const aName: String): Boolean;
  begin
    result := IndexOfName(aName) <> -1;
  end;






{$ifdef DELPHI7}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  destructor TStringList.Destroy;
  var
    i: Integer;
  begin
    if fOwnsObjects then
      for i := Pred(Count) downto 0 do
        Objects[i].Free;

    inherited Destroy;
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TStringlist.get_Integer(const aIndex: Integer): Integer;
  begin
    result := Integer(Objects[aIndex]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TStringlist.Remove(const aString: String);
  var
    idx: Integer;
  begin
    idx := IndexOf(aString);
    if idx <> -1 then
      Delete(idx);
  end;










{ TComInterfacedStringList ----------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  constructor TComInterfacedStringList.Create;
  begin
    inherited;

    fList := TStringList.Create;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.Add(const aString: String): Integer;
  begin
    result := -1;

    if fUnique then
      result := fList.IndexOf(aString);

    if (NOT fUnique) or (result = -1) then
      result := fList.Add(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Add(const aStrings: IStringList);
  begin
    Add(aStrings.List);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Add(const aStrings: TStrings);
  var
    i: Integer;
  begin
    if fList.Sorted then
      fList.AddStrings(aStrings)
    else
      for i := 0 to Pred(aStrings.Count) do
        Add(aStrings[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Add(const aStrings: array of String);
  var
    i: Integer;
    strings: IStringList;
  begin
    strings := TComInterfacedStringList.Create;
    strings.Capacity := Length(aStrings);

    for i := 0 to High(aStrings) do
      strings.Add(aStrings[i]);

    Add(strings);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Clear;
  begin
    fList.Clear;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.Clone: IStringList;
  begin
    result := TComInterfacedStringList.Create;
    result.Unique := self.get_Unique;
    result.Sorted := self.get_Sorted;
    result.Add(self);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.Contains(const aString: String): Boolean;
  begin
    result := (fList.IndexOf(aString) <> -1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.ContainsName(const aName: String): Boolean;
  begin
    result := fList.ContainsName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Delete(const aIndex: Integer);
  begin
    fList.Delete(aIndex);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Delete(const aString: String);
  var
    idx: Integer;
  begin
    idx := IndexOf(aString);
    if idx <> -1 then
      Delete(idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  destructor TComInterfacedStringList.Destroy;
  begin
    fList.Free;

    inherited;
  end;


{$ifdef ForInEnumerators}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.GetEnumerator: TStringsEnumerator;
  begin
    result := TStringsEnumerator.Create(fList);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_AsArray: StringArray;
  var
    i: Integer;
  begin
    SetLength(result, get_Count);

    for i := 0 to Pred(get_Count) do
      result[i] := fList[i];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Capacity: Integer;
  begin
    result:= fList.Capacity;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Count: Integer;
  begin
    result := fList.Count;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Item(const aIndex: Integer): String;
  begin
    result := fList[aIndex];
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_List: TStringList;
  begin
    result := fList;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Name(const aIndex: Integer): String;
  begin
    result := fList.Names[aIndex];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Sorted: Boolean;
  begin
    result := fList.Sorted;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Unique: Boolean;
  begin
    result := fUnique;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.get_Value(const aName: String): String;
  begin
    result := fList.Values[aName];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.IndexOf(const aString: String): Integer;
  begin
    result := fList.IndexOf(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedStringList.IndexOfName(const aName: String): Integer;
  begin
    result := fList.IndexOfName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Insert(const aIndex: Integer;
                                            const aStrings: TStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStrings.Count) do
      fList.Insert(aIndex + i, aStrings[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.LoadFromFile(const aFilename: String);
  begin
    fList.LoadFromFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.SaveToFile(const aFilename: String);
  begin
    fList.SaveToFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.Insert(const aIndex: Integer;
                                            const aString: String);
  begin
    fList.Insert(aIndex, aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.set_Capacity(const aValue: Integer);
  begin
    fList.Capacity := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.set_Item(const aIndex: Integer;
                                              const aValue: String);
  begin
    fList[aIndex] := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.set_Sorted(const aValue: Boolean);
  begin
    fList.Sorted := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.set_Unique(const aValue: Boolean);
  begin
    fUnique := aValue;

    if fUnique then
      fList.Duplicates := dupIgnore
    else
      fList.Duplicates := dupAccept;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedStringList.set_Value(const aName: String;
                                               const aValue: String);
  begin
    fList.Values[aName] := aValue;
  end;




end.

