{
  * X11 (MIT) LICENSE *

  Copyright © 2020 Jolyon Smith

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

  unit Deltics.Strings.Lists.Wide;


interface

  uses
    Classes,
    Deltics.InterfacedObjects,
    Deltics.Strings.Types;


  type
    TWideStrings            = class;
    TWideStringList         = class;
    TWideStringsEnumerator  = class;


    TWideStringListSortCompareFn = function(List: TWideStrings; Index1, Index2: Integer): Integer;

    PWideStringItem = ^TWideStringItem;
    TWideStringItem = record
      fString: WideString;
      fObject: TObject;
    end;

    PWideStringItemList = ^TWideStringItemList;
    TWideStringItemList = array of TWideStringItem;


    IWideStringList = interface(IStringListBase)
    ['{EB808363-A5DC-4C34-9F44-0F8AE16B4F15}']
      function get_AsArray: WideStringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): WideString;
      function get_List: TWideStringList;
      function get_Name(const aIndex: Integer): WideString;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: WideString): WideString;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: WideString);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: WideString; const aValue: WideString);

      function Add(const aString: WideString): Integer; overload;
      procedure Add(const aList: IWideStringList); overload;
      procedure Add(const aStrings: TWideStrings); overload;
      procedure Add(const aArray: WideStringArray); overload;
      procedure Clear;
      function Clone: IWideStringList;
      function Contains(const aString: WideString): Boolean;
      function ContainsName(const aName: WideString): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: WideString); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TWideStringsEnumerator;
    {$endif}
      function IndexOf(const aString: WideString): Integer;
      function IndexOfName(const aName: WideString): Integer;
      procedure Insert(const aIndex: Integer; const aString: WideString); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TWideStrings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

      property AsArray: WideStringArray read get_AsArray;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property Count: Integer read get_Count;
      property Items[const aIndex: Integer]: WideString read get_Item write set_Item; default;
      property List: TWideStringList read get_List;
      property Names[const aIndex: Integer]: WideString read get_Name;
      property Sorted: Boolean read get_Sorted write set_Sorted;
      property Unique: Boolean read get_Unique write set_Unique;
      property Values[const aName: WideString]: WideString read get_Value write set_Value;
    end;



    TWideStrings = class(TPersistent)
    private
      fUpdateCount: Integer;
      function get_CommaText: WideString;
      function get_Name(aIndex: Integer): WideString;
      function get_Value(const aName: WideString): WideString;
      procedure set_CommaText(const aValue: WideString);
      procedure set_Value(const aName, aValue: WideString);
      procedure ReadData(aReader: TReader);
      procedure WriteData(aWriter: TWriter);
      function get_ValueFromIndex(aIndex: Integer): WideString;
      procedure set_ValueFromIndex(aIndex: Integer; const aValue: WideString);
    protected
      function get_Capacity: Integer; virtual;
      function get_Count: Integer; virtual; abstract;
      function get_Object(aIndex: Integer): TObject; virtual;
      function get_Text: WideString; virtual;
      procedure set_Capacity(aNewCapacity: Integer); virtual;
      procedure set_Object(aIndex: Integer; aObject: TObject); virtual;
      procedure set_Text(const aValue: WideString); virtual;
      procedure DefineProperties(aFiler: TFiler); override;
      procedure Error(const aMsg: String; aData: Integer); overload;
      procedure Error(aMsg: PResStringRec; aData: Integer); overload;
      function ExtractName(const aString: WideString): WideString;
      function Get(Index: Integer): WideString; virtual; abstract;
      procedure Put(aIndex: Integer; const aString: WideString); virtual;
      procedure SetUpdateState(Updating: Boolean); virtual;
      property UpdateCount: Integer read FUpdateCount;
      function CompareStrings(const S1, S2: WideString): Integer; virtual;
    public
      function Add(const aString: WideString): Integer; virtual;
      function AddObject(const aString: WideString; AObject: TObject): Integer; virtual;
      procedure AddStrings(aStrings: TWideStrings); overload; virtual;
      procedure Assign(aSource: TPersistent); override;
      procedure BeginUpdate;
      procedure Clear; virtual; abstract;
      procedure Delete(aIndex: Integer); virtual; abstract;
      procedure EndUpdate;
      function Equals(aStrings: TWideStrings): Boolean; reintroduce;
      procedure Exchange(aIndex1, aIndex2: Integer); virtual;
      function IndexOf(const aString: WideString): Integer; virtual;
      function IndexOfName(const aName: WideString): Integer; virtual;
      function IndexOfObject(aObject: TObject): Integer; virtual;
      procedure Insert(aIndex: Integer; const aString: WideString); virtual; abstract;
      procedure InsertObject(aIndex: Integer; const aString: WideString; aObject: TObject); virtual;
      procedure LoadFromFile(const aFileName: string); overload; virtual;
      procedure LoadFromStream(Stream: TStream); overload; virtual;
      procedure Move(aCurIndex, aNewIndex: Integer); virtual;
      procedure SaveToFile(const aFileName: String); overload; virtual;
      procedure SaveToStream(Stream: TStream); overload; virtual;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property CommaText: WideString read get_CommaText write set_CommaText;
      property Count: Integer read get_Count;
      property Names[aIndex: Integer]: WideString read get_Name;
      property Objects[aIndex: Integer]: TObject read get_Object write set_Object;
      property Values[const aName: WideString]: WideString read get_Value write set_Value;
      property ValueFromIndex[aIndex: Integer]: WideString read get_ValueFromIndex write set_ValueFromIndex;
      property Strings[aIndex: Integer]: WideString read Get write Put; default;
      property Text: WideString read get_Text write set_Text;
    end;


    TWideStringList = class(TWideStrings)
    private
      fList: TWideStringItemList;
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
      procedure QuickSort(L, R: Integer; aCompareFn: TWideStringListSortCompareFn);
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
      function Get(aIndex: Integer): WideString; override;
      function GetObject(aIndex: Integer): TObject;
      procedure Put(aIndex: Integer; const aString: WideString); override;
      procedure PutObject(aIndex: Integer; aObject: TObject);
      procedure SetUpdateState(aUpdating: Boolean); override;
      function CompareStrings(const aS1, aS2: WideString): Integer; override;
      procedure InsertItem(aIndex: Integer; const aString: WideString; aObject: TObject); virtual;
    public
      class function CreateManaged: IWideStringList;
      constructor Create; overload;
      constructor Create(aOwnsObjects: Boolean); overload;
      destructor Destroy; override;
      function Add(const aString: WideString): Integer; override;
      function AddObject(const aString: WideString; aObject: TObject): Integer; override;
      procedure Assign(aSource: TPersistent); override;
      procedure Clear; override;
      function ContainsName(const aName: WideString): Boolean;
      procedure Delete(aIndex: Integer); override;
      procedure Exchange(aIndex1, aIndex2: Integer); override;
      function Find(const aString: WideString; var aIndex: Integer): Boolean; virtual;
      function IndexOf(const aString: WideString): Integer; override;
      procedure Insert(aIndex: Integer; const aString: WideString); override;
      procedure InsertObject(aIndex: Integer; const aString: WideString; aObject: TObject); override;
      procedure Sort; virtual;
      procedure CustomSort(aCompareFn: TWideStringListSortCompareFn); virtual;
      property Duplicates: TDuplicates read fDuplicates write fDuplicates;
      property Sorted: Boolean read fSorted write set_Sorted;
      property CaseSensitive: Boolean read fCaseSensitive write set_CaseSensitive;
      property OnChange: TNotifyEvent read fOnChange write fOnChange;
      property OnChanging: TNotifyEvent read fOnChanging write fOnChanging;
      property OwnsObjects: Boolean read fOwnsObjects write fOwnsObjects;
    end;


    TComInterfacedWideStringList = class(TComInterfacedObject, IWideStringList)
      function get_AsArray: WideStringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): WideString;
      function get_List: TWideStringList;
      function get_Name(const aIndex: Integer): WideString;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: WideString): WideString;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: WideString);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: WideString; const aValue: WideString);
    public
      function Add(const aString: WideString): Integer; overload;
      procedure Add(const aList: IWideStringList); overload;
      procedure Add(const aStrings: TWideStrings); overload;
      procedure Add(const aArray: WideStringArray); overload;
      procedure Clear;
      function Clone: IWideStringList;
      function Contains(const aString: WideString): Boolean;
      function ContainsName(const aName: WideString): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: WideString); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TWideStringsEnumerator;
    {$endif}
      function IndexOf(const aString: WideString): Integer;
      function IndexOfName(const aName: WideString): Integer;
      procedure Insert(const aIndex: Integer; const aString: WideString); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TWideStrings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

    private
      fList: TWideStringList;
      fUnique: Boolean;
    public
      constructor Create;
      destructor Destroy; override;
    end;


    TWideStringsEnumerator = class
    private
      fIndex: Integer;
      fStrings: IWideStringList;
    public
      constructor Create(aStrings: IWideStringList);
      function GetCurrent: WideString; {$ifdef InlineMethods} inline; {$endif}
      function MoveNext: Boolean;
      property Current: WideString read GetCurrent;
    end;



implementation

  uses
    RTLConsts,
    Deltics.Strings;



  const
    LineBreak         : WideString = #13#10;
    NameValueSeparator: WideChar   = '=';


  function StringListCompareStrings(List: TWideStrings; Index1, Index2: Integer): Integer;
  begin
    Result := List.CompareStrings(List[Index1], List[Index2]);
  end;





  function TWideStrings.Add(const aString: WideString): Integer;
  begin
    result := Count;
    Insert(result, aString);
  end;


  function TWideStrings.AddObject(const aString: WideString;
                                        aObject: TObject): Integer;
  begin
    result := Add(aString);
    set_Object(result, aObject);
  end;


  procedure TWideStrings.AddStrings(aStrings: TWideStrings);
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


  procedure TWideStrings.Assign(aSource: TPersistent);
  var
    src: TWideStrings absolute aSource;
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


  procedure TWideStrings.BeginUpdate;
  begin
    if fUpdateCount = 0 then
      SetUpdateState(TRUE);

    Inc(fUpdateCount);
  end;


  procedure TWideStrings.DefineProperties(aFiler: TFiler);

    function DoWrite: Boolean;
    begin
      if aFiler.Ancestor <> nil then
      begin
        Result := True;
        if (aFiler.Ancestor is TWideStrings) then
          result := NOT Equals(TWideStrings(aFiler.Ancestor))
      end
      else
        result := Count > 0;
    end;

  begin
    aFiler.DefineProperty('Strings', ReadData, WriteData, DoWrite);
  end;


  procedure TWideStrings.EndUpdate;
  begin
    Dec(fUpdateCount);
    if fUpdateCount = 0 then
      SetUpdateState(FALSE);
  end;


  function TWideStrings.Equals(aStrings: TWideStrings): Boolean;
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
  procedure TWideStrings.Error(const aMsg: String; aData: Integer);
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

  procedure TWideStrings.Error(aMsg: PResStringRec; aData: Integer);
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


  procedure TWideStrings.Exchange(aIndex1, aIndex2: Integer);
  var
    TempObject: TObject;
    TempString: WideString;
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


  function TWideStrings.ExtractName(const aString: WideString): WideString;
  var
    n, v: UnicodeString;
  begin
    Wide.Split(aString, WideChar('='), n, v);
    result := n;
  end;


  function TWideStrings.get_Capacity: Integer;
  begin  // descendents may optionally override/replace this default implementation
    Result := Count;
  end;


  function TWideStrings.get_CommaText: WideString;
  begin
    // result := GetDelimitedText;
  end;


(*
  function TWideStrings.GetDelimitedText: WideString;
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
        if (P^ <> #0) then S := WideQuotedStr(S, QuoteChar);
        Result := Result + S + Delimiter;
      end;
      System.Delete(Result, Length(Result), 1);
    end;
  end;
*)

  function TWideStrings.get_Name(aIndex: Integer): WideString;
  begin
    Result := ExtractName(Get(aIndex));
  end;


  function TWideStrings.get_Object(aIndex: Integer): TObject;
  begin
    result := NIL;
  end;


  function TWideStrings.get_Text: WideString;
  var
    I, L, Size, Count: Integer;
    P: PChar;
    S, LB: WideString;
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


  function TWideStrings.get_Value(const aName: WideString): WideString;
  var
    i: Integer;
  begin
    i := IndexOfName(aName);
    if i >= 0 then
      result := Copy(Get(i), Length(aName) + 2, MaxInt)
    else
      result := '';
  end;


  function TWideStrings.IndexOf(const aString: WideString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if CompareStrings(Get(result), aString) = 0 then
        EXIT;

    result := -1;
  end;


  function TWideStrings.IndexOfName(const aName: WideString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if Wide.BeginsWith(Get(result), aName) then
        EXIT;

    result := -1;
  end;


  function TWideStrings.IndexOfObject(aObject: TObject): Integer;
  begin
    for result := 0 to Pred(Count) do
      if get_Object(result) = aObject then
        EXIT;

    result := -1;
  end;


  procedure TWideStrings.InsertObject(aIndex: Integer; const aString: WideString; aObject: TObject);
  begin
    Insert(aIndex, aString);
    set_Object(aIndex, aObject);
  end;


  procedure TWideStrings.LoadFromFile(const aFileName: String);
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


  procedure TWideStrings.LoadFromStream(Stream: TStream);
  begin
    // TODO
  end;


  procedure TWideStrings.Move(aCurIndex, aNewIndex: Integer);
  var
    TempObject: TObject;
    TempString: WideString;
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


  procedure TWideStrings.Put(aIndex: Integer; const aString: WideString);
  var
    TempObject: TObject;
  begin
    TempObject := get_Object(aIndex);
    Delete(aIndex);
    InsertObject(aIndex, aString, TempObject);
  end;


  procedure TWideStrings.set_Object(aIndex: Integer; aObject: TObject);
  begin
    // NO-OP - override in descendants
  end;


  procedure TWideStrings.ReadData(aReader: TReader);
  begin
    aReader.ReadListBegin;

    BeginUpdate;
    try
      Clear;
      while NOT aReader.EndOfList do
      {$ifNdef UNICODE}
        Add(aReader.ReadWideString);
      {$else}
        Add(aReader.ReadString);
      {$endif}

    finally
      EndUpdate;
    end;

    aReader.ReadListEnd;
  end;


  procedure TWideStrings.SaveToFile(const aFileName: String);
  begin
    // TODO:
  end;


  procedure TWideStrings.SaveToStream(Stream: TStream);
  begin
    // TODO:
  end;


  procedure TWideStrings.set_Capacity(aNewCapacity: Integer);
  begin
    // do nothing - descendents may optionally implement this method
  end;


  procedure TWideStrings.set_CommaText(const aValue: WideString);
  begin
    // TODO:
  end;


  procedure TWideStrings.set_Text(const aValue: WideString);
  var
    P, Start: PWIDEChar;
    S: WideString;
  begin
    BeginUpdate;
    try
      Clear;
      P := Pointer(aValue);
      if P <> NIL then
        // This is a lot faster than using StrPos/WideStrPos when
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

  procedure TWideStrings.SetUpdateState(Updating: Boolean);
  begin
  end;


  procedure TWideStrings.set_Value(const aName, aValue: WideString);
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


  procedure TWideStrings.WriteData(aWriter: TWriter);
  var
    i: Integer;
  begin
    aWriter.WriteListBegin;

    for i := 0 to Pred(Count) do
    {$ifNdef UNICODE}
      aWriter.WriteWideString(Get(i));
    {$else}
      aWriter.WriteString(Get(i));
    {$endif}

    aWriter.WriteListEnd;
  end;


  function TWideStrings.CompareStrings(const S1, S2: WideString): Integer;
  begin
    result := Wide.Compare(S1, S2);
  end;


  function TWideStrings.get_ValueFromIndex(aIndex: Integer): WideString;
  var
    value: UnicodeString;
    p: Integer;
  begin
    if aIndex >= 0 then
    begin
      value := Get(aIndex);

      if Wide.Find(value, NameValueSeparator, p) then
        Wide.DeleteLeft(value, p)
      else
        result := '';
    end
    else
      result := '';
  end;


  procedure TWideStrings.set_ValueFromIndex(      aIndex: Integer;
                                            const aValue: WideString);
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








  class function TWideStringList.CreateManaged: IWideStringList;
  begin
    result := TComInterfacedWideStringList.Create;
  end;


  constructor TWideStringList.Create;
  begin
    inherited Create;
  end;


  constructor TWideStringList.Create(aOwnsObjects: Boolean);
  begin
    inherited Create;
    fOwnsObjects := aOwnsObjects;
  end;


  destructor TWideStringList.Destroy;
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


  function TWideStringList.Add(const aString: WideString): Integer;
  begin
    result := AddObject(aString, NIL);
  end;


  function TWideStringList.AddObject(const aString: WideString;
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


  procedure TWideStringList.Assign(aSource: TPersistent);
  var
    src: TWideStringList absolute aSource;
  begin
    inherited Assign(aSource);

    if aSource is TWideStringList then
    begin
      fCaseSensitive  := src.fCaseSensitive;
      fDuplicates     := src.fDuplicates;
      fSorted         := src.fSorted;
    end;
  end;


  procedure TWideStringList.Changed;
  begin
    if (UpdateCount = 0) and Assigned(fOnChange) then
      fOnChange(self);
  end;


  procedure TWideStringList.Changing;
  begin
    if (UpdateCount = 0) and Assigned(fOnChanging) then
      fOnChanging(self);
  end;


  procedure TWideStringList.Clear;
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

  procedure TWideStringList.Delete(aIndex: Integer);
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
      System.Move(fList[aIndex + 1], fList[aIndex], (fCount - aIndex) * sizeof(TWideStringItem));

      // Make sure there is no danglng pointer in the last (now unused) element

      PPointer(@fList[fCount].fString)^ := NIL;
      PPointer(@fList[fCount].fObject)^ := NIL;
    end;

    if Obj <> NIL then
      Obj.Free;

    Changed;
  end;


  procedure TWideStringList.Exchange(aIndex1, aIndex2: Integer);
  begin
    if (aIndex1 < 0) or (aIndex1 >= fCount) then Error(Pointer(@SListIndexError), aIndex1);
    if (aIndex2 < 0) or (aIndex2 >= fCount) then Error(Pointer(@SListIndexError), aIndex2);

    Changing;

    ExchangeItems(aIndex1, aIndex2);

    Changed;
  end;


  procedure TWideStringList.ExchangeItems(aIndex1, aIndex2: Integer);
  var
    Temp: Pointer;
    Item1, Item2: PWideStringItem;
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


  function TWideStringList.Find(const aString: WideString;
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


  procedure TWideStringList.FreeOwnedObjects;
  var
    i: Integer;
  begin
    if Length(fOwnedObjects) > 0 then
      for i := Low(fOwnedObjects) to High(fOwnedObjects) do
        fOwnedObjects[i].Free;
  end;


  procedure TWideStringList.GatherOwnedObjects;
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


  function TWideStringList.Get(aIndex: Integer): WideString;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fString;
  end;


  function TWideStringList.get_Capacity: Integer;
  begin
    result := fCapacity;
  end;


  function TWideStringList.get_Count: Integer;
  begin
    result := fCount;
  end;


  function TWideStringList.get_Object(aIndex: Integer): TObject;
  begin
    result := GetObject(aIndex);
  end;


  procedure TWideStringList.set_Object(aIndex: Integer; aObject: TObject);
  begin
    PutObject(aIndex, aObject);
  end;


  function TWideStringList.GetObject(aIndex: Integer): TObject;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fObject;
  end;


  procedure TWideStringList.Grow;
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


  function TWideStringList.IndexOf(const aString: WideString): Integer;
  begin
    if NOT Sorted then
      result := inherited IndexOf(aString)
    else if NOT Find(aString, result) then
      result := -1;
  end;


  procedure TWideStringList.Insert(aIndex: Integer; const aString: WideString);
  begin
    InsertObject(aIndex, aString, NIL);
  end;


  procedure TWideStringList.InsertObject(      aIndex: Integer;
                                         const aString: WideString;
                                               aObject: TObject);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if (aIndex < 0) or (aIndex > fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    InsertItem(aIndex, aString, aObject);
  end;


  procedure TWideStringList.InsertItem(       aIndex: Integer;
                                        const aString: WideString;
                                              aObject: TObject);
  begin
    Changing;

    if fCount = fCapacity then
      Grow;

    if aIndex < fCount then
      System.Move(fList[aIndex], fList[aIndex + 1], (fCount - aIndex) * sizeof(TWideStringItem));

    Pointer(fList[aIndex].fString) := NIL;
    Pointer(fList[aIndex].fObject) := NIL;
    fList[aIndex].fObject := aObject;
    fList[aIndex].fString := aString;

    Inc(fCount);

    Changed;
  end;


  procedure TWideStringList.Put(      aIndex: Integer;
                                const aString: WideString);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fString := aString;

    Changed;
  end;


  procedure TWideStringList.PutObject(aIndex: Integer; aObject: TObject);
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fObject := aObject;

    Changed;
  end;


  procedure TWideStringList.QuickSort(L, R: Integer;
                                      aCompareFn: TWideStringListSortCompareFn);
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


  procedure TWideStringList.set_Capacity(aNewCapacity: Integer);
  begin
    if (aNewCapacity < fCount) then
      Error(Pointer(@SListCapacityError), aNewCapacity);

    if aNewCapacity <> fCapacity then
    begin
      SetLength(fList, aNewCapacity);
      fCapacity := aNewCapacity;
    end;
  end;


  procedure TWideStringList.set_Sorted(aValue: Boolean);
  begin
    if fSorted <> aValue then
    begin
      if aValue then Sort;
      fSorted := aValue;
    end;
  end;


  procedure TWideStringList.SetUpdateState(aUpdating: Boolean);
  begin
    if (aUpdating) then
      Changing
    else
      Changed;
  end;


  procedure TWideStringList.Sort;
  begin
    CustomSort(StringListCompareStrings);
  end;


  procedure TWideStringList.CustomSort(aCompareFn: TWideStringListSortCompareFn);
  begin
    if NOT Sorted and (fCount > 1) then
    begin
      Changing;
      QuickSort(0, fCount - 1, aCompareFn);
      Changed;
    end;
  end;


  function TWideStringList.CompareStrings(const aS1, aS2: WideString): Integer;
  const
    CASEMODE: array[FALSE..TRUE] of TCaseSensitivity = (csIgnoreCase, csCaseSensitive);
  begin
    result := Wide.Compare(aS1, aS2, CASEMODE[CaseSensitive]);
  end;


  function TWideStringList.ContainsName(const aName: WideString): Boolean;
  begin
    result := IndexOfName(aName) <> -1;
  end;


  procedure TWideStringList.set_CaseSensitive(const aValue: Boolean);
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





{ TComInterfacedWideStringList ------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  constructor TComInterfacedWideStringList.Create;
  begin
    inherited;

    fList := TWideStringList.Create;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.Add(const aString: WideString): Integer;
  begin
    result := -1;

    if fUnique then
      result := fList.IndexOf(aString);

    if (NOT fUnique) or (result = -1) then
      result := fList.Add(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Add(const aList: IWideStringList);
  begin
    Add(aList.List);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Add(const aStrings: TWideStrings);
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
  procedure TComInterfacedWideStringList.Add(const aArray: WideStringArray);
  var
    i: Integer;
  begin
    if fList.Capacity - fList.Count < Length(aArray) then
      fList.Capacity := fList.Count + Length(aArray);

    for i := 0 to High(aArray) do
      fList.Add(aArray[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Clear;
  begin
    fList.Clear;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.Clone: IWideStringList;
  begin
    result := TComInterfacedWideStringList.Create;
    result.Unique := self.get_Unique;
    result.Sorted := self.get_Sorted;
    result.Add(self);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.Contains(const aString: WideString): Boolean;
  begin
    result := (fList.IndexOf(aString) <> -1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.ContainsName(const aName: WideString): Boolean;
  begin
    result := fList.ContainsName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Delete(const aIndex: Integer);
  begin
    fList.Delete(aIndex);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Delete(const aString: WideString);
  var
    idx: Integer;
  begin
    idx := IndexOf(aString);
    if idx <> -1 then
      Delete(idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  destructor TComInterfacedWideStringList.Destroy;
  begin
    fList.Free;

    inherited;
  end;


{$ifdef ForInEnumerators}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.GetEnumerator: TWideStringsEnumerator;
  begin
    result := TWideStringsEnumerator.Create(self);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_AsArray: WideStringArray;
  var
    i: Integer;
  begin
    SetLength(result, get_Count);

    for i := 0 to Pred(get_Count) do
      result[i] := fList[i];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Capacity: Integer;
  begin
    result:= fList.Capacity;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Count: Integer;
  begin
    result := fList.Count;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Item(const aIndex: Integer): WideString;
  begin
    result := fList[aIndex];
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_List: TWideStringList;
  begin
    result := fList;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Name(const aIndex: Integer): WideString;
  begin
    result := fList.Names[aIndex];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Sorted: Boolean;
  begin
    result := fList.Sorted;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Unique: Boolean;
  begin
    result := fUnique;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.get_Value(const aName: WideString): WideString;
  begin
    result := fList.Values[aName];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.IndexOf(const aString: WideString): Integer;
  begin
    result := fList.IndexOf(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedWideStringList.IndexOfName(const aName: WideString): Integer;
  begin
    result := fList.IndexOfName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Insert(const aIndex: Integer;
                                            const aStrings: TWideStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStrings.Count) do
      fList.Insert(aIndex + i, aStrings[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.LoadFromFile(const aFilename: String);
  begin
    fList.LoadFromFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.SaveToFile(const aFilename: String);
  begin
    fList.SaveToFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.Insert(const aIndex: Integer;
                                            const aString: WideString);
  begin
    fList.Insert(aIndex, aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.set_Capacity(const aValue: Integer);
  begin
    fList.Capacity := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.set_Item(const aIndex: Integer;
                                              const aValue: WideString);
  begin
    fList[aIndex] := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.set_Sorted(const aValue: Boolean);
  begin
    fList.Sorted := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.set_Unique(const aValue: Boolean);
  begin
    fUnique := aValue;

    if fUnique then
      fList.Duplicates := dupIgnore
    else
      fList.Duplicates := dupAccept;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedWideStringList.set_Value(const aName: WideString;
                                               const aValue: WideString);
  begin
    fList.Values[aName] := aValue;
  end;




{ TWideStringsEnumerator }

  constructor TWideStringsEnumerator.Create(aStrings: IWideStringList);
  begin
    inherited Create;

    fIndex    := -1;
    fStrings  := aStrings;

  end;


  function TWideStringsEnumerator.GetCurrent: WideString;
  begin
    result := fStrings[fIndex];
  end;


  function TWideStringsEnumerator.MoveNext: Boolean;
  begin
    result := fIndex < fStrings.Count - 1;
    if result then
      Inc(fIndex);
  end;



end.

