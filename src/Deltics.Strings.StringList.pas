{
  * X11 (MIT) LICENSE *

  Copyright � 2014 Jolyon Smith

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


  unit Deltics.Strings.StringList;


interface

  uses
    Classes,
    Deltics.Classes,
    Deltics.Strings.Types;


  type
    TALTStrings = class;
    TALTStringList = class;

  {$ifdef UNICODE}
    TWIDEStrings    = Classes.TStrings;
    TWIDEStringList = Classes.TStringList;

    TANSIStrings    = TALTStrings;
    TANSIStringList = TALTStringList;
  {$else}
    TANSIStrings    = Classes.TStrings;
    TANSIStringList = Classes.TStringList;

    TWIDEStrings    = TALTStrings;
    TWIDEStringList = TALTStringList;
  {$endif}

    TStringList = class;
    TStringArray = Deltics.Strings.Types.TStringArray;


    IStringList = interface
    ['{7623F313-9BC7-4D9C-9F9F-0A8C8E650874}']
      function get_AsArray: TStringArray;
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
      procedure Delete(const aIndex: Integer);
    {$ifdef ForInEnumerators}
      function GetEnumerator: TStringsEnumerator;
    {$endif}
      function IndexOf(const aString: String): Integer;
      function IndexOfName(const aName: String): Integer;
      procedure Insert(const aIndex: Integer; const aString: String); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TStrings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

      property AsArray: TStringArray read get_AsArray;
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
      function get_AsArray: TStringArray;
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
      procedure Delete(const aIndex: Integer);
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


  {$ifdef UNICODE}
    ALTChar   = ANSIChar;
    ALTString = ANSIString;

    PANSIStringItem = ^TANSIStringItem;
    TANSIStringItem = record
      fString: ANSIString;
      fObject: TObject;
    end;

    PANSIStringItemList = ^TANSIStringItemList;
    TANSIStringItemList = array of TANSIStringItem;

    PALTStringItem = PANSIStringItem;
    TALTStringItem = TANSIStringItem;
    PALTStringItemList = PANSIStringItemList;
    TALTStringItemList = TANSIStringItemList;
  {$else}
    ALTChar   = WIDEChar;
    ALTString = WIDEString;

    PWIDEStringItem = ^TWIDEStringItem;
    TWIDEStringItem = record
      fString: WIDEString;
      fObject: TObject;
    end;

    PWIDEStringItemList = ^TWIDEStringItemList;
    TWIDEStringItemList = array of TWIDEStringItem;

    PALTStringItem = PWIDEStringItem;
    TALTStringItem = TWIDEStringItem;
    PALTStringItemList = PWIDEStringItemList;
    TALTStringItemList = TWIDEStringItemList;
  {$endif}

    TALTStringListSortCompare = function(List: TALTStringList; Index1, Index2: Integer): Integer;

    TALTStrings = class(TPersistent)
    private
      fUpdateCount: Integer;
      function get_CommaText: ALTString;
      function get_Name(aIndex: Integer): ALTString;
      function get_Value(const aName: ALTString): ALTString;
      procedure set_CommaText(const aValue: ALTString);
      procedure set_Value(const aName, aValue: ALTString);
      procedure ReadData(aReader: TReader);
      procedure WriteData(aWriter: TWriter);
      function get_ValueFromIndex(aIndex: Integer): ALTString;
      procedure set_ValueFromIndex(aIndex: Integer; const aValue: ALTString);
    protected
      function get_Capacity: Integer; virtual;
      function get_Count: Integer; virtual; abstract;
      function get_Object(aIndex: Integer): TObject; virtual;
      function get_Text: ALTString; virtual;
      procedure set_Capacity(aNewCapacity: Integer); virtual;
      procedure set_Object(aIndex: Integer; aObject: TObject); virtual;
      procedure set_Text(const aValue: ALTString); virtual;
      procedure DefineProperties(aFiler: TFiler); override;
      procedure Error(const aMsg: String; aData: Integer); overload;
      procedure Error(aMsg: PResStringRec; aData: Integer); overload;
      function ExtractName(const aString: ALTString): ALTString;
      function Get(Index: Integer): ALTString; virtual; abstract;
      procedure Put(aIndex: Integer; const aString: ALTString); virtual;
      procedure SetUpdateState(Updating: Boolean); virtual;
      property UpdateCount: Integer read FUpdateCount;
      function CompareStrings(const S1, S2: ALTString): Integer; virtual;
    public
      function Add(const aString: ALTString): Integer; virtual;
      function AddObject(const aString: ALTString; AObject: TObject): Integer; virtual;
      procedure AddStrings(aStrings: TALTStrings); overload; virtual;
      procedure Assign(aSource: TPersistent); override;
      procedure BeginUpdate;
      procedure Clear; virtual; abstract;
      procedure Delete(aIndex: Integer); virtual; abstract;
      procedure EndUpdate;
      function Equals(aStrings: TALTStrings): Boolean; reintroduce;
      procedure Exchange(aIndex1, aIndex2: Integer); virtual;
      function IndexOf(const aString: ALTString): Integer; virtual;
      function IndexOfName(const aName: ALTString): Integer; virtual;
      function IndexOfObject(aObject: TObject): Integer; virtual;
      procedure Insert(aIndex: Integer; const aString: ALTString); virtual; abstract;
      procedure InsertObject(aIndex: Integer; const aString: ALTString; aObject: TObject); virtual;
      procedure LoadFromFile(const aFileName: string); overload; virtual;
      procedure LoadFromStream(Stream: TStream); overload; virtual;
      procedure Move(aCurIndex, aNewIndex: Integer); virtual;
      procedure SaveToFile(const aFileName: String); overload; virtual;
      procedure SaveToStream(Stream: TStream); overload; virtual;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property CommaText: ALTString read get_CommaText write set_CommaText;
      property Count: Integer read get_Count;
      property Names[aIndex: Integer]: ALTString read get_Name;
      property Objects[aIndex: Integer]: TObject read get_Object write set_Object;
      property Values[const aName: ALTString]: ALTString read get_Value write set_Value;
      property ValueFromIndex[aIndex: Integer]: ALTString read get_ValueFromIndex write set_ValueFromIndex;
      property Strings[aIndex: Integer]: ALTString read Get write Put; default;
      property Text: ALTString read get_Text write set_Text;
    end;


    TALTStringList = class(TALTStrings)
    private
      fList: TALTStringItemList;
      fCount: Integer;
      fCapacity: Integer;
      fSorted: Boolean;
      fDuplicates: TDuplicates;
      fCaseSensitive: Boolean;
      fOnChange: TNotifyEvent;
      fOnChanging: TNotifyEvent;
      fOwnsObjects: Boolean;
      fOwnedObjects: array of TObject;
      procedure ExchangeItems(aIndex1, aIndex2: Integer);
      procedure Grow;
      procedure QuickSort(L, R: Integer; aCompareFn: TALTStringListSortCompare);
      procedure set_Sorted(aValue: Boolean);
      procedure set_CaseSensitive(const aValue: Boolean);
      procedure FreeOwnedObjects;
      procedure GatherOwnedObjects;
    protected
      function get_Capacity: Integer; override;
      function get_Count: Integer; override;
      function get_Object(aIndex: Integer): TObject; override;
      procedure set_Capacity(aNewCapacity: Integer); override;
      procedure set_Object(aIndex: Integer; aObject: TObject); override;
      procedure Changed; virtual;
      procedure Changing; virtual;
      function Get(aIndex: Integer): ALTString; override;
      function GetObject(aIndex: Integer): TObject;
      procedure Put(aIndex: Integer; const aString: ALTString); override;
      procedure PutObject(aIndex: Integer; aObject: TObject);
      procedure SetUpdateState(aUpdating: Boolean); override;
      function CompareStrings(const aS1, aS2: ALTString): Integer; override;
      procedure InsertItem(aIndex: Integer; const aString: ALTString; aObject: TObject); virtual;
    public
      constructor Create; overload;
      constructor Create(aOwnsObjects: Boolean); overload;
      destructor Destroy; override;
      function Add(const aString: ALTString): Integer; override;
      function AddObject(const aString: ALTString; aObject: TObject): Integer; override;
      procedure Assign(aSource: TPersistent); override;
      procedure Clear; override;
      procedure Delete(aIndex: Integer); override;
      procedure Exchange(aIndex1, aIndex2: Integer); override;
      function Find(const aString: ALTString; var aIndex: Integer): Boolean; virtual;
      function IndexOf(const aString: ALTString): Integer; override;
      procedure Insert(aIndex: Integer; const aString: ALTString); override;
      procedure InsertObject(aIndex: Integer; const aString: ALTString; aObject: TObject); override;
      procedure Sort; virtual;
      procedure CustomSort(aCompareFn: TALTStringListSortCompare); virtual;
      property Duplicates: TDuplicates read fDuplicates write fDuplicates;
      property Sorted: Boolean read fSorted write set_Sorted;
      property CaseSensitive: Boolean read fCaseSensitive write set_CaseSensitive;
      property OnChange: TNotifyEvent read fOnChange write fOnChange;
      property OnChanging: TNotifyEvent read fOnChanging write fOnChanging;
      property OwnsObjects: Boolean read fOwnsObjects write fOwnsObjects;
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
  function TComInterfacedStringList.get_AsArray: TStringArray;
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





{$ifdef UNICODE}

  function ALT: ANSIClass; overload;
  begin
    result := ANSIFn;
  end;

{$else}

  function ALT: WIDEClass; overload;
  begin
    result := WIDEFn;
  end;

{$endif}


  const
    LineBreak         : ALTString = #13#10;
    NameValueSeparator: ALTChar   = '=';


  function StringListCompareStrings(List: TALTStringList; Index1, Index2: Integer): Integer;
  begin
    Result := List.CompareStrings(List.FList[Index1].FString,
                                  List.FList[Index2].FString);
  end;





  function TALTStrings.Add(const aString: ALTString): Integer;
  begin
    result := Count;
    Insert(result, aString);
  end;


  function TALTStrings.AddObject(const aString: ALTString;
                                        aObject: TObject): Integer;
  begin
    result := Add(aString);
    set_Object(result, aObject);
  end;


  procedure TALTStrings.AddStrings(aStrings: TALTStrings);
  var
    i: Integer;
  begin
    BeginUpdate;
    try
      for i := 0 to Pred(aStrings.Count) do
        AddObject(aStrings[i], aStrings.Objects[i]);

    finally
      EndUpdate;
    end;
  end;


  procedure TALTStrings.Assign(aSource: TPersistent);
  var
    src: TALTStrings absolute aSource;
  begin
    if aSource is TStrings then
    begin
      BeginUpdate;
      try
        Clear;
        AddStrings(src);

      finally
        EndUpdate;
      end;

      EXIT;
    end;

    inherited Assign(aSource);
  end;


  procedure TALTStrings.BeginUpdate;
  begin
    if fUpdateCount = 0 then
      SetUpdateState(TRUE);

    Inc(fUpdateCount);
  end;


  procedure TALTStrings.DefineProperties(aFiler: TFiler);

    function DoWrite: Boolean;
    begin
      if aFiler.Ancestor <> nil then
      begin
        Result := True;
        if (aFiler.Ancestor is TALTStrings) then
          result := NOT Equals(TALTStrings(aFiler.Ancestor))
      end
      else
        result := Count > 0;
    end;

  begin
    aFiler.DefineProperty('Strings', ReadData, WriteData, DoWrite);
  end;


  procedure TALTStrings.EndUpdate;
  begin
    Dec(fUpdateCount);
    if fUpdateCount = 0 then
      SetUpdateState(FALSE);
  end;


  function TALTStrings.Equals(aStrings: TALTStrings): Boolean;
  var
    i: Integer;
  begin
    result := (Count = aStrings.Count);

    if NOT result then
      EXIT;

    for i := 0 to Pred(Count) do
    begin
      result := (Get(i) = aStrings.Get(i));
      if NOT result then
        EXIT;
    end;
  end;


  {$IFOPT O+}
    // Turn off optimizations to force creating a EBP stack frame and
    // place params on the stack.
    {$DEFINE OPTIMIZATIONSON}
    {$O-}
  {$ENDIF O+}
  procedure TALTStrings.Error(const aMsg: String; aData: Integer);
  {$ifdef __DELPHI2007}
    function ReturnAddr: Pointer;
    asm
      MOV EAX,[EBP+4]
    end;
  {$endif}
  begin
    raise EStringListError.CreateFmt(aMsg, [aData]) at
    {$ifdef __DELPHI2007}
      ReturnAddr;
    {$else}
      PPointer(PByte(@aMsg) + sizeof(aMsg) + sizeof(self) + sizeof(Pointer))^;
    {$endif}
  end;

  procedure TALTStrings.Error(aMsg: PResStringRec; aData: Integer);
  {$ifdef __DELPHI2007}
    function ReturnAddr: Pointer;
    asm
      MOV EAX,[EBP+4]
    end;
  {$endif}
  begin
    raise EStringListError.CreateFmt(LoadResString(aMsg), [aData]) at
    {$ifdef __DELPHI2007}
      ReturnAddr;
    {$else}
      PPointer(PByte(@aMsg) + sizeof(aMsg) + sizeof(self) + sizeof(Pointer))^;
    {$endif}
  end;
  {$IFDEF OPTIMIZATIONSON}
    {$UNDEF OPTIMIZATIONSON}
    {$O+}
  {$ENDIF OPTIMIZATIONSON}


  procedure TALTStrings.Exchange(aIndex1, aIndex2: Integer);
  var
    TempObject: TObject;
    TempString: ALTString;
  begin
    BeginUpdate;
    try
      TempString := Strings[aIndex1];
      TempObject := Objects[aIndex1];
      Strings[aIndex1] := Strings[aIndex2];
      Objects[aIndex1] := Objects[aIndex2];
      Strings[aIndex2] := TempString;
      Objects[aIndex2] := TempObject;

    finally
      EndUpdate;
    end;
  end;


  function TALTStrings.ExtractName(const aString: ALTString): ALTString;
  var
  {$ifdef UNICODE}          // Cannot use ALTString in this case since ALTString == WIDEString
    n, v: ANSIString;       //  and for the var params in the Split() method, the compiler
  {$else}                   //  insists that we use the declared type.
    n, v: UnicodeString;
  {$endif}
  begin
    ALT.Split(aString, ALTChar('='), n, v);
    result := n;
  end;


  function TALTStrings.get_Capacity: Integer;
  begin  // descendents may optionally override/replace this default implementation
    Result := Count;
  end;


  function TALTStrings.get_CommaText: ALTString;
  begin
    // result := GetDelimitedText;
  end;


(*
  function TALTStrings.GetDelimitedText: ALTString;
  var
    S: string;
    P: PChar;
    I, Count: Integer;
    LDelimiters: set of Char;
  begin
    Count := GetCount;
    if (Count = 1) and (Get(0) = '') then
      Result := QuoteChar + QuoteChar
    else
    begin
      Result := '';
      LDelimiters := [Char(#0), Char(QuoteChar), Char(Delimiter)];
      if not StrictDelimiter then
        LDelimiters := LDelimiters + [Char(#1)..Char(' ')];
      for I := 0 to Count - 1 do
      begin
        S := Get(I);
        P := PChar(S);
        while not (P^ in LDelimiters) do
          P := NextChar(P);
        if (P^ <> #0) then S := AnsiQuotedStr(S, QuoteChar);
        Result := Result + S + Delimiter;
      end;
      System.Delete(Result, Length(Result), 1);
    end;
  end;
*)

  function TALTStrings.get_Name(aIndex: Integer): ALTString;
  begin
    Result := ExtractName(Get(aIndex));
  end;


  function TALTStrings.get_Object(aIndex: Integer): TObject;
  begin
    result := NIL;
  end;


  function TALTStrings.get_Text: ALTString;
  var
    I, L, Size, Count: Integer;
    P: PChar;
    S, LB: ALTString;
  begin
    Count := get_Count;
    Size := 0;
    LB := LineBreak;
    for I := 0 to Count - 1 do Inc(Size, Length(Get(I)) + Length(LB));
    SetString(Result, nil, Size);
    P := Pointer(Result);
    for I := 0 to Count - 1 do
    begin
      S := Get(I);
      L := Length(S);
      if L <> 0 then
      begin
        System.Move(Pointer(S)^, P^, L * SizeOf(Char));
        Inc(P, L);
      end;
      L := Length(LB);
      if L <> 0 then
      begin
        System.Move(Pointer(LB)^, P^, L * SizeOf(Char));
        Inc(P, L);
      end;
    end;
  end;


  function TALTStrings.get_Value(const aName: ALTString): ALTString;
  var
    i: Integer;
  begin
    i := IndexOfName(aName);
    if i >= 0 then
      result := Copy(Get(i), Length(aName) + 2, MaxInt)
    else
      result := '';
  end;


  function TALTStrings.IndexOf(const aString: ALTString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if CompareStrings(Get(result), aString) = 0 then
        EXIT;

    result := -1;
  end;


  function TALTStrings.IndexOfName(const aName: ALTString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if ALT.BeginsWith(Get(result), aName) then
        EXIT;

    result := -1;
  end;


  function TALTStrings.IndexOfObject(aObject: TObject): Integer;
  begin
    for result := 0 to Pred(Count) do
      if get_Object(result) = aObject then
        EXIT;

    result := -1;
  end;


  procedure TALTStrings.InsertObject(aIndex: Integer; const aString: ALTString; aObject: TObject);
  begin
    Insert(aIndex, aString);
    set_Object(aIndex, aObject);
  end;


  procedure TALTStrings.LoadFromFile(const aFileName: String);
//  var
//    Stream: TStream;
  begin
    // TODO:
(*
    Stream := TFileStream.Create(aFileName, fmOpenRead or fmShareDenyWrite);
    try
      LoadFromStream(Stream);

    finally
      Stream.Free;
    end;
*)
  end;


  procedure TALTStrings.LoadFromStream(Stream: TStream);
  begin
    // TODO
  end;


  procedure TALTStrings.Move(aCurIndex, aNewIndex: Integer);
  var
    TempObject: TObject;
    TempString: ALTString;
  begin
    if aCurIndex <> aNewIndex then
    begin
      BeginUpdate;
      try
        TempString := Get(aCurIndex);
        TempObject := get_Object(aCurIndex);

        set_Object(aCurIndex, NIL);
        Delete(aCurIndex);

        InsertObject(aNewIndex, TempString, TempObject);

      finally
        EndUpdate;
      end;
    end;
  end;


  procedure TALTStrings.Put(aIndex: Integer; const aString: ALTString);
  var
    TempObject: TObject;
  begin
    TempObject := get_Object(aIndex);
    Delete(aIndex);
    InsertObject(aIndex, aString, TempObject);
  end;


  procedure TALTStrings.set_Object(aIndex: Integer; aObject: TObject);
  begin
    // NO-OP - override in descendants
  end;


  procedure TALTStrings.ReadData(aReader: TReader);
  begin
    aReader.ReadListBegin;

    BeginUpdate;
    try
      Clear;
      while NOT aReader.EndOfList do
      {$ifdef UNICODE}
        Add(ANSI.FromWIDE(aReader.ReadString));
      {$else}
        Add(aReader.ReadWideString);
      {$endif}

    finally
      EndUpdate;
    end;

    aReader.ReadListEnd;
  end;


  procedure TALTStrings.SaveToFile(const aFileName: String);
  begin
    // TODO:
  end;


  procedure TALTStrings.SaveToStream(Stream: TStream);
  begin
    // TODO:
  end;


  procedure TALTStrings.set_Capacity(aNewCapacity: Integer);
  begin
    // do nothing - descendents may optionally implement this method
  end;


  procedure TALTStrings.set_CommaText(const aValue: ALTString);
  begin
    // TODO:
  end;


  procedure TALTStrings.set_Text(const aValue: ALTString);
  var
    P, Start: PWIDEChar;
    S: ALTString;
  begin
    BeginUpdate;
    try
      Clear;
      P := Pointer(aValue);
      if P <> NIL then
        // This is a lot faster than using StrPos/AnsiStrPos when
        // LineBreak is the default (#13#10)
        while P^ <> #0 do
        begin
          Start := P;
          while NOT (ANSIChar(P^) in [#0, #10, #13]) do Inc(P);

          SetString(S, Start, P - Start);
          Add(S);

          if P^ = WIDEChar(#13) then Inc(P);
          if P^ = WIDEChar(#10) then Inc(P);
        end;

    finally
      EndUpdate;
    end;
  end;

  procedure TALTStrings.SetUpdateState(Updating: Boolean);
  begin
  end;


  procedure TALTStrings.set_Value(const aName, aValue: ALTString);
  var
    I: Integer;
  begin
    I := IndexOfName(aName);
    if aValue <> '' then
    begin
      if I < 0 then I := Add('');
      Put(I, aName + NameValueSeparator + aValue);
    end
    else
    begin
      if I >= 0 then Delete(I);
    end;
  end;


  procedure TALTStrings.WriteData(aWriter: TWriter);
  var
    i: Integer;
  begin
    aWriter.WriteListBegin;

    for i := 0 to Pred(Count) do
    {$ifdef UNICODE}
      aWriter.WriteString(WIDE.FromANSI(Get(i)));
    {$else}
      aWriter.WriteWideString(Get(i));
    {$endif}

    aWriter.WriteListEnd;
  end;


  function TALTStrings.CompareStrings(const S1, S2: ALTString): Integer;
  begin
    result := ALT.Compare(S1, S2);
  end;


  function TALTStrings.get_ValueFromIndex(aIndex: Integer): ALTString;
  var
    value: {$ifdef UNICODE}ANSIString{$else}UnicodeString{$endif};
    p: Integer;
  begin
    if aIndex >= 0 then
    begin
      value := Get(aIndex);

      if ALT.Find(value, NameValueSeparator, p) then
        ALT.DeleteLeft(value, p)
      else
        result := '';
    end
    else
      result := '';
  end;


  procedure TALTStrings.set_ValueFromIndex(      aIndex: Integer;
                                            const aValue: ALTString);
  begin
    if aValue <> '' then
    begin
      if aIndex < 0 then
        aIndex := Add('');

      Put(aIndex, Names[aIndex] + NameValueSeparator + aValue);
    end
    else if aIndex >= 0 then
      Delete(aIndex);
  end;








  constructor TALTStringList.Create;
  begin
    inherited Create;
  end;


  constructor TALTStringList.Create(aOwnsObjects: Boolean);
  begin
    inherited Create;
    fOwnsObjects := aOwnsObjects;
  end;


  destructor TALTStringList.Destroy;
  begin
    fOnChange   := NIL;
    fOnChanging := NIL;

    // If the list owns the Objects gather them and free after the list is disposed

    if OwnsObjects then
      GatherOwnedObjects;

    inherited Destroy;

    fCount    := 0;
    Capacity  := 0;

    // Free the objects that were owned by the list

    FreeOwnedObjects;
  end;


  function TALTStringList.Add(const aString: ALTString): Integer;
  begin
    result := AddObject(aString, NIL);
  end;


  function TALTStringList.AddObject(const aString: ALTString;
                                          aObject: TObject): Integer;
  begin
    if NOT Sorted then
      result := fCount
    else
      if Find(aString, result) then
        case Duplicates of
          dupIgnore : EXIT;
          dupError  : Error(Pointer(@SDuplicateString), 0);
        end;

    InsertItem(result, aString, aObject);
  end;


  procedure TALTStringList.Assign(aSource: TPersistent);
  var
    src: TALTStringList absolute aSource;
  begin
    inherited Assign(aSource);

    if aSource is TALTStringList then
    begin
      fCaseSensitive  := src.fCaseSensitive;
      fDuplicates     := src.fDuplicates;
      fSorted         := src.fSorted;
    end;
  end;


  procedure TALTStringList.Changed;
  begin
    if (UpdateCount = 0) and Assigned(fOnChange) then
      fOnChange(self);
  end;


  procedure TALTStringList.Changing;
  begin
    if (UpdateCount = 0) and Assigned(fOnChanging) then
      fOnChanging(self);
  end;


  procedure TALTStringList.Clear;
  begin
    if fCount <> 0 then
    begin
      Changing;

      // If the list owns the Objects gather them and free after the list is disposed
      if OwnsObjects then
        GatherOwnedObjects;

      fCount    := 0;
      Capacity  := 0;

      // Free the objects that were owned by the list

      FreeOwnedObjects;

      Changed;
    end;
  end;

  procedure TALTStringList.Delete(aIndex: Integer);
  var
    Obj: TObject;
  begin
    if (aIndex < 0) or (aIndex >= FCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    // If this list owns its objects then free the associated TObject with this index

    if OwnsObjects then
      Obj := fList[aIndex].fObject
    else
      Obj := NIL;

    // Direct memory writing to managed array follows
    //  see http://dn.embarcadero.com/article/33423
    // Explicitly finalize the element we about to stomp on with move
    Finalize(fList[aIndex]);
    Dec(fCount);

    if aIndex < FCount then
    begin
      System.Move(fList[aIndex + 1], fList[aIndex], (fCount - aIndex) * sizeof(TALTStringItem));

      // Make sure there is no danglng pointer in the last (now unused) element

      PPointer(@fList[fCount].fString)^ := NIL;
      PPointer(@fList[fCount].fObject)^ := NIL;
    end;

    if Obj <> NIL then
      Obj.Free;

    Changed;
  end;


  procedure TALTStringList.Exchange(aIndex1, aIndex2: Integer);
  begin
    if (aIndex1 < 0) or (aIndex1 >= fCount) then Error(Pointer(@SListIndexError), aIndex1);
    if (aIndex2 < 0) or (aIndex2 >= fCount) then Error(Pointer(@SListIndexError), aIndex2);

    Changing;

    ExchangeItems(aIndex1, aIndex2);

    Changed;
  end;


  procedure TALTStringList.ExchangeItems(aIndex1, aIndex2: Integer);
  var
    Temp: Pointer;
    Item1, Item2: PALTStringItem;
  begin
    Item1 := @fList[aIndex1];
    Item2 := @fList[aIndex2];

    Temp := Pointer(Item1^.fString);
    Pointer(Item1^.fString) := Pointer(Item2^.fString);
    Pointer(Item2^.fString) := Temp;

    Temp := Pointer(Item1^.fObject);
    Pointer(Item1^.fObject) := Pointer(Item2^.fObject);
    Pointer(Item2^.fObject) := Temp;
  end;


  function TALTStringList.Find(const aString: ALTString;
                                var aIndex: Integer): Boolean;
  var
    L, H, I, C: Integer;
  begin
    result := FALSE;

    L := 0;
    H := FCount - 1;
    while L <= H do
    begin
      I := (L + H) shr 1;
      C := CompareStrings(fList[I].fString, aString);

      if C < 0 then
        L := I + 1
      else
      begin
        H := I - 1;
        if C = 0 then
        begin
          result := TRUE;
          if Duplicates <> dupAccept then
            L := I;
        end;
      end;
    end;

    aIndex := L;
  end;


  procedure TALTStringList.FreeOwnedObjects;
  var
    i: Integer;
  begin
    if Length(fOwnedObjects) > 0 then
      for i := Low(fOwnedObjects) to High(fOwnedObjects) do
        fOwnedObjects[i].Free;
  end;


  procedure TALTStringList.GatherOwnedObjects;
  var
    i, j: Integer;
  begin
    j := 0;
    SetLength(fOwnedObjects, fCount);

    for i := 0 to Pred(fCount) do
      if Assigned(fList[i].fObject) then
      begin
        fOwnedObjects[j] := fList[i].fObject;
        Inc(j);
      end;

    SetLength(fOwnedObjects, j);
  end;


  function TALTStringList.Get(aIndex: Integer): ALTString;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fString;
  end;


  function TALTStringList.get_Capacity: Integer;
  begin
    result := fCapacity;
  end;


  function TALTStringList.get_Count: Integer;
  begin
    result := fCount;
  end;


  function TALTStringList.get_Object(aIndex: Integer): TObject;
  begin
    result := GetObject(aIndex);
  end;


  procedure TALTStringList.set_Object(aIndex: Integer; aObject: TObject);
  begin
    PutObject(aIndex, aObject);
  end;


  function TALTStringList.GetObject(aIndex: Integer): TObject;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fObject;
  end;


  procedure TALTStringList.Grow;
  var
    delta: Integer;
  begin
    if fCapacity > 64 then
      delta := FCapacity div 4
    else if fCapacity > 8 then
      delta := 16
    else
      delta := 4;

    Capacity := Capacity + delta;
  end;


  function TALTStringList.IndexOf(const aString: ALTString): Integer;
  begin
    if NOT Sorted then
      result := inherited IndexOf(aString)
    else if NOT Find(aString, result) then
      result := -1;
  end;


  procedure TALTStringList.Insert(aIndex: Integer; const aString: ALTString);
  begin
    InsertObject(aIndex, aString, NIL);
  end;


  procedure TALTStringList.InsertObject(      aIndex: Integer;
                                         const aString: ALTString;
                                               aObject: TObject);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if (aIndex < 0) or (aIndex > fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    InsertItem(aIndex, aString, aObject);
  end;


  procedure TALTStringList.InsertItem(       aIndex: Integer;
                                        const aString: ALTString;
                                              aObject: TObject);
  begin
    Changing;

    if fCount = fCapacity then
      Grow;

    if aIndex < fCount then
      System.Move(fList[aIndex], fList[aIndex + 1], (fCount - aIndex) * sizeof(TALTStringItem));

    Pointer(fList[aIndex].fString) := NIL;
    Pointer(fList[aIndex].fObject) := NIL;
    fList[aIndex].fObject := aObject;
    fList[aIndex].fString := aString;

    Inc(fCount);

    Changed;
  end;


  procedure TALTStringList.Put(      aIndex: Integer;
                                const aString: ALTString);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fString := aString;

    Changed;
  end;


  procedure TALTStringList.PutObject(aIndex: Integer; aObject: TObject);
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fObject := aObject;

    Changed;
  end;


  procedure TALTStringList.QuickSort(L, R: Integer;
                                      aCompareFn: TALTStringListSortCompare);
  var
    I, J, P: Integer;
  begin
    repeat
      I := L;
      J := R;
      P := (L + R) shr 1;
      repeat
        while aCompareFn(self, I, P) < 0 do Inc(I);
        while aCompareFn(self, J, P) > 0 do Dec(J);

        if I <= J then
        begin
          if I <> J then
            ExchangeItems(I, J);

          if P = I then
            P := J
          else if P = J then
            P := I;

          Inc(I);
          Dec(J);
        end;
      until I > J;

      if L < J then QuickSort(L, J, aCompareFn);

      L := I;
    until I >= R;
  end;


  procedure TALTStringList.set_Capacity(aNewCapacity: Integer);
  begin
    if (aNewCapacity < fCount) then
      Error(Pointer(@SListCapacityError), aNewCapacity);

    if aNewCapacity <> fCapacity then
    begin
      SetLength(fList, aNewCapacity);
      fCapacity := aNewCapacity;
    end;
  end;


  procedure TALTStringList.set_Sorted(aValue: Boolean);
  begin
    if fSorted <> aValue then
    begin
      if aValue then Sort;
      fSorted := aValue;
    end;
  end;


  procedure TALTStringList.SetUpdateState(aUpdating: Boolean);
  begin
    if (aUpdating) then
      Changing
    else
      Changed;
  end;


  procedure TALTStringList.Sort;
  begin
    CustomSort(StringListCompareStrings);
  end;


  procedure TALTStringList.CustomSort(aCompareFn: TALTStringListSortCompare);
  begin
    if NOT Sorted and (fCount > 1) then
    begin
      Changing;
      QuickSort(0, fCount - 1, aCompareFn);
      Changed;
    end;
  end;


  function TALTStringList.CompareStrings(const aS1, aS2: ALTString): Integer;
  const
    CASEMODE: array[FALSE..TRUE] of TCaseSensitivity = (csIgnoreCase, csCaseSensitive);
  begin
    result := ALT.Compare(aS1, aS2, CASEMODE[CaseSensitive]);
  end;


  procedure TALTStringList.set_CaseSensitive(const aValue: Boolean);
  begin
    if aValue <> fCaseSensitive then
    begin
      fCaseSensitive := aValue;

      if Sorted then
      begin
        // Calling Sort won't sort the list because CustomSort will
        // only sort the list if it's not already sorted
        Sorted := FALSE;
        Sorted := TRUE;
      end;
    end;
  end;





end.

