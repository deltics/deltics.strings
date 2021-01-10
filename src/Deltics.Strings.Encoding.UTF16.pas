
{$i deltics.strings.inc}


  unit Deltics.Strings.Encoding.Utf16;


interface

  uses
    Deltics.Strings.Encoding;


  type
    TUtf16LEEncoding = class(TEncoding)
    protected
      constructor Create; override;
    public
      function Decode(const aBytes; const aNumBytes: Integer; const aChars: PWideChar; const aMaxChars: Integer): Integer; override;
      function Encode(const aChars: PWideChar; const aNumChars: Integer; const aBytes; const aMaxBytes: Integer): Integer; override;
      function GetByteCount(const aChars: PWideChar; const aNumChars: Integer): Integer; override;
      function GetCharCount(const aBytes; const aNumBytes: Integer): Integer; override;
    end;


    TUtf16Encoding = class(TUtf16LEEncoding)
    protected
      constructor Create; override;
    public
      function Decode(const aBytes; const aNumBytes: Integer; const aChars: PWideChar; const aMaxChars: Integer): Integer; override;
      function Encode(const aChars: PWideChar; const aNumChars: Integer; const aBytes; const aMaxBytes: Integer): Integer; override;
    end;


implementation

  uses
    Windows,
    Deltics.ReverseBytes,
    Deltics.Strings.Encoding.Bom;


{ TUTF16LEEncoding }

  constructor TUtf16LEEncoding.Create;
  begin
    inherited Create(cpUtf16LE, Utf16LEBom.AsBytes);
  end;


  function TUtf16LEEncoding.Decode(const aBytes;
                                   const aNumBytes: Integer;
                                   const aChars: PWideChar;
                                   const aMaxChars: Integer): Integer;
  begin
    result := aNumBytes div 2;
    if result > aMaxChars then
      result := aMaxChars;

    CopyMemory(@aBytes, aChars, result * 2);
  end;


  function TUtf16LEEncoding.Encode(const aChars: PWideChar;
                                   const aNumChars: Integer;
                                   const aBytes;
                                   const aMaxBytes: Integer): Integer;
  begin
    result := aNumChars * 2;
    if result > aMaxBytes then
      result := aMaxBytes;

    CopyMemory(aChars, @aBytes, result);
  end;


  function TUtf16LEEncoding.GetByteCount(const aChars: PWideChar;
                                         const aNumChars: Integer): Integer;
  begin
    result := aNumChars * 2;
  end;


  function TUtf16LEEncoding.GetCharCount(const aBytes;
                                         const aNumBytes: Integer): Integer;
  begin
    result := aNumBytes div 2;
  end;






{ TUTF16BEEncoding }

  constructor TUtf16Encoding.Create;
  begin
    inherited Create(cpUtf16, Utf16Bom.AsBytes);
  end;


  function TUtf16Encoding.Decode(const aBytes;
                                 const aNumBytes: Integer;
                                 const aChars: PWideChar;
                                 const aMaxChars: Integer): Integer;
  begin
    result := inherited Decode(aBytes, aNumBytes, aChars, aMaxChars);
    ReverseBytes(System.PWord(aChars), result);
  end;


  function TUtf16Encoding.Encode(const aChars: PWideChar;
                                 const aNumChars: Integer;
                                 const aBytes;
                                 const aMaxBytes: Integer): Integer;
  begin
    result := inherited Encode(aChars, aNumChars, aBytes, aMaxBytes);
    ReverseBytes(System.PWord(@aBytes), aNumChars);
  end;





end.
