
{$i deltics.strings.inc}


  unit Deltics.Strings.StringBuilder;


interface

  uses
    Classes,
    SysUtils;


  type
    TStringBuilder = class
    private
      fData: PChar;
      fDataSize: Integer;
      fPageSize: Integer;
      fCursor: PChar;
      fSpaceAvailable: Integer;
      procedure AddPage;
      function get_AsString: String;
    public
      constructor Create(aPageSize: Integer = 1024; aInitialPages: Integer = 1);
      constructor CreateCopy(aSource: TStringBuilder);
      destructor Destroy; override;
      procedure CopyFrom(aSource: TStringBuilder);
      procedure Append(aInteger: Integer); overload;
      procedure Append(aChar: Char); overload;
      procedure Append(const aString: String); overload;
      procedure Append(aStringList: TStrings); overload;
      procedure Append(aStringList: TStrings; aSeparator: Char); overload;
      procedure Append(aStringList: TStrings; aBrace, aSeparator: Char); overload;
      procedure Rewind(aCount: Integer);
      property AsString: String read get_AsString;
    end;


implementation

{ TStringBuilder }

  constructor TStringBuilder.Create(aPageSize, aInitialPages: Integer);
  begin
    inherited Create;

    fDataSize       := aPageSize * aInitialPages;
    fPageSize       := aPageSize;
    fSpaceAvailable := fDataSize;

    GetMem(fData, fDataSize * 2);

    fCursor := fData;
  end;


  constructor TStringBuilder.CreateCopy(aSource: TStringBuilder);
  var
    cursorPos: Integer;
  begin
    inherited Create;

    fDataSize       := aSource.fDataSize;
    fPageSize       := aSource.fPageSize;
    fSpaceAvailable := aSource.fSpaceAvailable;

    cursorPos := aSource.fCursor - aSource.fData;

    GetMem(fData, (fDataSize + fPageSize) * 2);

    fCursor := fData + cursorPos;
  end;



  destructor TStringBuilder.Destroy;
  begin
    FreeMem(fData);

    inherited;
  end;


  function TStringBuilder.get_AsString: String;
  begin
    SetLength(result, fCursor - fData);
    Move(fData^, result[1], Length(result) * 2);
  end;


  procedure TStringBuilder.AddPage;
  var
    cursorPos: Integer;
  begin
    cursorPos := fCursor - fData;
    ReallocMem(fData, (fDataSize + fPageSize) * 2);
    fCursor   := fData + cursorPos;

    Inc(fDataSize, fPageSize);
    Inc(fSpaceAvailable, fPageSize);
  end;



  procedure TStringBuilder.Append(aStringList: TStrings);
  var
    i: Integer;
  begin
    for i := 0 to Pred(aStringList.Count) do
      Append(aStringList[i]);
  end;


  procedure TStringBuilder.Append(aStringList: TStrings;
                                  aSeparator: Char);
  var
    i, maxi: Integer;
  begin
    maxi := Pred(aStringList.Count);

    case maxi of
       0  : Append(aStringList[maxi]);
      -1  : EXIT;
    else
      for i := 0 to maxi - 1 do
      begin
        Append(aStringList[i]);
        Append(aSeparator);
      end;
      Append(aStringList[maxi]);
    end;
  end;


  procedure TStringBuilder.Append(aStringList: TStrings;
                                  aBrace: Char;
                                  aSeparator: Char);
  var
    i, maxi: Integer;
    ob, cb: Char;
  begin
    maxi := Pred(aStringList.Count);

    if maxi = -1 then
      EXIT;

    ob := aBrace;
    case ob of
      '(' : cb := ')';
      '{' : cb := '}';
      '[' : cb := ']';
      '<' : cb := '>';
    else
      cb := ob;
    end;

    for i := 0 to maxi - 1 do
    begin
      Append(ob);
      Append(aStringList[i]);
      Append(cb);
      Append(aSeparator);
    end;

    Append(ob);
    Append(aStringList[maxi]);
    Append(cb);
  end;


  procedure TStringBuilder.CopyFrom(aSource: TStringBuilder);
  var
    cursorPos: Integer;
  begin
    FreeMem(fData);

    fDataSize       := aSource.fDataSize;
    fPageSize       := aSource.fPageSize;
    fSpaceAvailable := aSource.fSpaceAvailable;

    cursorPos := aSource.fCursor - aSource.fData;

    GetMem(fData, fDataSize * 2);
    Move(aSource.fData^, fData^, fDataSize * 2);

    fCursor := fData + cursorPos;
  end;


  procedure TStringBuilder.Append(aInteger: Integer);
  begin
    Append(IntToStr(aInteger));
  end;



  procedure TStringBuilder.Append(aChar: Char);
  begin
    if fSpaceAvailable = 0 then
      AddPage;

    fCursor^ := aChar;

    Inc(fCursor);
    Dec(fSpaceAvailable);
  end;



  procedure TStringBuilder.Append(const aString: String);
  var
    len: Integer;
  begin
    len := Length(aString);
    if len = 0 then
      EXIT;

    if fSpaceAvailable < len then
      AddPage;

    Move(aString[1], fCursor^, len * 2);

    Inc(fCursor, len);
    Dec(fSpaceAvailable, len);
  end;



  procedure TStringBuilder.Rewind(aCount: Integer);
  begin
    Dec(fCursor, aCount);
    Inc(fSpaceAvailable, aCount);
  end;





end.
