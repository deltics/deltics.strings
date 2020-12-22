
  unit Test.Strings.ANSI;

interface

  uses
    Deltics.Smoketest;


  type
    TANSITests = class(TTest)
    published
      procedure Transcoding;

      procedure fn_Alloc;
      procedure fn_CopyToBuffer;
      procedure fn_CopyToBufferOffset;
      procedure fn_FromBuffer;
      procedure fn_Len;

      procedure fn_Coalesce;
      procedure fn_HasLength;
      procedure fn_HasIndex;
      procedure fn_IIf;
      procedure fn_IndexOf;
      procedure fn_Reverse;
      procedure fn_Split;

      procedure fn_Concat;
      procedure fn_Format;
      procedure fn_StringOf;

      procedure fn_IsAlpha;
      procedure fn_IsAlphaNumeric;
      procedure fn_IsEmpty;
      procedure fn_IsInteger;
      procedure fn_IsLowercase;
      procedure fn_IsNull;
      procedure fn_IsNumeric;
      procedure fn_IsUppercase;

      procedure fn_Compare;
      procedure fn_MatchesAny;
      procedure fn_SameString;
      procedure fn_SameText;

      procedure fn_BeginsWith;
      procedure fn_Contains;
      procedure fn_EndsWith;

      procedure fn_Find;
      procedure fn_FindNext;
      procedure fn_FindPrevious;
      procedure fn_FindLast;
      procedure fn_FindAll;

      procedure fn_Append;
      procedure fn_Insert;
      procedure fn_Prepend;
      procedure fn_Embrace;
      procedure fn_Enquote;
      procedure fn_PadLeft;
      procedure fn_PadRight;

      procedure fn_Delete;
      procedure fn_DeleteAll;
      procedure fn_DeleteLast;
      procedure fn_DeleteRange;
      procedure fn_DeleteLeft;
      procedure fn_DeleteRight;

      procedure fn_Remove;
      procedure fn_RemoveAll;
      procedure fn_RemoveLast;

      procedure fn_Extract;
      procedure fn_ExtractLeft;
      procedure fn_ExtractRight;
      procedure fn_ExtractRightFrom;

      procedure fn_Copy;
      procedure fn_CopyFrom;
      procedure fn_CopyRange;
      procedure fn_CopyLeft;
      procedure fn_CopyRight;

      procedure fn_Replace;
      procedure fn_ReplaceAll;
      procedure fn_ReplaceLast;

      procedure fn_Trim;
      procedure fn_TrimLeft;
      procedure fn_TrimRight;

      procedure fn_Unbrace;
      procedure fn_Unquote;

      procedure fn_Lowercase;
      procedure fn_Startcase;
      procedure fn_Uppercase;
    end;



implementation

  uses
    Math,
    SysUtils,
    Windows,
    Deltics.Contracts,
    Deltics.Strings,
    Test.Strings;





{ TANSITests ------------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.Transcoding;
  const
    NON_ANSI = WideChar(Word($047E));
  begin
    Test('ANSI.Encode(string)!').Expect(ANSI.Encode(SRCS)).Equals(SRCA);
    Test('FromString(string)!').Expect(ANSI.FromString(SRCS)).Equals(SRCA);

    Test('FromUTF8(utf8string)!').Expect(ANSI.FromUTF8(SRCU)).Equals(SRCA);
    Test('FromUTF8(utf8 buffer)!').Expect(ANSI.FromUTF8(PUTF8Char(SRCU))).Equals(SRCA);
    Test('FromUTF8(utf8 buffer, -1)!').Expect(ANSI.FromUTF8(PUTF8Char(SRCU), -1)).Equals(SRCA);
    Test('FromUTF8(utf8 buffer, 0)!').Expect(ANSI.FromUTF8(PUTF8Char(SRCU), 0)).Equals('');
    Test('FromUTF8(utf8 buffer, 3)!').Expect(ANSI.FromUTF8(PUTF8Char(SRCU), 3)).Equals(Copy(SRCA, 1, 3));

    Test('FromWIDE(widestring)!').Expect(ANSI.FromWIDE(SRCW)).Equals(SRCA);
    Test('FromWIDE(wide buffer)!').Expect(ANSI.FromWIDE(PWIDEChar(SRCW))).Equals(SRCA);
    Test('FromWIDE(wide buffer, -1)!').Expect(ANSI.FromWIDE(PWIDEChar(SRCW), -1)).Equals(SRCA);
    Test('FromWIDE(wide buffer, 0)!').Expect(ANSI.FromWIDE(PWIDEChar(SRCW), 0)).Equals('');
    Test('FromWIDE(wide buffer, 3)!').Expect(ANSI.FromWIDE(PWIDEChar(SRCW), 3)).Equals(Copy(SRCA, 1, 3));

(*
    Deltics.Strings.AllowUnicodeDataLoss := FALSE;
    try
      ANSI.FromWIDE(NON_ANSI);
      Test('ANSI.FromWIDE(''' + NON_ANSI + ''')').Expecting(EUnicodeDataLoss);
    except
      Test('ANSI.FromWIDE(''' + NON_ANSI + ''')').Expecting(EUnicodeDataLoss);
    end;

    Deltics.Strings.AllowUnicodeDataLoss := TRUE;
    try
      ANSI.FromWIDE(NON_ANSI);
    except
      Test('ANSI.FromWIDE(''' + NON_ANSI + ''')').UnexpectedException;
    end;
*)

    try
      Test('FromUTF8(utf8 buffer, -10)!').Expect(ANSI.FromUTF8(PUTF8Char(SRCU), -10)).Equals(SRCA);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    try
      Test('FromWIDE(wide buffer, -10)!').Expect(ANSI.FromWIDE(PWIDEChar(SRCW), -10)).Equals(SRCA);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Alloc;
  var
    p: Pointer;
    pANSI: PANSIChar absolute p;
    pWIDE: PWIDEChar absolute p;
    pUTF8: PUTF8Char absolute p;
  begin
    pANSI := ANSI.Alloc(SRCA);

    Test('ANSI.Alloc [result]').Expect(p).IsAssigned;
    Test('ANSI.Alloc [buffer length]').Expect(ANSI.Len(pANSI)).Equals(Length(SRCA));
    Test('ANSI.Alloc [buffer content]').Expect(p).Equals(PANSIString(SRCA), Length(SRCA));

    FreeMem(pANSI);

    pWIDE := ANSI.AllocWIDE(SRCA);

    Test('ANSI.AllocWIDE [result').Expect(p).IsAssigned;
    Test('ANSI.AllocWIDE [buffer length]').Expect(WIDE.Len(pWIDE)).Equals(Length(SRCW));
    Test('ANSI.AllocWIDE [buffer content]').Expect(p).Equals(PWIDEString(SRCW), Length(SRCW) * 2);

    FreeMem(pWIDE);

    pUTF8 := ANSI.AllocUTF8(SRCA);

    Test('ANSI.AllocUTF8 [result]').Expect(p).IsAssigned;
    Test('ANSI.AllocUTF8 [buffer length]').Expect(UTF8.Len(pUTF8)).Equals(Length(SRCU));
    Test('ANSI.AllocUTF8 [buffer content]').Expect(p).Equals(PUTF8String(SRCU), Length(SRCU));

    FreeMem(pUTF8);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyToBuffer;
  var
    p: Pointer;
    zeroes: pointer;
    PANSI: PANSIChar absolute p;
  begin
    GetMem(p, 10);
    ZeroMemory(p, 10);

    GetMem(zeroes, 10);
    ZeroMemory(zeroes, 10);

    ANSI.CopyToBuffer(SRCA, p, 0);
    Test('ANSI.CopyToBuffer [buffer is zeroes]').Expect(p).Equals(zeroes, 10);

    ANSI.CopyToBuffer(SRCA, p);
    Test('ANSI.CopyToBuffer [buffer]').Expect(p).Equals(PANSIString(SRCA), Length(SRCA));
    ZeroMemory(p, 10);

    ANSI.CopyToBuffer(SRCA, p, 1);
    Test('ANSI.CopyToBuffer [buffer[0]]').Expect(pANSI[0]).Equals('U');
    Test('ANSI.CopyToBuffer [buffer[1]]').Expect(pANSI[1]).Equals(#0);
    ZeroMemory(p, 10);

    try
      ANSI.CopyToBuffer(SRCA, NIL);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    try
      ANSI.CopyToBuffer(SRCA, p, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    FreeMem(zeroes);
    FreeMem(p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyToBufferOffset;
  var
    p: Pointer;
    zeroes: pointer;
    PANSI: PANSIChar absolute p;
  begin
    GetMem(p, 10);
    ZeroMemory(p, 10);

    GetMem(zeroes, 10);
    ZeroMemory(zeroes, 10);

    ANSI.CopyToBufferOffset(SRCA, p, 1);
    Test('ANSI.CopyToBufferOffset(src, p, 1) [buffer[0]]').Expect(pANSI[0]).Equals(#0);
    Inc(pANSI);
    Test('ANSI.CopyToBufferOffset(src, p, 1) [buffer[1]...]').Expect(p).Equals(PANSIString(SRCA), Length(SRCA));
    Dec(pANSI);
    ZeroMemory(p, 10);

    ANSI.CopyToBufferOffset(SRCA, p, 1, 1);
    Test('ANSI.CopyToBufferOffset(src, p, 1) [buffer[0]]').Expect(pANSI[0]).Equals(#0);
    Test('ANSI.CopyToBufferOffset(src, p, 1) [buffer[1]]').Expect(pANSI[1]).Equals('U');
    Test('ANSI.CopyToBufferOffset(src, p, 1) [buffer[2]]').Expect(pANSI[2]).Equals(#0);
    ZeroMemory(p, 10);

    // Advance the buffer pointer and copy to a negative offset then test the buffer
    //  after restoring the pointer back to it's origin.

    Inc(pANSI);
    ANSI.CopyToBufferOffset(SRCA, p, -1);
    Dec(pANSI);
    Test('ANSI.CopyToBufferOffset(src, p, -1) [buffer]').Expect(p).Equals(PANSIString(SRCA), Length(SRCA));
    ZeroMemory(p, 10);

    // Same again, but this time copying 0 characters

    Inc(pANSI);
    ANSI.CopyToBufferOffset(SRCA, p, -1, 0);
    Dec(pANSI);
    Test('ANSI.CopyToBufferOffset(src, p, -1, 0) [buffer]').Expect(p).Equals(zeroes, 10);
    ZeroMemory(p, 10);

    // And again, but this time copying 1 character

    Inc(pANSI);
    ANSI.CopyToBufferOffset(SRCA, p, -1, 2);
    Dec(pANSI);
    Test('ANSI.CopyToBufferOffset(src, p, -1, 2) [buffer[0]]').Expect(pANSI[0]).Equals('U');
    Test('ANSI.CopyToBufferOffset(src, p, -1, 2) [buffer[1]]').Expect(pANSI[1]).Equals('n');
    Test('ANSI.CopyToBufferOffset(src, p, -1, 2) [buffer[2]]').Expect(pANSI[2]).Equals(#0);
    ZeroMemory(p, 10);

    try
      ANSI.CopyToBufferOffset(SRCA, p, -1, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    FreeMem(zeroes);
    FreeMem(p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FromBuffer;
  var
    p: PANSIChar;
  begin
    p   := PANSIChar(SRCA);

    Test('ANSI.FromBuffer(p)').Expect(ANSI.FromBuffer(p)).Equals(SRCA);
    Test('ANSI.FromBuffer(p, -1)').Expect(ANSI.FromBuffer(p, -1)).Equals(SRCA);
    Test('ANSI.FromBuffer(p, 0)').Expect(ANSI.FromBuffer(p, 0)).Equals('');
    Test('ANSI.FromBuffer(p, 1)').Expect(ANSI.FromBuffer(p, 1)).Equals(SRCA[1]);

    try
      ANSI.FromBuffer(p, -2);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Len;
  const
    STR: ANSIString = 'test';
    BUFFER: array[0..7] of ANSIChar = ('b','u','f','f','e','r',#0,#0);
    NULLBUFFER: array[0..7] of ANSIChar = (#0,#0,#0,#0,#0,#0,#0,#0);
  begin
    Test('ANSI.Len(string)').Expect(ANSI.Len(PANSIChar(STR))).Equals(4);
    Test('ANSI.Len(buffer)').Expect(ANSI.Len(@BUFFER[0])).Equals(6);
    Test('ANSI.Len(null buffer)').Expect(ANSI.Len(@NULLBUFFER[0])).Equals(0);
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Coalesce;
  begin
    Test('ANSI.Coalesce(''str'', ''default'')').Expect(ANSI.Coalesce('str', 'default')).Equals('str');
    Test('ANSI.Coalesce('' '', ''default'')').Expect(ANSI.Coalesce(' ', 'default')).Equals(' ');
    Test('ANSI.Coalesce('''', ''default'')').Expect(ANSI.Coalesce('', 'default')).Equals('default');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_HasLength;
  var
    len: Integer;
  begin
    Test('ANSI.HasLength('''', var len) result').Expect(ANSI.HasLength('', len)).IsFALSE;
    Test('ANSI.HasLength('''', var len) value of len').Expect(len).Equals(0);
    Test('ANSI.HasLength(''abc'', var len) result').Expect(ANSI.HasLength('abc', len)).IsTRUE;
    Test('ANSI.HasLength(''abc'', var len) value of len').Expect(len).Equals(3);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_HasIndex;
  var
    c: ANSIChar;
  begin
    Test('ANSI.HasIndex(''abc'', -1)').Expect(ANSI.HasIndex('abc', -1)).IsFALSE;
    Test('ANSI.HasIndex(''abc'', 0)').Expect(ANSI.HasIndex('abc', 0)).IsFALSE;
    Test('ANSI.HasIndex(''abc'', 1)').Expect(ANSI.HasIndex('abc', 1)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 2)').Expect(ANSI.HasIndex('abc', 2)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 3)').Expect(ANSI.HasIndex('abc', 3)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 4)').Expect(ANSI.HasIndex('abc', 4)).IsFALSE;

    Test('ANSI.HasIndex(''abc'', -1, var c) result').Expect(ANSI.HasIndex('abc', -1, c)).IsFALSE;
    Test('ANSI.HasIndex(''abc'', -1, var c) c').Expect(c).Equals(#0);
    Test('ANSI.HasIndex(''abc'', 0, var c) result').Expect(ANSI.HasIndex('abc', 0, c)).IsFALSE;
    Test('ANSI.HasIndex(''abc'', 0, var c) c').Expect(c).Equals(#0);
    Test('ANSI.HasIndex(''abc'', 1, var c) result').Expect(ANSI.HasIndex('abc', 1, c)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 1, var c) c').Expect(c).Equals('a');
    Test('ANSI.HasIndex(''abc'', 2, var c) result').Expect(ANSI.HasIndex('abc', 2, c)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 2, var c) c').Expect(c).Equals('b');
    Test('ANSI.HasIndex(''abc'', 3, var c) result').Expect(ANSI.HasIndex('abc', 3, c)).IsTRUE;
    Test('ANSI.HasIndex(''abc'', 3, var c) c').Expect(c).Equals('c');
    Test('ANSI.HasIndex(''abc'', 4, var c) result').Expect(ANSI.HasIndex('abc', 4, c)).IsFALSE;
    Test('ANSI.HasIndex(''abc'', 4, var c) c').Expect(c).Equals(#0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IIf;
  begin
    Test('ANSI.IIf(TRUE, ''true'', ''false'')').Expect(ANSI.IIf(TRUE, 'true', 'false')).Equals('true');
    Test('ANSI.IIf(FALSE, ''true'', ''false'')').Expect(ANSI.IIf(FALSE, 'true', 'false')).Equals('false');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IndexOf;
  begin
    Test('ANSI.IndexOf(''a'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('a', ['a', 'b', 'c'])).Equals(0);
    Test('ANSI.IndexOf(''b'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('b', ['a', 'b', 'c'])).Equals(1);
    Test('ANSI.IndexOf(''c'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('c', ['a', 'b', 'c'])).Equals(2);
    Test('ANSI.IndexOf(''d'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('d', ['a', 'b', 'c'])).Equals(-1);
    Test('ANSI.IndexOf(''A'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('A', ['a', 'b', 'c'])).Equals(-1);
    Test('ANSI.IndexOf('''', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOf('', ['a', 'b', 'c'])).Equals(-1);

    Test('ANSI.IndexOfText(''a'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('a', ['a', 'b', 'c'])).Equals(0);
    Test('ANSI.IndexOfText(''b'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('b', ['a', 'b', 'c'])).Equals(1);
    Test('ANSI.IndexOfText(''c'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('c', ['a', 'b', 'c'])).Equals(2);
    Test('ANSI.IndexOfText(''A'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('A', ['a', 'b', 'c'])).Equals(0);
    Test('ANSI.IndexOfText(''B'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('B', ['a', 'b', 'c'])).Equals(1);
    Test('ANSI.IndexOfText(''C'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('C', ['a', 'b', 'c'])).Equals(2);
    Test('ANSI.IndexOfText(''d'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('d', ['a', 'b', 'c'])).Equals(-1);
    Test('ANSI.IndexOfText(''D'', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('D', ['a', 'b', 'c'])).Equals(-1);
    Test('ANSI.IndexOfText('''', [''a'', ''b'', ''c''])').Expect(ANSI.IndexOfText('', ['a', 'b', 'c'])).Equals(-1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Reverse;
  begin
    Test('ANSI.Reverse('''')').Expect(ANSI.Reverse('')).Equals('');
    Test('ANSI.Reverse(''a'')').Expect(ANSI.Reverse('a')).Equals('a');
    Test('ANSI.Reverse(''abc'')').Expect(ANSI.Reverse('abc')).Equals('cba');
    Test('ANSI.Reverse(''abc d'')').Expect(ANSI.Reverse('abc d')).Equals('d cba');
    Test('ANSI.Reverse(''Ábc'')').Expect(ANSI.Reverse('Ábc')).Equals('cbÁ');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Split;
  const
    STAR: ANSIChar = '*';
  var
    s: ANSIString;
    left, right: ANSIString;
    parts: TANSIStringArray;
  begin
  // Splitting around a char

    Test('ANSI.Split('''', ''*'')').Expect(ANSI.Split('', STAR, left, right)).IsFALSE;
    Test('')['left'].Expect(left).Equals('');
    Test('')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''left'', ''*'')').Expect(ANSI.Split('left', STAR, left, right)).IsFALSE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''left*'', ''*'')').Expect(ANSI.Split('left*', STAR, left, right)).IsTRUE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''*right'', ''*'')').Expect(ANSI.Split('*right', STAR, left, right)).IsTRUE;
    Test('*right')['left'].Expect(left).Equals('');
    Test('*right')['right'].Expect(right).Equals('right');

    Test('ANSI.Split(''left*right'', ''*'')').Expect(ANSI.Split('left*right', STAR, left, right)).IsTRUE;
    Test('left*right')['left'].Expect(left).Equals('left');
    Test('left*right')['right'].Expect(right).Equals('right');

    s := 'left*mid-left*middle*mid-right*right';
    Test('ANSI.Split(''%s'', ''*'')', [s]).Expect(ANSI.Split(s, STAR, parts)).IsTRUE;
    Test('ANSI.Split(''%s'', ''*'')', [s])['no. of parts'].Expect(Length(parts)).Equals(5);
    Test('part')[0].Expect(parts[0]).Equals('left');
    Test('part')[1].Expect(parts[1]).Equals('mid-left');
    Test('part')[2].Expect(parts[2]).Equals('middle');
    Test('part')[3].Expect(parts[3]).Equals('mid-right');
    Test('part')[4].Expect(parts[4]).Equals('right');

  // Splitting around a sub-string

    Test('ANSI.Split('''', ''**'')').Expect(ANSI.Split('', '**', left, right)).IsFALSE;
    Test('')['left'].Expect(left).Equals('');
    Test('')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''left'', ''**'')').Expect(ANSI.Split('left', '**', left, right)).IsFALSE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''left**'', ''**'')').Expect(ANSI.Split('left**', '**', left, right)).IsTRUE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('ANSI.Split(''**right'', ''**'')').Expect(ANSI.Split('**right', '**', left, right)).IsTRUE;
    Test('**right')['left'].Expect(left).Equals('');
    Test('**right')['right'].Expect(right).Equals('right');

    Test('ANSI.Split(''left**right'', ''**'')').Expect(ANSI.Split('left**right', '**', left, right)).IsTRUE;
    Test('left**right')['left'].Expect(left).Equals('left');
    Test('left**right')['right'].Expect(right).Equals('right');

    s := 'left**mid-left**middle**mid-right**right';
    Test('ANSI.Split(''%s'', ''**'')', [s]).Expect(ANSI.Split(s, '**', parts)).IsTRUE;
    Test('ANSI.Split(''%s'', ''**'')', [s])['no. of parts'].Expect(Length(parts)).Equals(5);
    Test('part')[0].Expect(parts[0]).Equals('left');
    Test('part')[1].Expect(parts[1]).Equals('mid-left');
    Test('part')[2].Expect(parts[2]).Equals('middle');
    Test('part')[3].Expect(parts[3]).Equals('mid-right');
    Test('part')[4].Expect(parts[4]).Equals('right');

  // Contracts

    try
      ANSI.Split('a*b', #0, left, right);
      Test('ANSI.Split(''a*b'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.Split(''a*b'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.Split('a*b', '', left, right);
      Test('ANSI.Split(''a*b'', '')').Expecting(EContractViolation);
    except
      Test('ANSI.Split(''a*b'', '')').Expecting(EContractViolation);
    end;
  end;



















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Concat;
  begin
    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', 'bee', 'c'])).Equals('abeec');
    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', '', 'c'])).Equals('ac');

    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', 'bee', 'c'], ',')).Equals('a,bee,c');
    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', '', 'c'], ',')).Equals('a,,c');

    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', 'bee', 'c'], ', ')).Equals('a, bee, c');
    Test('ANSI.Concat(array)').Expect(ANSI.Concat(['a', '', 'c'], ', ')).Equals('a, , c');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Format;
  begin
    Note('ANSI.Format is a simple pass-thru method for calling the Format() RTL function.  '
       + 'Therefore only a limited number of test-cases are provided here primarily as '
       + 'as example of usage.');

    Test('ANSI.Format(''%d'', [42])').Expect(ANSI.Format('%d', [42])).Equals('42');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_StringOf;
  begin
    Test('ANSI.StringOf('''', 10)').Expect(ANSI.StringOf('', 10)).Equals('');
    Test('ANSI.StringOf(''foo'', 0)').Expect(ANSI.StringOf('foo', 0)).Equals('');
    Test('ANSI.StringOf(''foo'', 3)').Expect(ANSI.StringOf('foo', 3)).Equals('foofoofoo');

    Test('ANSI.StringOf(''*'', 0)').Expect(ANSI.StringOf('*', 0)).Equals('');
    Test('ANSI.StringOf(''*'', 3)').Expect(ANSI.StringOf('*', 3)).Equals('***');
  end;







  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsAlpha;
  begin
    Test('ANSI.IsAlpha(''a'')').Expect(ANSI.IsAlpha('a')).IsTRUE;
    Test('ANSI.IsAlpha(''é'')').Expect(ANSI.IsAlpha('é')).IsTRUE;
    Test('ANSI.IsAlpha(''A'')').Expect(ANSI.IsAlpha('A')).IsTRUE;

    Test('ANSI.IsAlpha(''1'')').Expect(ANSI.IsAlpha('1')).IsFALSE;
    Test('ANSI.IsAlpha('''')').Expect(ANSI.IsAlpha('')).IsFALSE;
    Test('ANSI.IsAlpha(''café'')').Expect(ANSI.IsAlpha('café')).IsTRUE;

    Test('ANSI.IsAlpha(''BBC'')').Expect(ANSI.IsAlpha('BBC')).IsTRUE;
    Test('ANSI.IsAlpha(''BBC1'')').Expect(ANSI.IsAlpha('BBC1')).IsFALSE;
    Test('ANSI.IsAlpha('' BBC '')').Expect(ANSI.IsAlpha(' BBC ')).IsFALSE;
    Test('ANSI.IsAlpha(''BBC/ITV'')').Expect(ANSI.IsAlpha('BBC/ITV')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsAlphaNumeric;
  begin
    Test('ANSI.IsAlphaNumeric(''a'')').Expect(ANSI.IsAlphaNumeric('a')).IsTRUE;
    Test('ANSI.IsAlphaNumeric(''é'')').Expect(ANSI.IsAlphaNumeric('é')).IsTRUE;
    Test('ANSI.IsAlphaNumeric(''A'')').Expect(ANSI.IsAlphaNumeric('A')).IsTRUE;

    Test('ANSI.IsAlphaNumeric(''1'')').Expect(ANSI.IsAlphaNumeric('1')).IsTRUE;
    Test('ANSI.IsAlphaNumeric('''')').Expect(ANSI.IsAlphaNumeric('')).IsFALSE;
    Test('ANSI.IsAlphaNumeric(''café'')').Expect(ANSI.IsAlphaNumeric('café')).IsTRUE;

    Test('ANSI.IsAlphaNumeric(''+1'')').Expect(ANSI.IsAlphaNumeric('+1')).IsFALSE;
    Test('ANSI.IsAlphaNumeric(''1.1'')').Expect(ANSI.IsAlphaNumeric('1.1')).IsFALSE;

    Test('ANSI.IsAlphaNumeric(''BBC'')').Expect(ANSI.IsAlphaNumeric('BBC')).IsTRUE;
    Test('ANSI.IsAlphaNumeric(''BBC1'')').Expect(ANSI.IsAlphaNumeric('BBC1')).IsTRUE;
    Test('ANSI.IsAlphaNumeric('' BBC '')').Expect(ANSI.IsAlphaNumeric(' BBC ')).IsFALSE;
    Test('ANSI.IsAlphaNumeric(''BBC/ITV'')').Expect(ANSI.IsAlphaNumeric('BBC/ITV')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsEmpty;
  begin
    Test('ANSI.IsEmpty(''a'')').Expect(ANSI.IsEmpty('a')).IsFALSE;
    Test('ANSI.IsEmpty('''')').Expect(ANSI.IsEmpty('')).IsTRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsInteger;
  begin
    Test('ANSI.IsInteger('''')').Expect(ANSI.IsInteger('')).IsFALSE;
    Test('ANSI.IsInteger(''abc'')').Expect(ANSI.IsInteger('abc')).IsFALSE;
    Test('ANSI.IsInteger(''1.'')').Expect(ANSI.IsInteger('')).IsFALSE;
    Test('ANSI.IsInteger(''.1'')').Expect(ANSI.IsInteger('')).IsFALSE;
    Test('ANSI.IsInteger(''1.0'')').Expect(ANSI.IsInteger('')).IsFALSE;

    Test('ANSI.IsInteger(''11'')').Expect(ANSI.IsInteger('11')).IsTRUE;
    Test('ANSI.IsInteger(''+11'')').Expect(ANSI.IsInteger('+11')).IsTRUE;
    Test('ANSI.IsInteger(''-11'')').Expect(ANSI.IsInteger('-11')).IsTRUE;

    Test('ANSI.IsInteger('' 11'')').Expect(ANSI.IsInteger(' 11')).IsTRUE;
    Test('ANSI.IsInteger(''11 '')').Expect(ANSI.IsInteger('11 ')).IsTRUE;
    Test('ANSI.IsInteger('' 11 '')').Expect(ANSI.IsInteger(' 11 ')).IsTRUE;

    Test('ANSI.IsInteger('' +11'')').Expect(ANSI.IsInteger(' +11')).IsTRUE;
    Test('ANSI.IsInteger(''+11 '')').Expect(ANSI.IsInteger('+11 ')).IsTRUE;
    Test('ANSI.IsInteger('' +11 '')').Expect(ANSI.IsInteger(' +11 ')).IsTRUE;

    Test('ANSI.IsInteger('' -11'')').Expect(ANSI.IsInteger(' -11')).IsTRUE;
    Test('ANSI.IsInteger(''-11 '')').Expect(ANSI.IsInteger('-11 ')).IsTRUE;
    Test('ANSI.IsInteger('' -11 '')').Expect(ANSI.IsInteger(' -11 ')).IsTRUE;

    // Not ideal, but in the interests of efficiency:

    Test('ANSI.IsInteger(''1,000'')').Expect(ANSI.IsInteger('')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsLowercase;
  const
    CHARS : array[0..6] of ANSIChar   = ('a', 'â',                         {} 'A', 'Â', '1', '?', '™');
    STRS  : array[0..8] of ANSIString = ('abc', 'a1', 'âbc?', 'windows™',  {} 'ABC', 'A1', 'ABC?', 'Windows™', '');
    LAST_LOWER_CHAR = 1;
    LAST_LOWER_STR  = 3;
  var
    i: Integer;
  begin
    for i := Low(CHARS) to High(CHARS) do
      Test('ANSI.IsLowercase(%s)', [CHARS[i]]).Expect(ANSI.IsLowercase(CHARS[i])).Equals(i <= LAST_LOWER_CHAR);

    for i := Low(STRS) to High(STRS) do
      Test('ANSI.IsLowercase(%s)', [STRS[i]]).Expect(ANSI.IsLowercase(STRS[i])).Equals(i <= LAST_LOWER_STR);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsNull;
  begin
    Test('ANSI.IsNull(''a'')').Expect(ANSI.IsNull('a')).IsFALSE;
    Test('ANSI.IsNull('' '')').Expect(ANSI.IsNull(' ')).IsFALSE;
    Test('ANSI.IsNull#0)').Expect(ANSI.IsNull(#0)).IsTRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsNumeric;
  begin
    Test('ANSI.IsNumeric(''a'')').Expect(ANSI.IsNumeric('a')).IsFALSE;
    Test('ANSI.IsNumeric(''é'')').Expect(ANSI.IsNumeric('é')).IsFALSE;
    Test('ANSI.IsNumeric(''A'')').Expect(ANSI.IsNumeric('A')).IsFALSE;
    Test('ANSI.IsNumeric(''1'')').Expect(ANSI.IsNumeric('1')).IsTRUE;
    Test('ANSI.IsNumeric('''')').Expect(ANSI.IsNumeric('')).IsFALSE;
    Test('ANSI.IsNumeric(''+123'')').Expect(ANSI.IsNumeric('+123')).IsFALSE;
    Test('ANSI.IsNumeric(''123'')').Expect(ANSI.IsNumeric('123')).IsTRUE;
    Test('ANSI.IsNumeric(''123.1'')').Expect(ANSI.IsNumeric('123.1')).IsFALSE;
    Test('ANSI.IsNumeric(''BBC1'')').Expect(ANSI.IsNumeric('BBC1')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsUppercase;
  const
    CHARS : array[0..6] of ANSIChar   = ('A', 'Â',                         {} 'a', 'â', '1', '?', '™');
    STRS  : array[0..8] of ANSIString = ('ABC', 'A1', 'ÂBC?', 'WINDOWS™',  {} 'abc', 'a1', 'abc?', 'Windows™', '');
    LAST_UPPER_CHAR = 1;
    LAST_UPPER_STR  = 3;
  var
    i: Integer;
  begin
    for i := Low(CHARS) to High(CHARS) do
      Test('ANSI.IsUppercase(%s)', [CHARS[i]]).Expect(ANSI.IsUppercase(CHARS[i])).Equals(i <= LAST_UPPER_CHAR);

    for i := Low(STRS) to High(STRS) do
      Test('ANSI.IsUppercase(%s)', [STRS[i]]).Expect(ANSI.IsUppercase(STRS[i])).Equals(i <= LAST_UPPER_STR);
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Compare;
  begin
    Test('ANSI.Compare(a, A)').Expect(ANSI.Compare('a', 'A')).Equals(isLesser);
    Test('ANSI.Compare(A, a)').Expect(ANSI.Compare('A', 'a')).Equals(isGreater);
    Test('ANSI.Compare(a, a)').Expect(ANSI.Compare('a', 'a')).Equals(isEqual);

    Test('ANSI.Compare(c, A)').Expect(ANSI.Compare('c', 'A')).Equals(isGreater);
    Test('ANSI.Compare(c, a)').Expect(ANSI.Compare('c', 'a')).Equals(isGreater);
    Test('ANSI.Compare(a, c)').Expect(ANSI.Compare('a', 'c')).Equals(isLesser);
    Test('ANSI.Compare(A, c)').Expect(ANSI.Compare('A', 'c')).Equals(isLesser);

    Test('ANSI.Compare(a, A, csIgnoreCase)').Expect(ANSI.Compare('a', 'A', csIgnoreCase)).Equals(isEqual);
    Test('ANSI.Compare(A, a, csIgnoreCase)').Expect(ANSI.Compare('A', 'a', csIgnoreCase)).Equals(isEqual);
    Test('ANSI.Compare(a, a, csIgnoreCase)').Expect(ANSI.Compare('a', 'a', csIgnoreCase)).Equals(isEqual);

    Test('ANSI.CompareText(c, A)').Expect(ANSI.CompareText('c', 'A')).Equals(isGreater);
    Test('ANSI.CompareText(c, a)').Expect(ANSI.CompareText('c', 'a')).Equals(isGreater);
    Test('ANSI.CompareText(a, c)').Expect(ANSI.CompareText('a', 'c')).Equals(isLesser);
    Test('ANSI.CompareText(A, c)').Expect(ANSI.CompareText('A', 'c')).Equals(isLesser);

    Test('ANSI.CompareText(a, A)').Expect(ANSI.CompareText('a', 'A')).Equals(isEqual);
    Test('ANSI.CompareText(A, a)').Expect(ANSI.CompareText('A', 'a')).Equals(isEqual);
    Test('ANSI.CompareText(a, a)').Expect(ANSI.CompareText('a', 'a')).Equals(isEqual);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_MatchesAny;
  begin
    Test('ANSI.MatchesAny(''abc'', [''abc'', ''def''])').Expect(ANSI.MatchesAny('abc', ['abc', 'def'])).IsTRUE;
    Test('ANSI.MatchesAny(''abc'', [''abcdef'', ''def''])').Expect(ANSI.MatchesAny('abc', ['abcdef', 'def'])).IsFALSE;
    Test('ANSI.MatchesAny('''', [''abc'', ''def''])').Expect(ANSI.MatchesAny('', ['abc', 'def'])).IsFALSE;
    Test('ANSI.MatchesAny(''abc'', ['' abc '', ''def''])').Expect(ANSI.MatchesAny('abc', [' abc ', 'def'])).IsFALSE;

    Test('ANSI.MatchesAnyText(''abc'', [''abc'', ''def''])').Expect(ANSI.MatchesAnyText('abc', ['abc', 'def'])).IsTRUE;
    Test('ANSI.MatchesAnyText(''abc'', [''ABC'', ''DEF''])').Expect(ANSI.MatchesAnyText('abc', ['ABC', 'DEF'])).IsTRUE;
    Test('ANSI.MatchesAnyText('''', [''abc'', ''def''])').Expect(ANSI.MatchesAnyText('', ['abc', 'def'])).IsFALSE;
    Test('ANSI.MatchesAnyText(''abc'', [''def'', ''ghi''])').Expect(ANSI.MatchesAnyText('abc', ['def', 'ghi'])).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_SameString;
  begin
    Test('ANSI.SameString(abc, ABC)').Expect(ANSI.SameString('abc', 'ABC')).IsFALSE;
    Test('ANSI.SameString(ABC, abc)').Expect(ANSI.SameString('ABC', 'abc')).IsFALSE;
    Test('ANSI.SameString(abc, abc)').Expect(ANSI.SameString('abc', 'abc')).IsTRUE;
    Test('ANSI.SameString(abc, abc)').Expect(ANSI.SameString('abc', 'abcd')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_SameText;
  begin
    Test('ANSI.SameText(abc, ABC)').Expect(ANSI.SameText('abc', 'ABC')).IsTRUE;
    Test('ANSI.SameText(ABC, abc)').Expect(ANSI.SameText('ABC', 'abc')).IsTRUE;
    Test('ANSI.SameText(abc, abc)').Expect(ANSI.SameText('abc', 'abc')).IsTRUE;
    Test('ANSI.SameText(abc, abc)').Expect(ANSI.SameText('abc', 'abcd')).IsFALSE;
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_BeginsWith;
  begin
    Test('ANSI.BeginsWith(''abcdef'', ''a'')').Expect(ANSI.BeginsWith('abcdef', 'a')).IsTRUE;
    Test('ANSI.BeginsWith(''abcdef'', ''A'')').Expect(ANSI.BeginsWith('abcdef', 'A')).IsFALSE;
    Test('ANSI.BeginsWith(''abcdef'', ''b'')').Expect(ANSI.BeginsWith('abcdef', 'b')).IsFALSE;
    Test('ANSI.BeginsWith(''abcdef'', ''A'', csIgnoreCase)').Expect(ANSI.BeginsWith('abcdef', 'A', csIgnoreCase)).IsTRUE;
    Test('ANSI.BeginsWith(''abcdef'', ''B'', csIgnoreCase)').Expect(ANSI.BeginsWith('abcdef', 'B', csIgnoreCase)).IsFALSE;

    Test('ANSI.BeginsWith(''abcdef'', ''abc'')').Expect(ANSI.BeginsWith('abcdef', 'abc')).IsTRUE;
    Test('ANSI.BeginsWith(''abcdef'', ''ABC'')').Expect(ANSI.BeginsWith('abcdef', 'ABC')).IsFALSE;
    Test('ANSI.BeginsWith(''abcdef'', ''def'')').Expect(ANSI.BeginsWith('abcdef', 'def')).IsFALSE;

    Test('ANSI.BeginsWith(''abcdef'', ''abc'', csIgnoreCase)').Expect(ANSI.BeginsWith('abcdef', 'abc', csIgnoreCase)).IsTRUE;
    Test('ANSI.BeginsWith(''abcdef'', ''ABC'', csIgnoreCase)').Expect(ANSI.BeginsWith('abcdef', 'ABC', csIgnoreCase)).IsTRUE;

    Test('ANSI.BeginsWith('''', ''abc'')').Expect(ANSI.BeginsWith('', 'abc')).IsFALSE;

    try
      ANSI.BeginsWith('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('ANSI.BeginsWithText(''abcdef'', ''a'')').Expect(ANSI.BeginsWithText('abcdef', 'a')).IsTRUE;
    Test('ANSI.BeginsWithText(''abcdef'', ''A'')').Expect(ANSI.BeginsWithText('abcdef', 'A')).IsTRUE;
    Test('ANSI.BeginsWithText(''abcdef'', ''b'')').Expect(ANSI.BeginsWithText('abcdef', 'b')).IsFALSE;
    Test('ANSI.BeginsWithText(''abcdef'', ''B'')').Expect(ANSI.BeginsWithText('abcdef', 'B')).IsFALSE;

    Test('ANSI.BeginsWithText(''abcdef'', ''abc'')').Expect(ANSI.BeginsWithText('abcdef', 'abc')).IsTRUE;
    Test('ANSI.BeginsWithText(''abcdef'', ''ABC'')').Expect(ANSI.BeginsWithText('abcdef', 'ABC')).IsTRUE;
    Test('ANSI.BeginsWithText(''abcdef'', ''def'')').Expect(ANSI.BeginsWithText('abcdef', 'def')).IsFALSE;

    Test('ANSI.BeginsWithText('''', ''abc'')').Expect(ANSI.BeginsWithText('', 'abc')).IsFALSE;

    try
      ANSI.BeginsWithText('abcdef', #0);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    try
      ANSI.BeginsWithText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Contains;
  begin
    Test('ANSI.Contains(''abcdef'', ''cd'')').Expect(ANSI.Contains('abcdef', 'cd')).IsTRUE;
    Test('ANSI.Contains(''abcdef'', ''CD'')').Expect(ANSI.Contains('abcdef', 'CD')).IsFALSE;
    Test('ANSI.Contains(''abcdef'', ''lp'')').Expect(ANSI.Contains('abcdef', 'lp')).IsFALSE;

    Test('ANSI.Contains(''abcdef'', ''cd'', csIgnoreCase)').Expect(ANSI.Contains('abcdef', 'cd', csIgnoreCase)).IsTRUE;
    Test('ANSI.Contains(''abcdef'', ''CD'', csIgnoreCase)').Expect(ANSI.Contains('abcdef', 'CD', csIgnoreCase)).IsTRUE;

    Test('ANSI.Contains('''', ''cd'')').Expect(ANSI.Contains('', 'cd')).IsFALSE;

    try
      ANSI.Contains('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('ANSI.ContainsText(''abcdef'', ''cd'')').Expect(ANSI.ContainsText('abcdef', 'cd')).IsTRUE;
    Test('ANSI.ContainsText(''abcdef'', ''CD'')').Expect(ANSI.ContainsText('abcdef', 'CD')).IsTRUE;
    Test('ANSI.ContainsText(''abcdef'', ''lp'')').Expect(ANSI.ContainsText('abcdef', 'lp')).IsFALSE;

    Test('ANSI.ContainsText('''', ''cd'')').Expect(ANSI.ContainsText('', 'cd')).IsFALSE;

    try
      ANSI.ContainsText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_EndsWith;
  begin
    Test('ANSI.EndsWith(''abcdef'', ''def'')').Expect(ANSI.EndsWith('abcdef', 'def')).IsTRUE;
    Test('ANSI.EndsWith(''abcdef'', ''f'')').Expect(ANSI.EndsWith('abcdef', 'f')).IsTRUE;
    Test('ANSI.EndsWith(''abcdef'', ''F'')').Expect(ANSI.EndsWith('abcdef', 'F')).IsFALSE;
    Test('ANSI.EndsWith(''abcdef'', ''DEF'')').Expect(ANSI.EndsWith('abcdef', 'DEF')).IsFALSE;
    Test('ANSI.EndsWith(''abcdef'', ''abc'')').Expect(ANSI.EndsWith('abcdef', 'abc')).IsFALSE;

    Test('ANSI.EndsWith(''abcdef'', ''def'', csIgnoreCase)').Expect(ANSI.EndsWith('abcdef', 'def', csIgnoreCase)).IsTRUE;
    Test('ANSI.EndsWith(''abcdef'', ''f'', csIgnoreCase)').Expect(ANSI.EndsWith('abcdef', 'f', csIgnoreCase)).IsTRUE;
    Test('ANSI.EndsWith(''abcdef'', ''DEF'', csIgnoreCase)').Expect(ANSI.EndsWith('abcdef', 'DEF', csIgnoreCase)).IsTRUE;
    Test('ANSI.EndsWith(''abcdef'', ''F'', csIgnoreCase)').Expect(ANSI.EndsWith('abcdef', 'F', csIgnoreCase)).IsTRUE;

    Test('ANSI.EndsWith('''', ''def'')').Expect(ANSI.EndsWith('', 'def')).IsFALSE;
    Test('ANSI.EndsWith('''', ''d'')').Expect(ANSI.EndsWith('', 'd')).IsFALSE;

    try
      ANSI.EndsWith('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('ANSI.EndsWithText(''abcdef'', ''def'')').Expect(ANSI.EndsWithText('abcdef', 'def')).IsTRUE;
    Test('ANSI.EndsWithText(''abcdef'', ''f'')').Expect(ANSI.EndsWithText('abcdef', 'f')).IsTRUE;
    Test('ANSI.EndsWithText(''abcdef'', ''F'')').Expect(ANSI.EndsWithText('abcdef', 'F')).IsTRUE;
    Test('ANSI.EndsWithText(''abcdef'', ''DEF'')').Expect(ANSI.EndsWithText('abcdef', 'DEF')).IsTRUE;
    Test('ANSI.EndsWithText(''abcdef'', ''abc'')').Expect(ANSI.EndsWithText('abcdef', 'abc')).IsFALSE;

    Test('ANSI.EndsWithText('''', ''def'')').Expect(ANSI.EndsWithText('', 'def')).IsFALSE;

    try
      ANSI.EndsWithText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Find;
  const
    STR : ANSIString  = 'abcdefghiabc';
    f   : ANSIChar    = 'f';
    G   : ANSIChar    = 'G';
    z   : ANSIChar    = 'z';
    def : ANSIString  = 'def';
    GHI : ANSIString  = 'GHI';
    xyz : ANSIString  = 'xyz';
  var
    p: Integer;
  begin
  // Find Char tests

    // Tests that Find always starts at the beginning of the string (initial p value is ignored)
    //  i.e. "Find"= "FindFirst"

    p := 8;
    Test('ANSI.Find(%s, %s, p [=8])!', [STR, f]).Expect(ANSI.Find(STR, f, p)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    // Tests that Find is case-sensitive (by default)

    Test('ANSI.Find(%s, %s, POS)!', [STR, f]).Expect(ANSI.Find(STR, f, p)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    Test('ANSI.Find(%s, %s, POS)!', [STR, G]).Expect(ANSI.Find(STR, G, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    // Tests that Find does not find things that aren't there

    Test('ANSI.Find(%s, %s, POS)!', [STR, z]).Expect(ANSI.Find(STR, z, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    // Tests that Find can be used without case-sentivity

    Test('ANSI.Find(%s, %s, POS, csIgnoreCase)!', [STR, f]).Expect(ANSI.Find(STR, f, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    Test('ANSI.Find(%s, %s, POS, csIgnoreCase)!', [STR, G]).Expect(ANSI.Find(STR, G, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

  // Find String tests

    Test('ANSI.Find(%s, %s, POS)!', [STR, def]).Expect(ANSI.Find(STR, def, p)).IsTRUE;
    Test('POS').Expect(p).Equals(4);

    Test('ANSI.Find(%s, %s, POS)!', [STR, GHI]).Expect(ANSI.Find(STR, GHI, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    Test('ANSI.Find(%s, %s, POS)!', [STR, xyz]).Expect(ANSI.Find(STR, xyz, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    Test('ANSI.Find(%s, %s, POS, csIgnoreCase)!', [STR, def]).Expect(ANSI.Find(STR, def, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(4);

    Test('ANSI.Find(%s, %s, POS, csIgnoreCase)!', [STR, GHI]).Expect(ANSI.Find(STR, GHI, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

  // Find Char tests

    Test('ANSI.FindText(%s, %s, POS)!', [STR, G]).Expect(ANSI.FindText(STR, G, p)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

    Test('ANSI.FindText(%s, %s, POS)!', [STR, z]).Expect(ANSI.FindText(STR, z, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

  // Find String tests

    Test('ANSI.FindText(%s, %s, POS)!', [STR, GHI]).Expect(ANSI.FindText(STR, GHI, p)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

    Test('ANSI.FindText(%s, %s, POS)!', [STR, xyz]).Expect(ANSI.FindText(STR, xyz, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindNext;
  const              // 0    .    1
    STR : ANSIString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
  // FindNext Char tests

    p := 0;
    Test('ANSI.FindNext(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNext(''%s'', ''a'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('ANSI.FindNext(''%s'', ''a'', p [=20]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'a', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''a'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('ANSI.FindNext(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'A', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('ANSI.FindNext(''%s'', ''A'', p [=5]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'A', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''A'', p [=5]) [p]!', [STR]).Expect(p).Equals(0);

    p := 1;
    Test('ANSI.FindNext(''%s'', ''z'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'z', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''z'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('ANSI.FindNext(''%s'', ''a'', p [=5]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'a', p, csIgnoreCase)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''a'', p [=5]) [p]!', [STR]).Expect(p).Equals(10);

    p := 5;
    Test('ANSI.FindNext(''%s'', ''A'', p [=5]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'A', p, csIgnoreCase)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''A'', p [=5]) [p]!', [STR]).Expect(p).Equals(10);

  // FindNext String tests

    p := 0;
    Test('ANSI.FindNext(''%s'', ''abc'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'abc', p)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''abc'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNext(''%s'', ''abc'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'abc', p)).IsTRUE;
    Test('ANSI.FindNext(''%s'', ''abc'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('ANSI.FindNext(''%s'', ''abc'', p [=20]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'abc', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''abc'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('ANSI.FindNext(''%s'', ''ABC'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'ABC', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''ABC'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('ANSI.FindNext(''%s'', ''ABC'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'ABC', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''ABC'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    p := 1;
    Test('ANSI.FindNext(''%s'', ''xyz'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNext(STR, 'xyz', p)).IsFALSE;
    Test('ANSI.FindNext(''%s'', ''xyz'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    try
      ANSI.FindNext(STR, #0, p);
      Test('ANSI.FindNext(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindNext(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindNext(STR, '', p);
      Test('ANSI.FindNext(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindNext(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindNextText Char tests

    p := 0;
    Test('ANSI.FindNextText(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNextText(''%s'', ''a'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('ANSI.FindNextText(''%s'', ''a'', p [=20]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'a', p)).IsFALSE;
    Test('ANSI.FindNextText(''%s'', ''a'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('ANSI.FindNextText(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'A', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNextText(''%s'', ''A'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'A', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''A'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 1;
    Test('ANSI.FindNextText(''%s'', ''z'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'z', p)).IsFALSE;
    Test('ANSI.FindNextText(''%s'', ''z'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

  // FindNextText String tests

    p := 0;
    Test('ANSI.FindNextText(''%s'', ''abc'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'abc', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''abc'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNextText(''%s'', ''abc'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'abc', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''abc'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('ANSI.FindNextText(''%s'', ''abc'', p [=20]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'abc', p)).IsFALSE;
    Test('ANSI.FindNextText(''%s'', ''abc'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('ANSI.FindNextText(''%s'', ''ABC'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'ABC', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''ABC'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindNextText(''%s'', ''ABC'', p [=1]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'ABC', p)).IsTRUE;
    Test('ANSI.FindNextText(''%s'', ''ABC'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 1;
    Test('ANSI.FindNextText(''%s'', ''xyz'', p [=0]) [result]!', [STR]).Expect(ANSI.FindNextText(STR, 'xyz', p)).IsFALSE;
    Test('ANSI.FindNextText(''%s'', ''xyz'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;

    try
      ANSI.FindNextText(STR, #0, p);
      Test('ANSI.FindNextText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindNextText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindNextText(STR, '', p);
      Test('ANSI.FindNextText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindNextText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindPrevious;
  const              // 0    .    1
    STR : ANSIString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
  // FindPrevious Char tests

    p := 0;
    Test('ANSI.FindPrevious(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(ANSI.FindPrevious(STR, 'a', p)).IsFALSE;
    Test('ANSI.FindPrevious(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('ANSI.FindPrevious(''aaa'', ''A'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'A', p)).IsFALSE;
    Test('ANSI.FindPrevious(''aaa'', ''A, p [=4]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=3]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=3]) [p]!', [STR]).Expect(p).Equals(2);

    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=2]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=1]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'a', p)).IsFALSE;
    Test('ANSI.FindPrevious(''aaa'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

  // FindNext Substring tests

    p := 4;
    Test('ANSI.FindPrevious(''aaa'', ''AA'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'AA', p)).IsFALSE;
    Test('ANSI.FindPrevious(''aaa'', ''AA'', p [=4]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'aa', p)).IsTRUE;
    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=4]) [p]!', [STR]).Expect(p).Equals(2);

    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=2]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'aa', p)).IsTRUE;
    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=1]) [result]!', [STR]).Expect(ANSI.FindPrevious('aaa', 'aa', p)).IsFALSE;
    Test('ANSI.FindPrevious(''aaa'', ''aa'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    try
      ANSI.FindPrevious(STR, #0, p);
      Test('ANSI.FindPrevious(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindPrevious(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindPrevious(STR, '', p);
      Test('ANSI.FindPrevious(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindPrevious(STR, '''', p)').Expecting(EContractViolation);
    end;


  // FindPreviousText Char tests

    p := 0;
    Test('ANSI.FindPreviousText(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(ANSI.FindPreviousText(STR, 'A', p)).IsFALSE;
    Test('ANSI.FindPreviousText(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    p := 4;
    Test('ANSI.FindPreviousText(''aaa'', ''a'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'a', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''a'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=3]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=3]) [p]!', [STR]).Expect(p).Equals(2);

    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=2]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=1]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'A', p)).IsFALSE;
    Test('ANSI.FindPreviousText(''aaa'', ''A'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

  // FindPreviousText Substring tests

    p := 4;
    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=4]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'AA', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=4]) [p]!', [STR]).Expect(p).Equals(2);

    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=2]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'AA', p)).IsTRUE;
    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=1]) [result]!', [STR]).Expect(ANSI.FindPreviousText('aaa', 'AA', p)).IsFALSE;
    Test('ANSI.FindPreviousText(''aaa'', ''AA'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    try
      ANSI.FindPreviousText(STR, #0, p);
      Test('ANSI.FindPreviousText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindPreviousText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindPreviousText(STR, '', p);
      Test('ANSI.FindPreviousText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindPreviousText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindLast;
  const              // 0    .    1
    STR : ANSIString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
    // Tests that FindLast always starts at the end of the string

    p := 1;
    Test('ANSI.FindLast(str, ''f'', p [=1]) [result]').Expect(ANSI.FindLast(STR, 'f', p)).IsTRUE;
    Test('ANSI.FindLast(str, ''f'', p [=1]) [p]').Expect(p).Equals(6);

    Test('ANSI.FindLast(str, ''f'', p) [result]').Expect(ANSI.FindLast(STR, 'f', p)).IsTRUE;
    Test('ANSI.FindLast(str, ''f'', p) [p]').Expect(p).Equals(6);

    Test('ANSI.FindLast(str, ''a'', p) [result]').Expect(ANSI.FindLast(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindLast(str, ''a'', p) [p]').Expect(p).Equals(10);

    Test('ANSI.FindLast(str, ''F'', p) [result]').Expect(ANSI.FindLast(STR, 'F', p)).IsFALSE;
    Test('ANSI.FindLast(str, ''F'', p) [p]').Expect(p).Equals(0);

    Test('ANSI.FindLast(str, ''z'', p) [result]').Expect(ANSI.FindLast(STR, 'z', p)).IsFALSE;
    Test('ANSI.FindLast(str, ''z'', p) [p]').Expect(p).Equals(0);

    Test('ANSI.FindLast(str, ''f'', p, csIgnoreCase) [result]').Expect(ANSI.FindLast(STR, 'f', p, csIgnoreCase)).IsTRUE;
    Test('ANSI.FindLast(str, ''f'', p, csIgnoreCase) [p]').Expect(p).Equals(6);

    Test('ANSI.FindLast(str, ''F'', p, csIgnoreCase) [result]').Expect(ANSI.FindLast(STR, 'F', p, csIgnoreCase)).IsTRUE;
    Test('ANSI.FindLast(str, ''F'', p, csIgnoreCase) [p]').Expect(p).Equals(6);

    try
      ANSI.FindLast(STR, #0, p);
      Test('ANSI.FindLast(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindLast(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindLast(STR, '', p);
      Test('ANSI.FindLast(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindLast(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindLastText tests

    Test('ANSI.FindLastText(str, ''f'', p) [result]').Expect(ANSI.FindLastText(STR, 'f', p)).IsTRUE;
    Test('ANSI.FindLastText(str, ''f'', p) [p]').Expect(p).Equals(6);

    Test('ANSI.FindLastText(str, ''a'', p) [result]').Expect(ANSI.FindLastText(STR, 'a', p)).IsTRUE;
    Test('ANSI.FindLastText(str, ''a'', p) [p]').Expect(p).Equals(10);

    Test('ANSI.FindLastText(str, ''F'', p) [result]').Expect(ANSI.FindLastText(STR, 'F', p)).IsTRUE;
    Test('ANSI.FindLastText(str, ''F'', p) [p]').Expect(p).Equals(6);

    Test('ANSI.FindLastText(str, ''z'', p) [result]').Expect(ANSI.FindLastText(STR, 'z', p)).IsFALSE;
    Test('ANSI.FindLastText(str, ''z'', p) [p]').Expect(p).Equals(0);

    try
      ANSI.FindLastText(STR, #0, p);
      Test('ANSI.FindLastText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindLastText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindLastText(STR, '', p);
      Test('ANSI.FindLastText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindLastText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindAll;
  const  //    .    1    .    2    .    3    .    4    .    5
    STR = 'There once was a tiny shrew that lived in a shoe.';
  var
    p: TCharIndexArray;
  begin
    Test('ANSI.FindAll('''', ''a'', p) result').Expect(ANSI.FindAll('', 'a', p)).Equals(0);
    Test('ANSI.FindAll('''', ''a'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('ANSI.FindAll(STR, ''Z'', p) result').Expect(ANSI.FindAll(STR, 'Z', p)).Equals(0);
    Test('ANSI.FindAll(STR, ''Z'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('ANSI.FindAll(STR, ''T'', p) result').Expect(ANSI.FindAll(STR, 'T', p)).Equals(1);
    Test('ANSI.FindAll(STR, ''T'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('ANSI.FindAll(STR, ''T'', p) p[0]').Expect(p[0]).Equals(1);

    Test('ANSI.FindAll(STR, ''t'', p) result').Expect(ANSI.FindAll(STR, 't', p)).Equals(3);
    Test('ANSI.FindAll(STR, ''t'', p) length(p)').Expect(Length(p)).Equals(3);
    Test('ANSI.FindAll(STR, ''t'', p) p[0]').Expect(p[0]).Equals(18);
    Test('ANSI.FindAll(STR, ''t'', p) p[1]').Expect(p[1]).Equals(29);
    Test('ANSI.FindAll(STR, ''t'', p) p[2]').Expect(p[2]).Equals(32);

    Test('ANSI.FindAll(STR, ''.'', p) result').Expect(ANSI.FindAll(STR, '.', p)).Equals(1);
    Test('ANSI.FindAll(STR, ''.'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('ANSI.FindAll(STR, ''.'', p) p[0]').Expect(p[0]).Equals(49);

    Test('ANSI.FindAll(STR, ''e'', p) result').Expect(ANSI.FindAll(STR, 'e', p)).Equals(6);
    Test('ANSI.FindAll(STR, ''e'', p) length(p)').Expect(Length(p)).Equals(6);
    Test('ANSI.FindAll(STR, ''e'', p) p[0]').Expect(p[0]).Equals(3);
    Test('ANSI.FindAll(STR, ''e'', p) p[1]').Expect(p[1]).Equals(5);
    Test('ANSI.FindAll(STR, ''e'', p) p[2]').Expect(p[2]).Equals(10);
    Test('ANSI.FindAll(STR, ''e'', p) p[3]').Expect(p[3]).Equals(26);
    Test('ANSI.FindAll(STR, ''e'', p) p[4]').Expect(p[4]).Equals(37);
    Test('ANSI.FindAll(STR, ''e'', p) p[5]').Expect(p[5]).Equals(48);

    Test('ANSI.FindAll(STR, '' a '', p) result').Expect(ANSI.FindAll(STR, ' a ', p)).Equals(2);
    Test('ANSI.FindAll(STR, '' a '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('ANSI.FindAll(STR, '' a '', p) p[0]').Expect(p[0]).Equals(15);
    Test('ANSI.FindAll(STR, '' a '', p) p[1]').Expect(p[1]).Equals(42);

    Test('ANSI.FindAll(STR, '' A '', p) result').Expect(ANSI.FindAll(STR, ' A ', p)).Equals(0);
    Test('ANSI.FindAll(STR, '' A '', p) length(p)').Expect(Length(p)).Equals(0);

    try
      ANSI.FindAll(STR, #0, p);
      Test('ANSI.FindAll(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindAll(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindAll(STR, '', p);
      Test('ANSI.FindAll(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindAll(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindAllText

    Test('ANSI.FindAllText(STR, ''Z'', p) result').Expect(ANSI.FindAllText(STR, 'Z', p)).Equals(0);
    Test('ANSI.FindAllText(STR, ''Z'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('ANSI.FindAllText(STR, ''T'', p) result').Expect(ANSI.FindAllText(STR, 'T', p)).Equals(4);
    Test('ANSI.FindAllText(STR, ''T'', p) length(p)').Expect(Length(p)).Equals(4);
    Test('ANSI.FindAllText(STR, ''T'', p) p[0]').Expect(p[0]).Equals(1);
    Test('ANSI.FindAllText(STR, ''T'', p) p[1]').Expect(p[1]).Equals(18);
    Test('ANSI.FindAllText(STR, ''T'', p) p[2]').Expect(p[2]).Equals(29);
    Test('ANSI.FindAllText(STR, ''T'', p) p[3]').Expect(p[3]).Equals(32);

    Test('ANSI.FindAllText(STR, ''t'', p) result').Expect(ANSI.FindAllText(STR, 't', p)).Equals(4);
    Test('ANSI.FindAllText(STR, ''t'', p) length(p)').Expect(Length(p)).Equals(4);
    Test('ANSI.FindAllText(STR, ''t'', p) p[0]').Expect(p[0]).Equals(1);
    Test('ANSI.FindAllText(STR, ''t'', p) p[1]').Expect(p[1]).Equals(18);
    Test('ANSI.FindAllText(STR, ''t'', p) p[2]').Expect(p[2]).Equals(29);
    Test('ANSI.FindAllText(STR, ''t'', p) p[3]').Expect(p[3]).Equals(32);

    Test('ANSI.FindAllText(STR, ''.'', p) result').Expect(ANSI.FindAllText(STR, '.', p)).Equals(1);
    Test('ANSI.FindAllText(STR, ''.'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('ANSI.FindAllText(STR, ''.'', p) p[0]').Expect(p[0]).Equals(49);

    Test('ANSI.FindAllText(STR, '' a '', p) result').Expect(ANSI.FindAllText(STR, ' a ', p)).Equals(2);
    Test('ANSI.FindAllText(STR, '' a '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('ANSI.FindAllText(STR, '' a '', p) p[0]').Expect(p[0]).Equals(15);
    Test('ANSI.FindAllText(STR, '' a '', p) p[1]').Expect(p[1]).Equals(42);

    Test('ANSI.FindAllText(STR, '' A '', p) result').Expect(ANSI.FindAllText(STR, ' A ', p)).Equals(2);
    Test('ANSI.FindAllText(STR, '' A '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('ANSI.FindAllText(STR, '' A '', p) p[0]').Expect(p[0]).Equals(15);
    Test('ANSI.FindAllText(STR, '' A '', p) p[1]').Expect(p[1]).Equals(42);

    try
      ANSI.FindAllText(STR, #0, p);
      Test('ANSI.FindAllText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindAllText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      ANSI.FindAllText(STR, '', p);
      Test('ANSI.FindAllText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('ANSI.FindAllText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;

















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Append;
  begin
    Test('ANSI.Append(''abc'', ''.'')').Expect(ANSI.Append('abc', '.')).Equals('abc.');
    Test('ANSI.Append('''', ''.'')').Expect(ANSI.Append('', '.')).Equals('.');

    Test('ANSI.Append(''abc'', ''def'')').Expect(ANSI.Append('abc', 'def')).Equals('abcdef');
    Test('ANSI.Append(''abc'', '''')').Expect(ANSI.Append('abc', '')).Equals('abc');
    Test('ANSI.Append('''', ''def'')').Expect(ANSI.Append('', 'def')).Equals('def');

    Test('ANSI.Append(''abc'', ''def'', ''/'')').Expect(ANSI.Append('abc', 'def', '/')).Equals('abc/def');
    Test('ANSI.Append(''abc'', '''', ''/'')').Expect(ANSI.Append('abc', '', '/')).Equals('abc');
    Test('ANSI.Append('''', ''def'', ''/'')').Expect(ANSI.Append('', 'def', '/')).Equals('def');

    Test('ANSI.Append(''abc'', ''def'', '' || '')').Expect(ANSI.Append('abc', 'def', ' || ')).Equals('abc || def');
    Test('ANSI.Append(''abc'', '''', '' || '')').Expect(ANSI.Append('abc', '', ' || ')).Equals('abc');
    Test('ANSI.Append('''', ''def'', '' || '')').Expect(ANSI.Append('', 'def', ' || ')).Equals('def');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Insert;
  begin
    Test('ANSI.Insert(''foobar'', 4, ''.'')').Expect(ANSI.Insert('foobar', 4, '.')).Equals('foo.bar');
    Test('ANSI.Insert(''foobar'', 0, ''.'')').Expect(ANSI.Insert('foobar', 0, '.')).Equals('foobar');
    Test('ANSI.Insert(''foobar'', 10, ''.'')').Expect(ANSI.Insert('foobar', 10, '.')).Equals('foobar');

    Test('ANSI.Insert(''foobar'', 4, ''.'', ''/'')').Expect(ANSI.Insert('foobar', 4, '.', '/')).Equals('foo/./bar');
    Test('ANSI.Insert(''foobar'', 0, ''.'', ''/'')').Expect(ANSI.Insert('foobar', 0, '.', '/')).Equals('foobar');
    Test('ANSI.Insert(''foobar'', 1, ''.'', ''/'')').Expect(ANSI.Insert('foobar', 1, '.', '/')).Equals('foobar');
    Test('ANSI.Insert(''foobar'', 6, ''.'', ''/'')').Expect(ANSI.Insert('foobar', 6, '.', '/')).Equals('fooba/./r');
    Test('ANSI.Insert(''foobar'', 10, ''.'', ''/'')').Expect(ANSI.Insert('foobar', 10, '.', '/')).Equals('foobar');

    Test('ANSI.Insert(''foobar'', 4, ''middle'', '' || '')').Expect(ANSI.Insert('foobar', 4, 'middle', ' || ')).Equals('foo || middle || bar');
    Test('ANSI.Insert(''foobar'', 0, ''middle'', '' || '')').Expect(ANSI.Insert('foobar', 0, 'middle', ' || ')).Equals('foobar');
    Test('ANSI.Insert(''foobar'', 1, ''middle'', '' || '')').Expect(ANSI.Insert('foobar', 1, 'middle', ' || ')).Equals('foobar');
    Test('ANSI.Insert(''foobar'', 6, ''middle'', '' || '')').Expect(ANSI.Insert('foobar', 6, 'middle', ' || ')).Equals('fooba || middle || r');
    Test('ANSI.Insert(''foobar'', 10, ''middle'', '' || '')').Expect(ANSI.Insert('foobar', 10, 'middle', ' || ')).Equals('foobar');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Prepend;
  begin
    Test('ANSI.Prepend(''abc'', ''.'')').Expect(ANSI.Prepend('abc', '.')).Equals('.abc');
    Test('ANSI.Prepend('''', ''.'')').Expect(ANSI.Prepend('', '.')).Equals('.');

    Test('ANSI.Prepend(''abc'', ''def'')').Expect(ANSI.Prepend('abc', 'def')).Equals('defabc');
    Test('ANSI.Prepend(''abc'', '''')').Expect(ANSI.Prepend('abc', '')).Equals('abc');
    Test('ANSI.Prepend('''', ''def'')').Expect(ANSI.Prepend('', 'def')).Equals('def');

    Test('ANSI.Prepend(''abc'', ''def'', ''/'')').Expect(ANSI.Prepend('abc', 'def', '/')).Equals('def/abc');
    Test('ANSI.Prepend(''abc'', '''', ''/'')').Expect(ANSI.Prepend('abc', '', '/')).Equals('abc');
    Test('ANSI.Prepend('''', ''def'', ''/'')').Expect(ANSI.Prepend('', 'def', '/')).Equals('def');

    Test('ANSI.Prepend(''abc'', ''def'', '' || '')').Expect(ANSI.Prepend('abc', 'def', ' || ')).Equals('def || abc');
    Test('ANSI.Prepend(''abc'', '''', '' || '')').Expect(ANSI.Prepend('abc', '', ' || ')).Equals('abc');
    Test('ANSI.Prepend('''', ''def'', '' || '')').Expect(ANSI.Prepend('', 'def', ' || ')).Equals('def');
  end;






  procedure TANSITests.fn_Embrace;
  begin
    // Default braces ( )
    Test('ANSI.Embrace()').Expect(ANSI.Embrace('')).Equals('()');
    Test('ANSI.Embrace(abc)').Expect(ANSI.Embrace('abc')).Equals('(abc)');

    // Embracing an empty string
    Test('ANSI.Embrace('''', [)').Expect(ANSI.Embrace('', '[')).Equals('[]');
    Test('ANSI.Embrace('''', {)').Expect(ANSI.Embrace('', '{')).Equals('{}');
    Test('ANSI.Embrace('''', <)').Expect(ANSI.Embrace('', '<')).Equals('<>');
    Test('ANSI.Embrace('''', #)').Expect(ANSI.Embrace('', '#')).Equals('##');
    Test('ANSI.Embrace('''', !)').Expect(ANSI.Embrace('', '!')).Equals('!!');

    // Embracing a string with a braced pair
    Test('ANSI.Embrace(abc, ()').Expect(ANSI.Embrace('abc', '(')).Equals('(abc)');
    Test('ANSI.Embrace(abc, [)').Expect(ANSI.Embrace('abc', '[')).Equals('[abc]');
    Test('ANSI.Embrace(abc, {)').Expect(ANSI.Embrace('abc', '{')).Equals('{abc}');
    Test('ANSI.Embrace(abc, <)').Expect(ANSI.Embrace('abc', '<')).Equals('<abc>');

    // Embracing a string with non-brace character
    Test('ANSI.Embrace(abc, #)').Expect(ANSI.Embrace('abc', '#')).Equals('#abc#');
    Test('ANSI.Embrace(abc, !)').Expect(ANSI.Embrace('abc', '!')).Equals('!abc!');
    Test('ANSI.Embrace(abc, @)').Expect(ANSI.Embrace('abc', '@')).Equals('@abc@');
    Test('ANSI.Embrace(abc, $)').Expect(ANSI.Embrace('abc', '$')).Equals('$abc$');
    Test('ANSI.Embrace(abc, &)').Expect(ANSI.Embrace('abc', '&')).Equals('&abc&');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Enquote;
  begin
    Test('ANSI.Enquote('''')').Expect(ANSI.Enquote('')).Equals('''''');
    Test('ANSI.Enquote('''', ''"'')').Expect(ANSI.Enquote('', '"')).Equals('""');

    Test('ANSI.Enquote(''Mother knows best'')').Expect(ANSI.Enquote('Mother knows best')).Equals('''Mother knows best''');
    Test('ANSI.Enquote(''Mother knows best'', ''"'')').Expect(ANSI.Enquote('Mother knows best', '"')).Equals('"Mother knows best"');

    Test('ANSI.Enquote(''Some Mothers Do ''Ave ''Em'')').Expect(ANSI.Enquote('Some Mothers Do ''Ave ''Em')).Equals('''Some Mothers Do ''''Ave ''''Em''');
    Test('ANSI.Enquote(''Some Mothers Do ''Ave ''Em'', '''''')').Expect(ANSI.Enquote('Some Mothers Do ''Ave ''Em', '''')).Equals('''Some Mothers Do ''''Ave ''''Em''');
    Test('ANSI.Enquote(''Some Mothers Do ''Ave ''Em'', ''"'')').Expect(ANSI.Enquote('Some Mothers Do ''Ave ''Em', '"')).Equals('"Some Mothers Do ''Ave ''Em"');
    Test('ANSI.Enquote(''Some Mothers Do ''Ave ''Em'', '''''', ''\'')').Expect(ANSI.Enquote('Some Mothers Do ''Ave ''Em', '''', '\')).Equals('''Some Mothers Do \''Ave \''Em''');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_PadLeft;
  begin
    Test('ANSI.PadLeft(42, 4)').Expect(ANSI.PadLeft(42, 4)).Equals('  42');
    Test('ANSI.PadLeft(42, 4, ''0'')').Expect(ANSI.PadLeft(42, 4, ANSIChar('0'))).Equals('0042');
    Test('ANSI.PadLeft(42, 4, ''0'')').Expect(ANSI.PadLeft(42, 4, WIDEChar('0'))).Equals('0042');

    Test('ANSI.PadLeft(''foo'', 10)').Expect(ANSI.PadLeft('foo', 10)).Equals('       foo');
    Test('ANSI.PadLeft(''foo'', 10, '' '')').Expect(ANSI.PadLeft('foo', 10, ' ')).Equals('       foo');
    Test('ANSI.PadLeft(''foo'', 10, ''x'')').Expect(ANSI.PadLeft('foo', 10, 'x')).Equals('xxxxxxxfoo');

    Test('ANSI.PadLeft(''foo'', 3, '' '')').Expect(ANSI.PadLeft('foo', 3, ' ')).Equals('foo');
    Test('ANSI.PadLeft(''foo'', 2, '' '')').Expect(ANSI.PadLeft('foo', 2, ' ')).Equals('foo');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_PadRight;
  begin
    Test('ANSI.PadRight(42, 4)').Expect(ANSI.PadRight(42, 4)).Equals('42  ');
    Test('ANSI.PadRight(42, 4, ''0'')').Expect(ANSI.PadRight(42, 4, ANSIChar('0'))).Equals('4200');
    Test('ANSI.PadRight(42, 4, ''0'')').Expect(ANSI.PadRight(42, 4, WIDEChar('0'))).Equals('4200');

    Test('ANSI.PadRight(''foo'', 10)').Expect(ANSI.PadRight('foo', 10)).Equals('foo       ');
    Test('ANSI.PadRight(''foo'', 10, '' '')').Expect(ANSI.PadRight('foo', 10, ' ')).Equals('foo       ');
    Test('ANSI.PadRight(''foo'', 10, ''x'')').Expect(ANSI.PadRight('foo', 10, 'x')).Equals('fooxxxxxxx');

    Test('ANSI.PadRight(''foo'', 3, '' '')').Expect(ANSI.PadRight('foo', 3, ' ')).Equals('foo');
    Test('ANSI.PadRight(''foo'', 2, '' '')').Expect(ANSI.PadRight('foo', 2, ' ')).Equals('foo');
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Delete;
  const
    TEST_INDEX: array[1..4, 1..2] of Integer = (
                                                ( 0,  6),
                                                (-1,  6),
                                                ( 7,  1),
                                                ( 1, -1)
                                               );
  var
    i: Integer;
    s: ANSIString;
  begin
    s := 'abcdef';
    ANSI.Delete(s, 1, 0);
    Test('ANSI.Delete(var ''abcdef'', 1, 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    ANSI.Delete(s, 1, 3);
    Test('ANSI.Delete(var ''abcdef'', 1, 3)').Expect(s).Equals('def');

    s := 'abcdef';
    ANSI.Delete(s, 2, 3);
    Test('ANSI.Delete(var ''abcdef'', 2, 3)').Expect(s).Equals('aef');

    s := 'abcdef';
    ANSI.Delete(s, 4, 3);
    Test('ANSI.Delete(var ''abcdef'', 4, 3)').Expect(s).Equals('abc');

    s := 'abcdef';
    ANSI.Delete(s, 4, 10);
    Test('ANSI.Delete(var ''abcdef'', 4, 10)').Expect(s).Equals('abc');

    s := 'abcdef';
    ANSI.Delete(s, 1, 6);
    Test('ANSI.Delete(var ''abcdef'', 1, 6)').Expect(s).Equals('');

    s := 'abcdef';
    ANSI.Delete(s, 1, 10);
    Test('ANSI.Delete(var ''abcdef'', 1, 10)').Expect(s).Equals('');

    Note('Contracts');
    s := 'abcdef';
    for i := Low(TEST_INDEX) to High(TEST_INDEX) do
      try
        ANSI.Delete(s, TEST_INDEX[i, 1], TEST_INDEX[i, 2]);
        Test.Expecting(EContractViolation);
      except
        Test.Expecting(EContractViolation);
      end;

    Note('Contract violations should not affect the input string');
    Test.Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('ANSI.Delete(var ''abcdef'', ''abc'') [result]').Expect(ANSI.Delete(s, 'abc')).IsTRUE;
    Test('ANSI.Delete(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.Delete(var ''abcdef'', ''bcd'') [result]').Expect(ANSI.Delete(s, 'bcd')).IsTRUE;
    Test('ANSI.Delete(var ''abcdef'', ''bcd'') [var]').Expect(s).Equals('aef');

    s := 'abcdef';
    Test('ANSI.Delete(var ''abcdef'', ''c'') [result]').Expect(ANSI.Delete(s, 'c')).IsTRUE;
    Test('ANSI.Delete(var ''abcdef'', ''c'') [var]').Expect(s).Equals('abdef');

    s := 'abcdef';
    Test('ANSI.Delete(var ''abcdef'', ''z'') [result]').Expect(ANSI.Delete(s, 'z')).IsFALSE;
    Test('ANSI.Delete(var ''abcdef'', ''z'') [var]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('ANSI.Delete(var ''abcdef'', ''ABC'') [result]').Expect(ANSI.Delete(s, 'ABC')).IsFALSE;
    Test('ANSI.Delete(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('abcdef');

  // DeleteText (only supports substring deletion, not index range)

    s := 'abcdef';
    Test('ANSI.DeleteText(var ''abcdef'', ''ABC'') [result]').Expect(ANSI.DeleteText(s, 'ABC')).IsTRUE;
    Test('ANSI.DeleteText(var ''abcdef'', ''ABC'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.DeleteText(var ''abcdef'', ''abc'') [result]').Expect(ANSI.DeleteText(s, 'abc')).IsTRUE;
    Test('ANSI.DeleteText(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.DeleteText(var ''abcdef'', ''xyz'') [result]').Expect(ANSI.DeleteText(s, 'xyz')).IsFALSE;
    Test('ANSI.DeleteText(var ''abcdef'', ''xyz'') [var]').Expect(s).Equals('abcdef');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_DeleteAll;
  var
    s: ANSIString;
  begin
    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''a'') result').Expect(ANSI.DeleteAll(s, 'a')).Equals(2);
    Test('ANSI.DeleteAll(var ''abcabc'', ''a'') string').Expect(s).Equals('bcbc');

    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''A'') result').Expect(ANSI.DeleteAll(s, 'A')).Equals(0);
    Test('ANSI.DeleteAll(var ''abcabc'', ''A'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''d'') result').Expect(ANSI.DeleteAll(s, 'd')).Equals(0);
    Test('ANSI.DeleteAll(var ''abcabc'', ''d'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''abc'') result').Expect(ANSI.DeleteAll(s, 'abc')).Equals(2);
    Test('ANSI.DeleteAll(var ''abcabc'', ''abc'') string').Expect(s).Equals('');

    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''ABC'') result').Expect(ANSI.DeleteAll(s, 'ABC')).Equals(0);
    Test('ANSI.DeleteAll(var ''abcabc'', ''ABC'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('ANSI.DeleteAll(var ''abcabc'', ''def'') result').Expect(ANSI.DeleteAll(s, 'def')).Equals(0);
    Test('ANSI.DeleteAll(var ''abcabc'', ''def'') string').Expect(s).Equals('abcabc');

    try
      ANSI.DeleteAll(s, #0);
      Test('ANSI.DeleteAll(var ''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.DeleteAll(var ''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.DeleteAll(s, '');
      Test('ANSI.DeleteAll(var ''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.DeleteAll(var ''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_DeleteLast;
  var
    s: ANSIString;
  begin
  // DeleteLast (only supports substring deletion, not index range)

    s := 'abcdabc';
    Test('ANSI.DeleteLast(var ''abcdabc'', ''abc'') [result]').Expect(ANSI.DeleteLast(s, 'abc')).IsTRUE;
    Test('ANSI.DeleteLast(var ''abcdabc'', ''abc'') [var]').Expect(s).Equals('abcd');

    s := 'abcabc';
    Test('ANSI.DeleteLast(var ''abcabc'', ''bcd'') [result]').Expect(ANSI.DeleteLast(s, 'cab')).IsTRUE;
    Test('ANSI.DeleteLast(var ''abcabc'', ''bcd'') [var]').Expect(s).Equals('abc');

    s := 'abcabc';
    Test('ANSI.DeleteLast(var ''abcabc'', ''c'') [result]').Expect(ANSI.DeleteLast(s, 'c')).IsTRUE;
    Test('ANSI.DeleteLast(var ''abcabc'', ''c'') [var]').Expect(s).Equals('abcab');

    s := 'abcabc';
    Test('ANSI.DeleteLast(var ''abcabc'', ''z'') [result]').Expect(ANSI.DeleteLast(s, 'z')).IsFALSE;
    Test('ANSI.DeleteLast(var ''abcabc'', ''z'') [var]').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('ANSI.DeleteLast(var ''abcabc'', ''ABC'') [result]').Expect(ANSI.DeleteLast(s, 'ABC')).IsFALSE;
    Test('ANSI.DeleteLast(var ''abcabc'', ''abc'') [var]').Expect(s).Equals('abcabc');

  // DeleteLastText (only supports substring deletion, not index range)

    s := 'abcdabc';
    Test('ANSI.DeleteLastText(var ''abcdabc'', ''ABC'') [result]').Expect(ANSI.DeleteLastText(s, 'ABC')).IsTRUE;
    Test('ANSI.DeleteLastText(var ''abcdabc'', ''ABC'') [var]').Expect(s).Equals('abcd');

    s := 'abcdabc';
    Test('ANSI.DeleteLastText(var ''abcdabc'', ''abc'') [result]').Expect(ANSI.DeleteLastText(s, 'abc')).IsTRUE;
    Test('ANSI.DeleteLastText(var ''abcdabc'', ''abc'') [var]').Expect(s).Equals('abcd');

    s := 'abcabc';
    Test('ANSI.DeleteLastText(var ''abcabc'', ''xyz'') [result]').Expect(ANSI.DeleteLastText(s, 'xyz')).IsFALSE;
    Test('ANSI.DeleteLastText(var ''abcabc'', ''xyz'') [var]').Expect(s).Equals('abcabc');

  // DeleteLast contracts

    try
      ANSI.DeleteLast(s, #0);
      Test('ANSI.DeleteLast(var ''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.DeleteLast(var ''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.DeleteLast(s, '');
      Test('ANSI.DeleteLast(var ''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.DeleteLast(var ''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_DeleteRange;
  const
    TEST_INDEX: array[1..7, 1..2] of Integer = (
                                                ( 1,   0),
                                                (-1,   6),
                                                ( 0,   6),
                                                ( 4,  10),
                                                ( 1,  10),
                                                ( 7,   1),
                                                ( 1,  -1)
                                               );

  var
    i: Integer;
    s: ANSIString;
  begin
    s := 'abcdef';
    ANSI.DeleteRange(s, 1, 3);
    Test('ANSI.DeleteRange(var ''abcdef'', 1, 3)').Expect(s).Equals('def');

    s := 'abcdef';
    ANSI.DeleteRange(s, 2, 3);
    Test('ANSI.DeleteRange(var ''abcdef'', 2, 3)').Expect(s).Equals('adef');

    s := 'abcdef';
    ANSI.DeleteRange(s, 2, 2);
    Test('ANSI.DeleteRange(var ''abcdef'', 2, 2)').Expect(s).Equals('acdef');

    s := 'abcdef';
    ANSI.DeleteRange(s, 4, 3);
    Test('ANSI.DeleteRange(var ''abcdef'', 4, 3)').Expect(s).Equals('abef');

    s := 'abcdef';
    ANSI.DeleteRange(s, 1, 6);
    Test('ANSI.DeleteRange(var ''abcdef'', 1, 6)').Expect(s).Equals('');

    Note('Contracts');

    s := 'abcdef';

    for i := Low(TEST_INDEX) to High(TEST_INDEX) do
      try
        ANSI.DeleteRange(s, TEST_INDEX[i, 1], TEST_INDEX[i, 2]);
        Test.Expecting(EContractViolation);
      except
        Test.Expecting(EContractViolation);
      end;

    Note('Contract violations should not affect the input string');
    Test.Expect(s).Equals('abcdef');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_DeleteLeft;
  var
    s: ANSIString;
  begin
    s := 'abcdef';
    ANSI.DeleteLeft(s, 0);
    Test('ANSI.DeleteLeft(var ''abcdef'', 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    ANSI.DeleteLeft(s, 3);
    Test('ANSI.DeleteLeft(var ''abcdef'', 3)').Expect(s).Equals('def');

    s := 'abcdef';
    ANSI.DeleteLeft(s, 10);
    Test('ANSI.DeleteLeft(var ''abcdef'', 10)').Expect(s).Equals('');

    s := 'abcdef';
    Test('ANSI.DeleteLeft(var str, substr) [result]').Expect(ANSI.DeleteLeft(s, 'abc')).IsTRUE;
    Test('ANSI.DeleteLeft(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.DeleteLeft(var str, substr) [result]').Expect(ANSI.DeleteLeft(s, 'ABC')).IsFALSE;
    Test('ANSI.DeleteLeft(var str, substr) [str]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('ANSI.DeleteLeft(var str, substr, csIgnoreCase) [result]').Expect(ANSI.DeleteLeft(s, 'ABC', csIgnoreCase)).IsTRUE;
    Test('ANSI.DeleteLeft(var str, substr, csIgnoreCase) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.DeleteLeftText(var str, substr) [result]').Expect(ANSI.DeleteLeftText(s, 'ABC')).IsTRUE;
    Test('ANSI.DeleteLeftText(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('ANSI.DeleteLeftText(var str, substr) [result]').Expect(ANSI.DeleteLeftText(s, 'abc')).IsTRUE;
    Test('ANSI.DeleteLeftText(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    try
      ANSI.DeleteLeft(s, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_DeleteRight;
  var
    s: ANSIString;
  begin
    s := 'abcdef';
    ANSI.DeleteRight(s, 0);
    Test('ANSI.DeleteRight(var ''abcdef'', 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    ANSI.DeleteRight(s, 3);
    Test('ANSI.DeleteRight(var ''abcdef'', 3)').Expect(s).Equals('abc');

    s := 'abcdef';
    ANSI.DeleteRight(s, 10);
    Test('ANSI.DeleteRight(var ''abcdef'', 10)').Expect(s).Equals('');

    s := 'abcdef';
    Test('ANSI.DeleteRight(var str, substr) [result]').Expect(ANSI.DeleteRight(s, 'def')).IsTRUE;
    Test('ANSI.DeleteRight(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('ANSI.DeleteRight(var str, substr) [result]').Expect(ANSI.DeleteRight(s, 'DEF')).IsFALSE;
    Test('ANSI.DeleteRight(var str, substr) [str]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('ANSI.DeleteRight(var str, substr, csIgnoreCase) [result]').Expect(ANSI.DeleteRight(s, 'DEF', csIgnoreCase)).IsTRUE;
    Test('ANSI.DeleteRight(var str, substr, csIgnoreCase) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('ANSI.DeleteRightText(var str, substr) [result]').Expect(ANSI.DeleteRightText(s, 'DEF')).IsTRUE;
    Test('ANSI.DeleteRightText(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('ANSI.DeleteRightText(var str, substr) [result]').Expect(ANSI.DeleteRightText(s, 'def')).IsTRUE;
    Test('ANSI.DeleteRightText(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    try
      ANSI.DeleteRight(s, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Remove;
  const
    STR = 'abcabc';
  begin
    Test('ANSI.Remove(''abcabc'', ''a'')').Expect(ANSI.Remove(STR, 'a')).Equals('bcabc');
    Test('ANSI.Remove(''abcabc'', ''A'')').Expect(ANSI.Remove(STR, 'A')).Equals('abcabc');
    Test('ANSI.Remove(''abcabc'', ''d'')').Expect(ANSI.Remove(STR, 'd')).Equals('abcabc');

    Test('ANSI.Remove(''abcabc'', ''abc'')').Expect(ANSI.Remove(STR, 'abc')).Equals('abc');
    Test('ANSI.Remove(''abcabc'', ''ABC'')').Expect(ANSI.Remove(STR, 'ABC')).Equals('abcabc');
    Test('ANSI.Remove(''abcabc'', ''def'')').Expect(ANSI.Remove(STR, 'def')).Equals('abcabc');

    try
      ANSI.Remove(STR, #0);
      Test('ANSI.Remove(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.Remove(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.Remove(STR, '');
      Test('ANSI.Remove(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.Remove(''abcabc'', '''')').Expecting(EContractViolation);
    end;

    Test('ANSI.RemoveText(''abcabc'', ''a'')').Expect(ANSI.RemoveText(STR, 'a')).Equals('bcabc');
    Test('ANSI.RemoveText(''abcabc'', ''A'')').Expect(ANSI.RemoveText(STR, 'A')).Equals('bcabc');
    Test('ANSI.RemoveText(''abcabc'', ''d'')').Expect(ANSI.RemoveText(STR, 'd')).Equals('abcabc');

    Test('ANSI.RemoveText(''abcabc'', ''abc'')').Expect(ANSI.RemoveText(STR, 'abc')).Equals('abc');
    Test('ANSI.RemoveText(''abcabc'', ''ABC'')').Expect(ANSI.RemoveText(STR, 'ABC')).Equals('abc');
    Test('ANSI.RemoveText(''abcabc'', ''def'')').Expect(ANSI.RemoveText(STR, 'def')).Equals('abcabc');

    try
      ANSI.RemoveText(STR, #0);
      Test('ANSI.RemoveText(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveText(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.RemoveText(STR, '');
      Test('ANSI.RemoveText(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveText(''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_RemoveAll;
  const
    STR = 'abcabc';
  begin
    Test('ANSI.RemoveAll(''abcabc'', ''a'')').Expect(ANSI.RemoveAll(STR, 'a')).Equals('bcbc');
    Test('ANSI.RemoveAll(''abcabc'', ''A'')').Expect(ANSI.RemoveAll(STR, 'A')).Equals('abcabc');
    Test('ANSI.RemoveAll(''abcabc'', ''d'')').Expect(ANSI.RemoveAll(STR, 'd')).Equals('abcabc');

    Test('ANSI.RemoveAll(''abcabc'', ''abc'')').Expect(ANSI.RemoveAll(STR, 'abc')).Equals('');
    Test('ANSI.RemoveAll(''abcabc'', ''ABC'')').Expect(ANSI.RemoveAll(STR, 'ABC')).Equals('abcabc');
    Test('ANSI.RemoveAll(''abcabc'', ''def'')').Expect(ANSI.RemoveAll(STR, 'def')).Equals('abcabc');

    try
      ANSI.RemoveAll(STR, #0);
      Test('ANSI.RemoveAll(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveAll(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.RemoveAll(STR, '');
      Test('ANSI.RemoveAll(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveAll(''abcabc'', '''')').Expecting(EContractViolation);
    end;

    Test('ANSI.RemoveAllText(''abcabc'', ''a'')').Expect(ANSI.RemoveAllText(STR, 'a')).Equals('bcbc');
    Test('ANSI.RemoveAllText(''abcabc'', ''A'')').Expect(ANSI.RemoveAllText(STR, 'A')).Equals('bcbc');
    Test('ANSI.RemoveAllText(''abcabc'', ''d'')').Expect(ANSI.RemoveAllText(STR, 'd')).Equals('abcabc');

    Test('ANSI.RemoveAllText(''abcabc'', ''abc'')').Expect(ANSI.RemoveAllText(STR, 'abc')).Equals('');
    Test('ANSI.RemoveAllText(''abcabc'', ''ABC'')').Expect(ANSI.RemoveAllText(STR, 'ABC')).Equals('');
    Test('ANSI.RemoveAllText(''abcabc'', ''def'')').Expect(ANSI.RemoveAllText(STR, 'def')).Equals('abcabc');

    try
      ANSI.RemoveAllText(STR, #0);
      Test('ANSI.RemoveAllText(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveAllText(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.RemoveAllText(STR, '');
      Test('ANSI.RemoveAllText(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveAllText(''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  procedure TANSITests.fn_RemoveLast;
  const
    STR = 'abcdabc';
  begin
    Test('ANSI.RemoveLast(''abcdabc'', ''a'')').Expect(ANSI.RemoveLast(STR, 'a')).Equals('abcdbc');
    Test('ANSI.RemoveLast(''abcdabc'', ''A'')').Expect(ANSI.RemoveLast(STR, 'A')).Equals('abcdabc');
    Test('ANSI.RemoveLast(''abcdabc'', ''x'')').Expect(ANSI.RemoveLast(STR, 'x')).Equals('abcdabc');

    Test('ANSI.RemoveLast(''abcdabc'', ''abc'')').Expect(ANSI.RemoveLast(STR, 'abc')).Equals('abcd');
    Test('ANSI.RemoveLast(''abcdabc'', ''ABC'')').Expect(ANSI.RemoveLast(STR, 'ABC')).Equals('abcdabc');
    Test('ANSI.RemoveLast(''abcdabc'', ''def'')').Expect(ANSI.RemoveLast(STR, 'def')).Equals('abcdabc');

    try
      ANSI.RemoveLast(STR, #0);
      Test('ANSI.RemoveLast(''abcdabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveLast(''abcdabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.RemoveLast(STR, '');
      Test('ANSI.RemoveLast(''abcdabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveLast(''abcdabc'', '''')').Expecting(EContractViolation);
    end;

    Test('ANSI.RemoveLastText(''abcdabc'', ''a'')').Expect(ANSI.RemoveLastText(STR, 'a')).Equals('abcdbc');
    Test('ANSI.RemoveLastText(''abcdabc'', ''A'')').Expect(ANSI.RemoveLastText(STR, 'A')).Equals('abcdbc');
    Test('ANSI.RemoveLastText(''abcdabc'', ''x'')').Expect(ANSI.RemoveLastText(STR, 'x')).Equals('abcdabc');

    Test('ANSI.RemoveLastText(''abcdabc'', ''abc'')').Expect(ANSI.RemoveLastText(STR, 'abc')).Equals('abcd');
    Test('ANSI.RemoveLastText(''abcdabc'', ''ABC'')').Expect(ANSI.RemoveLastText(STR, 'ABC')).Equals('abcd');
    Test('ANSI.RemoveLastText(''abcdabc'', ''def'')').Expect(ANSI.RemoveLastText(STR, 'def')).Equals('abcdabc');

    try
      ANSI.RemoveLastText(STR, #0);
      Test('ANSI.RemoveLastText(''abcdabc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveLastText(''abcdabc'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.RemoveLastText(STR, '');
      Test('ANSI.RemoveLastText(''abcdabc'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.RemoveLastText(''abcdabc'', '''')').Expecting(EContractViolation);
    end;
  end;











  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Extract;
  const
    SRC: ANSIString = 'abcdefghi';
  var
    sSource: ANSIString;
    sExtract: ANSIString;
  begin
    sSource  := SRC;
    sExtract := 'z';
    try
      Test('ANSI.Extract(''abcdefghi'', -1, 1, var)').Expect(ANSI.Extract(sSource, -1, 1, sExtract)).IsTRUE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource  := SRC;
    sExtract := 'z';
    try
      Test('ANSI.Extract(''abcdefghi'', 7, 6, var)').Expect(ANSI.Extract(sSource, 7, 6, sExtract)).IsTRUE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource  := SRC;
    sExtract := 'z';
    try
      Test('ANSI.Extract(''abcdefghi'', 10, 1, var)').Expect(ANSI.Extract(sSource, 10, 1, sExtract)).IsFALSE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource := SRC;
    Test('ANSI.Extract(''abcdefghi'', 4, 3, var)').Expect(ANSI.Extract(sSource, 4, 3, sExtract)).IsTRUE;
    Test('source = ''abcghi''').Expect(sSource).Equals('abcghi');
    Test('var = ''def''').Expect(sExtract).Equals('def');

    sSource := SRC;
    Test('ANSI.Extract(''abcdefghi'', 1, 1, var)').Expect(ANSI.Extract(sSource, 1, 1, sExtract)).IsTRUE;
    Test('source = ''bcdefghi''').Expect(sSource).Equals('bcdefghi');
    Test('var = ''a''').Expect(sExtract).Equals('a');

    sSource := SRC;
    Test('ANSI.Extract(''abcdefghi'', 9, 1, var)').Expect(ANSI.Extract(sSource, 9, 1, sExtract)).IsTRUE;
    Test('source = ''abcdefgh''').Expect(sSource).Equals('abcdefgh');
    Test('var = ''i''').Expect(sExtract).Equals('i');

    sSource  := SRC;
    sExtract := 'z';
    Test('ANSI.Extract(''abcdefghi'', 1, 0, var)').Expect(ANSI.Extract(sSource, 1, 0, sExtract)).IsFALSE;
    Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
    Test('var = ''''').Expect(sExtract).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_ExtractLeft;
  const
    SRC: ANSIString = 'abcdefghi';
  var
    s, e: ANSIString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 0, var extract) result').Expect(ANSI.ExtractLeft(s, 0, e)).IsFALSE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 0, var extract) extract').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 0, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 3, var extract) result').Expect(ANSI.ExtractLeft(s, 3, e)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 3, var extract) extract').Expect(s).Equals('defghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 3, var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 10, var extract) result').Expect(ANSI.ExtractLeft(s, 10, e)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 10, var extract) s').Expect(s).Equals('');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', 10, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractLeft(s, -1, e);
      Test('ANSI.ExtractLeft(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractLeft(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

  // Extract up to specified char delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) result').Expect(ANSI.ExtractLeft(s, 'd', e)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) s').Expect(s).Equals('defghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) result').Expect(ANSI.ExtractLeft(s, 'a', e)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) result').Expect(ANSI.ExtractLeft(s, 'D', e)).IsFALSE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) result').Expect(ANSI.ExtractLeft(s, 'x', e)).IsFALSE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) extract').Expect(e).Equals('');

  // Extract up to specified string delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) result').Expect(ANSI.ExtractLeft(s, 'def', e)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) s').Expect(s).Equals('defghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) result').Expect(ANSI.ExtractLeft(s, 'DEF', e)).IsFALSE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) result').Expect(ANSI.ExtractLeft(s, 'xyz', e)).IsFALSE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) extract').Expect(e).Equals('');

  // Extract up to a char delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'd', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('efghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'a', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('bcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract up to a string delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'def', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('ghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('abc');

  // Extract up to and including a char delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'd', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('efghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abcd');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'a', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('bcdefghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('a');

  // Extract up to a string delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'def', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('ghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abcdef');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractLeft(s, 'abc', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('defghi');
    Test('ANSI.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abc');

  // Contracts

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractLeft(s, #0, e);
      Test('ANSI.ExtractLeft(''abcdefghi'', #0, var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractLeft(''abcdefghi'', #0, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractLeft(s, '', e);
      Test('ANSI.ExtractLeft(''abcdefghi'', '''', var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractLeft(''abcdefghi'', '''', var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_ExtractRight;
  const
    SRC: ANSIString = 'abcdefghi';
  var
    s, e: ANSIString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(''abcdefghi'', 0, var e) result').Expect(ANSI.ExtractRight(s, 0, e)).IsFALSE;
    Test('ANSI.ExtractRight(''abcdefghi'', 0, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(''abcdefghi'', 3, var e) result').Expect(ANSI.ExtractRight(s, 3, e)).IsTRUE;
    Test('ANSI.ExtractRight(''abcdefghi'', 3, var extract) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(''abcdefghi'', 10, var e) result').Expect(ANSI.ExtractRight(s, 10, e)).IsTRUE;
    Test('ANSI.ExtractRight(''abcdefghi'', 10, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractRight(s, -1, e);
      Test('ANSI.ExtractRight(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractRight(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchange)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

  // Extract from specified char delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) result').Expect(ANSI.ExtractRight(s, 'd', e)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) s').Expect(s).Equals('abcd');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) extract').Expect(e).Equals('efghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) result').Expect(ANSI.ExtractRight(s, 'i', e)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) result').Expect(ANSI.ExtractRight(s, 'D', e)).IsFALSE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) result').Expect(ANSI.ExtractRight(s, 'x', e)).IsFALSE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) extract').Expect(e).Equals('');

  // Extract from specified string delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) result').Expect(ANSI.ExtractRight(s, 'def', e)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) s').Expect(s).Equals('abcdef');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) result').Expect(ANSI.ExtractRight(s, 'DEF', e)).IsFALSE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) result').Expect(ANSI.ExtractRight(s, 'xyz', e)).IsFALSE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) extract').Expect(e).Equals('');

  // Extract from a char delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'd', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('efghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'i', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abcdefgh');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract from a string delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'def', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'ghi', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abcdef');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract from and including a char delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'd', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'i', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abcdefgh');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('i');

  // Extract from a string delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'def', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) result').Expect(ANSI.ExtractRight(s, 'ghi', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abcdef');
    Test('ANSI.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('ghi');

  // Contracts

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractRight(s, #0, e);
      Test('ANSI.ExtractRight(''abcdefghi'', #0, var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractRight(''abcdefghi'', #0, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractRight(s, '', e);
      Test('ANSI.ExtractRight(''abcdefghi'', '''', var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractRight(''abcdefghi'', '''', var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_ExtractRightFrom;
  const
    SRC: ANSIString = 'abcdefghi';
  var
    s, e: ANSIString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) result').Expect(ANSI.ExtractRightFrom(s, 0, e)).IsTRUE;
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) s').Expect(s).Equals('');
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) result').Expect(ANSI.ExtractRightFrom(s, 3, e)).IsTRUE;
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) s').Expect(s).Equals('abc');
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) result').Expect(ANSI.ExtractRightFrom(s, 10, e)).IsFALSE;
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) s').Expect(s).Equals('abcdefghi');
    Test('ANSI.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    try
      ANSI.ExtractRightFrom(s, -1, e);
      Test('ANSI.ExtractRightFrom(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('ANSI.ExtractRightFrom(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;













  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Copy;
  const
    STR = 'abcdef';
  begin
    Test('ANSI.Copy(''abcdef'', 1, 3)').Expect(ANSI.Copy(STR, 1, 3)).Equals('abc');
    Test('ANSI.Copy(''abcdef'', 2, 3)').Expect(ANSI.Copy(STR, 2, 3)).Equals('bcd');
    Test('ANSI.Copy(''abcdef'', 2, 7)').Expect(ANSI.Copy(STR, 2, 7)).Equals('bcdef');

    try
      ANSI.Copy(STR, 0, 3);
      Test('ANSI.Copy(''abcdef'', 0, 3)').Expecting(EContractViolation);
    except
      Test('ANSI.Copy(''abcdef'', 0, 3)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyFrom;
  const
    STR = 'abcdef';
  begin
    Test('ANSI.CopyFrom(''abcdef'', 1)').Expect(ANSI.CopyFrom(STR, 1)).Equals('abcdef');
    Test('ANSI.CopyFrom(''abcdef'', 2)').Expect(ANSI.CopyFrom(STR, 2)).Equals('bcdef');
    Test('ANSI.CopyFrom(''abcdef'', 7)').Expect(ANSI.CopyFrom(STR, 7)).Equals('');

    try
      ANSI.CopyFrom(STR, 0);
      Test('ANSI.CopyFrom(''abcdef'', 0)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyFrom(''abcdef'', 0)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyRange;
  const
    STR = 'abcdef';
  begin
    Test('ANSI.CopyRange(''abcdef'', 1, 3)').Expect(ANSI.CopyRange(STR, 1, 3)).Equals('abc');
    Test('ANSI.CopyRange(''abcdef'', 2, 3)').Expect(ANSI.CopyRange(STR, 2, 3)).Equals('bc');
    Test('ANSI.CopyRange(''abcdef'', 1, 7)').Expect(ANSI.CopyRange(STR, 1, 7)).Equals('abcdef');

    try
      ANSI.CopyRange(STR, 0, 3);
      Test('ANSI.CopyRange(''abcdef'', 0, 3)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyRange(''abcdef'', 0, 3)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyLeft;
  const
    STR = 'abcdef';
  begin
    Test('ANSI.CopyLeft(''abcdef'', 0)').Expect(ANSI.CopyLeft(STR, 0)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', 1)').Expect(ANSI.CopyLeft(STR, 1)).Equals('a');
    Test('ANSI.CopyLeft(''abcdef'', 3)').Expect(ANSI.CopyLeft(STR, 3)).Equals('abc');
    Test('ANSI.CopyLeft(''abcdef'', 10)').Expect(ANSI.CopyLeft(STR, 10)).Equals('abcdef');

    try
      ANSI.CopyLeft(STR, -1);
      Test('ANSI.CopyLeft(''abcdef'', -1)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyLeft(''abcdef'', -1)').Expecting(EContractViolation);
    end;

  // CopyLeft with Exclude Optional delimiter (default)

    Test('ANSI.CopyLeft(''abcdef'', ''a'')').Expect(ANSI.CopyLeft(STR, 'a')).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''d'')').Expect(ANSI.CopyLeft(STR, 'd')).Equals('abc');
    Test('ANSI.CopyLeft(''abcdef'', ''D'')').Expect(ANSI.CopyLeft(STR, 'D')).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', '','')').Expect(ANSI.CopyLeft(STR, ',')).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', ''ab'')').Expect(ANSI.CopyLeft(STR, 'ab')).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''def'')').Expect(ANSI.CopyLeft(STR, 'def')).Equals('abc');
    Test('ANSI.CopyLeft(''abcdef'', ''DEF'')').Expect(ANSI.CopyLeft(STR, 'DEF')).Equals('abcdef');

  // CopyLeft with Include Optional delimiter

    Test('ANSI.CopyLeft(''abcdef'', ''a'')').Expect(ANSI.CopyLeft(STR, 'a', doIncludeOptionalDelimiter)).Equals('a');
    Test('ANSI.CopyLeft(''abcdef'', ''d'')').Expect(ANSI.CopyLeft(STR, 'd', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeft(''abcdef'', ''D'')').Expect(ANSI.CopyLeft(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', '','')').Expect(ANSI.CopyLeft(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', ''ab'')').Expect(ANSI.CopyLeft(STR, 'ab', doIncludeOptionalDelimiter)).Equals('ab');
    Test('ANSI.CopyLeft(''abcdef'', ''def'')').Expect(ANSI.CopyLeft(STR, 'def', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', ''DEF'')').Expect(ANSI.CopyLeft(STR, 'DEF', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyLeft with Exclude Required delimiter

    Test('ANSI.CopyLeft(''abcdef'', ''a'')').Expect(ANSI.CopyLeft(STR, 'a', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''d'')').Expect(ANSI.CopyLeft(STR, 'd', doExcludeRequiredDelimiter)).Equals('abc');
    Test('ANSI.CopyLeft(''abcdef'', ''D'')').Expect(ANSI.CopyLeft(STR, 'D', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', '','')').Expect(ANSI.CopyLeft(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''ab'')').Expect(ANSI.CopyLeft(STR, 'ab', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''def'')').Expect(ANSI.CopyLeft(STR, 'def', doExcludeRequiredDelimiter)).Equals('abc');
    Test('ANSI.CopyLeft(''abcdef'', ''DEF'')').Expect(ANSI.CopyLeft(STR, 'DEF', doExcludeRequiredDelimiter)).Equals('');

  // CopyLeft with Include Required delimiter

    Test('ANSI.CopyLeft(''abcdef'', ''a'')').Expect(ANSI.CopyLeft(STR, 'a', doIncludeRequiredDelimiter)).Equals('a');
    Test('ANSI.CopyLeft(''abcdef'', ''d'')').Expect(ANSI.CopyLeft(STR, 'd', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeft(''abcdef'', ''D'')').Expect(ANSI.CopyLeft(STR, 'D', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', '','')').Expect(ANSI.CopyLeft(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeft(''abcdef'', ''ab'')').Expect(ANSI.CopyLeft(STR, 'ab', doIncludeRequiredDelimiter)).Equals('ab');
    Test('ANSI.CopyLeft(''abcdef'', ''def'')').Expect(ANSI.CopyLeft(STR, 'def', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeft(''abcdef'', ''DEF'')').Expect(ANSI.CopyLeft(STR, 'DEF', doIncludeRequiredDelimiter)).Equals('');

  // Case insensitive calls

  // CopyLeftText with Exclude Optional delimiter (default)

    Test('ANSI.CopyLeftText(''abcdef'', ''a'')').Expect(ANSI.CopyLeftText(STR, 'a')).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''d'')').Expect(ANSI.CopyLeftText(STR, 'd')).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', ''D'')').Expect(ANSI.CopyLeftText(STR, 'D')).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', '','')').Expect(ANSI.CopyLeftText(STR, ',')).Equals('abcdef');
    Test('ANSI.CopyLeftText(''abcdef'', ''ab'')').Expect(ANSI.CopyLeftText(STR, 'ab')).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''def'')').Expect(ANSI.CopyLeftText(STR, 'def')).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', ''DEF'')').Expect(ANSI.CopyLeftText(STR, 'DEF')).Equals('abc');

  // CopyLeftText with Include Optional delimiter

    Test('ANSI.CopyLeftText(''abcdef'', ''a'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'a', doIncludeOptionalDelimiter)).Equals('a');
    Test('ANSI.CopyLeftText(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'd', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeftText(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeftText(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeftText(''abcdef'', ''ab'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'ab', doIncludeOptionalDelimiter)).Equals('ab');
    Test('ANSI.CopyLeftText(''abcdef'', ''def'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'def', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeftText(''abcdef'', ''DEF'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyLeftText(STR, 'DEF', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyLeftText with Exclude Required delimiter

    Test('ANSI.CopyLeftText(''abcdef'', ''a'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'a', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'd', doExcludeRequiredDelimiter)).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'D', doExcludeRequiredDelimiter)).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''ab'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'ab', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''def'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'def', doExcludeRequiredDelimiter)).Equals('abc');
    Test('ANSI.CopyLeftText(''abcdef'', ''DEF'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'DEF', doExcludeRequiredDelimiter)).Equals('abc');

  // CopyLeftText with Include Required delimiter

    Test('ANSI.CopyLeftText(''abcdef'', ''a'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'a', doIncludeRequiredDelimiter)).Equals('a');
    Test('ANSI.CopyLeftText(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'd', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeftText(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'D', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('ANSI.CopyLeftText(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyLeftText(''abcdef'', ''ab'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'ab', doIncludeRequiredDelimiter)).Equals('ab');
    Test('ANSI.CopyLeftText(''abcdef'', ''def'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'def', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('ANSI.CopyLeftText(''abcdef'', ''DEF'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyLeftText(STR, 'DEF', doIncludeRequiredDelimiter)).Equals('abcdef');

    try
      ANSI.CopyLeft(STR, #0);
      Test('ANSI.CopyLeft(''abcdef'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyLeft(''abcdef'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.CopyLeft(STR, '');
      Test('ANSI.CopyLeft(''abcdef'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.CopyLeft(''abcdef'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_CopyRight;
  const
    STR = 'abcdef';
  begin
    Test('ANSI.CopyRight(''abcdef'', 0)').Expect(ANSI.CopyRight(STR, 0)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', 1)').Expect(ANSI.CopyRight(STR, 1)).Equals('f');
    Test('ANSI.CopyRight(''abcdef'', 3)').Expect(ANSI.CopyRight(STR, 3)).Equals('def');
    Test('ANSI.CopyRight(''abcdef'', 10)').Expect(ANSI.CopyRight(STR, 10)).Equals('abcdef');

    try
      ANSI.CopyRight(STR, -1);
      Test('ANSI.CopyRight(''abcdef'', -1)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyRight(''abcdef'', -1)').Expecting(EContractViolation);
    end;

  // CopyRight with Exclude Optional delimiter (default)

    Test('ANSI.CopyRight(''abcdef'', ''f'')').Expect(ANSI.CopyRight(STR, 'f')).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''d'')').Expect(ANSI.CopyRight(STR, 'd')).Equals('ef');
    Test('ANSI.CopyRight(''abcdef'', ''D'')').Expect(ANSI.CopyRight(STR, 'D')).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', '','')').Expect(ANSI.CopyRight(STR, ',')).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', ''ef'')').Expect(ANSI.CopyRight(STR, 'ef')).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''abc'')').Expect(ANSI.CopyRight(STR, 'abc')).Equals('def');
    Test('ANSI.CopyRight(''abcdef'', ''ABC'')').Expect(ANSI.CopyRight(STR, 'ABC')).Equals('abcdef');

  // CopyRight with Include Optional delimiter

    Test('ANSI.CopyRight(''abcdef'', ''f'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'f', doIncludeOptionalDelimiter)).Equals('f');
    Test('ANSI.CopyRight(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'd', doIncludeOptionalDelimiter)).Equals('def');
    Test('ANSI.CopyRight(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', ''ef'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'ef', doIncludeOptionalDelimiter)).Equals('ef');
    Test('ANSI.CopyRight(''abcdef'', ''abc'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'abc', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', ''ABC'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRight(STR, 'ABC', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyRight with Exclude Required delimiter

    Test('ANSI.CopyRight(''abcdef'', ''f'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'f', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'd', doExcludeRequiredDelimiter)).Equals('ef');
    Test('ANSI.CopyRight(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'D', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''ef'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'ef', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''abc'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'abc', doExcludeRequiredDelimiter)).Equals('def');
    Test('ANSI.CopyRight(''abcdef'', ''ABC'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'ABC', doExcludeRequiredDelimiter)).Equals('');

  // CopyRight with Include Required delimiter

    Test('ANSI.CopyRight(''abcdef'', ''f'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'f', doIncludeRequiredDelimiter)).Equals('f');
    Test('ANSI.CopyRight(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'd', doIncludeRequiredDelimiter)).Equals('def');
    Test('ANSI.CopyRight(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'D', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRight(''abcdef'', ''ef'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'ef', doIncludeRequiredDelimiter)).Equals('ef');
    Test('ANSI.CopyRight(''abcdef'', ''abc'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'abc', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRight(''abcdef'', ''ABC'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRight(STR, 'ABC', doIncludeRequiredDelimiter)).Equals('');

  // Case Insensitive calls

  // CopyRight with Exclude Optional delimiter (default)

    Test('ANSI.CopyRightText(''abcdef'', ''f'')').Expect(ANSI.CopyRightText(STR, 'f')).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''d'')').Expect(ANSI.CopyRightText(STR, 'd')).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', ''D'')').Expect(ANSI.CopyRightText(STR, 'D')).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', '','')').Expect(ANSI.CopyRightText(STR, ',')).Equals('abcdef');
    Test('ANSI.CopyRightText(''abcdef'', ''ef'')').Expect(ANSI.CopyRightText(STR, 'ef')).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''abc'')').Expect(ANSI.CopyRightText(STR, 'abc')).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', ''ABC'')').Expect(ANSI.CopyRightText(STR, 'ABC')).Equals('def');

  // CopyRightText with Include Optional delimiter

    Test('ANSI.CopyRightText(''abcdef'', ''f'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'f', doIncludeOptionalDelimiter)).Equals('f');
    Test('ANSI.CopyRightText(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'd', doIncludeOptionalDelimiter)).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'D', doIncludeOptionalDelimiter)).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRightText(''abcdef'', ''ef'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'ef', doIncludeOptionalDelimiter)).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', ''abc'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'abc', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRightText(''abcdef'', ''ABC'', doIncludeOptionalDelimiter)').Expect(ANSI.CopyRightText(STR, 'ABC', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyRightText with Exclude Required delimiter

    Test('ANSI.CopyRightText(''abcdef'', ''f'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'f', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'd', doExcludeRequiredDelimiter)).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'D', doExcludeRequiredDelimiter)).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''ef'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'ef', doExcludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''abc'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'abc', doExcludeRequiredDelimiter)).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', ''ABC'', doExcludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'ABC', doExcludeRequiredDelimiter)).Equals('def');

  // CopyRightText with Include Required delimiter

    Test('ANSI.CopyRightText(''abcdef'', ''f'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'f', doIncludeRequiredDelimiter)).Equals('f');
    Test('ANSI.CopyRightText(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'd', doIncludeRequiredDelimiter)).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'D', doIncludeRequiredDelimiter)).Equals('def');
    Test('ANSI.CopyRightText(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('ANSI.CopyRightText(''abcdef'', ''ef'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'ef', doIncludeRequiredDelimiter)).Equals('ef');
    Test('ANSI.CopyRightText(''abcdef'', ''abc'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'abc', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('ANSI.CopyRightText(''abcdef'', ''ABC'', doIncludeRequiredDelimiter)').Expect(ANSI.CopyRightText(STR, 'ABC', doIncludeRequiredDelimiter)).Equals('abcdef');

    try
      ANSI.CopyRight(STR, #0);
      Test('ANSI.CopyRight(''abcdef'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.CopyRight(''abcdef'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.CopyRight(STR, '');
      Test('ANSI.CopyRight(''abcdef'', '''')').Expecting(EContractViolation);
    except
      Test('ANSI.CopyRight(''abcdef'', '''')').Expecting(EContractViolation);
    end;
  end;

















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Replace;
  const
    STR = 'abcdef';
  var
    s: ANSIString;
  begin
    Test('ANSI.Replace(''abcdef'', ''a'', ''X'')').Expect(ANSI.Replace(STR, 'a', 'X')).Equals('Xbcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', ''X'')').Expect(ANSI.Replace(STR, 'A', 'X')).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''a'', ''X'', var s) result').Expect(ANSI.Replace(STR, 'a', 'X', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''a'', ''X'', var s) var s').Expect(s).Equals('Xbcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', ''X'', var s) result').Expect(ANSI.Replace(STR, 'A', 'X', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcdef');

    Test('ANSI.Replace(''abcdef'', ''a'', ''XYZ'')').Expect(ANSI.Replace(STR, 'a', 'XYZ')).Equals('XYZbcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', ''XYZ'')').Expect(ANSI.Replace(STR, 'A', 'XYZ')).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''a'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'a', 'XYZ', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''a'', ''XYZ'', var s) var s').Expect(s).Equals('XYZbcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'A', 'XYZ', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('ANSI.Replace(s, ''def'', ''abc'', var s) [where s = ''abcdef'']').Expect(ANSI.Replace(s, 'def', 'abc', s)).IsTRUE;
    Test('ANSI.Replace(s, ''def'', ''abc'', var s) [where s = ''abcdef'']').Expect(s).Equals('abcabc');

    s := 'x';
    Test('ANSI.Replace(''abcdef'', ''a'', s) [where s = ''x'']').Expect(ANSI.Replace(STR, 'a', s)).Equals('xbcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', s) [where s = ''x'']').Expect(ANSI.Replace(STR, 'abc', s)).Equals('xdef');

    Test('ANSI.Replace(''abcdef'', ''a'', '''')').Expect(ANSI.Replace(STR, 'a', '')).Equals('bcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', '''')').Expect(ANSI.Replace(STR, 'A', '')).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''a'', '''', var s) result').Expect(ANSI.Replace(STR, 'a', '', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''a'', '''', var s) var s').Expect(s).Equals('bcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', '''', var s) result').Expect(ANSI.Replace(STR, 'A', '', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''A'', '''', var s) var s').Expect(s).Equals('abcdef');

    Test('ANSI.Replace(''abcdef'', ''abc'', ''X'')').Expect(ANSI.Replace(STR, 'abc', 'X')).Equals('Xdef');
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''X'')').Expect(ANSI.Replace(STR, 'ABC', 'X')).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', ''X'', var s) result').Expect(ANSI.Replace(STR, 'abc', 'X', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''abc'', ''X'', var s) var s').Expect(s).Equals('Xdef');
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''X'', var s) result').Expect(ANSI.Replace(STR, 'ABC', 'X', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcdef');

    Test('ANSI.Replace(''abcdef'', ''abc'', '''')').Expect(ANSI.Replace(STR, 'abc', '')).Equals('def');
    Test('ANSI.Replace(''abcdef'', ''ab'', ''XYZ'')').Expect(ANSI.Replace(STR, 'ab', 'XYZ')).Equals('XYZcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', ''XYZ'')').Expect(ANSI.Replace(STR, 'abc', 'XYZ')).Equals('XYZdef');
    Test('ANSI.Replace(''abcdef'', ''abcd'', ''XYZ'')').Expect(ANSI.Replace(STR, 'abcd', 'XYZ')).Equals('XYZef');
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''XYZ'')').Expect(ANSI.Replace(STR, 'ABC', 'XYZ')).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', '''', var s) result').Expect(ANSI.Replace(STR, 'abc', '', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''abc'', '''', var s) var s').Expect(s).Equals('def');
    Test('ANSI.Replace(''abcdef'', ''ab'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'ab', 'XYZ', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''ab'', ''XYZ'', var s) var s').Expect(s).Equals('XYZcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'abc', 'XYZ', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''abc'', ''XYZ'', var s) var s').Expect(s).Equals('XYZdef');
    Test('ANSI.Replace(''abcdef'', ''abcd'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'abcd', 'XYZ', s)).IsTRUE;
    Test('ANSI.Replace(''abcdef'', ''abcd'', ''XYZ'', var s) var s').Expect(s).Equals('XYZef');
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''XYZ'', var s) result').Expect(ANSI.Replace(STR, 'ABC', 'XYZ', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''XYZ'', var s) var s').Expect(s).Equals('abcdef');

    Test('ANSI.Replace(''abcdef'', ''a'', ''a'', var s) result').Expect(ANSI.Replace(STR, 'a', 'a', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''a'', ''a'', var s) var s').Expect(s).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''A'', ''a'', var s) result').Expect(ANSI.Replace(STR, 'A', 'a', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''A'', ''a'', var s) var s').Expect(s).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''abc'', ''abc'', var s) result').Expect(ANSI.Replace(STR, 'abc', 'abc', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''abc'', ''abc'', var s) var s').Expect(s).Equals('abcdef');
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''abc'', var s) result').Expect(ANSI.Replace(STR, 'ABC', 'abc', s)).IsFALSE;
    Test('ANSI.Replace(''abcdef'', ''ABC'', ''abc'', var s) var s').Expect(s).Equals('abcdef');

    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''X'')').Expect(ANSI.ReplaceText(STR, 'A', 'X')).Equals('Xbcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''XYZ'')').Expect(ANSI.ReplaceText(STR, 'A', 'XYZ')).Equals('XYZbcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''A'', '''')').Expect(ANSI.ReplaceText(STR, 'A', '')).Equals('bcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''ABC'', ''X'')').Expect(ANSI.ReplaceText(STR, 'ABC', 'X')).Equals('Xdef');
    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''X'', var s) result').Expect(ANSI.ReplaceText(STR, 'A', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''X'', var s) var s').Expect(s).Equals('Xbcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''XYZ'', var s) result').Expect(ANSI.ReplaceText(STR, 'A', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceText(''abcdef'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('XYZbcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''A'', '''', var s) result').Expect(ANSI.ReplaceText(STR, 'A', '', s)).IsTRUE;
    Test('ANSI.ReplaceText(''abcdef'', ''A'', '''', var s) var s').Expect(s).Equals('bcdef');
    Test('ANSI.ReplaceText(''abcdef'', ''ABC'', ''X'', var s) result').Expect(ANSI.ReplaceText(STR, 'ABC', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceText(''abcdef'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('Xdef');

    try
      ANSI.Replace(STR, #0, 'a');
      Test('ANSI.Replace(''abcdef'', #0, ''a'')').Expecting(EContractViolation);
    except
      Test('ANSI.Replace(''abcdef'', #0, ''a'')').Expecting(EContractViolation);
    end;

    try
      ANSI.Replace(STR, '', 'a');
      Test('ANSI.Replace(''abcdef'', '''', ''a'')').Expecting(EContractViolation);
    except
      Test('ANSI.Replace(''abcdef'', '''', ''a'')').Expecting(EContractViolation);
    end;

    try
      ANSI.Replace(STR, 'a', #0);
      Test('ANSI.Replace(''abcdef'', ''a'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.Replace(''abcdef'', ''a'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.Replace(STR, 'abc', #0);
      Test('ANSI.Replace(''abcdef'', ''abc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.Replace(''abcdef'', ''abc'', #0)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_ReplaceAll;
  const
    STR = 'abracadabra';
  var
    s: ANSIString;
  begin
    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''o'')').Expect(ANSI.ReplaceAll(STR, 'a', 'o')).Equals('obrocodobro');
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''o'')').Expect(ANSI.ReplaceAll(STR, 'A', 'o')).Equals('abracadabra');
    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''o'', var s) result').Expect(ANSI.ReplaceAll(STR, 'a', 'o', s)).IsTRUE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''o'', var s) var s').Expect(s).Equals('obrocodobro');
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''o'', var s) result').Expect(ANSI.ReplaceAll(STR, 'A', 'o', s)).IsFALSE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''o'', var s) var s').Expect(s).Equals('abracadabra');

    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''oo'')').Expect(ANSI.ReplaceAll(STR, 'a', 'oo')).Equals('oobroocoodoobroo');
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''oo'')').Expect(ANSI.ReplaceAll(STR, 'A', 'oo')).Equals('abracadabra');
    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''oo'', var s) result').Expect(ANSI.ReplaceAll(STR, 'a', 'oo', s)).IsTRUE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''a'', ''oo'', var s) var s').Expect(s).Equals('oobroocoodoobroo');
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''oo'', var s) result').Expect(ANSI.ReplaceAll(STR, 'A', 'oo', s)).IsFALSE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''A'', ''oo'', var s) var s').Expect(s).Equals('abracadabra');

    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''y'')').Expect(ANSI.ReplaceAll(STR, 'bra', 'y')).Equals('aycaday');
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''y'')').Expect(ANSI.ReplaceAll(STR, 'BRA', 'y')).Equals('abracadabra');
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''y'', var s) result').Expect(ANSI.ReplaceAll(STR, 'bra', 'y', s)).IsTRUE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''y'', var s) var s').Expect(s).Equals('aycaday');
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''y'', var s) result').Expect(ANSI.ReplaceAll(STR, 'BRA', 'y', s)).IsFALSE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''y'', var s) var s').Expect(s).Equals('abracadabra');

    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''ky'')').Expect(ANSI.ReplaceAll(STR, 'bra', 'ky')).Equals('akycadaky');
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''cky'')').Expect(ANSI.ReplaceAll(STR, 'bra', 'cky')).Equals('ackycadacky');
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''ckys'')').Expect(ANSI.ReplaceAll(STR, 'bra', 'ckys')).Equals('ackyscadackys');
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''cky'')').Expect(ANSI.ReplaceAll(STR, 'BRA', 'cky')).Equals('abracadabra');
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''cky'', var s) result').Expect(ANSI.ReplaceAll(STR, 'bra', 'cky', s)).IsTRUE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''bra'', ''cky'', var s) var s').Expect(s).Equals('ackycadacky');
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''cky'', var s) result').Expect(ANSI.ReplaceAll(STR, 'BRA', 'kyy', s)).IsFALSE;
    Test('ANSI.ReplaceAll(''abracadabra'', ''BRA'', ''cky'', var s) var s').Expect(s).Equals('abracadabra');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_ReplaceLast;
  const
    STR = 'abcabc';
  var
    s: ANSIString;
  begin
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''X'')').Expect(ANSI.ReplaceLast(STR, 'a', 'X')).Equals('abcXbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''X'')').Expect(ANSI.ReplaceLast(STR, 'A', 'X')).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''X'', var s) result').Expect(ANSI.ReplaceLast(STR, 'a', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''X'', var s) var s').Expect(s).Equals('abcXbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''X'', var s) result').Expect(ANSI.ReplaceLast(STR, 'A', 'X', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcabc');

    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''XYZ'')').Expect(ANSI.ReplaceLast(STR, 'a', 'XYZ')).Equals('abcXYZbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''XYZ'')').Expect(ANSI.ReplaceLast(STR, 'A', 'XYZ')).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast(STR, 'a', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast(STR, 'A', 'XYZ', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcabc');

    s := 'x';
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', s) [where s = ''x'']').Expect(ANSI.ReplaceLast(STR, 'a', s)).Equals('abcxbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', s) [where s = ''x'']').Expect(ANSI.ReplaceLast(STR, 'abc', s)).Equals('abcx');

    Test('ANSI.ReplaceLast(''abcabc'', ''a'', '''')').Expect(ANSI.ReplaceLast(STR, 'a', '')).Equals('abcbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', '''')').Expect(ANSI.ReplaceLast(STR, 'A', '')).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', '''', var s) result').Expect(ANSI.ReplaceLast(STR, 'a', '', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', '''', var s) var s').Expect(s).Equals('abcbc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', '''', var s) result').Expect(ANSI.ReplaceLast(STR, 'A', '', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', '''', var s) var s').Expect(s).Equals('abcabc');

    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''X'')').Expect(ANSI.ReplaceLast(STR, 'abc', 'X')).Equals('abcX');
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''X'')').Expect(ANSI.ReplaceLast(STR, 'ABC', 'X')).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''X'', var s) result').Expect(ANSI.ReplaceLast(STR, 'abc', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''X'', var s) var s').Expect(s).Equals('abcX');
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''X'', var s) result').Expect(ANSI.ReplaceLast(STR, 'ABC', 'X', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcabc');

    Test('ANSI.ReplaceLast(''abcdabc'', ''abc'', '''')').Expect(ANSI.ReplaceLast('abcdabc', 'abc', '')).Equals('abcd');
    Test('ANSI.ReplaceLast(''abcabc'', ''ab'', ''XYZ'')').Expect(ANSI.ReplaceLast(STR, 'ab', 'XYZ')).Equals('abcXYZc');
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''XYZ'')').Expect(ANSI.ReplaceLast(STR, 'abc', 'XYZ')).Equals('abcXYZ');
    Test('ANSI.ReplaceLast(''abcabca'', ''abca'', ''XYZ'')').Expect(ANSI.ReplaceLast('abcabca', 'abca', 'XYZ')).Equals('abcXYZ');
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'')').Expect(ANSI.ReplaceLast(STR, 'ABC', 'XYZ')).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcdabc'', ''abc'', '''', var s) result').Expect(ANSI.ReplaceLast('abcdabc', 'abc', '', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', '''', var s) var s').Expect(s).Equals('abcd');
    Test('ANSI.ReplaceLast(''abcabc'', ''ab'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast(STR, 'ab', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''ab'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZc');
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast(STR, 'abc', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZ');
    Test('ANSI.ReplaceLast(''abcabca'', ''abcd'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast('abcabca', 'abca', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceLast(''abcabc'', ''abcd'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZ');
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLast(STR, 'ABC', 'XYZ', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'', var s) var s').Expect(s).Equals('abcabc');

    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''a'', var s) result').Expect(ANSI.ReplaceLast(STR, 'a', 'a', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''a'', ''a'', var s) var s').Expect(s).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''a'', var s) result').Expect(ANSI.ReplaceLast(STR, 'A', 'a', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''A'', ''a'', var s) var s').Expect(s).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''abc'', var s) result').Expect(ANSI.ReplaceLast(STR, 'abc', 'abc', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''abc'', ''abc'', var s) var s').Expect(s).Equals('abcabc');
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''abc'', var s) result').Expect(ANSI.ReplaceLast(STR, 'ABC', 'abc', s)).IsFALSE;
    Test('ANSI.ReplaceLast(''abcabc'', ''ABC'', ''abc'', var s) var s').Expect(s).Equals('abcabc');

    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''X'')').Expect(ANSI.ReplaceLastText(STR, 'A', 'X')).Equals('abcXbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''XYZ'')').Expect(ANSI.ReplaceLastText(STR, 'A', 'XYZ')).Equals('abcXYZbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', '''')').Expect(ANSI.ReplaceLastText(STR, 'A', '')).Equals('abcbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''ABC'', ''X'')').Expect(ANSI.ReplaceLastText(STR, 'ABC', 'X')).Equals('abcX');
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''X'', var s) result').Expect(ANSI.ReplaceLastText(STR, 'A', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcXbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''XYZ'', var s) result').Expect(ANSI.ReplaceLastText(STR, 'A', 'XYZ', s)).IsTRUE;
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', '''', var s) result').Expect(ANSI.ReplaceLastText(STR, 'A', '', s)).IsTRUE;
    Test('ANSI.ReplaceLastText(''abcabc'', ''A'', '''', var s) var s').Expect(s).Equals('abcbc');
    Test('ANSI.ReplaceLastText(''abcabc'', ''ABC'', ''X'', var s) result').Expect(ANSI.ReplaceLastText(STR, 'ABC', 'X', s)).IsTRUE;
    Test('ANSI.ReplaceLastText(''abcabc'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcX');

    try
      ANSI.ReplaceLast(STR, #0, 'a');
      Test('ANSI.ReplaceLast(''abcabc'', #0, ''a'')').Expecting(EContractViolation);
    except
      Test('ANSI.ReplaceLast(''abcabc'', #0, ''a'')').Expecting(EContractViolation);
    end;

    try
      ANSI.ReplaceLast(STR, '', 'a');
      Test('ANSI.ReplaceLast(''abcabc'', '''', ''a'')').Expecting(EContractViolation);
    except
      Test('ANSI.ReplaceLast(''abcabc'', '''', ''a'')').Expecting(EContractViolation);
    end;

    try
      ANSI.ReplaceLast(STR, 'a', #0);
      Test('ANSI.ReplaceLast(''abcabc'', ''a'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.ReplaceLast(''abcabc'', ''a'', #0)').Expecting(EContractViolation);
    end;

    try
      ANSI.ReplaceLast(STR, 'abc', #0);
      Test('ANSI.ReplaceLast(''abcabc'', ''abc'', #0)').Expecting(EContractViolation);
    except
      Test('ANSI.ReplaceLast(''abcabc'', ''abc'', #0)').Expecting(EContractViolation);
    end;
  end;






















    { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Trim;
  begin
    Test('ANSI.Trim(''   foo   '')').Expect(ANSI.Trim('   foo   ')).Equals('foo');
    Test('ANSI.Trim(''   foo   '', ''.'')').Expect(ANSI.Trim('   foo   ', '.')).Equals('   foo   ');
    Test('ANSI.Trim(''   foo   '', 1)').Expect(ANSI.Trim('   foo   ', 1)).Equals('  foo  ');
    Test('ANSI.Trim(''   foo   '', 4)').Expect(ANSI.Trim('   foo   ', 4)).Equals('o');
    Test('ANSI.Trim(''   foo   '', 5)').Expect(ANSI.Trim('   foo   ', 5)).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_TrimLeft;
  begin
    Test('ANSI.TrimLeft(''   foo'')').Expect(ANSI.TrimLeft('   foo')).Equals('foo');
    Test('ANSI.TrimLeft(''#9#9 foo'')').Expect(ANSI.TrimLeft(#9#9' foo')).Equals('foo');
    Test('ANSI.TrimLeft(''   foo'', '' '')').Expect(ANSI.TrimLeft('   foo', ' ')).Equals('foo');
    Test('ANSI.TrimLeft(''#9#9 foo'', '' '')').Expect(ANSI.TrimLeft(#9#9' foo', ' ')).Equals(#9#9' foo');
    Test('ANSI.TrimLeft(''   foo'', ''f'')').Expect(ANSI.TrimLeft('   foo', 'f')).Equals('   foo');

    Test('ANSI.TrimLeft(''   foo'', 1)').Expect(ANSI.TrimLeft('   foo', 1)).Equals('  foo');
    Test('ANSI.TrimLeft(''   foo'', 4)').Expect(ANSI.TrimLeft('   foo', 4)).Equals('oo');
    Test('ANSI.TrimLeft(''   foo'', 8)').Expect(ANSI.TrimLeft('   foo', 8)).Equals('');

    try
      ANSI.TrimLeft('   foo', -3);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_TrimRight;
  const
    OT = WideChar(Word($047E));
  begin
    Test('ANSI.TrimRight(''foo   '')').Expect(ANSI.TrimRight('foo   ')).Equals('foo');
    Test('ANSI.TrimRight(''foo #9#9'')').Expect(ANSI.TrimRight('foo '#9#9)).Equals('foo');
    Test('ANSI.TrimRight(''foo   '', '' '')').Expect(ANSI.TrimRight('foo   ', ' ')).Equals('foo');
    Test('ANSI.TrimRight(''foo #9#9'', '' '')').Expect(ANSI.TrimRight('foo '#9#9, '.')).Equals('foo '#9#9);
    Test('ANSI.TrimRight(''foo   '', ''o'')').Expect(ANSI.TrimRight('foo   ', 'o')).Equals('foo   ');

    Test('ANSI.TrimRight(''foo   '', 1)').Expect(ANSI.TrimRight('foo   ', 1)).Equals('foo  ');
    Test('ANSI.TrimRight(''foo   '', 4)').Expect(ANSI.TrimRight('foo   ', 4)).Equals('fo');
    Test('ANSI.TrimRight(''foo   '', 8)').Expect(ANSI.TrimRight('foo   ', 8)).Equals('');

    try
      ANSI.TrimRight('foo   ', -3);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Deltics.Strings.AllowUnicodeDataLoss := FALSE;
    try
      ANSI.TrimRight(ANSI.FromWIDE('foo' + OT), OT);
      Test('ANSI.TrimRight(''foo' + OT + ''', ''' + OT + ''')').Expecting(EUnicodeDataLoss);
    except
      Test('ANSI.TrimRight(''foo' + OT + ''', ''' + OT + ''')').Expecting(EUnicodeDataLoss);
    end;

    Deltics.Strings.AllowUnicodeDataLoss := TRUE;
    try
      Test('ANSI.TrimRight(''foo' + OT + ''', ''' + OT + ''')').Expect(ANSI.TrimRight(ANSI.FromWIDE('foo' + OT), OT)).Equals('foo');
    except
      Test('ANSI.TrimRight(''foo' + OT + ''', ''' + OT + ''')').UnexpectedException;
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Unbrace;
  begin
    Test('ANSI.Unbrace('''')').Expect(ANSI.Unbrace('')).Equals('');
    Test('ANSI.Unbrace(''()'')').Expect(ANSI.Unbrace('()')).Equals('');
    Test('ANSI.Unbrace(''(abc)'')').Expect(ANSI.Unbrace('(abc)')).Equals('abc');
    Test('ANSI.Unbrace(''[abc]'')').Expect(ANSI.Unbrace('[abc]')).Equals('abc');
    Test('ANSI.Unbrace(''{abc}'')').Expect(ANSI.Unbrace('{abc}')).Equals('abc');
    Test('ANSI.Unbrace(''<abc>'')').Expect(ANSI.Unbrace('<abc>')).Equals('abc');
    Test('ANSI.Unbrace(''#abc#'')').Expect(ANSI.Unbrace('#abc#')).Equals('abc');
    Test('ANSI.Unbrace(''?abc?'')').Expect(ANSI.Unbrace('?abc?')).Equals('abc');
    Test('ANSI.Unbrace(''abc'')').Expect(ANSI.Unbrace('abc')).Equals('abc');

    Test('ANSI.Unbrace(''(abc'')').Expect(ANSI.Unbrace('(abc')).Equals('(abc');
    Test('ANSI.Unbrace(''abc)'')').Expect(ANSI.Unbrace('abc)')).Equals('abc)');
    Test('ANSI.Unbrace(''(abc]'')').Expect(ANSI.Unbrace('(abc]')).Equals('(abc]');
    Test('ANSI.Unbrace(''(abc (live))'')').Expect(ANSI.Unbrace('(abc (live))')).Equals('abc (live)');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Unquote;
  begin
    Test('ANSI.Unquote(''Some Mothers Do ''''Ave ''''Em'')').Expect(ANSI.Unquote('''Some Mothers Do ''''Ave ''''Em''')).Equals('Some Mothers Do ''Ave ''Em');
    Test('ANSI.Unquote("Some Mothers Do ''Ave ''Em")').Expect(ANSI.Unquote('"Some Mothers Do ''Ave ''Em"')).Equals('Some Mothers Do ''Ave ''Em');
    Test('ANSI.Unquote(''Mother knows best'')').Expect(ANSI.Unquote('''Mother knows best''')).Equals('Mother knows best');
    Test('ANSI.Unquote("Mother knows best")').Expect(ANSI.Unquote('"Mother knows best"')).Equals('Mother knows best');
  end;




























  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Lowercase;
  const
    SOURCE  : array[0..6] of ANSIString = ('a', 'âbc', 'ÂBC', 'A', '1', 'Exp', 'Windows™');
    RESULT  : array[0..6] of ANSIString = ('a', 'âbc', 'âbc', 'a', '1', 'exp', 'windows™');
  var
    i: Integer;
  begin
    for i := Low(SOURCE) to High(Source) do
      Test('ANSI.Lowercase(%s)', [SOURCE[i]]).Expect(ANSI.Lowercase(SOURCE[i])).Equals(RESULT[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Startcase;
  const
    SOURCE  : array[0..7] of ANSIString = ('a', 'âbc', 'ÂBC', 'A', '1', 'Exp', 'Windows™ surface', 'easy as 123');
    RESULT  : array[0..7] of ANSIString = ('A', 'Âbc', 'Âbc', 'A', '1', 'Exp', 'Windows™ Surface', 'Easy As 123');
  var
    i: Integer;
  begin
    for i := Low(SOURCE) to High(Source) do
      Test('ANSI.Startcase(%s)', [SOURCE[i]]).Expect(ANSI.Startcase(SOURCE[i])).Equals(RESULT[i]);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Uppercase;
  const
    SOURCE  : array[0..6] of ANSIString = ('a', 'âbc', 'ÂBC', 'A', '1', 'Exp', 'Windows™');
    RESULT  : array[0..6] of ANSIString = ('A', 'ÂBC', 'ÂBC', 'A', '1', 'EXP', 'WINDOWS™');
  var
    i: Integer;
  begin
    for i := Low(SOURCE) to High(Source) do
      Test('ANSI.Uppercase(%s)', [SOURCE[i]]).Expect(ANSI.Uppercase(SOURCE[i])).Equals(RESULT[i]);
  end;




















{ TANSITests ------------------------------------------------------------------------------------- }

(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  function TANSITests.NameForCase: UnicodeString;
  begin
    result := 'ANSI() Box Tests';
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.Transcoding;
  var
    str: IANSIString;
  begin
    str := ANSI(SRCA);

    Test('ANSI(string).ToANSI').Expect(str.AsANSI).Equals(SRCW);
    Test('ANSI(string).ToString').Expect(str.AsString).Equals(SRCS);
    Test('ANSI(string).ToUTF8').Expect(str.AsUTF8).Equals(SRCU);
    Test('ANSI(string).ToWIDE').Expect(str.AsWIDE).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Alloc;
  var
    p: PANSIChar;
  begin
    p := ANSI('this').AllocANSI;
    Test('ANSI().Alloc').Expect(p[0]).Equals('t');
    Test('ANSI().Alloc').Expect(p[1]).Equals('h');
    Test('ANSI().Alloc').Expect(p[2]).Equals('i');
    Test('ANSI().Alloc').Expect(p[3]).Equals('s');
    Test('ANSI().Alloc').Expect(p[4]).Equals(#0);
  end;


  procedure TANSITests.fn_BeginsWith;
  begin

  end;


  procedure TANSITests.fn_Compare;
  const
    CASES: array[0..8] of TANSIStringAB = (
                                           (A: 'a.12'; B: 'a.2'),
                                           (A: '1';   B: '11'),
                                           (A: 'a';   B: 'abc'),
                                           (A: 'abc'; B: 'def'),
                                           (A: 'abc'; B: 'ABC'),
                                           (A: 'abc'; B: 'abc'),
                                           (A: 'ABC'; B: 'abc'),
                                           (A: 'def'; B: 'abc'),
                                           (A: 'def'; B: 'd')
                                          );
    NUM_LT  = 5;
    NUM_EQ  = 1;
  var
    i: Integer;
  begin
    for i := 0 to Pred(NUM_LT) do
      Test(WIDE.FromANSI(CASES[i].A + ' < ' + CASES[i].B + '!'))
        .Expect(ANSI(CASES[i].A).ComparedTo(CASES[i].B)).Equals(isLesser);

    for i := NUM_LT to Pred(NUM_LT + NUM_EQ) do
      Test(WIDE.FromANSI(CASES[i].A + ' = ' + CASES[i].B + '!'))
        .Expect(ANSI(CASES[i].A).ComparedTo(CASES[i].B)).Equals(isEqual);

    for i := (NUM_LT + NUM_EQ) to Pred(Length(CASES)) do with CASES[i] do
      Test('ANSI(%s).CompareWith(%s) = isGreater!', [A, B]).Expect(ANSI(A).ComparedTo(B)).Equals(isGreater);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Contains;
  const
    STR: ANSIString = 'The quick fox!';
  begin
    Note('Case Sensitive');

    Test('contains ''T''').Expect(ANSI(STR).Contains('T')).IsTRUE;
    Test('contains ''t''').Expect(ANSI(STR).Contains('t')).IsFALSE;
    Test('contains ''!''').Expect(ANSI(STR).Contains('!')).IsTRUE;
    Test('contains ''Q''').Expect(ANSI(STR).Contains('Q')).IsFALSE;
    Test('contains ''q''').Expect(ANSI(STR).Contains('q')).IsTRUE;
    Test('contains ''Z''').Expect(ANSI(STR).Contains('Z')).IsFALSE;

    Test('contains ''The''').Expect(ANSI(STR).Contains('The')).IsTRUE;
    Test('contains ''fox!''').Expect(ANSI(STR).Contains('fox!')).IsTRUE;
    Test('contains ''quick''').Expect(ANSI(STR).Contains('quick')).IsTRUE;
    Test('contains ''brown''').Expect(ANSI(STR).Contains('brown')).IsFALSE;

    Note('Ignore Case');

    Test('contains ''T''').Expect(ANSI(STR).Contains('T', csIgnoreCase)).IsTRUE;
    Test('contains ''t''').Expect(ANSI(STR).Contains('t', csIgnoreCase)).IsTRUE;
    Test('contains ''!''').Expect(ANSI(STR).Contains('!', csIgnoreCase)).IsTRUE;
    Test('contains ''Q''').Expect(ANSI(STR).Contains('Q', csIgnoreCase)).IsTRUE;
    Test('contains ''q''').Expect(ANSI(STR).Contains('q', csIgnoreCase)).IsTRUE;
    Test('contains ''Z''').Expect(ANSI(STR).Contains('Z', csIgnoreCase)).IsFALSE;

    Test('contains ''the''').Expect(ANSI(STR).Contains('the', csIgnoreCase)).IsTRUE;
    Test('contains ''Fox!''').Expect(ANSI(STR).Contains('Fox!', csIgnoreCase)).IsTRUE;
    Test('contains ''QUICK''').Expect(ANSI(STR).Contains('QUICK', csIgnoreCase)).IsTRUE;
    Test('contains ''brown''').Expect(ANSI(STR).Contains('brown', csIgnoreCase)).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_EqualsText;
  const
    CASES: array[0..3] of TANSIStringAB = (
                                       (A: '';                    B: ''),
                                       (A: 'LowerCase';           B: 'lowercase'),
                                       (A: '*NOT UPPERCASE*';     B: '*not uppercase*'),
                                       (A: 'Microsoft Windowsâ„¢';  B: 'microsoft windowsâ„¢')
                                      );
  var
    i: Integer;
  begin
    for i := 0 to Pred(Length(CASES)) do with CASES[i] do
      Test('ANSI(%s).EqualsText(%s)!', [A, B]).Expect(ANSI(A).EqualsText(B)).IsTRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Find;
  const            // 0         1         2         3         4
    STR: ANSIString = 'The quick, quick fox!  I said: The quick fox!©';
  var
    p: Integer;
    pa: TCharIndexArray;
  begin
    Note('aCaseMode = csCaseSensitive');

    ANSI(STR).Find('©', p);    Test('FirstPos of ''©''').Expect(p).Equals(46);

    ANSI(STR).Find('T', p);      Test('FirstPos of ''T''').Expect(p).Equals(1);
    ANSI(STR).Find('!', p);      Test('FirstPos of ''!''').Expect(p).Equals(21);
    ANSI(STR).Find('q', p);      Test('FirstPos of ''q''').Expect(p).Equals(5);
    ANSI(STR).Find('Z', p);      Test('FirstPos of ''Z''').Expect(p).Equals(0);

    ANSI(STR).Find('The', p);    Test('FirstPos of ''The''').Expect(p).Equals(1);
    ANSI(STR).Find('fox!', p);   Test('FirstPos of ''fox!''').Expect(p).Equals(18);
    ANSI(STR).Find('quick', p);  Test('FirstPos of ''quick''').Expect(p).Equals(5);
    ANSI(STR).Find('brown', p);  Test('FirstPos of ''brown''').Expect(p).Equals(0);

    ANSI(STR).Find('T', pa); Test('2 Positions of ''T''').Expect(Length(pa)).Equals(2).IsRequired;
                             Test('First ''T''').Expect(pa[0]).Equals(1);
                             Test('Second ''T''').Expect(pa[1]).Equals(32);

    ANSI(STR).Find('!', pa); Test('2 Positions of ''!''').Expect(Length(pa)).Equals(2).IsRequired;
                             Test('First ''!''').Expect(pa[0]).Equals(21);
                             Test('Second ''!''').Expect(pa[1]).Equals(45);

    ANSI(STR).Find('q', pa); Test('3 Positions of ''q''').Expect(Length(pa)).Equals(3).IsRequired;
                             Test('First ''q''').Expect(pa[0]).Equals(5);
                             Test('Second ''q''').Expect(pa[1]).Equals(12);
                             Test('Third ''q''').Expect(pa[2]).Equals(36);

    ANSI(STR).Find('z', pa); Test('No Positions of ''z''').Expect(Length(pa)).Equals(0);


    Note('aCaseMode = csIgnoreCase');

    ANSI(STR).Find('i', p, csIgnoreCase);      Test('First ''i''').Expect(p).Equals(7);
    ANSI(STR).Find('I', p, csIgnoreCase);      Test('First ''I''').Expect(p).Equals(7);

    ANSI(STR).Find('t', p, csIgnoreCase);      Test('First ''t''').Expect(p).Equals(1);
    ANSI(STR).Find('!', p, csIgnoreCase);      Test('First ''!''').Expect(p).Equals(21);
    ANSI(STR).Find('Q', p, csIgnoreCase);      Test('First ''Q''').Expect(p).Equals(5);
    ANSI(STR).Find('Z', p, csIgnoreCase);      Test('First ''Z''').Expect(p).Equals(0);

    ANSI(STR).Find('THE',   p, csIgnoreCase);  Test('First ''THE''').Expect(p).Equals(1);
    ANSI(STR).Find('FOX!',  p, csIgnoreCase);  Test('First ''FOX!''').Expect(p).Equals(18);
    ANSI(STR).Find('QUICK', p, csIgnoreCase);  Test('First ''QUICK''').Expect(p).Equals(5);
    ANSI(STR).Find('BROWN', p, csIgnoreCase);  Test('First ''BROWN''').Expect(p).Equals(0);

    ANSI(STR).Find('T', pa, csIgnoreCase); Test('2 Positions of ''T''').Expect(Length(pa)).Equals(2).IsRequired;
                                           Test('First ''T''').Expect(pa[0]).Equals(1);
                                           Test('Second ''T''').Expect(pa[1]).Equals(32);

    ANSI(STR).Find('!', pa, csIgnoreCase); Test('2 Positions of ''!''').Expect(Length(pa)).Equals(2).IsRequired;
                                           Test('First ''!''').Expect(pa[0]).Equals(21);
                                           Test('Second ''!''').Expect(pa[1]).Equals(45);

    ANSI(STR).Find('q', pa, csIgnoreCase); Test('3 Positions of ''q''').Expect(Length(pa)).Equals(3).IsRequired;
                                           Test('First ''q''').Expect(pa[0]).Equals(5);
                                           Test('Second ''q''').Expect(pa[1]).Equals(12);
                                           Test('Third ''q''').Expect(pa[2]).Equals(36);

    ANSI(STR).Find('z', pa, csIgnoreCase); Test('No Positions of ''z''').Expect(Length(pa)).Equals(0);
  end;


(*
  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindFirstText;
  const// 0         1         2         3         4
    STR: ANSIString = 'The quick, quick fox!  I said: The quick fox!';
  var
    p: Integer;
  begin
    ANSI(STR).FindFirstText('i', p);      Test('FirstPos of ''i''').Expect(p).Equals(7);
    ANSI(STR).FindFirstText('I', p);      Test('FirstPos of ''I''').Expect(p).Equals(7);

    ANSI(STR).FindFirstText('t', p);      Test('FirstPos of ''t''').Expect(p).Equals(1);
    ANSI(STR).FindFirstText('!', p);      Test('FirstPos of ''!''').Expect(p).Equals(21);
    ANSI(STR).FindFirstText('Q', p);      Test('FirstPos of ''Q''').Expect(p).Equals(5);
    ANSI(STR).FindFirstText('Z', p);      Test('FirstPos of ''Z''').Expect(p).Equals(0);

    ANSI(STR).FindFirstText('THE', p);    Test('FirstPos of ''THE''').Expect(p).Equals(1);
    ANSI(STR).FindFirstText('FOX!', p);   Test('FirstPos of ''FOX!''').Expect(p).Equals(18);
    ANSI(STR).FindFirstText('QUICK', p);  Test('FirstPos of ''QUICK''').Expect(p).Equals(5);
    ANSI(STR).FindFirstText('BROWN', p);  Test('FirstPos of ''BROWN''').Expect(p).Equals(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindNext;
  const// 0         1         2         3         4
    STR: ANSIString = 'The quick, quick fox!  I said: The quick fox!';
  var
    p: Integer;
  begin
    ANSI(STR).FindFirst('T', p);      Test('Pos of ''T''').Expect(p).Equals(1);
    ANSI(STR).FindNext('T', p);       Test('NextPos of ''T''').Expect(p).Equals(32);
    ANSI(STR).FindNext('T', p);       Test('NextPos of ''T''').Expect(p).Equals(0);

    ANSI(STR).FindFirst('!', p);      Test('Pos of ''!''').Expect(p).Equals(21);
    ANSI(STR).FindNext('!', p);       Test('NextPos of ''!''').Expect(p).Equals(45);
    ANSI(STR).FindNext('!', p);       Test('NextPos of ''!''').Expect(p).Equals(0);

    ANSI(STR).FindFirst('q', p);      Test('Pos of ''q''').Expect(p).Equals(5);
    ANSI(STR).FindNext('q', p);       Test('NextPos of ''q''').Expect(p).Equals(12);
    ANSI(STR).FindNext('q', p);       Test('NextPos of ''q''').Expect(p).Equals(36);
    ANSI(STR).FindNext('q', p);       Test('NextPos of ''q''').Expect(p).Equals(0);

    ANSI(STR).FindFirst('z', p);      Test('Pos of ''z''').Expect(p).Equals(0);
    ANSI(STR).FindNext('z', p);       Test('NextPos of ''z''').Expect(p).Equals(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_FindLast;
  const// 0         1         2         3         4
    STR: ANSIString = 'The quick, quick fox!  I said: The quick fox!';
  var
    p: Integer;
  begin
    ANSI(STR).FindLast('T', p);       Test('FindLast of ''T''').Expect(p).Equals(32);
    ANSI(STR).FindLast('!', p);       Test('FindLast of ''!''').Expect(p).Equals(45);
    ANSI(STR).FindLast('q', p);       Test('FindLast of ''q''').Expect(p).Equals(36);
    ANSI(STR).FindLast('Z', p);       Test('FindLast of ''Z''').Expect(p).Equals(0);

    ANSI(STR).FindLast('The', p);     Test('FindLast of ''The''').Expect(p).Equals(32);
    ANSI(STR).FindLast('fox!', p);    Test('FindLast of ''fox!''').Expect(p).Equals(42);
    ANSI(STR).FindLast('quick', p);   Test('FindLast of ''quick''').Expect(p).Equals(36);
    ANSI(STR).FindLast('brown', p);   Test('FindLast of ''brown''').Expect(p).Equals(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsLowercase;
  const
    STR_VECTOR: array[0..2] of TANSIStringAB = (
                                                (A: 'LowerCase';           B: 'lowercase'),
                                                (A: '*NOT LOWERCASE*';     B: '*not lowercase*'),
                                                (A: 'Microsoft Windows™';  B: 'microsoft windows™')
                                               );
    CHAR_VECTOR: array[0..3] of TANSICharAB = (
                                               (A: ' ';   B: ' '),
                                               (A: 'L';   B: 'l'),
                                               (A: '*';   B: '*'),
                                               (A: '™';   B: '™')
                                              );
  var
    i: Integer;
  begin
    Note('Tests for IsLowercase(ANSIString)...');

    Test('Empty String is NOT considered lowercase!').Expect(ANSI('').IsLowercase).IsFALSE;

    for i := 0 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].A).Expect(ANSI(STR_VECTOR[i].A).IsLowercase).IsFALSE;

    for i := 0 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].B).Expect(ANSI(STR_VECTOR[i].B).IsLowercase).IsTRUE;

    Note('Tests for IsLowercase(ANSIChar)...');

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(WIDE.FromANSI(CHAR_VECTOR[i].A)).Expect(ANSI(CHAR_VECTOR[i].A).IsLowercase).IsFALSE;

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(WIDE.FromANSI(CHAR_VECTOR[i].B)).Expect(ANSI(CHAR_VECTOR[i].B).IsLowercase).Equals(i = 1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_IsUppercase;
  const
    STR_VECTOR: array[0..2] of TANSIStringAB = (
                                                (A: 'UpperCase';           B: 'UPPERCASE'),
                                                (A: '*NOT uppercase*';     B: '*NOT UPPERCASE*'),
                                                (A: 'Microsoft Windows™';  B: 'MICROSOFT WINDOWS™')
                                               );
    CHAR_VECTOR: array[0..3] of TANSICharAB = (
                                               (A: ' ';   B: ' '),
                                               (A: 'L';   B: 'l'),
                                               (A: '*';   B: '*'),
                                               (A: '™';   B: '™')
                                              );
  var
    i: Integer;
  begin
    Note('Tests for IsUppercase(ANSIString)...');

    Test('Empty String is NOT considered uppercase!').Expect(ANSI('').IsUppercase).IsFALSE;

    for i := 0 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].A).Expect(ANSI(STR_VECTOR[i].A).IsUppercase).IsFALSE;

    for i := 1 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].B).Expect(ANSI(STR_VECTOR[i].B).IsUppercase).IsTRUE;

    Note('Tests for IsUppercase(ANSIChar)...');

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(CHAR_VECTOR[i].A).Expect(ANSI(CHAR_VECTOR[i].B).IsUppercase).IsFALSE;

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(CHAR_VECTOR[i].B).Expect(ANSI(CHAR_VECTOR[i].A).IsUppercase).Equals(i = 1);
  end;


  procedure TANSITests.fn_Tag;
  begin
    Test('(link).Tag(a)').Expect(ANSI('link').Tag('a')).Equals('<a>link</a>');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Lowercase;
  const
    STR_VECTOR: array[0..3] of TANSIStringAB = (
                                                (A: '';                    B: ''),
                                                (A: 'LowerCase';           B: 'lowercase'),
                                                (A: '*NOT UPPERCASE*';     B: '*not uppercase*'),
                                                (A: 'Microsoft Windows™';  B: 'microsoft windows™')
                                               );
    CHAR_VECTOR: array[0..3] of TANSICharAB = (
                                               (A: ' ';   B: ' '),
                                               (A: 'L';   B: 'l'),
                                               (A: '*';   B: '*'),
                                               (A: '™';   B: '™')
                                              );
  var
    i: Integer;
  begin
    Note('Tests for Lowercase(ANSIString)...');

    for i := 0 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].A).Expect(ANSI.Lowercase(STR_VECTOR[i].A)).Equals(STR_VECTOR[i].B);

    Note('Tests for Lowercase(ANSIChar)...');

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(CHAR_VECTOR[i].A).Expect(ANSI.Lowercase(CHAR_VECTOR[i].A)).Equals(CHAR_VECTOR[i].B);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Delete;
  begin
    Test('ANSI.Delete(''Food of the Gods'', ''o'')').Expect(ANSI.Delete(ssAll, 'Food of the Gods', 'o')).Equals('Fd f the Gds');
    Test('ANSI.Delete(''Food of the Gods'', ''od'')').Expect(ANSI.Delete(ssAll, 'Food of the Gods', 'od')).Equals('Fo of the Gs');

    Test('ANSI.Delete(''Food of the Gods'', ''f'')').Expect(ANSI.Delete(ssAll, 'Food of the Gods', 'f')).Equals('Food o the Gods');
    Test('ANSI.Delete(''Food of the Gods'', ''f'', [rsIgnoreCase])').Expect(ANSI.Delete(ssAll, 'Food of the Gods', 'f', csIgnoreCase)).Equals('ood o the Gods');

    Test('ANSI.Delete(''Food of the Gods'', ''o'', [rsOnce])').Expect(ANSI.Delete(ssFirst, 'Food of the Gods', 'o')).Equals('Fod of the Gods');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Replace;
  begin
    Test('ANSI.Replace(''Food of the Gods'', ''o'', '''')').Expect(ANSI.Replace(ssAll, 'Food of the Gods', 'o', '')).Equals('Fd f the Gds');
    Test('ANSI.Replace(''Food of the Gods'', ''od'', '''')').Expect(ANSI.Replace(ssAll, 'Food of the Gods', 'od', '')).Equals('Fo of the Gs');
    Test('ANSI.Replace(''Waiting for Godo'', ''o'', '''')').Expect(ANSI.Replace(ssAll, 'Waiting for Godo', 'o', '')).Equals('Waiting fr Gd');

    Test('ANSI.Replace(''Food of the Gods'', ''o'', ''oo'')').Expect(ANSI.Replace(ssAll, 'Food of the Gods', 'o', 'oo')).Equals('Fooood oof the Goods');

    Test('ANSI.Replace(''Food of the Gods'', ''o'', '''')').Expect(ANSI.Replace(ssFirst, 'Food of the Gods', 'o', '')).Equals('Fod of the Gods');
    Test('ANSI.Replace(''Food of the Gods'', ''o'', '''')').Expect(ANSI.Replace(ssLast, 'Food of the Gods', 'o', '')).Equals('Food of the Gds');

    Test('ANSI.Replace(''Food of the Gods'', ''x'', '''')').Expect(ANSI.Replace(ssAll, 'Food of the Gods', 'x', '')).Equals('Food of the Gods');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TANSITests.fn_Uppercase;
  const
    STR_VECTOR: array[0..3] of TANSIStringAB = (
                                                (A: '';                    B: ''),
                                                (A: 'UpperCase';           B: 'UPPERCASE'),
                                                (A: '*NOT LOWERCASE*';     B: '*NOT LOWERCASE*'),
                                                (A: 'Microsoft Windows™';  B: 'MICROSOFT WINDOWS™')
                                               );
    CHAR_VECTOR: array[0..3] of TANSICharAB = (
                                               (A: ' ';   B: ' '),
                                               (A: 'l';   B: 'L'),
                                               (A: '*';   B: '*'),
                                               (A: '™';   B: '™')
                                              );
  var
    i: Integer;
  begin
    Note('Tests for Uppercase(ANSIString)...');

    for i := 0 to Pred(Length(STR_VECTOR)) do
      Test(STR_VECTOR[i].A).Expect(ANSI.Uppercase(STR_VECTOR[i].A)).Equals(STR_VECTOR[i].B);

    Note('Tests for Uppercase(ANSIChar)...');

    for i := 0 to Pred(Length(CHAR_VECTOR)) do
      Test(CHAR_VECTOR[i].A).Expect(ANSI.Uppercase(CHAR_VECTOR[i].A)).Equals(CHAR_VECTOR[i].B);
  end;
*)













end.
