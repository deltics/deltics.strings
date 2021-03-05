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

  unit Deltics.Strings.Lists.Ansi;


interface

  uses
    Classes,
    Deltics.InterfacedObjects,
    Deltics.Strings.Types;


  type
    TAnsiStrings    = class;
    TAnsiStringList = class;

    TAnsiStringListSortCompareFn = function(List: TAnsiStrings; Index1, Index2: Integer): Integer;

    PAnsiStringItem = ^TAnsiStringItem;
    TAnsiStringItem = record
      fString: AnsiString;
      fObject: TObject;
    end;

    PAnsiStringItemList = ^TAnsiStringItemList;
    TAnsiStringItemList = array of TAnsiStringItem;


    TAnsiStrings = class(TPersistent)
    private
      fUpdateCount: Integer;
      function get_CommaText: AnsiString;
      function get_Name(aIndex: Integer): AnsiString;
      function get_Value(const aName: AnsiString): AnsiString;
      procedure set_CommaText(const aValue: AnsiString);
      procedure set_Value(const aName, aValue: AnsiString);
      procedure ReadData(aReader: TReader);
      procedure WriteData(aWriter: TWriter);
      function get_ValueFromIndex(aIndex: Integer): AnsiString;
      procedure set_ValueFromIndex(aIndex: Integer; const aValue: AnsiString);
    protected
      function get_Capacity: Integer; virtual;
      function get_Count: Integer; virtual; abstract;
      function get_Object(aIndex: Integer): TObject; virtual;
      function get_Text: AnsiString; virtual;
      procedure set_Capacity(aNewCapacity: Integer); virtual;
      procedure set_Object(aIndex: Integer; aObject: TObject); virtual;
      procedure set_Text(const aValue: AnsiString); virtual;
      procedure DefineProperties(aFiler: TFiler); override;
      procedure Error(const aMsg: String; aData: Integer); overload;
      procedure Error(aMsg: PResStringRec; aData: Integer); overload;
      function ExtractName(const aString: AnsiString): AnsiString;
      function Get(Index: Integer): AnsiString; virtual; abstract;
      procedure Put(aIndex: Integer; const aString: AnsiString); virtual;
      procedure SetUpdateState(Updating: Boolean); virtual;
      property UpdateCount: Integer read FUpdateCount;
      function CompareStrings(const S1, S2: AnsiString): Integer; virtual;
    public
      function Add(const aString: AnsiString): Integer; virtual;
      function AddObject(const aString: AnsiString; AObject: TObject): Integer; virtual;
      procedure AddStrings(aStrings: TAnsiStrings); overload; virtual;
      procedure Assign(aSource: TPersistent); override;
      procedure BeginUpdate;
      procedure Clear; virtual; abstract;
      procedure Delete(aIndex: Integer); virtual; abstract;
      procedure EndUpdate;
      function Equals(aStrings: TAnsiStrings): Boolean; reintroduce;
      procedure Exchange(aIndex1, aIndex2: Integer); virtual;
      function IndexOf(const aString: AnsiString): Integer; virtual;
      function IndexOfName(const aName: AnsiString): Integer; virtual;
      function IndexOfObject(aObject: TObject): Integer; virtual;
      procedure Insert(aIndex: Integer; const aString: AnsiString); virtual; abstract;
      procedure InsertObject(aIndex: Integer; const aString: AnsiString; aObject: TObject); virtual;
      procedure LoadFromFile(const aFileName: string); overload; virtual;
      procedure LoadFromStream(Stream: TStream); overload; virtual;
      procedure Move(aCurIndex, aNewIndex: Integer); virtual;
      procedure SaveToFile(const aFileName: String); overload; virtual;
      procedure SaveToStream(Stream: TStream); overload; virtual;
      property Capacity: Integer read get_Capacity write set_Capacity;
      property CommaText: AnsiString read get_CommaText write set_CommaText;
      property Count: Integer read get_Count;
      property Names[aIndex: Integer]: AnsiString read get_Name;
      property Objects[aIndex: Integer]: TObject read get_Object write set_Object;
      property Values[const aName: AnsiString]: AnsiString read get_Value write set_Value;
      property ValueFromIndex[aIndex: Integer]: AnsiString read get_ValueFromIndex write set_ValueFromIndex;
      property Strings[aIndex: Integer]: AnsiString read Get write Put; default;
      property Text: AnsiString read get_Text write set_Text;
    end;


    TAnsiStringList = class(TAnsiStrings)
    private
      fList: TAnsiStringItemList;
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
      procedure QuickSort(L, R: Integer; aCompareFn: TAnsiStringListSortCompareFn);
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
      function Get(aIndex: Integer): AnsiString; override;
      function GetObject(aIndex: Integer): TObject;
      procedure Put(aIndex: Integer; const aString: AnsiString); override;
      procedure PutObject(aIndex: Integer; aObject: TObject);
      procedure SetUpdateState(aUpdating: Boolean); override;
      function CompareStrings(const aS1, aS2: AnsiString): Integer; override;
      procedure InsertItem(aIndex: Integer; const aString: AnsiString; aObject: TObject); virtual;
    public
      constructor Create; overload;
      constructor Create(aOwnsObjects: Boolean); overload;
      destructor Destroy; override;
      function Add(const aString: AnsiString): Integer; override;
      function AddObject(const aString: AnsiString; aObject: TObject): Integer; override;
      procedure Assign(aSource: TPersistent); override;
      procedure Clear; override;
      procedure Delete(aIndex: Integer); override;
      procedure Exchange(aIndex1, aIndex2: Integer); override;
      function Find(const aString: AnsiString; var aIndex: Integer): Boolean; virtual;
      function IndexOf(const aString: AnsiString): Integer; override;
      procedure Insert(aIndex: Integer; const aString: AnsiString); override;
      procedure InsertObject(aIndex: Integer; const aString: AnsiString; aObject: TObject); override;
      procedure Sort; virtual;
      procedure CustomSort(aCompareFn: TAnsiStringListSortCompareFn); virtual;
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



  const
    LineBreak         : AnsiString = #13#10;
    NameValueSeparator: AnsiChar   = '=';


  function StringListCompareStrings(List: TAnsiStrings; Index1, Index2: Integer): Integer;
  begin
    Result := List.CompareStrings(List[Index1], List[Index2]);
  end;





  function TAnsiStrings.Add(const aString: AnsiString): Integer;
  begin
    result := Count;
    Insert(result, aString);
  end;


  function TAnsiStrings.AddObject(const aString: AnsiString;
                                        aObject: TObject): Integer;
  begin
    result := Add(aString);
    set_Object(result, aObject);
  end;


  procedure TAnsiStrings.AddStrings(aStrings: TAnsiStrings);
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


  procedure TAnsiStrings.Assign(aSource: TPersistent);
  var
    src: TAnsiStrings absolute aSource;
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


  procedure TAnsiStrings.BeginUpdate;
  begin
    if fUpdateCount = 0 then
      SetUpdateState(TRUE);

    Inc(fUpdateCount);
  end;


  procedure TAnsiStrings.DefineProperties(aFiler: TFiler);

    function DoWrite: Boolean;
    begin
      if aFiler.Ancestor <> nil then
      begin
        Result := True;
        if (aFiler.Ancestor is TAnsiStrings) then
          result := NOT Equals(TAnsiStrings(aFiler.Ancestor))
      end
      else
        result := Count > 0;
    end;

  begin
    aFiler.DefineProperty('Strings', ReadData, WriteData, DoWrite);
  end;


  procedure TAnsiStrings.EndUpdate;
  begin
    Dec(fUpdateCount);
    if fUpdateCount = 0 then
      SetUpdateState(FALSE);
  end;


  function TAnsiStrings.Equals(aStrings: TAnsiStrings): Boolean;
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
  procedure TAnsiStrings.Error(const aMsg: String; aData: Integer);
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

  procedure TAnsiStrings.Error(aMsg: PResStringRec; aData: Integer);
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


  procedure TAnsiStrings.Exchange(aIndex1, aIndex2: Integer);
  var
    TempObject: TObject;
    TempString: AnsiString;
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


  function TAnsiStrings.ExtractName(const aString: AnsiString): AnsiString;
  var
    n, v: AnsiString;       //  and for the var params in the Split() method, the compiler
  begin
    Ansi.Split(aString, AnsiChar('='), n, v);
    result := n;
  end;


  function TAnsiStrings.get_Capacity: Integer;
  begin  // descendents may optionally override/replace this default implementation
    Result := Count;
  end;


  function TAnsiStrings.get_CommaText: AnsiString;
  begin
    // result := GetDelimitedText;
  end;


(*
  function TAnsiStrings.GetDelimitedText: AnsiString;
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

  function TAnsiStrings.get_Name(aIndex: Integer): AnsiString;
  begin
    Result := ExtractName(Get(aIndex));
  end;


  function TAnsiStrings.get_Object(aIndex: Integer): TObject;
  begin
    result := NIL;
  end;


  function TAnsiStrings.get_Text: AnsiString;
  var
    I, L, Size, Count: Integer;
    P: PChar;
    S, LB: AnsiString;
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


  function TAnsiStrings.get_Value(const aName: AnsiString): AnsiString;
  var
    i: Integer;
  begin
    i := IndexOfName(aName);
    if i >= 0 then
      result := Copy(Get(i), Length(aName) + 2, MaxInt)
    else
      result := '';
  end;


  function TAnsiStrings.IndexOf(const aString: AnsiString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if CompareStrings(Get(result), aString) = 0 then
        EXIT;

    result := -1;
  end;


  function TAnsiStrings.IndexOfName(const aName: AnsiString): Integer;
  begin
    for result := 0 to Pred(Count) do
      if Ansi.BeginsWith(Get(result), aName) then
        EXIT;

    result := -1;
  end;


  function TAnsiStrings.IndexOfObject(aObject: TObject): Integer;
  begin
    for result := 0 to Pred(Count) do
      if get_Object(result) = aObject then
        EXIT;

    result := -1;
  end;


  procedure TAnsiStrings.InsertObject(aIndex: Integer; const aString: AnsiString; aObject: TObject);
  begin
    Insert(aIndex, aString);
    set_Object(aIndex, aObject);
  end;


  procedure TAnsiStrings.LoadFromFile(const aFileName: String);
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


  procedure TAnsiStrings.LoadFromStream(Stream: TStream);
  begin
    // TODO
  end;


  procedure TAnsiStrings.Move(aCurIndex, aNewIndex: Integer);
  var
    TempObject: TObject;
    TempString: AnsiString;
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


  procedure TAnsiStrings.Put(aIndex: Integer; const aString: AnsiString);
  var
    TempObject: TObject;
  begin
    TempObject := get_Object(aIndex);
    Delete(aIndex);
    InsertObject(aIndex, aString, TempObject);
  end;


  procedure TAnsiStrings.set_Object(aIndex: Integer; aObject: TObject);
  begin
    // NO-OP - override in descendants
  end;


  procedure TAnsiStrings.ReadData(aReader: TReader);
  begin
    aReader.ReadListBegin;

    BeginUpdate;
    try
      Clear;
      while NOT aReader.EndOfList do
      {$ifNdef UNICODE}
        Add(aReader.ReadString);
      {$else}
        Add(Ansi.FromWide(aReader.ReadString));
      {$endif}

    finally
      EndUpdate;
    end;

    aReader.ReadListEnd;
  end;


  procedure TAnsiStrings.SaveToFile(const aFileName: String);
  begin
    // TODO:
  end;


  procedure TAnsiStrings.SaveToStream(Stream: TStream);
  begin
    // TODO:
  end;


  procedure TAnsiStrings.set_Capacity(aNewCapacity: Integer);
  begin
    // do nothing - descendents may optionally implement this method
  end;


  procedure TAnsiStrings.set_CommaText(const aValue: AnsiString);
  begin
    // TODO:
  end;


  procedure TAnsiStrings.set_Text(const aValue: AnsiString);
  var
    P, Start: PWIDEChar;
    S: AnsiString;
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

  procedure TAnsiStrings.SetUpdateState(Updating: Boolean);
  begin
  end;


  procedure TAnsiStrings.set_Value(const aName, aValue: AnsiString);
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


  procedure TAnsiStrings.WriteData(aWriter: TWriter);
  var
    i: Integer;
  begin
    aWriter.WriteListBegin;

    for i := 0 to Pred(Count) do
    {$ifNdef UNICODE}
      aWriter.WriteString(Get(i));
    {$else}
      aWriter.WriteString(Wide.FromAnsi(Get(i)));
    {$endif}

    aWriter.WriteListEnd;
  end;


  function TAnsiStrings.CompareStrings(const S1, S2: AnsiString): Integer;
  begin
    result := Ansi.Compare(S1, S2);
  end;


  function TAnsiStrings.get_ValueFromIndex(aIndex: Integer): AnsiString;
  var
    value: AnsiString;
    p: Integer;
  begin
    if aIndex >= 0 then
    begin
      value := Get(aIndex);

      if Ansi.Find(value, NameValueSeparator, p) then
        Ansi.DeleteLeft(value, p)
      else
        result := '';
    end
    else
      result := '';
  end;


  procedure TAnsiStrings.set_ValueFromIndex(      aIndex: Integer;
                                            const aValue: AnsiString);
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








  constructor TAnsiStringList.Create;
  begin
    inherited Create;
  end;


  constructor TAnsiStringList.Create(aOwnsObjects: Boolean);
  begin
    inherited Create;
    fOwnsObjects := aOwnsObjects;
  end;


  destructor TAnsiStringList.Destroy;
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


  function TAnsiStringList.Add(const aString: AnsiString): Integer;
  begin
    result := AddObject(aString, NIL);
  end;


  function TAnsiStringList.AddObject(const aString: AnsiString;
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


  procedure TAnsiStringList.Assign(aSource: TPersistent);
  var
    src: TAnsiStringList absolute aSource;
  begin
    inherited Assign(aSource);

    if aSource is TAnsiStringList then
    begin
      fCaseSensitive  := src.fCaseSensitive;
      fDuplicates     := src.fDuplicates;
      fSorted         := src.fSorted;
    end;
  end;


  procedure TAnsiStringList.Changed;
  begin
    if (UpdateCount = 0) and Assigned(fOnChange) then
      fOnChange(self);
  end;


  procedure TAnsiStringList.Changing;
  begin
    if (UpdateCount = 0) and Assigned(fOnChanging) then
      fOnChanging(self);
  end;


  procedure TAnsiStringList.Clear;
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

  procedure TAnsiStringList.Delete(aIndex: Integer);
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
      System.Move(fList[aIndex + 1], fList[aIndex], (fCount - aIndex) * sizeof(TAnsiStringItem));

      // Make sure there is no danglng pointer in the last (now unused) element

      PPointer(@fList[fCount].fString)^ := NIL;
      PPointer(@fList[fCount].fObject)^ := NIL;
    end;

    if Obj <> NIL then
      Obj.Free;

    Changed;
  end;


  procedure TAnsiStringList.Exchange(aIndex1, aIndex2: Integer);
  begin
    if (aIndex1 < 0) or (aIndex1 >= fCount) then Error(Pointer(@SListIndexError), aIndex1);
    if (aIndex2 < 0) or (aIndex2 >= fCount) then Error(Pointer(@SListIndexError), aIndex2);

    Changing;

    ExchangeItems(aIndex1, aIndex2);

    Changed;
  end;


  procedure TAnsiStringList.ExchangeItems(aIndex1, aIndex2: Integer);
  var
    Temp: Pointer;
    Item1, Item2: PAnsiStringItem;
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


  function TAnsiStringList.Find(const aString: AnsiString;
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


  procedure TAnsiStringList.FreeOwnedObjects;
  var
    i: Integer;
  begin
    if Length(fOwnedObjects) > 0 then
      for i := Low(fOwnedObjects) to High(fOwnedObjects) do
        fOwnedObjects[i].Free;
  end;


  procedure TAnsiStringList.GatherOwnedObjects;
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


  function TAnsiStringList.Get(aIndex: Integer): AnsiString;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fString;
  end;


  function TAnsiStringList.get_Capacity: Integer;
  begin
    result := fCapacity;
  end;


  function TAnsiStringList.get_Count: Integer;
  begin
    result := fCount;
  end;


  function TAnsiStringList.get_Object(aIndex: Integer): TObject;
  begin
    result := GetObject(aIndex);
  end;


  procedure TAnsiStringList.set_Object(aIndex: Integer; aObject: TObject);
  begin
    PutObject(aIndex, aObject);
  end;


  function TAnsiStringList.GetObject(aIndex: Integer): TObject;
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    result := fList[aIndex].fObject;
  end;


  procedure TAnsiStringList.Grow;
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


  function TAnsiStringList.IndexOf(const aString: AnsiString): Integer;
  begin
    if NOT Sorted then
      result := inherited IndexOf(aString)
    else if NOT Find(aString, result) then
      result := -1;
  end;


  procedure TAnsiStringList.Insert(aIndex: Integer; const aString: AnsiString);
  begin
    InsertObject(aIndex, aString, NIL);
  end;


  procedure TAnsiStringList.InsertObject(      aIndex: Integer;
                                         const aString: AnsiString;
                                               aObject: TObject);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if (aIndex < 0) or (aIndex > fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    InsertItem(aIndex, aString, aObject);
  end;


  procedure TAnsiStringList.InsertItem(       aIndex: Integer;
                                        const aString: AnsiString;
                                              aObject: TObject);
  begin
    Changing;

    if fCount = fCapacity then
      Grow;

    if aIndex < fCount then
      System.Move(fList[aIndex], fList[aIndex + 1], (fCount - aIndex) * sizeof(TAnsiStringItem));

    Pointer(fList[aIndex].fString) := NIL;
    Pointer(fList[aIndex].fObject) := NIL;
    fList[aIndex].fObject := aObject;
    fList[aIndex].fString := aString;

    Inc(fCount);

    Changed;
  end;


  procedure TAnsiStringList.Put(      aIndex: Integer;
                                const aString: AnsiString);
  begin
    if Sorted then
      Error(Pointer(@SSortedListError), 0);

    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fString := aString;

    Changed;
  end;


  procedure TAnsiStringList.PutObject(aIndex: Integer; aObject: TObject);
  begin
    if Cardinal(aIndex) >= Cardinal(fCount) then
      Error(Pointer(@SListIndexError), aIndex);

    Changing;

    fList[aIndex].fObject := aObject;

    Changed;
  end;


  procedure TAnsiStringList.QuickSort(L, R: Integer;
                                      aCompareFn: TAnsiStringListSortCompareFn);
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


  procedure TAnsiStringList.set_Capacity(aNewCapacity: Integer);
  begin
    if (aNewCapacity < fCount) then
      Error(Pointer(@SListCapacityError), aNewCapacity);

    if aNewCapacity <> fCapacity then
    begin
      SetLength(fList, aNewCapacity);
      fCapacity := aNewCapacity;
    end;
  end;


  procedure TAnsiStringList.set_Sorted(aValue: Boolean);
  begin
    if fSorted <> aValue then
    begin
      if aValue then Sort;
      fSorted := aValue;
    end;
  end;


  procedure TAnsiStringList.SetUpdateState(aUpdating: Boolean);
  begin
    if (aUpdating) then
      Changing
    else
      Changed;
  end;


  procedure TAnsiStringList.Sort;
  begin
    CustomSort(StringListCompareStrings);
  end;


  procedure TAnsiStringList.CustomSort(aCompareFn: TAnsiStringListSortCompareFn);
  begin
    if NOT Sorted and (fCount > 1) then
    begin
      Changing;
      QuickSort(0, fCount - 1, aCompareFn);
      Changed;
    end;
  end;


  function TAnsiStringList.CompareStrings(const aS1, aS2: AnsiString): Integer;
  const
    CASEMODE: array[FALSE..TRUE] of TCaseSensitivity = (csIgnoreCase, csCaseSensitive);
  begin
    result := Ansi.Compare(aS1, aS2, CASEMODE[CaseSensitive]);
  end;


  procedure TAnsiStringList.set_CaseSensitive(const aValue: Boolean);
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

