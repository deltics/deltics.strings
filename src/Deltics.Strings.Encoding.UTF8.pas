
{$i deltics.strings.inc}


  unit Deltics.Strings.Encoding.Utf8;


interface

  uses
    Deltics.Strings.Encoding;


  type
    TUtf8Encoding = class(TMultiByteEncoding)
    protected
      constructor Create; override;
    public
      function Decode(const aBytes; const aNumBytes: Integer; const aChars: PWideChar; const aMaxChars: Integer): Integer; override;
      function Encode(const aChars: PWideChar; const aNumChars: Integer; const aBytes; const aMaxBytes: Integer): Integer; override;
      function GetByteCount(const aChars: PWideChar; const aNumChars: Integer): Integer; override;
      function GetCharCount(const aBytes; const aNumBytes: Integer): Integer; override;
    end;



implementation

  uses
    Windows,
    Deltics.Strings.Types;


{ TUTF8Encoding }

  constructor TUtf8Encoding.Create;
  begin
    inherited Create(cpUtf8, Utf8Bom.AsBytes);
  end;





  function TUtf8Encoding.Decode(const aBytes;
                                const aNumBytes: Integer;
                                const aChars: PWideChar;
                                const aMaxChars: Integer): Integer;
  begin
    result := MultiByteToWideChar(CP_UTF8, 0, PAnsiChar(@aBytes), aNumBytes, aChars, aMaxChars);
  end;


  function TUtf8Encoding.Encode(const aChars: PWideChar;
                                const aNumChars: Integer;
                                const aBytes;
                                const aMaxBytes: Integer): Integer;
  begin
    result := WideCharToMultiByte(CP_UTF8, 0, aChars, aNumChars, PAnsiChar(@aBytes), aMaxBytes, NIL, NIL);
  end;


  function TUtf8Encoding.GetByteCount(const aChars: PWideChar;
                                      const aNumChars: Integer): Integer;
  begin
    result := WideCharToMultiByte(CP_UTF8, 0, aChars, aNumChars, NIL, 0, NIL, NIL);
  end;


  function TUtf8Encoding.GetCharCount(const aBytes;
                                      const aNumBytes: Integer): Integer;
  begin
    result := MultiByteToWideChar(CP_UTF8, 0, PAnsiChar(@aBytes), aNumBytes, NIL, 0);
  end;




end.
