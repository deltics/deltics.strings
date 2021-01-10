
{$i deltics.strings.inc}


  unit Deltics.Strings.Encoding.Ascii;


interface

  uses
    Deltics.Strings.Encoding;


  type
    TASCIIEncoding = class(TMultiByteEncoding)
    protected
      constructor Create; override;
    public
      function GetByteCount(const aChars: PWIDEChar; const aNumChars: Integer): Integer; override;
      function GetCharCount(const aBytes; const aNumBytes: Integer): Integer; override;
    end;



implementation


{ TASCIIEncoding }

  constructor TASCIIEncoding.Create;
  begin
    inherited Create(cpASCII);
  end;


  function TASCIIEncoding.GetByteCount(const aChars: PWIDEChar;
                                       const aNumChars: Integer): Integer;
  begin
    result := aNumChars div 2;
  end;


  function TASCIIEncoding.GetCharCount(const aBytes;
                                       const aNumBytes: Integer): Integer;
  begin
    result := aNumBytes;
  end;



end.
