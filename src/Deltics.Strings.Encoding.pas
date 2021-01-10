
{$i deltics.strings.inc}

  unit Deltics.Strings.Encoding;


interface

  uses
    Classes,
    SysUtils,
    Deltics.Strings.Types;


  type
    TCodepage = Cardinal;


  const
    cpUtf32LE  = 12000;
    cpUtf32    = 12001;
    cpUtf16LE  = 1200;
    cpUtf16    = 1201;
    cpASCII    = 20217;
    cpUtf8     = 65001;


  type
    Encoding = class;
    TEncoding = class;
    TEncodingClass = class of TEncoding;


    Encoding = class
    public
      class function ANSI: TEncoding;
      class function ASCII: TEncoding;
      class function Utf8: TEncoding;
      class function Utf16: TEncoding;
      class function Utf16LE: TEncoding;
      class function Utf32: TEncoding;
      class function Utf32LE: TEncoding;
      class function ForCodepage(const aCodepage: TCodepage): TEncoding;
      class function Identify(const aBOM: TBOM; var aEncoding: TEncoding): Boolean; overload;
      class function Identify(const aStream: TStream; var aEncoding: TEncoding): Boolean; overload;
      class function Identify(const aBytes; const aNumBytes: Integer; var aEncoding: TEncoding): Boolean; overload;

    private
      fBom: TBOM;
      fCodepage: TCodepage;
    public
      property Bom: TBOM read fBom;
      property Codepage: TCodepage read fCodepage;
    end;


    TEncoding = class(Encoding)
    private
      class function Instance(var aEncoding: TEncoding; const aClass: TEncodingClass): TEncoding; // TODO: Check this:  static;
    private
      function get_IsUnicode: Boolean;
      function get_IsUtf16: Boolean;
      function get_IsUtf32: Boolean;
    protected
      constructor Create; overload; virtual; abstract;
      constructor Create(const aCodePage: Cardinal); overload;
      constructor Create(const aCodePage: Cardinal; const aBom: TBOM); overload;
    public
      function GetByteCount(const aChars: PWIDEChar; const aNumChars: Integer): Integer; virtual; abstract;
      function GetCharCount(const aBytes; const aNumBytes: Integer): Integer; virtual; abstract;
      function Decode(const aBytes; const aNumBytes: Integer; const aChars: PWIDEChar; const aMaxChars: Integer): Integer; virtual; abstract;
      function Encode(const aChars: PWIDEChar; const aNumChars: Integer; const aBytes; const aMaxBytes: Integer): Integer; virtual; abstract;
      property IsUnicode: Boolean read get_IsUnicode;
      property IsUtf16: Boolean read get_IsUtf16;
      property IsUtf32: Boolean read get_IsUtf32;
    end;


    TMultiByteEncoding = class(TEncoding)
    protected
      constructor Create; override;
    public
      function GetByteCount(const aChars: PWIDEChar; const aNumChars: Integer): Integer; override;
      function GetCharCount(const aBytes; const aNumBytes: Integer): Integer; override;
      function Decode(const aBytes; const aNumBytes: Integer; const aChars: PWIDEChar; const aMaxChars: Integer): Integer; override;
      function Encode(const aChars: PWIDEChar; const aNumChars: Integer; const aBytes; const aMaxBytes: Integer): Integer; override;
    end;




implementation

  uses
    SyncObjs,
    Windows,
    Deltics.Exceptions,
    Deltics.Strings.Encoding.Ascii,
    Deltics.Strings.Encoding.Utf8,
    Deltics.Strings.Encoding.Utf16,
    Deltics.Strings.Encoding.Utf32;


  type
    PEncoding = ^Encoding;

  var
    _ASCII    : TEncoding = NIL;
    _UTF8     : TEncoding = NIL;
    _UTF16    : TEncoding = NIL;
    _UTF16LE  : TEncoding = NIL;
    _UTF32    : TEncoding = NIL;
    _UTF32LE  : TEncoding = NIL;

    _AnsiEncodings: array of TEncoding;
    _AnsiEncodingsLock: TCriticalSection;


  function _AnsiEncodingForCodepage(const aCodepage: Word): TEncoding;
  var
    i: Integer;
  begin
    _AnsiEncodingsLock.Enter;
    try
      for i := 0 to High(_AnsiEncodings) do
      begin
        result := _AnsiEncodings[i];
        if result.Codepage = aCodepage then
          EXIT;
      end;

      result := TMultiByteEncoding.Create(aCodepage);
      SetLength(_AnsiEncodings, Length(_AnsiEncodings) + 1);

      _AnsiEncodings[Length(_AnsiEncodings) - 1] := result;

    finally
      _AnsiEncodingsLock.Leave;
    end;
  end;


  procedure _AnsiEncodingsFinalize;
  var
    i: Integer;
  begin
    _AnsiEncodingsLock.Enter;
    try
      for i := 0 to High(_AnsiEncodings) do
        _AnsiEncodings[i].Free;

      SetLength(_AnsiEncodings, 0);

    finally
      _AnsiEncodingsLock.Leave;
      _AnsiEncodingsLock.Free;
    end;
  end;


{$ifdef 32BIT}
  function InterlockedCompareExchangePointer(var Destination; const Exchange, Comperand: Pointer): Pointer;
  asm
    xchg ecx, eax
    lock cmpxchg [ecx], edx
  end;
{$else}
  {$ifdef 64BIT}
    function InterlockedCompareExchangePointer(var Destination; const Exchange, Comperand: Pointer): Pointer;
    asm
        .NOFRAME
        MOV     RAX,R8
   LOCK CMPXCHG [RCX],RDX
    end;
  {$else}
    {$message FATAL "InterlockedCompareExchangePointer is not supported on this platform"}
  {$endif}
{$endif}


  class function TEncoding.Instance(var   aEncoding: TEncoding;
                                    const aClass: TEncodingClass): TEncoding;
  var
    enc: TEncoding;
  begin
    if NOT Assigned(aEncoding) then
    begin
      enc := aClass.Create;
      if InterlockedCompareExchangePointer(aEncoding, enc, NIL) <> NIL then
        enc.Free;
    end;

    result := aEncoding;
  end;


  class function Encoding.ANSI: TEncoding;
  begin
    result := _AnsiEncodingForCodepage(GetACP);
  end;

  class function Encoding.ASCII: TEncoding;
  begin
    result := TEncoding.Instance(_ASCII, TASCIIEncoding);
  end;

  class function Encoding.Utf8: TEncoding;
  begin
    result := TEncoding.Instance(_UTF8, TUtf8Encoding);
  end;

  class function Encoding.Utf16: TEncoding;
  begin
    result := TEncoding.Instance(_UTF16, TUtf16Encoding);
  end;

  class function Encoding.Utf16LE: TEncoding;
  begin
    result := TEncoding.Instance(_UTF16LE, TUtf16LEEncoding);
  end;

  class function Encoding.Utf32: TEncoding;
  begin
    result := TEncoding.Instance(_UTF32, TUtf32Encoding);
  end;

  class function Encoding.Utf32LE: TEncoding;
  begin
    result := TEncoding.Instance(_UTF32LE, TUtf32LEEncoding);
  end;


  class function Encoding.Identify(const aBom: TBOM;
                                   var   aEncoding: TEncoding): Boolean;

    function HasBom(const aTestEncoding: TEncoding): Boolean;
    var
      encBom: TBOM;
    begin
      encBom := aTestEncoding.Bom;

      if (Length(aBOM) < Length(encBOM)) then
        result := FALSE
      else
        result := CompareMem(@aBOM[0], @encBOM[0], Length(encBOM));

      if result then
        aEncoding := aTestEncoding;
    end;

  begin
    result := FALSE;

    // A BOM has a minimum size, so if the BOM passed to us is not
    //  big enough then we know we will not be able to identify any
    //  encoding from it

    if (Length(aBOM) < 2) then
      EXIT;

    result := TRUE;

    if HasBOM(Encoding.Utf32) then EXIT;
    if HasBOM(Encoding.Utf32LE) then EXIT;
    if HasBOM(Encoding.Utf16) then EXIT;
    if HasBOM(Encoding.Utf16LE) then EXIT;
    if HasBOM(Encoding.Utf8) then EXIT;

    // We failed to identify a recognisable BOM.  There is one last
    //  heuristic... if the BOM passed was at least two bytes of which
    //  one is non-zero (null), then we can infer a UTF16 encoding with
    //  the position of the zero (null) determining the endianness

    result := FALSE;

    // TODO: Are there heuristic techniques for identifying UTF8/32 or
    //        other encodings other than UTF16 .. ?

    if (aBOM[0] <> 0) and (aBOM[1] = 0) then
      aEncoding := Encoding.Utf16LE
    else if (aBOM[0] = 0) and (aBOM[1] <> 0) then
      aEncoding := Encoding.Utf16;
  end;


  class function Encoding.Identify(const aStream: TStream;
                                   var   aEncoding: TEncoding): Boolean;
  var
    restorePos: Int64;
    bom: TBOM;
    bytesRead: Integer;
  begin
    restorePos := aStream.Position;

    SetLength(bom, 4);
    bytesRead := aStream.Read(bom[0], 4);
    try
      if bytesRead < 4 then
        SetLength(bom, bytesRead);

      result := Identify(bom, aEncoding);
      if result then
      begin
        // The encoding was identified by a recognizable BOM so
        //  we adjust the restorePos so that we will re-position
        //  the stream on the first byte immediately following
        //  the BOM

        bom         := aEncoding.Bom;
        restorePos  := restorePos + Length(bom);
      end;

    finally
      aStream.Position := restorePos;
    end;
  end;


  class function Encoding.ForCodepage(const aCodepage: TCodepage): TEncoding;
  begin
    case aCodepage of
      cpUtf32    : result := Encoding.Utf32;
      cpUtf32LE  : result := Encoding.Utf32LE;
      cpUtf16    : result := Encoding.Utf16;
      cpUtf16LE  : result := Encoding.Utf16LE;
      cpUtf8     : result := Encoding.Utf8;
      cpASCII    : result := Encoding.ASCII;
    else
      result := _AnsiEncodingForCodepage(aCodepage);
    end;
  end;


  class function Encoding.Identify(const aBytes;
                                   const aNumBytes: Integer;
                                   var   aEncoding: TEncoding): Boolean;
  var
    bom: TBOM;
  begin
    result := (aNumBytes >= 2);
    if NOT result then
      EXIT;

    if aNumBytes > 4 then
      SetLength(bom, 4)
    else
      SetLength(bom, aNumBytes);

    CopyMemory(@bom[0], @aBytes, Length(bom));

    result := Identify(bom, aEncoding);
  end;







  constructor TEncoding.Create(const aCodePage: Cardinal);
  begin
    inherited Create;

    fCodePage := aCodePage;
  end;




  constructor TEncoding.Create(const aCodePage: Cardinal; const aBom: TBOM);
  begin
    Create(aCodepage);

    fBom := aBom;
  end;









  function TEncoding.get_IsUnicode: Boolean;
  begin
    result := (fCodepage = cpUtf8)
           or (fCodepage = cpUtf16) or (fCodepage = cpUtf16LE)
           or (fCodepage = cpUtf32) or (fCodepage = cpUtf32LE);
  end;


  function TEncoding.get_IsUtf16: Boolean;
  begin
    result := (fCodepage = cpUtf16) or (fCodepage = cpUtf16LE);
  end;


  function TEncoding.get_IsUtf32: Boolean;
  begin
    result := (fCodepage = cpUtf32) or (fCodepage = cpUtf32LE);
  end;




{ TMultiByteEncoding }

  function TMultiByteEncoding.GetByteCount(const aChars: PWideChar;
                                           const aNumChars: Integer): Integer;
  begin
    result := WideCharToMultiByte(fCodePage, 0, aChars, aNumChars, NIL, 0, NIL, NIL);
  end;


  function TMultiByteEncoding.GetCharCount(const aBytes;
                                           const aNumBytes: Integer): Integer;
  begin
    result := MultiByteToWideChar(fCodePage, 0, @aBytes, aNumBytes, NIL, 0);
  end;


  function TMultiByteEncoding.Encode(const aChars: PWIDEChar;
                                     const aNumChars: Integer;
                                     const aBytes;
                                     const aMaxBytes: Integer): Integer;
  begin
    result := WideCharToMultiByte(fCodePage, 0, aChars, aNumChars, @aBytes, aMaxBytes, NIL, NIL);
  end;


  constructor TMultiByteEncoding.Create;
  begin
    raise ENotSupported.CreateFmt('%s does not support a default constructor.  You must '
                                + 'override the constructor to identify the Codepage '
                                + '(at minimum) and BOM (if applicable).', [Classname]);
  end;


  function TMultiByteEncoding.Decode(const aBytes;
                                     const aNumBytes: Integer;
                                     const aChars: PWIDEChar;
                                     const aMaxChars: Integer): Integer;
  begin
    result := MultiByteToWideChar(fCodePage, 0, PANSIChar(@aBytes), aNumBytes, aChars, aMaxChars);
  end;



initialization
  _AnsiEncodingsLock := TCriticalSection.Create;

finalization
  _ASCII.Free;
  _UTF8.Free;
  _UTF16.Free;
  _UTF16LE.Free;
  _UTF32.Free;
  _UTF32LE.Free;

  _ASCII    := NIL;
  _UTF8     := NIL;
  _UTF16    := NIL;
  _UTF16LE  := NIL;
  _UTF32    := NIL;
  _UTF32LE  := NIL;

  _AnsiEncodingsFinalize;
end.
