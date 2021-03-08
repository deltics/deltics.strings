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

  unit Deltics.Strings.Lists.Utf8;


interface

  uses
    Classes,
    Deltics.InterfacedObjects,
    Deltics.Strings.Types;


  type
    TUtf8Strings           = class;
    TUtf8StringList        = class;
    TUtf8StringsEnumerator = class;

    TUtf8StringListSortCompareFn = function(List: TUtf8Strings; Index1, Index2: Integer): Integer;

    PUtf8StringItem = ^TUtf8StringItem;
    TUtf8StringItem = record
      fString: Utf8String;
      fObject: TObject;
    end;

    PUtf8StringItemList = ^TUtf8StringItemList;
    TUtf8StringItemList = array of TUtf8StringItem;


    IUtf8StringList = interface(IStringListBase)
    ['{0DB2A26C-7E8C-444E-AAE5-11B84D0C8658}']
      function get_AsArray: Utf8StringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): Utf8String;
      function get_List: TUtf8StringList;
      function get_Name(const aIndex: Integer): Utf8String;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: Utf8String): Utf8String;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: Utf8String);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: Utf8String; const aValue: Utf8String);

      function Add(const aString: Utf8String): Integer; overload;
      procedure Add(const aList: IUtf8StringList); overload;
      procedure Add(const aStrings: TUtf8Strings); overload;
      procedure Add(const aArray: Utf8StringArray); overload;
      procedure Clear;
      function Clone: IUtf8StringList;
      function Contains(const aString: Utf8String): Boolean;
      function ContainsName(const aName: Utf8String): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: Utf8String); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TUtf8StringsEnumerator;
    {$endif}
      function IndexOf(const aString: Utf8String): Integer;
      function IndexOfName(const aName: Utf8String): Integer;
      procedure Insert(const aIndex: Integer; const aString: Utf8String); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TUtf8Strings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

      property AsArray: Utf8StringArray read get_AsArray;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property Count: Integer read get_Count;
      property Items[const aIndex: Integer]: Utf8String read get_Item write set_Item; default;
      property List: TUtf8StringList read get_List;
      property Names[const aIndex: Integer]: Utf8String read get_Name;
      property Sorted: Boolean read get_Sorted write set_Sorted;
      property Unique: Boolean read get_Unique write set_Unique;
      property Values[const aName: Utf8String]: Utf8String read get_Value write set_Value;
    end;


    TUtf8Strings = class(TPersistent)
    private
      fUpdateCount: Integer;
      function get_CommaText: Utf8String;
      function get_Name(const aIndex: Integer): Utf8String;
      function get_Value(const aName: Utf8String): Utf8String;
      procedure set_CommaText(const aValue: Utf8String);
      procedure set_Value(const aName, aValue: Utf8String);
      procedure ReadData(aReader: TReader);
      procedure WriteData(aWriter: TWriter);
      function get_ValueFromIndex(aIndex: Integer): Utf8String;
      procedure set_ValueFromIndex(aIndex: Integer; const aValue: Utf8String);
    protected
      function get_Capacity: Integer; virtual;
      function get_Count: Integer; virtual; abstract;
      function get_Object(aIndex: Integer): TObject; virtual;
      function get_Text: Utf8String; virtual;
      procedure set_Capacity(aNewCapacity: Integer); virtual;
      procedure set_Object(aIndex: Integer; aObject: TObject); virtual;
      procedure set_Text(const aValue: Utf8String); virtual;
      procedure DefineProperties(aFiler: TFiler); override;
      procedure Error(const aMsg: String; aData: Integer); overload;
      procedure Error(aMsg: PResStringRec; aData: Integer); overload;
      function ExtractName(const aString: Utf8String): Utf8String;
      function Get(Index: Integer): Utf8String; virtual; abstract;
      procedure Put(aIndex: Integer; const aString: Utf8String); virtual;
      procedure SetUpdateState(Updating: Boolean); virtual;
      property UpdateCount: Integer read FUpdateCount;
      function CompareStrings(const S1, S2: Utf8String): Integer; virtual;
    public
      function Add(const aString: Utf8String): Integer; virtual;
      function AddObject(const aString: Utf8String; AObject: TObject): Integer; virtual;
      procedure AddStrings(aStrings: TUtf8Strings); overload; virtual;
      procedure Assign(aSource: TPersistent); override;
      procedure BeginUpdate;
      procedure Clear; virtual; abstract;
      procedure Delete(aIndex: Integer); virtual; abstract;
      procedure EndUpdate;
      function Equals(aStrings: TUtf8Strings): Boolean; reintroduce;
      procedure Exchange(aIndex1, aIndex2: Integer); virtual;
      function IndexOf(const aString: Utf8String): Integer; virtual;
      function IndexOfName(const aName: Utf8String): Integer; virtual;
      function IndexOfObject(aObject: TObject): Integer; virtual;
      procedure Insert(aIndex: Integer; const aString: Utf8String); virtual; abstract;
      procedure InsertObject(aIndex: Integer; const aString: Utf8String; aObject: TObject); virtual;
      procedure LoadFromFile(const aFileName: string); overload; virtual;
      procedure LoadFromStream(Stream: TStream); overload; virtual;
      procedure Move(aCurIndex, aNewIndex: Integer); virtual;
      procedure SaveToFile(const aFileName: String); overload; virtual;
      procedure SaveToStream(Stream: TStream); overload; virtual;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property CommaText: Utf8String read get_CommaText write set_CommaText;
      property Count: Integer read get_Count;
      property Names[const aIndex: Integer]: Utf8String read get_Name;
      property Objects[aIndex: Integer]: TObject read get_Object write set_Object;
      property Values[const aName: Utf8String]: Utf8String read get_Value write set_Value;
      property ValueFromIndex[aIndex: Integer]: Utf8String read get_ValueFromIndex write set_ValueFromIndex;
      property Strings[aIndex: Integer]: Utf8String read Get write Put; default;
      property Text: Utf8String read get_Text write set_Text;
    end;


    TUtf8StringList = class(TUtf8Strings)
    private
      fList: TUtf8StringItemList;
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
      procedure QuickSort(L, R: Integer; aCompareFn: TUtf8StringListSortCompareFn);
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
      function Get(aIndex: Integer): Utf8String; override;
      function GetObject(aIndex: Integer): TObject;
      procedure Put(aIndex: Integer; const aString: Utf8String); override;
      procedure PutObject(aIndex: Integer; aObject: TObject);
      procedure SetUpdateState(aUpdating: Boolean); override;
      function CompareStrings(const aS1, aS2: Utf8String): Integer; override;
      procedure InsertItem(aIndex: Integer; const aString: Utf8String; aObject: TObject); virtual;
    public
      class function CreateManaged: IUtf8StringList;
      constructor Create; overload;
      constructor Create(aOwnsObjects: Boolean); overload;
      destructor Destroy; override;
      function Add(const aString: Utf8String): Integer; override;
      function AddObject(const aString: Utf8String; aObject: TObject): Integer; override;
      procedure Assign(aSource: TPersistent); override;
      procedure Clear; override;
      function ContainsName(const aName: Utf8String): Boolean;
      procedure Delete(aIndex: Integer); override;
      procedure Exchange(aIndex1, aIndex2: Integer); override;
      function Find(const aString: Utf8String; var aIndex: Integer): Boolean; virtual;
      function IndexOf(const aString: Utf8String): Integer; override;
      procedure Insert(aIndex: Integer; const aString: Utf8String); override;
      procedure InsertObject(aIndex: Integer; const aString: Utf8String; aObject: TObject); override;
      procedure Sort; virtual;
      procedure CustomSort(aCompareFn: TUtf8StringListSortCompareFn); virtual;
      property Duplicates: TDuplicates read fDuplicates write fDuplicates;
      property Sorted: Boolean read fSorted write set_Sorted;
      property CaseSensitive: Boolean read fCaseSensitive write set_CaseSensitive;
      property OnChange: TNotifyEvent read fOnChange write fOnChange;
      property OnChanging: TNotifyEvent read fOnChanging write fOnChanging;
      property OwnsObjects: Boolean read fOwnsObjects write fOwnsObjects;
    end;


    TComInterfacedUtf8StringList = class(TComInterfacedObject, IUtf8StringList)
      function get_AsArray: Utf8StringArray;
      function get_Capacity: Integer;
      function get_Count: Integer;
      function get_Item(const aIndex: Integer): Utf8String;
      function get_List: TUtf8StringList;
      function get_Name(const aIndex: Integer): Utf8String;
      function get_Sorted: Boolean;
      function get_Unique: Boolean;
      function get_Value(const aName: Utf8String): Utf8String;
      procedure set_Capacity(const aValue: Integer);
      procedure set_Item(const aIndex: Integer; const aValue: Utf8String);
      procedure set_Sorted(const aValue: Boolean);
      procedure set_Unique(const aValue: Boolean);
      procedure set_Value(const aName: Utf8String; const aValue: Utf8String);
    public
      function Add(const aString: Utf8String): Integer; overload;
      procedure Add(const aList: IUtf8StringList); overload;
      procedure Add(const aStrings: TUtf8Strings); overload;
      procedure Add(const aArray: Utf8StringArray); overload;
      procedure Clear;
      function Clone: IUtf8StringList;
      function Contains(const aString: Utf8String): Boolean;
      function ContainsName(const aName: Utf8String): Boolean;
      procedure Delete(const aIndex: Integer); overload;
      procedure Delete(const aString: Utf8String); overload;
    {$ifdef ForInEnumerators}
      function GetEnumerator: TUtf8StringsEnumerator;
    {$endif}
      function IndexOf(const aString: Utf8String): Integer;
      function IndexOfName(const aName: Utf8String): Integer;
      procedure Insert(const aIndex: Integer; const aString: Utf8String); overload;
      procedure Insert(const aIndex: Integer; const aStrings: TUtf8Strings); overload;
      procedure LoadFromFile(const aFilename: String);
      procedure SaveToFile(const aFilename: String);

    private
      fList: TUtf8StringList;
      fUnique: Boolean;
    public
      constructor Create;
      destructor Destroy; override;
    end;


    TUtf8StringsEnumerator = class
    private
      fIndex: Integer;
      fStrings: IUtf8StringList;
    public
      constructor Create(aStrings: IUtf8StringList);
      function GetCurrent: Utf8String; {$ifdef InlineMethods} inline; {$endif}
      function MoveNext: Boolean;
      property Current: Utf8String read GetCurrent;
    end;


implementation

  uses
    RTLConsts,
    Deltics.Strings;



  const
    LineBreak         : Utf8String = #13#10;
    NameValueSeparator: Utf8Char   = '=';


  function StringListCompareStrings(List: TUtf8Strings; Index1, Index2: Integer): Integer;
  begin
    Result := List.CompareStrings(List[Index1], List[Index2]);
  end;





  function TUtf8Strings.Add(const aString: Utf8String): Integer;
  begin
    result := Count;
    Insert(result, aString);
  end;


  function TUtf8Strings.AddObject(const aString: Utf8String;
                                        aObject: TObject): Integer;
  begin
    result := Add(aString);
    set_Object(result, aObject);
  end;


  procedure TUtf8Strings.AddStrings(aStrings: TUtf8Strings);
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


  procedure TUtf8Strings.Assign(aSource: TPersistent);
  var
    src: TUtf8Strings absolute aSource;
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


  procedure TUtf8Strings.BeginUpdate;
  begin
    if fUpdateCount = 0 then
      SetUpdateState(TRUE);

    Inc(fUpdateCount);
  end;


  procedure TUtf8Strings.DefineProperties(aFiler: TFiler);

    function DoWrite: Boolean;
    begin
      if aFiler.Ancestor <> nil then
      begin
        Result := True;
        if (aFiler.Ancestor is TUtf8Strings) then
          result := NOT Equals(TUtf8Strings(aFiler.Ancestor))
      end
      else
        result := Count > 0;
    end;

  begin
    aFiler.DefineProperty('Strings', ReadData, WriteData, DoWrite);
  end;


  procedure TUtf8Strings.EndUpdate;
  begin
    Dec(fUpdateCount);
    if fUpdateCount = 0 then
      SetUpdateState(FALSE);
  end;


  function TUtf8Strings.Equals(aStrings: TUtf8Strings): Boolean;
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
  procedure TUtf8Strings.Error(const aMsg: String; aData: Integer);
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

  procedure TUtf8Strings.Error(aMsg: PResStringRec; aData: Integer);
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


  procedure TUtf8Strings.Exchange(aIndex1, aIndex2: Integer);
  var
    TempObject: TObject;
    TempString: Utf8String;
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


  function TUtf8Strings.ExtractName(const aString: Utf8String): Utf8String;
  var
    n, v: Utf8String;
  begin
    Utf8.Split(aString, Utf8Char('='), n, v);
    result := n;
  end;


  function TUtf8Strings.get_Capacity: Integer;
  begin  // descendents may optionally override/replace this default implementation
    Result := Count;
  end;


  function TUtf8Strings.get_CommaText: Utf8String;
  begin
    // result := GetDelimitedText;
  end;


(*
  function TUtf8Strings.GetDelimitedText: Utf8String;
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

  function TUtf8Strings.get_Name(const aIndex: Integer): Utf8String;
  begin
    Result := ExtractName(Get(aIndex));
  end;


  function TUtf8Strings.get_Object(aIndex: Integer): TObject;
  begin
    result := NIL;
  end;


  function TUtf8Strings.get_Text: Utf8String;
  var
    I, L, Size, Count: Integer;
    P: PChar;
    S, LB: Utf8String;
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


  function TUtf8Strings.get_Value(const aName: Utf8String): Utf8String;
  var
    i: Integer;
  begin
    i := IndexOfName(aName);
    if i >= 0 then
      result := Copy(Get(i), Length(aName) + 2, MaxInt)
    else
      result := '';
  end;


  function TUtf8Strings.IndexOf(const aString: Utf8String): Integer;
  begin
    for result := 0 to Pred(Count) do
      if CompareStrings(Get(result), aString) = 0 then
        EXIT;

    result := -1;
  end;


  function TUtf8Strings.IndexOfName(const aName: Utf8String): Integer;
  begin
    for result := 0 to Pred(Count) do
      if Utf8.BeginsWith(Get(result), aName) then
        EXIT;

    result := -1;
  end;


  function TUtf8Strings.IndexOfObject(aObject: TObject): Integer;
  begin
    for result := 0 to Pred(Count) do
      if get_Object(result) = aObject then
        EXIT;

    result := -1;
  end;


  procedure TUtf8Strings.InsertObject(aIndex: Integer; const aString: Utf8String; aObject: TObject);
  begin
    Insert(aIndex, aString);
    set_Object(aIndex, aObject);
  end;


  procedure TUtf8Strings.LoadFromFile(const aFileName: String);
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


  procedure TUtf8Strings.LoadFromStream(Stream: TStream);
  begin
    // TODO
  end;


  procedure TUtf8Strings.Move(aCurIndex, aNewIndex: Integer);
  var
    TempObject: TObject;
    TempString: Utf8String;
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


  procedure TUtf8Strings.Put(aIndex: Integer; const aString: Utf8String);
  var
    TempObject: TObject;
  begin
    TempObject := get_Object(aIndex);
    Delete(aIndex);
    InsertObject(aIndex, aString, TempObject);
  end;


  procedure TUtf8Strings.set_Object(aIndex: Integer; aObject: TObject);
  begin
    // NO-OP - override in descendants
  end;


  procedure TUtf8Strings.ReadData(aReader: TReader);
  begin
    aReader.ReadListBegin;

    BeginUpdate;
    try
      Clear;
      while NOT aReader.EndOfList do
      {$ifNdef UNICODE}
        Add(Utf8.FromAnsi(aReader.ReadString));
      {$else}
        Add(Utf8.FromWide(aReader.ReadString));
      {$endif}

    finally
      EndUpdate;
    end;

    aReader.ReadListEnd;
  end;


  procedure TUtf8Strings.SaveToFile(const aFileName: String);
  begin
    // TODO:
  end;


  procedure TUtf8Strings.SaveToStream(Stream: TStream);
  begin
    // TODO:
  end;


  procedure TUtf8Strings.set_Capacity(aNewCapacity: Integer);
  begin
    // do nothing - descendents may optionally implement this method
  end;


  procedure TUtf8Strings.set_CommaText(const aValue: Utf8String);
  begin
    // TODO:
  end;


  procedure TUtf8Strings.set_Text(const aValue: Utf8String);
  var
    P, Start: PWIDEChar;
    S: Utf8String;
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

  procedure TUtf8Strings.SetUpdateState(Updating: Boolean);
  begin
  end;


  procedure TUtf8Strings.set_Value(const aName, aValue: Utf8String);
  var
    I: Integer;
  begin
    I := IndexOfName(aName);
    if aValue <> '' then
    begin
      if I < 0 then I := Add('');
      Put(I, Utf8.Append(aName, Utf8.Append(NameValueSeparator, aValue)));
    end
    else if I >= 0 then Delete(I);
  end;


  procedure TUtf8Strings.WriteData(aWriter: TWriter);
  var
    i: Integer;
  begin
    aWriter.WriteListBegin;

    for i := 0 to Pred(Count) do
    {$ifNdef UNICODE}
      aWriter.WriteString(Ansi.FromUtf8(Get(i)));
    {$else}
      aWriter.WriteString(Wide.FromUtf8(Get(i)));
    {$endif}

    aWriter.WriteListEnd;
  end;


  function TUtf8Strings.CompareStrings(const S1, S2: Utf8String): Integer;
  begin
    result := Utf8.Compare(S1, S2);
  end;


  function TUtf8Strings.get_ValueFromIndex(aIndex: Integer): Utf8String;
  var
    value: Utf8String;
    p: Integer;
  begin
    if aIndex >= 0 then
    begin
      value := Get(aIndex);

      if Utf8.Find(value, NameValueSeparator, p) then
        Utf8.DeleteLeft(value, p)
      else
        result := '';
    end
    else
      result := '';
  end;


  procedure TUtf8Strings.set_ValueFromIndex(      aIndex: Integer;
                                            const aValue: Utf8String);
  begin
    if aValue <> '' then
    begin
      if aIndex < 0 then
        aIndex := Add('');

      Put(aIndex, Utf8.Append(Names[aIndex], Utf8.Append(NameValueSeparator, aValue)));
    end
    else if aIndex >= 0 then
      Delete(aIndex);
  end;






  class function TUtf8StringList.CreateManaged: IUtf8StringList;
  begin
    result := TComInterfacedUtf8StringList.Create;
  end;


  constructor TUtf8StringList.Create;
  begin
    inherited Create;
  end;


  constructor TUtf8StringList.Create(aOwnsObjects: Boolean);
  begin
    inherited Create;
    fOwnsObjects := aOwnsObjects;
  end;


  destructor TUtf8StringList.Destroy;
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


  function TUtf8StringList.Add(const aString: Utf8String): Integer;
  begin
    result := AddObject(aString, NIL);
  end;


  function TUtf8StringList.AddObject(const aString: Utf8String;
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


  procedure TUtf8StringList.Assign(aSource: TPersistent);
  var
    src: TUtf8StringList absolute aSource;
  begin
    inherited Assign(aSource);

    if aSource is TUtf8StringList then
    begin
      fCaseSensitive  := src.fCaseSensitive;
      fDuplicates     := src.fDuplicates;
      fSorted         := src.fSorted;
    end;
  end;


  procedure TUtf8StringList.Changed;
  begin
    if (UpdateCount = 0) and Assigned(fOnChange) then
      fOnChange(self);
  end;


  procedure TUtf8StringList.Changing;
  begin
    if (UpdateCount = 0) and Assigned(fOnChanging) then
      fOnChanging(self);
  end;


  procedure TUtf8StringList.Clear;
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

  procedure TUtf8StringList.Delete(aIndex: Integer);
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
      System.Move(fList[aIndex + 1], fList[aIndex], (fCount - aIndex) * sizeof(TUtf8StringItem));

      // Make sure there is no danglng pointer in the last (now unused) element

      PPointer(@fList[fCount].fString)^ := NIL;
      PPointer(@fList[fCount].fObject)^ := NIL;
    end;

    if Obj <> NIL then
      Obj.Free;

    Changed;
  end;


  procedure TUtf8StringList.Exchange(aIndex1, aIndex2: Integer);
  begin
    if (aIndex1 < 0) or (aIndex1 >= fCount) then Error(Pointer(@SListIndexError), aIndex1);
    if (aIndex2 < 0) or (aIndex2 >= fCount) then Error(Pointer(@SListIndexError), aIndex2);

    Changing;

    ExchangeItems(aIndex1, aIndex2);

    Changed;
  end;


  procedure TUtf8StringList.ExchangeItems(aIndex1, aIndex2: Integer);
  var
    Temp: Pointer;
    Item1, Item2: PUtf8StringItem;
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


  function TUtf8StringList.Find(const aString: Utf8String;
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


  procedure TUtf8StringList.FreeOwnedObjects;
  var
    i: Integer;
  begin
    if Length(fOwnedObjects) > 0 then
      for i := Low(fOwnedObjects) to High(fOwnedObjects) do
        fOwnedObjects[i].Free;
  end;


  procedure TUtf8StringList.GatherOwnedObjects;
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


  function TUtf8StringList.Get(aIndex: Integer): Utf8String;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fString;
  end;


  function TUtf8StringList.get_Capacity: Integer;
  begin
    result := fCapacity;
  end;


  function TUtf8StringList.get_Count: Integer;
  begin
    result := fCount;
  end;


  function TUtf8StringList.get_Object(aIndex: Integer): TObject;
  begin
    result := GetObject(aIndex);
  end;


  procedure TUtf8StringList.set_Object(aIndex: Integer; aObject: TObject);
  begin
    PutObject(aIndex, aObject);
  end;


  function TUtf8StringList.GetObject(aIndex: Integer): TObject;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fObject;
  end;


  procedure TUtf8StringList.Grow;
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


  function TUtf8StringList.IndexOf(const aString: Utf8String): Integer;
  begin
    if NOT Sorted then
      result := inherited IndexOf(aString)
    else if NOT Find(aString, result) then
      result := -1;
  end;


  procedure TUtf8StringList.Insert(aIndex: Integer; const aString: Utf8String);
  begin
    InsertObject(aIndex, aString, NIL);
  end;


  procedure TUtf8StringList.InsertObject(      aIndex: Integer;
                                         const aString: Utf8String;
                                               aObject: TObject);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if (aIndex < 0) or (aIndex > fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    InsertItem(aIndex, aString, aObject);
  end;


  procedure TUtf8StringList.InsertItem(       aIndex: Integer;
                                        const aString: Utf8String;
                                              aObject: TObject);
  begin
    Changing;

    if fCount = fCapacity then
      Grow;

    if aIndex < fCount then
      System.Move(fList[aIndex], fList[aIndex + 1], (fCount - aIndex) * sizeof(TUtf8StringItem));

    Pointer(fList[aIndex].fString) := NIL;
    Pointer(fList[aIndex].fObject) := NIL;
    fList[aIndex].fObject := aObject;
    fList[aIndex].fString := aString;

    Inc(fCount);

    Changed;
  end;


  procedure TUtf8StringList.Put(      aIndex: Integer;
                                const aString: Utf8String);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fString := aString;

    Changed;
  end;


  procedure TUtf8StringList.PutObject(aIndex: Integer; aObject: TObject);
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fObject := aObject;

    Changed;
  end;


  procedure TUtf8StringList.QuickSort(L, R: Integer;
                                      aCompareFn: TUtf8StringListSortCompareFn);
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


  procedure TUtf8StringList.set_Capacity(aNewCapacity: Integer);
  begin
    if (aNewCapacity < fCount) then
      Error(Pointer(@SListCapacityError), aNewCapacity);

    if aNewCapacity <> fCapacity then
    begin
      SetLength(fList, aNewCapacity);
      fCapacity := aNewCapacity;
    end;
  end;


  procedure TUtf8StringList.set_Sorted(aValue: Boolean);
  begin
    if fSorted <> aValue then
    begin
      if aValue then Sort;
      fSorted := aValue;
    end;
  end;


  procedure TUtf8StringList.SetUpdateState(aUpdating: Boolean);
  begin
    if (aUpdating) then
      Changing
    else
      Changed;
  end;


  procedure TUtf8StringList.Sort;
  begin
    CustomSort(StringListCompareStrings);
  end;


  procedure TUtf8StringList.CustomSort(aCompareFn: TUtf8StringListSortCompareFn);
  begin
    if NOT Sorted and (fCount > 1) then
    begin
      Changing;
      QuickSort(0, fCount - 1, aCompareFn);
      Changed;
    end;
  end;


  function TUtf8StringList.CompareStrings(const aS1, aS2: Utf8String): Integer;
  const
    CASEMODE: array[FALSE..TRUE] of TCaseSensitivity = (csIgnoreCase, csCaseSensitive);
  begin
    result := Utf8.Compare(aS1, aS2, CASEMODE[CaseSensitive]);
  end;


  function TUtf8StringList.ContainsName(const aName: Utf8String): Boolean;
  begin
    result := IndexOfName(aName) <> -1;
  end;


  procedure TUtf8StringList.set_CaseSensitive(const aValue: Boolean);
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






{ TComInterfacedUtf8StringList ------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  constructor TComInterfacedUtf8StringList.Create;
  begin
    inherited;

    fList := TUtf8StringList.Create;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.Add(const aString: Utf8String): Integer;
  begin
    result := -1;

    if fUnique then
      result := fList.IndexOf(aString);

    if (NOT fUnique) or (result = -1) then
      result := fList.Add(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Add(const aList: IUtf8StringList);
  begin
    Add(aList.List);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Add(const aStrings: TUtf8Strings);
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
  procedure TComInterfacedUtf8StringList.Add(const aArray: Utf8StringArray);
  var
    i: Integer;
  begin
    if fList.Capacity - fList.Count < Length(aArray) then
      fList.Capacity := fList.Count + Length(aArray);

    for i := 0 to High(aArray) do
      fList.Add(aArray[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Clear;
  begin
    fList.Clear;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.Clone: IUtf8StringList;
  begin
    result := TComInterfacedUtf8StringList.Create;
    result.Unique := self.get_Unique;
    result.Sorted := self.get_Sorted;
    result.Add(self);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.Contains(const aString: Utf8String): Boolean;
  begin
    result := (fList.IndexOf(aString) <> -1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.ContainsName(const aName: Utf8String): Boolean;
  begin
    result := fList.ContainsName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Delete(const aIndex: Integer);
  begin
    fList.Delete(aIndex);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Delete(const aString: Utf8String);
  var
    idx: Integer;
  begin
    idx := IndexOf(aString);
    if idx <> -1 then
      Delete(idx);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  destructor TComInterfacedUtf8StringList.Destroy;
  begin
    fList.Free;

    inherited;
  end;


{$ifdef ForInEnumerators}
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.GetEnumerator: TUtf8StringsEnumerator;
  begin
    result := TUtf8StringsEnumerator.Create(self);
  end;
{$endif}


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_AsArray: Utf8StringArray;
  var
    i: Integer;
  begin
    SetLength(result, get_Count);

    for i := 0 to Pred(get_Count) do
      result[i] := fList[i];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Capacity: Integer;
  begin
    result:= fList.Capacity;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Count: Integer;
  begin
    result := fList.Count;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Item(const aIndex: Integer): Utf8String;
  begin
    result := fList[aIndex];
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_List: TUtf8StringList;
  begin
    result := fList;
  end;



  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Name(const aIndex: Integer): Utf8String;
  begin
    result := fList.Names[aIndex];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Sorted: Boolean;
  begin
    result := fList.Sorted;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Unique: Boolean;
  begin
    result := fUnique;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.get_Value(const aName: Utf8String): Utf8String;
  begin
    result := fList.Values[aName];
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.IndexOf(const aString: Utf8String): Integer;
  begin
    result := fList.IndexOf(aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function TComInterfacedUtf8StringList.IndexOfName(const aName: Utf8String): Integer;
  begin
    result := fList.IndexOfName(aName);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Insert(const aIndex: Integer;
                                            const aStrings: TUtf8Strings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStrings.Count) do
      fList.Insert(aIndex + i, aStrings[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.LoadFromFile(const aFilename: String);
  begin
    fList.LoadFromFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.SaveToFile(const aFilename: String);
  begin
    fList.SaveToFile(aFilename);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.Insert(const aIndex: Integer;
                                            const aString: Utf8String);
  begin
    fList.Insert(aIndex, aString);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.set_Capacity(const aValue: Integer);
  begin
    fList.Capacity := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.set_Item(const aIndex: Integer;
                                              const aValue: Utf8String);
  begin
    fList[aIndex] := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.set_Sorted(const aValue: Boolean);
  begin
    fList.Sorted := aValue;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.set_Unique(const aValue: Boolean);
  begin
    fUnique := aValue;

    if fUnique then
      fList.Duplicates := dupIgnore
    else
      fList.Duplicates := dupAccept;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  procedure TComInterfacedUtf8StringList.set_Value(const aName: Utf8String;
                                               const aValue: Utf8String);
  begin
    fList.Values[aName] := aValue;
  end;


{ TUtf8StringsEnumerator }

  constructor TUtf8StringsEnumerator.Create(aStrings: IUtf8StringList);
  begin
    inherited Create;

    fIndex    := -1;
    fStrings  := aStrings;
  end;


  function TUtf8StringsEnumerator.GetCurrent: Utf8String;
  begin
    result := fStrings[fIndex];
  end;


  function TUtf8StringsEnumerator.MoveNext: Boolean;
  begin
    result := fIndex < fStrings.Count - 1;
    if result then
      Inc(fIndex);
  end;

end.

