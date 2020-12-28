
  unit Test.Strings.WIDE;

interface

  uses
    Deltics.Smoketest;


  type
    TWIDETests = class(TTest)
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

      procedure fn_IsBoolean;
      procedure fn_IsInteger;

      procedure fn_IsAlpha;
      procedure fn_IsAlphaNumeric;
      procedure fn_IsEmpty;
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

      procedure fn_Camelcase;
      procedure fn_Lowercase;
      procedure fn_Skewercase;
      procedure fn_Snakecase;
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




{ TWIDETests ------------------------------------------------------------------------------------- }

  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.Transcoding;
  begin
    Test('WIDE.Encode!').Expect(WIDE.Encode(SRCS)).Equals(SRCW);

    Test('WIDE.FromANSI(string)!').Expect(WIDE.FromANSI(SRCA)).Equals(SRCW);
    Test('WIDE.FromANSI(buffer)!').Expect(WIDE.FromANSI(PANSIChar(SRCA))).Equals(SRCW);

    Test('WIDE.FromUTF8(string)!').Expect(WIDE.FromUTF8(SRCU)).Equals(SRCW);
    Test('WIDE.FromUTF8(buffer)!').Expect(WIDE.FromUTF8(PUTF8Char(SRCU))).Equals(SRCW);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Alloc;
  var
    p: Pointer;
    pANSI: PANSIChar absolute p;
    pWIDE: PWIDEChar absolute p;
    pUTF8: PUTF8Char absolute p;
  begin
    pANSI := WIDE.AllocANSI(SRCW);

    Test('WIDE.AllocANSI result').Expect(p).IsAssigned;
    Test('WIDE.AllocANSI buffer length').Expect(ANSI.Len(pANSI)).Equals(Length(SRCA));
    Test('WIDE.AllocANSI buffer content').Expect(p).Equals(PANSIString(SRCA), Length(SRCA));

    FreeMem(pANSI);

    pWIDE := WIDE.Alloc(SRCW);

    Test('WIDE.AllocWIDE result').Expect(p).IsAssigned;
    Test('WIDE.AllocWIDE buffer length').Expect(WIDE.Len(pWIDE)).Equals(Length(SRCW));
    Test('WIDE.AllocWIDE buffer content').Expect(p).Equals(PWIDEString(SRCW), Length(SRCW) * 2);

    FreeMem(pWIDE);

    pUTF8 := WIDE.AllocUTF8(SRCW);

    Test('WIDE.AllocUTF8 result').Expect(p).IsAssigned;
    Test('WIDE.AllocUTF8 buffer length').Expect(UTF8.Len(pUTF8)).Equals(Length(SRCU));
    Test('WIDE.AllocUTF8 buffer content').Expect(p).Equals(PUTF8String(SRCU), Length(SRCU));

    FreeMem(pUTF8);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyToBuffer;
  var
    p: Pointer;
    zeroes: pointer;
    PWIDE: PWIDEChar absolute p;
  begin
    GetMem(p, 20);
    ZeroMemory(p, 20);

    GetMem(zeroes, 20);
    ZeroMemory(zeroes, 20);

    WIDE.CopyToBuffer(SRCW, p, 0);
    Test('WIDE.CopyToBuffer [buffer is zeroes]').Expect(p).Equals(zeroes, 20);

    WIDE.CopyToBuffer(SRCW, p);
    Test('WIDE.CopyToBuffer [buffer]').Expect(p).Equals(PWIDEString(SRCW), Length(SRCW));
    ZeroMemory(p, 20);

    WIDE.CopyToBuffer(SRCW, p, 1);
    Test('WIDE.CopyToBuffer [buffer[0]]').Expect(pWIDE[0]).Equals('U');
    Test('WIDE.CopyToBuffer [buffer[1]]').Expect(pWIDE[1]).Equals(#0);
    ZeroMemory(p, 20);

    try
      WIDE.CopyToBuffer(SRCW, NIL);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    try
      WIDE.CopyToBuffer(SRCW, p, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    FreeMem(zeroes);
    FreeMem(p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyToBufferOffset;
  var
    p: Pointer;
    zeroes: pointer;
    PWIDE: PWIDEChar absolute p;
  begin
    GetMem(p, 20);
    ZeroMemory(p, 20);

    GetMem(zeroes, 20);
    ZeroMemory(zeroes, 20);

    WIDE.CopyToBufferOffset(SRCW, p, 2);
    Test('WIDE.CopyToBufferOffset(src, p, 1) [buffer[0]]').Expect(pWIDE[0]).Equals(#0);
    Inc(pWIDE);
    Test('WIDE.CopyToBufferOffset(src, p, 1) [buffer[1]...]').Expect(p).Equals(PWIDEString(SRCW), Length(SRCW));
    Dec(pWIDE);
    ZeroMemory(p, 20);

    WIDE.CopyToBufferOffset(SRCW, p, 2, 1);
    Test('WIDE.CopyToBufferOffset(src, p, 2, 1) [buffer[0]]').Expect(pWIDE[0]).Equals(#0);
    Test('WIDE.CopyToBufferOffset(src, p, 2, 1) [buffer[1]]').Expect(pWIDE[1]).Equals('U');
    Test('WIDE.CopyToBufferOffset(src, p, 2, 1) [buffer[2]]').Expect(pWIDE[2]).Equals(#0);
    ZeroMemory(p, 20);

    // Advance the buffer pointer and copy to a negative offset then test the buffer
    //  after restoring the pointer back to it's origin.

    Inc(pWIDE);
    WIDE.CopyToBufferOffset(SRCW, p, -2);
    Dec(pWIDE);
    Test('WIDE.CopyToBufferOffset(src, p, -2) [buffer]').Expect(p).Equals(PWIDEString(SRCW), Length(SRCW));
    ZeroMemory(p, 20);

    // Same again, but this time copying 0 characters

    Inc(pWIDE);
    WIDE.CopyToBufferOffset(SRCW, p, -2, 0);
    Dec(pWIDE);
    Test('WIDE.CopyToBufferOffset(src, p, -2, 0) [buffer]').Expect(p).Equals(zeroes, 20);
    ZeroMemory(p, 20);

    // And again, but this time copying 2 characters

    Inc(pWIDE);
    WIDE.CopyToBufferOffset(SRCW, p, -2, 2);
    Dec(pWIDE);
    Test('WIDE.CopyToBufferOffset(src, p, -2, 2) [buffer[0]]').Expect(pWIDE[0]).Equals('U');
    Test('WIDE.CopyToBufferOffset(src, p, -2, 2) [buffer[1]]').Expect(pWIDE[1]).Equals('n');
    Test('WIDE.CopyToBufferOffset(src, p, -2, 2) [buffer[2]]').Expect(pWIDE[2]).Equals(#0);
    ZeroMemory(p, 20);

    try
      WIDE.CopyToBufferOffset(SRCW, p, -2, -2);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    FreeMem(zeroes);
    FreeMem(p);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_FromBuffer;
  var
    p: PWIDEChar;
  begin
    p   := PWIDEChar(SRCW);

    Test('WIDE.FromBuffer(p)').Expect(WIDE.FromBuffer(p)).Equals(SRCW);
    Test('WIDE.FromBuffer(p, -1)').Expect(WIDE.FromBuffer(p, -1)).Equals(SRCW);
    Test('WIDE.FromBuffer(p, 0)').Expect(WIDE.FromBuffer(p, 0)).Equals('');
    Test('WIDE.FromBuffer(p, 1)').Expect(WIDE.FromBuffer(p, 1)).Equals(SRCW[1]);

    try
      WIDE.FromBuffer(p, -2);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Len;
  const
    STR: UnicodeString = 'test';
    BUFFER: array[0..7] of WIDEChar = ('b','u','f','f','e','r',#0,#0);
    NULLBUFFER: array[0..7] of WIDEChar = (#0,#0,#0,#0,#0,#0,#0,#0);
  begin
    Test('WIDE.Len(string)').Expect(WIDE.Len(PWIDEChar(STR))).Equals(4);
    Test('WIDE.Len(buffer)').Expect(WIDE.Len(@BUFFER[0])).Equals(6);
    Test('WIDE.Len(null buffer)').Expect(WIDE.Len(@NULLBUFFER[0])).Equals(0);
  end;

















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Coalesce;
  begin
    Test('WIDE.Coalesce(''str'', ''default'')').Expect(WIDE.Coalesce('str', 'default')).Equals('str');
    Test('WIDE.Coalesce('' '', ''default'')').Expect(WIDE.Coalesce(' ', 'default')).Equals(' ');
    Test('WIDE.Coalesce('''', ''default'')').Expect(WIDE.Coalesce('', 'default')).Equals('default');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_HasLength;
  var
    len: Integer;
  begin
    Test('WIDE.HasLength('''', var len) result').Expect(WIDE.HasLength('', len)).IsFALSE;
    Test('WIDE.HasLength('''', var len) value of len').Expect(len).Equals(0);
    Test('WIDE.HasLength(''abc'', var len) result').Expect(WIDE.HasLength('abc', len)).IsTRUE;
    Test('WIDE.HasLength(''abc'', var len) value of len').Expect(len).Equals(3);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_HasIndex;
  var
    c: WIDEChar;
  begin
    Test('WIDE.HasIndex(''abc'', -1)').Expect(WIDE.HasIndex('abc', -1)).IsFALSE;
    Test('WIDE.HasIndex(''abc'', 0)').Expect(WIDE.HasIndex('abc', 0)).IsFALSE;
    Test('WIDE.HasIndex(''abc'', 1)').Expect(WIDE.HasIndex('abc', 1)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 2)').Expect(WIDE.HasIndex('abc', 2)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 3)').Expect(WIDE.HasIndex('abc', 3)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 4)').Expect(WIDE.HasIndex('abc', 4)).IsFALSE;

    Test('WIDE.HasIndex(''abc'', -1, var c) result').Expect(WIDE.HasIndex('abc', -1, c)).IsFALSE;
    Test('WIDE.HasIndex(''abc'', -1, var c) c').Expect(c).Equals(#0);
    Test('WIDE.HasIndex(''abc'', 0, var c) result').Expect(WIDE.HasIndex('abc', 0, c)).IsFALSE;
    Test('WIDE.HasIndex(''abc'', 0, var c) c').Expect(c).Equals(#0);
    Test('WIDE.HasIndex(''abc'', 1, var c) result').Expect(WIDE.HasIndex('abc', 1, c)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 1, var c) c').Expect(c).Equals('a');
    Test('WIDE.HasIndex(''abc'', 2, var c) result').Expect(WIDE.HasIndex('abc', 2, c)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 2, var c) c').Expect(c).Equals('b');
    Test('WIDE.HasIndex(''abc'', 3, var c) result').Expect(WIDE.HasIndex('abc', 3, c)).IsTRUE;
    Test('WIDE.HasIndex(''abc'', 3, var c) c').Expect(c).Equals('c');
    Test('WIDE.HasIndex(''abc'', 4, var c) result').Expect(WIDE.HasIndex('abc', 4, c)).IsFALSE;
    Test('WIDE.HasIndex(''abc'', 4, var c) c').Expect(c).Equals(#0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IIf;
  begin
    Test('WIDE.IIf(TRUE, ''true'', ''false'')').Expect(WIDE.IIf(TRUE, 'true', 'false')).Equals('true');
    Test('WIDE.IIf(FALSE, ''true'', ''false'')').Expect(WIDE.IIf(FALSE, 'true', 'false')).Equals('false');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IndexOf;
  begin
    Test('WIDE.IndexOf(''a'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('a', ['a', 'b', 'c'])).Equals(0);
    Test('WIDE.IndexOf(''b'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('b', ['a', 'b', 'c'])).Equals(1);
    Test('WIDE.IndexOf(''c'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('c', ['a', 'b', 'c'])).Equals(2);
    Test('WIDE.IndexOf(''d'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('d', ['a', 'b', 'c'])).Equals(-1);
    Test('WIDE.IndexOf(''A'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('A', ['a', 'b', 'c'])).Equals(-1);
    Test('WIDE.IndexOf('''', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOf('', ['a', 'b', 'c'])).Equals(-1);

    Test('WIDE.IndexOfText(''a'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('a', ['a', 'b', 'c'])).Equals(0);
    Test('WIDE.IndexOfText(''b'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('b', ['a', 'b', 'c'])).Equals(1);
    Test('WIDE.IndexOfText(''c'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('c', ['a', 'b', 'c'])).Equals(2);
    Test('WIDE.IndexOfText(''A'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('A', ['a', 'b', 'c'])).Equals(0);
    Test('WIDE.IndexOfText(''B'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('B', ['a', 'b', 'c'])).Equals(1);
    Test('WIDE.IndexOfText(''C'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('C', ['a', 'b', 'c'])).Equals(2);
    Test('WIDE.IndexOfText(''d'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('d', ['a', 'b', 'c'])).Equals(-1);
    Test('WIDE.IndexOfText(''D'', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('D', ['a', 'b', 'c'])).Equals(-1);
    Test('WIDE.IndexOfText('''', [''a'', ''b'', ''c''])').Expect(WIDE.IndexOfText('', ['a', 'b', 'c'])).Equals(-1);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Reverse;
  begin
    Test('WIDE.Reverse('''')').Expect(WIDE.Reverse('')).Equals('');
    Test('WIDE.Reverse(''a'')').Expect(WIDE.Reverse('a')).Equals('a');
    Test('WIDE.Reverse(''abc'')').Expect(WIDE.Reverse('abc')).Equals('cba');
    Test('WIDE.Reverse(''abc d'')').Expect(WIDE.Reverse('abc d')).Equals('d cba');
    Test('WIDE.Reverse(''Ábc'')').Expect(WIDE.Reverse('Ábc')).Equals('cbÁ');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Split;
  const
    STAR: WIDEChar = '*';
  var
    s: UnicodeString;
    left, right: UnicodeString;
    parts: TWIDEStringArray;
  begin
  // Splitting around a char

    Test('WIDE.Split('''', ''*'')').Expect(WIDE.Split('', STAR, left, right)).IsFALSE;
    Test('')['left'].Expect(left).Equals('');
    Test('')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''left'', ''*'')').Expect(WIDE.Split('left', STAR, left, right)).IsFALSE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''left*'', ''*'')').Expect(WIDE.Split('left*', STAR, left, right)).IsTRUE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''*right'', ''*'')').Expect(WIDE.Split('*right', STAR, left, right)).IsTRUE;
    Test('*right')['left'].Expect(left).Equals('');
    Test('*right')['right'].Expect(right).Equals('right');

    Test('WIDE.Split(''left*right'', ''*'')').Expect(WIDE.Split('left*right', STAR, left, right)).IsTRUE;
    Test('left*right')['left'].Expect(left).Equals('left');
    Test('left*right')['right'].Expect(right).Equals('right');

    s := 'left*mid-left*middle*mid-right*right';
    Test('WIDE.Split(''%s'', ''*'')', [s]).Expect(WIDE.Split(s, STAR, parts)).IsTRUE;
    Test('WIDE.Split(''%s'', ''*'')', [s])['no. of parts'].Expect(Length(parts)).Equals(5);
    Test('part')[0].Expect(parts[0]).Equals('left');
    Test('part')[1].Expect(parts[1]).Equals('mid-left');
    Test('part')[2].Expect(parts[2]).Equals('middle');
    Test('part')[3].Expect(parts[3]).Equals('mid-right');
    Test('part')[4].Expect(parts[4]).Equals('right');

  // Splitting around a sub-string

    Test('WIDE.Split('''', ''**'')').Expect(WIDE.Split('', '**', left, right)).IsFALSE;
    Test('')['left'].Expect(left).Equals('');
    Test('')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''left'', ''**'')').Expect(WIDE.Split('left', '**', left, right)).IsFALSE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''left**'', ''**'')').Expect(WIDE.Split('left**', '**', left, right)).IsTRUE;
    Test('left')['left'].Expect(left).Equals('left');
    Test('left')['right'].Expect(right).Equals('');

    Test('WIDE.Split(''**right'', ''**'')').Expect(WIDE.Split('**right', '**', left, right)).IsTRUE;
    Test('**right')['left'].Expect(left).Equals('');
    Test('**right')['right'].Expect(right).Equals('right');

    Test('WIDE.Split(''left**right'', ''**'')').Expect(WIDE.Split('left**right', '**', left, right)).IsTRUE;
    Test('left**right')['left'].Expect(left).Equals('left');
    Test('left**right')['right'].Expect(right).Equals('right');

    s := 'left**mid-left**middle**mid-right**right';
    Test('WIDE.Split(''%s'', ''**'')', [s]).Expect(WIDE.Split(s, '**', parts)).IsTRUE;
    Test('WIDE.Split(''%s'', ''**'')', [s])['no. of parts'].Expect(Length(parts)).Equals(5);
    Test('part')[0].Expect(parts[0]).Equals('left');
    Test('part')[1].Expect(parts[1]).Equals('mid-left');
    Test('part')[2].Expect(parts[2]).Equals('middle');
    Test('part')[3].Expect(parts[3]).Equals('mid-right');
    Test('part')[4].Expect(parts[4]).Equals('right');

  // Contracts

    try
      WIDE.Split('a*b', #0, left, right);
      Test('WIDE.Split(''a*b'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.Split(''a*b'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.Split('a*b', '', left, right);
      Test('WIDE.Split(''a*b'', '')').Expecting(EContractViolation);
    except
      Test('WIDE.Split(''a*b'', '')').Expecting(EContractViolation);
    end;
  end;






















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Concat;
  const
    COMMA       : WIDEChar      = ',';
    COMMASPACE  : UnicodeString = ', ';
  begin
    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', 'bee', 'c'])).Equals('abeec');
    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', '', 'c'])).Equals('ac');

    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', 'bee', 'c'], COMMA)).Equals('a,bee,c');
    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', '', 'c'], COMMA)).Equals('a,,c');

    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', 'bee', 'c'], COMMASPACE)).Equals('a, bee, c');
    Test('WIDE.Concat(array)').Expect(WIDE.Concat(['a', '', 'c'], COMMASPACE)).Equals('a, , c');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Format;
  begin
    Note('WIDE.Format is a simple pass-thru method for calling the WideFormat() RTL function.  '
       + 'Therefore only a limited number of test-cases are provided here primarily as '
       + 'as example of usage.');

    Test('WIDE.Format(''%d'', [42])').Expect(WIDE.Format('%d', [42])).Equals('42');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_StringOf;
  begin
    Test('WIDE.StringOf(''foo'', 0)').Expect(WIDE.StringOf('*', 0)).Equals('');
    Test('WIDE.StringOf(''foo'', 3)').Expect(WIDE.StringOf('*', 3)).Equals('***');

    Test('WIDE.StringOf('''', 10)').Expect(WIDE.StringOf('', 10)).Equals('');
    Test('WIDE.StringOf(''foo'', 0)').Expect(WIDE.StringOf('foo', 0)).Equals('');
    Test('WIDE.StringOf(''foo'', 3)').Expect(WIDE.StringOf('foo', 3)).Equals('foofoofoo');
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsAlpha;
  begin
    Test('WIDE.IsAlpha(''a'')').Expect(WIDE.IsAlpha('a')).IsTRUE;
    Test('WIDE.IsAlpha(''é'')').Expect(WIDE.IsAlpha('é')).IsTRUE;
    Test('WIDE.IsAlpha(''A'')').Expect(WIDE.IsAlpha('A')).IsTRUE;

    Test('WIDE.IsAlpha(''1'')').Expect(WIDE.IsAlpha('1')).IsFALSE;
    Test('WIDE.IsAlpha('''')').Expect(WIDE.IsAlpha('')).IsFALSE;
    Test('WIDE.IsAlpha(''café'')').Expect(WIDE.IsAlpha('café')).IsTRUE;

    Test('WIDE.IsAlpha(''BBC'')').Expect(WIDE.IsAlpha('BBC')).IsTRUE;
    Test('WIDE.IsAlpha(''BBC1'')').Expect(WIDE.IsAlpha('BBC1')).IsFALSE;
    Test('WIDE.IsAlpha('' BBC '')').Expect(WIDE.IsAlpha(' BBC ')).IsFALSE;
    Test('WIDE.IsAlpha(''BBC/ITV'')').Expect(WIDE.IsAlpha('BBC/ITV')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsAlphaNumeric;
  begin
    Test('WIDE.IsAlphaNumeric(''a'')').Expect(WIDE.IsAlphaNumeric('a')).IsTRUE;
    Test('WIDE.IsAlphaNumeric(''é'')').Expect(WIDE.IsAlphaNumeric('é')).IsTRUE;
    Test('WIDE.IsAlphaNumeric(''A'')').Expect(WIDE.IsAlphaNumeric('A')).IsTRUE;

    Test('WIDE.IsAlphaNumeric(''1'')').Expect(WIDE.IsAlphaNumeric('1')).IsTRUE;
    Test('WIDE.IsAlphaNumeric('''')').Expect(WIDE.IsAlphaNumeric('')).IsFALSE;
    Test('WIDE.IsAlphaNumeric(''café'')').Expect(WIDE.IsAlphaNumeric('café')).IsTRUE;

    Test('WIDE.IsAlphaNumeric(''+1'')').Expect(WIDE.IsAlphaNumeric('+1')).IsFALSE;
    Test('WIDE.IsAlphaNumeric(''1.1'')').Expect(WIDE.IsAlphaNumeric('1.1')).IsFALSE;

    Test('WIDE.IsAlphaNumeric(''BBC'')').Expect(WIDE.IsAlphaNumeric('BBC')).IsTRUE;
    Test('WIDE.IsAlphaNumeric(''BBC1'')').Expect(WIDE.IsAlphaNumeric('BBC1')).IsTRUE;
    Test('WIDE.IsAlphaNumeric('' BBC '')').Expect(WIDE.IsAlphaNumeric(' BBC ')).IsFALSE;
    Test('WIDE.IsAlphaNumeric(''BBC/ITV'')').Expect(WIDE.IsAlphaNumeric('BBC/ITV')).IsFALSE;
  end;


  procedure TWIDETests.fn_IsBoolean;
  begin
    Test('WIDE.IsBoolean('''')').Expect(WIDE.IsBoolean('')).IsFALSE;
    Test('WIDE.IsBoolean(''nope'')').Expect(WIDE.IsBoolean('nope')).IsFALSE;
    Test('WIDE.IsBoolean(''okay'')').Expect(WIDE.IsBoolean('okay')).IsFALSE;

    Test('WIDE.IsBoolean(''0'')').Expect(WIDE.IsBoolean('0')).IsTRUE;
    Test('WIDE.IsBoolean(''1'')').Expect(WIDE.IsBoolean('1')).IsTRUE;
    Test('WIDE.IsBoolean(''-1'')').Expect(WIDE.IsBoolean('-1')).IsTRUE;
    Test('WIDE.IsBoolean(''n'')').Expect(WIDE.IsBoolean('n')).IsTRUE;
    Test('WIDE.IsBoolean(''y'')').Expect(WIDE.IsBoolean('y')).IsTRUE;
    Test('WIDE.IsBoolean(''t'')').Expect(WIDE.IsBoolean('t')).IsFALSE;
    Test('WIDE.IsBoolean(''f'')').Expect(WIDE.IsBoolean('f')).IsFALSE;
    Test('WIDE.IsBoolean(''N'')').Expect(WIDE.IsBoolean('N')).IsTRUE;
    Test('WIDE.IsBoolean(''Y'')').Expect(WIDE.IsBoolean('Y')).IsTRUE;
    Test('WIDE.IsBoolean(''T'')').Expect(WIDE.IsBoolean('T')).IsFALSE;
    Test('WIDE.IsBoolean(''F'')').Expect(WIDE.IsBoolean('F')).IsFALSE;

    Test('WIDE.IsBoolean(''ok'')').Expect(WIDE.IsBoolean('ok')).IsTRUE;
    Test('WIDE.IsBoolean(''no'')').Expect(WIDE.IsBoolean('no')).IsTRUE;
    Test('WIDE.IsBoolean(''yes'')').Expect(WIDE.IsBoolean('yes')).IsTRUE;
    Test('WIDE.IsBoolean(''true'')').Expect(WIDE.IsBoolean('true')).IsTRUE;
    Test('WIDE.IsBoolean(''false'')').Expect(WIDE.IsBoolean('false')).IsTRUE;
    Test('WIDE.IsBoolean(''OK'')').Expect(WIDE.IsBoolean('OK')).IsTRUE;
    Test('WIDE.IsBoolean(''NO'')').Expect(WIDE.IsBoolean('NO')).IsTRUE;
    Test('WIDE.IsBoolean(''YES'')').Expect(WIDE.IsBoolean('YES')).IsTRUE;
    Test('WIDE.IsBoolean(''TRUE'')').Expect(WIDE.IsBoolean('TRUE')).IsTRUE;
    Test('WIDE.IsBoolean(''FALSE'')').Expect(WIDE.IsBoolean('FALSE')).IsTRUE;

    Test('WIDE.AsBoolean(''0'')').Expect(WIDE.AsBoolean('0')).IsFALSE;
    Test('WIDE.AsBoolean(''1'')').Expect(WIDE.AsBoolean('1')).IsTRUE;
    Test('WIDE.AsBoolean(''-1'')').Expect(WIDE.AsBoolean('-1')).IsTRUE;
    Test('WIDE.AsBoolean(''n'')').Expect(WIDE.AsBoolean('n')).IsFALSE;
    Test('WIDE.AsBoolean(''y'')').Expect(WIDE.AsBoolean('y')).IsTRUE;
    Test('WIDE.AsBoolean(''N'')').Expect(WIDE.AsBoolean('N')).IsFALSE;
    Test('WIDE.AsBoolean(''Y'')').Expect(WIDE.AsBoolean('Y')).IsTRUE;

    Test('WIDE.AsBoolean(''ok'')').Expect(WIDE.AsBoolean('ok')).IsTRUE;
    Test('WIDE.AsBoolean(''no'')').Expect(WIDE.AsBoolean('no')).IsFALSE;
    Test('WIDE.AsBoolean(''yes'')').Expect(WIDE.AsBoolean('yes')).IsTRUE;
    Test('WIDE.AsBoolean(''true'')').Expect(WIDE.AsBoolean('true')).IsTRUE;
    Test('WIDE.AsBoolean(''false'')').Expect(WIDE.AsBoolean('false')).IsFALSE;
    Test('WIDE.AsBoolean(''OK'')').Expect(WIDE.AsBoolean('OK')).IsTRUE;
    Test('WIDE.AsBoolean(''NO'')').Expect(WIDE.AsBoolean('NO')).IsFALSE;
    Test('WIDE.AsBoolean(''YES'')').Expect(WIDE.AsBoolean('YES')).IsTRUE;
    Test('WIDE.AsBoolean(''TRUE'')').Expect(WIDE.AsBoolean('TRUE')).IsTRUE;
    Test('WIDE.AsBoolean(''FALSE'')').Expect(WIDE.AsBoolean('FALSE')).IsFALSE;

    try
      Test('WIDE.AsBoolean(''roger'')').Expect(WIDE.AsBoolean('roger'));

    except
      Test.Expecting(EConvertError);
    end;

  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsInteger;
  begin
    Note('Basic signed and unsigned decimal tests');

    Test('WIDE.IsInteger('''')').Expect(WIDE.IsInteger('')).IsFALSE;
    Test('WIDE.IsInteger(''abc'')').Expect(WIDE.IsInteger('abc')).IsFALSE;
    Test('WIDE.IsInteger(''1.'')').Expect(WIDE.IsInteger('')).IsFALSE;
    Test('WIDE.IsInteger(''.1'')').Expect(WIDE.IsInteger('')).IsFALSE;
    Test('WIDE.IsInteger(''1.0'')').Expect(WIDE.IsInteger('')).IsFALSE;

    Test('WIDE.IsInteger(''11'')').Expect(WIDE.IsInteger('11')).IsTRUE;
    Test('WIDE.IsInteger(''+11'')').Expect(WIDE.IsInteger('+11')).IsTRUE;
    Test('WIDE.IsInteger(''-11'')').Expect(WIDE.IsInteger('-11')).IsTRUE;

    Test('WIDE.IsInteger('' 11'')').Expect(WIDE.IsInteger(' 11')).IsTRUE;
    Test('WIDE.IsInteger(''11 '')').Expect(WIDE.IsInteger('11 ')).IsTRUE;
    Test('WIDE.IsInteger('' 11 '')').Expect(WIDE.IsInteger(' 11 ')).IsTRUE;

    Test('WIDE.IsInteger('' +11'')').Expect(WIDE.IsInteger(' +11')).IsTRUE;
    Test('WIDE.IsInteger(''+11 '')').Expect(WIDE.IsInteger('+11 ')).IsTRUE;
    Test('WIDE.IsInteger('' +11 '')').Expect(WIDE.IsInteger(' +11 ')).IsTRUE;

    Test('WIDE.IsInteger('' -11'')').Expect(WIDE.IsInteger(' -11')).IsTRUE;
    Test('WIDE.IsInteger(''-11 '')').Expect(WIDE.IsInteger('-11 ')).IsTRUE;
    Test('WIDE.IsInteger('' -11 '')').Expect(WIDE.IsInteger(' -11 ')).IsTRUE;

    // Not ideal, but in the interests of efficiency we do not support
    //  thousands separators (which is also consistent with StrToInt):

    Test('WIDE.IsInteger(''1,000'')').Expect(WIDE.IsInteger('')).IsFALSE;

    Note('Test Binary notation support');

    Test('WIDE.AsInteger(''%01'')').Expect(WIDE.AsInteger('%01')).Equals(1);
    Test('WIDE.AsInteger(''%10'')').Expect(WIDE.AsInteger('%10')).Equals(2);
    Test('WIDE.IsInteger(''%2'')').Expect(WIDE.IsInteger('%2')).IsFALSE;

    Test('WIDE.AsInteger(''0b01'')').Expect(WIDE.AsInteger('0b01')).Equals(1);
    Test('WIDE.AsInteger(''0b10'')').Expect(WIDE.AsInteger('0b10')).Equals(2);
    Test('WIDE.IsInteger(''0b2'')').Expect(WIDE.IsInteger('0b2')).IsFALSE;

    Note('Test Octal notation support');

    Test('WIDE.AsInteger(''&01'')').Expect(WIDE.AsInteger('&01')).Equals(1);
    Test('WIDE.AsInteger(''&10'')').Expect(WIDE.AsInteger('&10')).Equals(8);
    Test('WIDE.IsInteger(''&8'')').Expect(WIDE.IsInteger('&8')).IsFALSE;

    Test('WIDE.AsInteger(''0o01'')').Expect(WIDE.AsInteger('0o01')).Equals(1);
    Test('WIDE.AsInteger(''0o10'')').Expect(WIDE.AsInteger('0o10')).Equals(8);
    Test('WIDE.IsInteger(''0o8'')').Expect(WIDE.IsInteger('0o8')).IsFALSE;

    Note('Test Unsigned Decimal notation support');

    Test('WIDE.AsInteger(''#01'')').Expect(WIDE.AsInteger('#01')).Equals(1);
    Test('WIDE.AsInteger(''#10'')').Expect(WIDE.AsInteger('#10')).Equals(10);
    Test('WIDE.IsInteger(''#-1'')').Expect(WIDE.IsInteger('#-1')).IsFALSE;

    Test('WIDE.AsInteger(''0o01'')').Expect(WIDE.AsInteger('0o01')).Equals(1);
    Test('WIDE.AsInteger(''0o10'')').Expect(WIDE.AsInteger('0o10')).Equals(8);
    Test('WIDE.IsInteger(''0o8'')').Expect(WIDE.IsInteger('0o8')).IsFALSE;

    Note('Test Hex notation support');

    Test('WIDE.AsInteger(''$01'')').Expect(WIDE.AsInteger('$01')).Equals(1);
    Test('WIDE.AsInteger(''$a'')').Expect(WIDE.AsInteger('$a')).Equals(10);
    Test('WIDE.AsInteger(''$A'')').Expect(WIDE.AsInteger('$A')).Equals(10);
    Test('WIDE.AsInteger(''$ff'')').Expect(WIDE.AsInteger('$ff')).Equals(255);
    Test('WIDE.IsInteger(''$z'')').Expect(WIDE.IsInteger('$z')).IsFALSE;

    Test('WIDE.AsInteger(''0x01'')').Expect(WIDE.AsInteger('0x01')).Equals(1);
    Test('WIDE.AsInteger(''0xa'')').Expect(WIDE.AsInteger('0xa')).Equals(10);
    Test('WIDE.AsInteger(''0xA'')').Expect(WIDE.AsInteger('0xA')).Equals(10);
    Test('WIDE.AsInteger(''0xff'')').Expect(WIDE.AsInteger('0xff')).Equals(255);
    Test('WIDE.IsInteger(''0xz'')').Expect(WIDE.IsInteger('0xz')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsEmpty;
  begin
    Test('WIDE.IsEmpty(''a'')').Expect(WIDE.IsEmpty('a')).IsFALSE;
    Test('WIDE.IsEmpty('''')').Expect(WIDE.IsEmpty('')).IsTRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsLowercase;
  const
    CHARS : array[0..6] of WIDEChar   = ('a', 'â',                         {} 'A', 'Â', '1', '?', '™');
    STRS  : array[0..8] of WIDEString = ('abc', 'a1', 'âbc?', 'windows™',  {} 'ABC', 'A1', 'ABC?', 'Windows™', '');
    LAST_LOWER_CHAR = 1;
    LAST_LOWER_STR  = 3;
  var
    i: Integer;
  begin
    for i := Low(CHARS) to High(CHARS) do
      Test('WIDE.IsLowercase(%s)', [CHARS[i]]).Expect(WIDE.IsLowercase(CHARS[i])).Equals(i <= LAST_LOWER_CHAR);

    for i := Low(STRS) to High(STRS) do
      Test('WIDE.IsLowercase(%s)', [STRS[i]]).Expect(WIDE.IsLowercase(STRS[i])).Equals(i <= LAST_LOWER_STR);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsNull;
  begin
    Test('WIDE.IsNull(''a'')').Expect(WIDE.IsNull('a')).IsFALSE;
    Test('WIDE.IsNull('' '')').Expect(WIDE.IsNull(' ')).IsFALSE;
    Test('WIDE.IsNull#0)').Expect(WIDE.IsNull(#0)).IsTRUE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsNumeric;
  begin
    Test('WIDE.IsNumeric(''a'')').Expect(WIDE.IsNumeric('a')).IsFALSE;
    Test('WIDE.IsNumeric(''é'')').Expect(WIDE.IsNumeric('é')).IsFALSE;
    Test('WIDE.IsNumeric(''A'')').Expect(WIDE.IsNumeric('A')).IsFALSE;
    Test('WIDE.IsNumeric(''1'')').Expect(WIDE.IsNumeric('1')).IsTRUE;
    Test('WIDE.IsNumeric('''')').Expect(WIDE.IsNumeric('')).IsFALSE;
    Test('WIDE.IsNumeric(''+123'')').Expect(WIDE.IsNumeric('+123')).IsFALSE;
    Test('WIDE.IsNumeric(''123'')').Expect(WIDE.IsNumeric('123')).IsTRUE;
    Test('WIDE.IsNumeric(''123.1'')').Expect(WIDE.IsNumeric('123.1')).IsFALSE;
    Test('WIDE.IsNumeric(''BBC1'')').Expect(WIDE.IsNumeric('BBC1')).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_IsUppercase;
  const
    CHARS : array[0..6] of WIDEChar   = ('A', 'Â',                         {} 'a', 'â', '1', '?', '™');
    STRS  : array[0..8] of WIDEString = ('ABC', 'A1', 'ÂBC?', 'WINDOWS™',  {} 'abc', 'a1', 'abc?', 'Windows™', '');
    LAST_UPPER_CHAR = 1;
    LAST_UPPER_STR  = 3;
  var
    i: Integer;
  begin
    for i := Low(CHARS) to High(CHARS) do
      Test('WIDE.IsUppercase(%s)', [CHARS[i]]).Expect(WIDE.IsUppercase(CHARS[i])).Equals(i <= LAST_UPPER_CHAR);

    for i := Low(STRS) to High(STRS) do
      Test('WIDE.IsUppercase(%s)', [STRS[i]]).Expect(WIDE.IsUppercase(STRS[i])).Equals(i <= LAST_UPPER_STR);
  end;



















  procedure TWIDETests.fn_Compare;
  begin
    Test('WIDE.Compare(a, A)').Expect(WIDE.Compare('a', 'A')).LessThan(0);
    Test('WIDE.Compare(A, a)').Expect(WIDE.Compare('A', 'a')).GreaterThan(0);
    Test('WIDE.Compare(a, a)').Expect(WIDE.Compare('a', 'a')).Equals(0);

    Test('WIDE.Compare(c, A)').Expect(WIDE.Compare('c', 'A')).Equals(1);
    Test('WIDE.Compare(c, a)').Expect(WIDE.Compare('c', 'a')).Equals(1);
    Test('WIDE.Compare(a, c)').Expect(WIDE.Compare('a', 'c')).Equals(-1);
    Test('WIDE.Compare(A, c)').Expect(WIDE.Compare('A', 'c')).Equals(-1);

    Test('WIDE.Compare(a, A, csIgnoreCase)').Expect(WIDE.Compare('a', 'A', csIgnoreCase)).Equals(0);
    Test('WIDE.Compare(A, a, csIgnoreCase)').Expect(WIDE.Compare('A', 'a', csIgnoreCase)).Equals(0);
    Test('WIDE.Compare(a, a, csIgnoreCase)').Expect(WIDE.Compare('a', 'a', csIgnoreCase)).Equals(0);

    Test('WIDE.CompareText(c, A)').Expect(WIDE.CompareText('c', 'A')).Equals(isGreater);
    Test('WIDE.CompareText(c, a)').Expect(WIDE.CompareText('c', 'a')).Equals(isGreater);
    Test('WIDE.CompareText(a, c)').Expect(WIDE.CompareText('a', 'c')).Equals(isLesser);
    Test('WIDE.CompareText(A, c)').Expect(WIDE.CompareText('A', 'c')).Equals(isLesser);

    Test('WIDE.CompareText(cba, ABC)').Expect(WIDE.CompareText('cba', 'ABC')).Equals(isGreater);
    Test('WIDE.CompareText(cba, abc)').Expect(WIDE.CompareText('cba', 'abc')).Equals(isGreater);
    Test('WIDE.CompareText(abc, cba)').Expect(WIDE.CompareText('abc', 'cba')).Equals(isLesser);
    Test('WIDE.CompareText(ABC, cba)').Expect(WIDE.CompareText('ABC', 'cba')).Equals(isLesser);

    Test('WIDE.CompareText(a, A)').Expect(WIDE.CompareText('a', 'A')).Equals(isEqual);
    Test('WIDE.CompareText(A, a)').Expect(WIDE.CompareText('A', 'a')).Equals(isEqual);
    Test('WIDE.CompareText(a, a)').Expect(WIDE.CompareText('a', 'a')).Equals(isEqual);

    Test('WIDE.CompareText(abc, abc)').Expect(WIDE.CompareText('abc', 'abc')).Equals(isEqual);
    Test('WIDE.CompareText(abc, ABC)').Expect(WIDE.CompareText('abc', 'ABC')).Equals(isEqual);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_MatchesAny;
  begin
    Test('WIDE.MatchesAny(''abc'', [''abc'', ''def''])').Expect(WIDE.MatchesAny('abc', ['abc', 'def'])).IsTRUE;
    Test('WIDE.MatchesAny(''abc'', [''abcdef'', ''def''])').Expect(WIDE.MatchesAny('abc', ['abcdef', 'def'])).IsFALSE;
    Test('WIDE.MatchesAny('''', [''abc'', ''def''])').Expect(WIDE.MatchesAny('', ['abc', 'def'])).IsFALSE;
    Test('WIDE.MatchesAny(''abc'', ['' abc '', ''def''])').Expect(WIDE.MatchesAny('abc', [' abc ', 'def'])).IsFALSE;

    Test('WIDE.MatchesAnyText(''abc'', [''abc'', ''def''])').Expect(WIDE.MatchesAnyText('abc', ['abc', 'def'])).IsTRUE;
    Test('WIDE.MatchesAnyText(''abc'', [''ABC'', ''DEF''])').Expect(WIDE.MatchesAnyText('abc', ['ABC', 'DEF'])).IsTRUE;
    Test('WIDE.MatchesAnyText('''', [''abc'', ''def''])').Expect(WIDE.MatchesAnyText('', ['abc', 'def'])).IsFALSE;
    Test('WIDE.MatchesAnyText(''abc'', [''def'', ''ghi''])').Expect(WIDE.MatchesAnyText('abc', ['def', 'ghi'])).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_SameString;
  const
    TRUE_CASES: array[0..3] of TWIDEStringAB = (
                                                (A: '';                    B: ''),
                                                (A: 'Mixed Case';           B: 'Mixed Case'),
                                                (A: '*not uppercase*';     B: '*not uppercase*'),
                                                (A: 'Microsoft Windows™';  B: 'Microsoft Windows™')
                                               );
    FALSE_CASES: array[0..3] of TWIDEStringAB = (
                                                 (A: '';                    B: ' '),
                                                 (A: 'LowerCase';           B: 'lowercase'),
                                                 (A: '*NOT UPPERCASE*';     B: '*not uppercase*'),
                                                 (A: 'Microsoft Windows™';  B: 'microsoft Windows™')
                                                );
  var
    i: Integer;
  begin
    for i := 0 to High(TRUE_CASES) do
      with TRUE_CASES[i] do
        Test('WIDE.SameString(%s, %s)', [A, B]).Expect(WIDE.SameString(A, B)).IsTRUE;

    for i := 0 to High(FALSE_CASES) do
      with FALSE_CASES[i] do
        Test('WIDE.SameString(%s, %s)', [A, B]).Expect(WIDE.SameString(A, B)).IsFALSE;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_SameText;
  const
    TRUE_CASES: array[0..3] of TWIDEStringAB = (
                                                (A: '';                    B: ''),
                                                (A: 'LowerCase';           B: 'lowercase'),
                                                (A: '*NOT UPPERCASE*';     B: '*not uppercase*'),
                                                (A: 'Microsoft Windows™';  B: 'microsoft windows™')
                                               );
    FALSE_CASES: array[0..3] of TWIDEStringAB = (
                                                 (A: '';                    B: ' '),
                                                 (A: 'LowerCase';           B: 'lower-case'),
                                                 (A: '*NOT UPPERCASE*';     B: 'not uppercase'),
                                                 (A: 'Microsoft Windows™';  B: 'microsoft word™')
                                                );
  var
    i: Integer;
  begin
    for i := 0 to High(TRUE_CASES) do
      with TRUE_CASES[i] do
        Test('WIDE.SameText(%s, %s)', [A, B]).Expect(WIDE.SameText(A, B)).IsTRUE;

    for i := 0 to High(FALSE_CASES) do
      with FALSE_CASES[i] do
        Test('WIDE.SameText(%s, %s)', [A, B]).Expect(WIDE.SameText(A, B)).IsFALSE;
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Camelcase;
  begin
    Test('WIDE.Camelcase(''This is a test'')').Expect(WIDE.Camelcase('This is a test')).Equals('ThisIsATest');
    Test('WIDE.Camelcase(''  This  is  a test  '')').Expect(WIDE.Camelcase('  This  is  a test  ')).Equals('ThisIsATest');
    Test('WIDE.Camelcase(''abc'')').Expect(WIDE.Camelcase('abc')).Equals('Abc');
    Test('WIDE.Camelcase('' abc '')').Expect(WIDE.Camelcase(' abc ')).Equals('Abc');
    Test('WIDE.Camelcase('''')').Expect(WIDE.Camelcase('')).Equals('');
    Test('WIDE.Camelcase(''  '')').Expect(WIDE.Camelcase('  ')).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Lowercase;
  begin
    Test('WIDE.Lowercase(a)').Expect(WIDE.Lowercase('a')).Equals('a');
    Test('WIDE.Lowercase(A)').Expect(WIDE.Lowercase('A')).Equals('a');
    Test('WIDE.Lowercase(1)').Expect(WIDE.Lowercase('1')).Equals('1');
    Test('WIDE.Lowercase(?)').Expect(WIDE.Lowercase('?')).Equals('?');
    Test('WIDE.Lowercase(™)').Expect(WIDE.Lowercase('™')).Equals('™');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Skewercase;
  begin
    Test('WIDE.Skewercase(''This is a test'')').Expect(WIDE.Skewercase('This is a test')).Equals('This-is-a-test');
    Test('WIDE.Skewercase(''  This  is  a test  '')').Expect(WIDE.Skewercase('  This  is  a test  ')).Equals('This-is-a-test');
    Test('WIDE.Skewercase(''abc'')').Expect(WIDE.Skewercase('abc')).Equals('abc');
    Test('WIDE.Skewercase('' abc '')').Expect(WIDE.Skewercase(' abc ')).Equals('abc');
    Test('WIDE.Skewercase('''')').Expect(WIDE.Skewercase('')).Equals('');
    Test('WIDE.Skewercase(''  '')').Expect(WIDE.Skewercase('  ')).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Snakecase;
  begin
    Test('WIDE.Snakecase(''This is a test'')').Expect(WIDE.Snakecase('This is a test')).Equals('This_is_a_test');
    Test('WIDE.Snakecase(''  This  is  a test  '')').Expect(WIDE.Snakecase('  This  is  a test  ')).Equals('This_is_a_test');
    Test('WIDE.Snakecase(''abc'')').Expect(WIDE.Snakecase('abc')).Equals('abc');
    Test('WIDE.Snakecase('' abc '')').Expect(WIDE.Snakecase(' abc ')).Equals('abc');
    Test('WIDE.Snakecase('''')').Expect(WIDE.Snakecase('')).Equals('');
    Test('WIDE.Snakecase(''  '')').Expect(WIDE.Snakecase('  ')).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Startcase;
  begin
    Test('WIDE.Startcase(''This is a test'')').Expect(WIDE.Startcase('This is a test')).Equals('This Is A Test');
    Test('WIDE.Startcase(''  This is a test  '')').Expect(WIDE.Startcase('  This is a test  ')).Equals('  This Is A Test  ');
    Test('WIDE.Startcase(''abc'')').Expect(WIDE.Startcase('abc')).Equals('Abc');
    Test('WIDE.Startcase('' abc '')').Expect(WIDE.Startcase(' abc ')).Equals(' Abc ');
    Test('WIDE.Startcase('''')').Expect(WIDE.Startcase('')).Equals('');
    Test('WIDE.Startcase(''  '')').Expect(WIDE.Startcase('  ')).Equals('  ');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Uppercase;
  begin
    Test('WIDE.Uppercase(a)').Expect(WIDE.Uppercase('a')).Equals('A');
    Test('WIDE.Uppercase(A)').Expect(WIDE.Uppercase('A')).Equals('A');
    Test('WIDE.Uppercase(1)').Expect(WIDE.Uppercase('1')).Equals('1');
    Test('WIDE.Uppercase(?)').Expect(WIDE.Uppercase('?')).Equals('?');
    Test('WIDE.Uppercase(™)').Expect(WIDE.Uppercase('™')).Equals('™');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_BeginsWith;
  begin
    Test('WIDE.BeginsWith(''abcdef'', ''a'')').Expect(WIDE.BeginsWith('abcdef', 'a')).IsTRUE;
    Test('WIDE.BeginsWith(''abcdef'', ''A'')').Expect(WIDE.BeginsWith('abcdef', 'A')).IsFALSE;
    Test('WIDE.BeginsWith(''abcdef'', ''b'')').Expect(WIDE.BeginsWith('abcdef', 'b')).IsFALSE;
    Test('WIDE.BeginsWith(''abcdef'', ''A'', csIgnoreCase)').Expect(WIDE.BeginsWith('abcdef', 'A', csIgnoreCase)).IsTRUE;
    Test('WIDE.BeginsWith(''abcdef'', ''B'', csIgnoreCase)').Expect(WIDE.BeginsWith('abcdef', 'B', csIgnoreCase)).IsFALSE;

    Test('WIDE.BeginsWith(''abcdef'', ''abc'')').Expect(WIDE.BeginsWith('abcdef', 'abc')).IsTRUE;
    Test('WIDE.BeginsWith(''abcdef'', ''ABC'')').Expect(WIDE.BeginsWith('abcdef', 'ABC')).IsFALSE;
    Test('WIDE.BeginsWith(''abcdef'', ''def'')').Expect(WIDE.BeginsWith('abcdef', 'def')).IsFALSE;

    Test('WIDE.BeginsWith(''abcdef'', ''abc'', csIgnoreCase)').Expect(WIDE.BeginsWith('abcdef', 'abc', csIgnoreCase)).IsTRUE;
    Test('WIDE.BeginsWith(''abcdef'', ''ABC'', csIgnoreCase)').Expect(WIDE.BeginsWith('abcdef', 'ABC', csIgnoreCase)).IsTRUE;

    Test('WIDE.BeginsWith('''', ''abc'')').Expect(WIDE.BeginsWith('', 'abc')).IsFALSE;

    try
      WIDE.BeginsWith('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('WIDE.BeginsWithText(''abcdef'', ''a'')').Expect(WIDE.BeginsWithText('abcdef', 'a')).IsTRUE;
    Test('WIDE.BeginsWithText(''abcdef'', ''A'')').Expect(WIDE.BeginsWithText('abcdef', 'A')).IsTRUE;
    Test('WIDE.BeginsWithText(''abcdef'', ''b'')').Expect(WIDE.BeginsWithText('abcdef', 'b')).IsFALSE;
    Test('WIDE.BeginsWithText(''abcdef'', ''B'')').Expect(WIDE.BeginsWithText('abcdef', 'B')).IsFALSE;

    Test('WIDE.BeginsWithText(''abcdef'', ''abc'')').Expect(WIDE.BeginsWithText('abcdef', 'abc')).IsTRUE;
    Test('WIDE.BeginsWithText(''abcdef'', ''ABC'')').Expect(WIDE.BeginsWithText('abcdef', 'ABC')).IsTRUE;
    Test('WIDE.BeginsWithText(''abcdef'', ''def'')').Expect(WIDE.BeginsWithText('abcdef', 'def')).IsFALSE;

    Test('WIDE.BeginsWithText('''', ''abc'')').Expect(WIDE.BeginsWithText('', 'abc')).IsFALSE;

    try
      WIDE.BeginsWithText('abcdef', #0);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    try
      WIDE.BeginsWithText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Contains;
  begin
    Test('WIDE.Contains(''abcdef'', ''cd'')').Expect(WIDE.Contains('abcdef', 'cd')).IsTRUE;
    Test('WIDE.Contains(''abcdef'', ''CD'')').Expect(WIDE.Contains('abcdef', 'CD')).IsFALSE;
    Test('WIDE.Contains(''abcdef'', ''lp'')').Expect(WIDE.Contains('abcdef', 'lp')).IsFALSE;

    Test('WIDE.Contains(''abcdef'', ''cd'', csIgnoreCase)').Expect(WIDE.Contains('abcdef', 'cd', csIgnoreCase)).IsTRUE;
    Test('WIDE.Contains(''abcdef'', ''CD'', csIgnoreCase)').Expect(WIDE.Contains('abcdef', 'CD', csIgnoreCase)).IsTRUE;

    Test('WIDE.Contains('''', ''cd'')').Expect(WIDE.Contains('', 'cd')).IsFALSE;

    try
      WIDE.Contains('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('WIDE.ContainsText(''abcdef'', ''cd'')').Expect(WIDE.ContainsText('abcdef', 'cd')).IsTRUE;
    Test('WIDE.ContainsText(''abcdef'', ''CD'')').Expect(WIDE.ContainsText('abcdef', 'CD')).IsTRUE;
    Test('WIDE.ContainsText(''abcdef'', ''lp'')').Expect(WIDE.ContainsText('abcdef', 'lp')).IsFALSE;

    Test('WIDE.ContainsText('''', ''cd'')').Expect(WIDE.ContainsText('', 'cd')).IsFALSE;

    try
      WIDE.ContainsText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_EndsWith;
  begin
    Test('WIDE.EndsWith(''abcdef'', ''def'')').Expect(WIDE.EndsWith('abcdef', 'def')).IsTRUE;
    Test('WIDE.EndsWith(''abcdef'', ''DEF'')').Expect(WIDE.EndsWith('abcdef', 'DEF')).IsFALSE;
    Test('WIDE.EndsWith(''abcdef'', ''abc'')').Expect(WIDE.EndsWith('abcdef', 'abc')).IsFALSE;

    Test('WIDE.EndsWith(''abcdef'', ''def'', csIgnoreCase)').Expect(WIDE.EndsWith('abcdef', 'def', csIgnoreCase)).IsTRUE;
    Test('WIDE.EndsWith(''abcdef'', ''DEF'', csIgnoreCase)').Expect(WIDE.EndsWith('abcdef', 'DEF', csIgnoreCase)).IsTRUE;

    Test('WIDE.EndsWith('''', ''def'')').Expect(WIDE.EndsWith('', 'def')).IsFALSE;

    try
      WIDE.EndsWith('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;

    Test('WIDE.EndsWithText(''abcdef'', ''def'')').Expect(WIDE.EndsWithText('abcdef', 'def')).IsTRUE;
    Test('WIDE.EndsWithText(''abcdef'', ''DEF'')').Expect(WIDE.EndsWithText('abcdef', 'DEF')).IsTRUE;
    Test('WIDE.EndsWithText(''abcdef'', ''abc'')').Expect(WIDE.EndsWithText('abcdef', 'abc')).IsFALSE;

    Test('WIDE.EndsWithText('''', ''def'')').Expect(WIDE.EndsWithText('', 'def')).IsFALSE;

    try
      WIDE.EndsWithText('abcdef', '');
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;



































  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Find;
  const
    STR : UnicodeString  = 'abcdefghiabc';
    f   : WIDEChar    = 'f';
    G   : WIDEChar    = 'G';
    z   : WIDEChar    = 'z';
    def : UnicodeString  = 'def';
    GHI : UnicodeString  = 'GHI';
    xyz : UnicodeString  = 'xyz';
  var
    p: Integer;
  begin
  // Find Char tests

    // Tests that Find always starts at the beginning of the string (initial p value is ignored)
    //  i.e. "Find"= "FindFirst"

    p := 8;
    Test('WIDE.Find(%s, %s, p [=8])!', [STR, f]).Expect(WIDE.Find(STR, f, p)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    // Tests that Find is case-sensitive (by default)

    Test('WIDE.Find(%s, %s, POS)!', [STR, f]).Expect(WIDE.Find(STR, f, p)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    Test('WIDE.Find(%s, %s, POS)!', [STR, G]).Expect(WIDE.Find(STR, G, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    // Tests that Find does not find things that aren't there

    Test('WIDE.Find(%s, %s, POS)!', [STR, z]).Expect(WIDE.Find(STR, z, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    // Tests that Find can be used without case-sentivity

    Test('WIDE.Find(%s, %s, POS, csIgnoreCase)!', [STR, f]).Expect(WIDE.Find(STR, f, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(6);

    Test('WIDE.Find(%s, %s, POS, csIgnoreCase)!', [STR, G]).Expect(WIDE.Find(STR, G, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

  // Find String tests

    Test('WIDE.Find(%s, %s, POS)!', [STR, def]).Expect(WIDE.Find(STR, def, p)).IsTRUE;
    Test('POS').Expect(p).Equals(4);

    Test('WIDE.Find(%s, %s, POS)!', [STR, GHI]).Expect(WIDE.Find(STR, GHI, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    Test('WIDE.Find(%s, %s, POS)!', [STR, xyz]).Expect(WIDE.Find(STR, xyz, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

    Test('WIDE.Find(%s, %s, POS, csIgnoreCase)!', [STR, def]).Expect(WIDE.Find(STR, def, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(4);

    Test('WIDE.Find(%s, %s, POS, csIgnoreCase)!', [STR, GHI]).Expect(WIDE.Find(STR, GHI, p, csIgnoreCase)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

  // Find Char tests

    Test('WIDE.FindText(%s, %s, POS)!', [STR, G]).Expect(WIDE.FindText(STR, G, p)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

    Test('WIDE.FindText(%s, %s, POS)!', [STR, z]).Expect(WIDE.FindText(STR, z, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);

  // Find String tests

    Test('WIDE.FindText(%s, %s, POS)!', [STR, GHI]).Expect(WIDE.FindText(STR, GHI, p)).IsTRUE;
    Test('POS').Expect(p).Equals(7);

    Test('WIDE.FindText(%s, %s, POS)!', [STR, xyz]).Expect(WIDE.FindText(STR, xyz, p)).IsFALSE;
    Test('POS').Expect(p).Equals(0);
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_FindNext;
  const              // 0    .    1
    STR : UnicodeString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
  // FindNext Char tests

    p := 0;
    Test('WIDE.FindNext(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNext(''%s'', ''a'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('WIDE.FindNext(''%s'', ''a'', p [=20]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'a', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''a'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('WIDE.FindNext(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'A', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('WIDE.FindNext(''%s'', ''A'', p [=5]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'A', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''A'', p [=5]) [p]!', [STR]).Expect(p).Equals(0);

    p := 1;
    Test('WIDE.FindNext(''%s'', ''z'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'z', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''z'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('WIDE.FindNext(''%s'', ''a'', p [=5]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'a', p, csIgnoreCase)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''a'', p [=5]) [p]!', [STR]).Expect(p).Equals(10);

    p := 5;
    Test('WIDE.FindNext(''%s'', ''A'', p [=5]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'A', p, csIgnoreCase)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''A'', p [=5]) [p]!', [STR]).Expect(p).Equals(10);

  // FindNext String tests

    p := 0;
    Test('WIDE.FindNext(''%s'', ''abc'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'abc', p)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''abc'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNext(''%s'', ''abc'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'abc', p)).IsTRUE;
    Test('WIDE.FindNext(''%s'', ''abc'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('WIDE.FindNext(''%s'', ''abc'', p [=20]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'abc', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''abc'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('WIDE.FindNext(''%s'', ''ABC'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'ABC', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''ABC'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 5;
    Test('WIDE.FindNext(''%s'', ''ABC'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'ABC', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''ABC'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    p := 1;
    Test('WIDE.FindNext(''%s'', ''xyz'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNext(STR, 'xyz', p)).IsFALSE;
    Test('WIDE.FindNext(''%s'', ''xyz'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    try
      WIDE.FindNext(STR, #0, p);
      Test('WIDE.FindNext(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindNext(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindNext(STR, '', p);
      Test('WIDE.FindNext(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindNext(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindNextText Char tests

    p := 0;
    Test('WIDE.FindNextText(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNextText(''%s'', ''a'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('WIDE.FindNextText(''%s'', ''a'', p [=20]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'a', p)).IsFALSE;
    Test('WIDE.FindNextText(''%s'', ''a'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('WIDE.FindNextText(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'A', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNextText(''%s'', ''A'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'A', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''A'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 1;
    Test('WIDE.FindNextText(''%s'', ''z'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'z', p)).IsFALSE;
    Test('WIDE.FindNextText(''%s'', ''z'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

  // FindNextText String tests

    p := 0;
    Test('WIDE.FindNextText(''%s'', ''abc'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'abc', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''abc'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNextText(''%s'', ''abc'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'abc', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''abc'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 20;
    Test('WIDE.FindNextText(''%s'', ''abc'', p [=20]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'abc', p)).IsFALSE;
    Test('WIDE.FindNextText(''%s'', ''abc'', p [=20]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;
    Test('WIDE.FindNextText(''%s'', ''ABC'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'ABC', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''ABC'', p [=0]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindNextText(''%s'', ''ABC'', p [=1]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'ABC', p)).IsTRUE;
    Test('WIDE.FindNextText(''%s'', ''ABC'', p [=1]) [p]!', [STR]).Expect(p).Equals(10);

    p := 1;
    Test('WIDE.FindNextText(''%s'', ''xyz'', p [=0]) [result]!', [STR]).Expect(WIDE.FindNextText(STR, 'xyz', p)).IsFALSE;
    Test('WIDE.FindNextText(''%s'', ''xyz'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 0;

    try
      WIDE.FindNextText(STR, #0, p);
      Test('WIDE.FindNextText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindNextText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindNextText(STR, '', p);
      Test('WIDE.FindNextText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindNextText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_FindPrevious;
  const              // 0    .    1
    STR : UnicodeString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
  // FindPrevious Char tests

    p := 0;
    Test('WIDE.FindPrevious(''%s'', ''a'', p [=0]) [result]!', [STR]).Expect(WIDE.FindPrevious(STR, 'a', p)).IsFALSE;
    Test('WIDE.FindPrevious(''%s'', ''a'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('WIDE.FindPrevious(''aaa'', ''A'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'A', p)).IsFALSE;
    Test('WIDE.FindPrevious(''aaa'', ''A, p [=4]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=3]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=3]) [p]!', [STR]).Expect(p).Equals(2);

    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=2]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'a', p)).IsTRUE;
    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=1]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'a', p)).IsFALSE;
    Test('WIDE.FindPrevious(''aaa'', ''a'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

  // FindNext Substring tests

    p := 4;
    Test('WIDE.FindPrevious(''aaa'', ''AA'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'AA', p)).IsFALSE;
    Test('WIDE.FindPrevious(''aaa'', ''AA'', p [=4]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'aa', p)).IsTRUE;
    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=4]) [p]!', [STR]).Expect(p).Equals(2);

    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=2]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'aa', p)).IsTRUE;
    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=1]) [result]!', [STR]).Expect(WIDE.FindPrevious('aaa', 'aa', p)).IsFALSE;
    Test('WIDE.FindPrevious(''aaa'', ''aa'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    try
      WIDE.FindPrevious(STR, #0, p);
      Test('WIDE.FindPrevious(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindPrevious(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindPrevious(STR, '', p);
      Test('WIDE.FindPrevious(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindPrevious(STR, '''', p)').Expecting(EContractViolation);
    end;


  // FindPreviousText Char tests

    p := 0;
    Test('WIDE.FindPreviousText(''%s'', ''A'', p [=0]) [result]!', [STR]).Expect(WIDE.FindPreviousText(STR, 'A', p)).IsFALSE;
    Test('WIDE.FindPreviousText(''%s'', ''A'', p [=0]) [p]!', [STR]).Expect(p).Equals(0);

    p := 4;
    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    p := 4;
    Test('WIDE.FindPreviousText(''aaa'', ''a'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'a', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''a'', p [=4]) [p]!', [STR]).Expect(p).Equals(3);

    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=3]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=3]) [p]!', [STR]).Expect(p).Equals(2);

    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=2]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'A', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=1]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'A', p)).IsFALSE;
    Test('WIDE.FindPreviousText(''aaa'', ''A'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

  // FindPreviousText Substring tests

    p := 4;
    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=4]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'AA', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=4]) [p]!', [STR]).Expect(p).Equals(2);

    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=2]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'AA', p)).IsTRUE;
    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=2]) [p]!', [STR]).Expect(p).Equals(1);

    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=1]) [result]!', [STR]).Expect(WIDE.FindPreviousText('aaa', 'AA', p)).IsFALSE;
    Test('WIDE.FindPreviousText(''aaa'', ''AA'', p [=1]) [p]!', [STR]).Expect(p).Equals(0);

    try
      WIDE.FindPreviousText(STR, #0, p);
      Test('WIDE.FindPreviousText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindPreviousText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindPreviousText(STR, '', p);
      Test('WIDE.FindPreviousText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindPreviousText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_FindLast;
  const              // 0    .    1
    STR : UnicodeString  = 'abcdefghiabc';
  var
    p: Integer;
  begin
    // Tests that FindLast always starts at the end of the string

    p := 1;
    Test('WIDE.FindLast(str, ''f'', p [=1]) [result]').Expect(WIDE.FindLast(STR, 'f', p)).IsTRUE;
    Test('WIDE.FindLast(str, ''f'', p [=1]) [p]').Expect(p).Equals(6);

    Test('WIDE.FindLast(str, ''f'', p) [result]').Expect(WIDE.FindLast(STR, 'f', p)).IsTRUE;
    Test('WIDE.FindLast(str, ''f'', p) [p]').Expect(p).Equals(6);

    Test('WIDE.FindLast(str, ''a'', p) [result]').Expect(WIDE.FindLast(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindLast(str, ''a'', p) [p]').Expect(p).Equals(10);

    Test('WIDE.FindLast(str, ''F'', p) [result]').Expect(WIDE.FindLast(STR, 'F', p)).IsFALSE;
    Test('WIDE.FindLast(str, ''F'', p) [p]').Expect(p).Equals(0);

    Test('WIDE.FindLast(str, ''z'', p) [result]').Expect(WIDE.FindLast(STR, 'z', p)).IsFALSE;
    Test('WIDE.FindLast(str, ''z'', p) [p]').Expect(p).Equals(0);

    Test('WIDE.FindLast(str, ''f'', p, csIgnoreCase) [result]').Expect(WIDE.FindLast(STR, 'f', p, csIgnoreCase)).IsTRUE;
    Test('WIDE.FindLast(str, ''f'', p, csIgnoreCase) [p]').Expect(p).Equals(6);

    Test('WIDE.FindLast(str, ''F'', p, csIgnoreCase) [result]').Expect(WIDE.FindLast(STR, 'F', p, csIgnoreCase)).IsTRUE;
    Test('WIDE.FindLast(str, ''F'', p, csIgnoreCase) [p]').Expect(p).Equals(6);

    try
      WIDE.FindLast(STR, #0, p);
      Test('WIDE.FindLast(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindLast(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindLast(STR, '', p);
      Test('WIDE.FindLast(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindLast(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindLastText tests

    Test('WIDE.FindLastText(str, ''f'', p) [result]').Expect(WIDE.FindLastText(STR, 'f', p)).IsTRUE;
    Test('WIDE.FindLastText(str, ''f'', p) [p]').Expect(p).Equals(6);

    Test('WIDE.FindLastText(str, ''a'', p) [result]').Expect(WIDE.FindLastText(STR, 'a', p)).IsTRUE;
    Test('WIDE.FindLastText(str, ''a'', p) [p]').Expect(p).Equals(10);

    Test('WIDE.FindLastText(str, ''F'', p) [result]').Expect(WIDE.FindLastText(STR, 'F', p)).IsTRUE;
    Test('WIDE.FindLastText(str, ''F'', p) [p]').Expect(p).Equals(6);

    Test('WIDE.FindLastText(str, ''z'', p) [result]').Expect(WIDE.FindLastText(STR, 'z', p)).IsFALSE;
    Test('WIDE.FindLastText(str, ''z'', p) [p]').Expect(p).Equals(0);

    try
      WIDE.FindLastText(STR, #0, p);
      Test('WIDE.FindLastText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindLastText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindLastText(STR, '', p);
      Test('WIDE.FindLastText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindLastText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_FindAll;
  const  //    .    1    .    2    .    3    .    4    .    5
    STR = 'There once was a tiny shrew that lived in a shoe.';
  var
    p: TCharIndexArray;
  begin
    Test('WIDE.FindAll('''', ''a'', p) result').Expect(WIDE.FindAll('', 'a', p)).Equals(0);
    Test('WIDE.FindAll('''', ''a'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('WIDE.FindAll(STR, ''Z'', p) result').Expect(WIDE.FindAll(STR, 'Z', p)).Equals(0);
    Test('WIDE.FindAll(STR, ''Z'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('WIDE.FindAll(STR, ''T'', p) result').Expect(WIDE.FindAll(STR, 'T', p)).Equals(1);
    Test('WIDE.FindAll(STR, ''T'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('WIDE.FindAll(STR, ''T'', p) p[0]').Expect(p[0]).Equals(1);

    Test('WIDE.FindAll(STR, ''t'', p) result').Expect(WIDE.FindAll(STR, 't', p)).Equals(3);
    Test('WIDE.FindAll(STR, ''t'', p) length(p)').Expect(Length(p)).Equals(3);
    Test('WIDE.FindAll(STR, ''t'', p) p[0]').Expect(p[0]).Equals(18);
    Test('WIDE.FindAll(STR, ''t'', p) p[1]').Expect(p[1]).Equals(29);
    Test('WIDE.FindAll(STR, ''t'', p) p[2]').Expect(p[2]).Equals(32);

    Test('WIDE.FindAll(STR, ''.'', p) result').Expect(WIDE.FindAll(STR, '.', p)).Equals(1);
    Test('WIDE.FindAll(STR, ''.'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('WIDE.FindAll(STR, ''.'', p) p[0]').Expect(p[0]).Equals(49);

    Test('WIDE.FindAll(STR, ''e'', p) result').Expect(WIDE.FindAll(STR, 'e', p)).Equals(6);
    Test('WIDE.FindAll(STR, ''e'', p) length(p)').Expect(Length(p)).Equals(6);
    Test('WIDE.FindAll(STR, ''e'', p) p[0]').Expect(p[0]).Equals(3);
    Test('WIDE.FindAll(STR, ''e'', p) p[1]').Expect(p[1]).Equals(5);
    Test('WIDE.FindAll(STR, ''e'', p) p[2]').Expect(p[2]).Equals(10);
    Test('WIDE.FindAll(STR, ''e'', p) p[3]').Expect(p[3]).Equals(26);
    Test('WIDE.FindAll(STR, ''e'', p) p[4]').Expect(p[4]).Equals(37);
    Test('WIDE.FindAll(STR, ''e'', p) p[5]').Expect(p[5]).Equals(48);

    Test('WIDE.FindAll(STR, '' a '', p) result').Expect(WIDE.FindAll(STR, ' a ', p)).Equals(2);
    Test('WIDE.FindAll(STR, '' a '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('WIDE.FindAll(STR, '' a '', p) p[0]').Expect(p[0]).Equals(15);
    Test('WIDE.FindAll(STR, '' a '', p) p[1]').Expect(p[1]).Equals(42);

    Test('WIDE.FindAll(STR, '' A '', p) result').Expect(WIDE.FindAll(STR, ' A ', p)).Equals(0);
    Test('WIDE.FindAll(STR, '' A '', p) length(p)').Expect(Length(p)).Equals(0);

    try
      WIDE.FindAll(STR, #0, p);
      Test('WIDE.FindAll(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindAll(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindAll(STR, '', p);
      Test('WIDE.FindAll(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindAll(STR, '''', p)').Expecting(EContractViolation);
    end;

  // FindAllText

    Test('WIDE.FindAllText(STR, ''Z'', p) result').Expect(WIDE.FindAllText(STR, 'Z', p)).Equals(0);
    Test('WIDE.FindAllText(STR, ''Z'', p) length(p)').Expect(Length(p)).Equals(0);

    Test('WIDE.FindAllText(STR, ''T'', p) result').Expect(WIDE.FindAllText(STR, 'T', p)).Equals(4);
    Test('WIDE.FindAllText(STR, ''T'', p) length(p)').Expect(Length(p)).Equals(4);
    Test('WIDE.FindAllText(STR, ''T'', p) p[0]').Expect(p[0]).Equals(1);
    Test('WIDE.FindAllText(STR, ''T'', p) p[1]').Expect(p[1]).Equals(18);
    Test('WIDE.FindAllText(STR, ''T'', p) p[2]').Expect(p[2]).Equals(29);
    Test('WIDE.FindAllText(STR, ''T'', p) p[3]').Expect(p[3]).Equals(32);

    Test('WIDE.FindAllText(STR, ''t'', p) result').Expect(WIDE.FindAllText(STR, 't', p)).Equals(4);
    Test('WIDE.FindAllText(STR, ''t'', p) length(p)').Expect(Length(p)).Equals(4);
    Test('WIDE.FindAllText(STR, ''t'', p) p[0]').Expect(p[0]).Equals(1);
    Test('WIDE.FindAllText(STR, ''t'', p) p[1]').Expect(p[1]).Equals(18);
    Test('WIDE.FindAllText(STR, ''t'', p) p[2]').Expect(p[2]).Equals(29);
    Test('WIDE.FindAllText(STR, ''t'', p) p[3]').Expect(p[3]).Equals(32);

    Test('WIDE.FindAllText(STR, ''.'', p) result').Expect(WIDE.FindAllText(STR, '.', p)).Equals(1);
    Test('WIDE.FindAllText(STR, ''.'', p) length(p)').Expect(Length(p)).Equals(1);
    Test('WIDE.FindAllText(STR, ''.'', p) p[0]').Expect(p[0]).Equals(49);

    Test('WIDE.FindAllText(STR, '' a '', p) result').Expect(WIDE.FindAllText(STR, ' a ', p)).Equals(2);
    Test('WIDE.FindAllText(STR, '' a '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('WIDE.FindAllText(STR, '' a '', p) p[0]').Expect(p[0]).Equals(15);
    Test('WIDE.FindAllText(STR, '' a '', p) p[1]').Expect(p[1]).Equals(42);

    Test('WIDE.FindAllText(STR, '' A '', p) result').Expect(WIDE.FindAllText(STR, ' A ', p)).Equals(2);
    Test('WIDE.FindAllText(STR, '' A '', p) length(p)').Expect(Length(p)).Equals(2);
    Test('WIDE.FindAllText(STR, '' A '', p) p[0]').Expect(p[0]).Equals(15);
    Test('WIDE.FindAllText(STR, '' A '', p) p[1]').Expect(p[1]).Equals(42);

    try
      WIDE.FindAllText(STR, #0, p);
      Test('WIDE.FindAllText(STR, #0, p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindAllText(STR, #0, p)').Expecting(EContractViolation);
    end;

    try
      WIDE.FindAllText(STR, '', p);
      Test('WIDE.FindAllText(STR, '''', p)').Expecting(EContractViolation);
    except
      Test('WIDE.FindAllText(STR, '''', p)').Expecting(EContractViolation);
    end;
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Append;
  begin
    Test('WIDE.Append(''abc'', ''.'')').Expect(WIDE.Append('abc', '.')).Equals('abc.');
    Test('WIDE.Append('''', ''.'')').Expect(WIDE.Append('', '.')).Equals('.');

    Test('WIDE.Append(''abc'', ''def'')').Expect(WIDE.Append('abc', 'def')).Equals('abcdef');
    Test('WIDE.Append(''abc'', '''')').Expect(WIDE.Append('abc', '')).Equals('abc');
    Test('WIDE.Append('''', ''def'')').Expect(WIDE.Append('', 'def')).Equals('def');

    Test('WIDE.Append(''abc'', ''def'', ''/'')').Expect(WIDE.Append('abc', 'def', '/')).Equals('abc/def');
    Test('WIDE.Append(''abc'', '''', ''/'')').Expect(WIDE.Append('abc', '', '/')).Equals('abc');
    Test('WIDE.Append('''', ''def'', ''/'')').Expect(WIDE.Append('', 'def', '/')).Equals('def');

    Test('WIDE.Append(''abc'', ''def'', '' || '')').Expect(WIDE.Append('abc', 'def', ' || ')).Equals('abc || def');
    Test('WIDE.Append(''abc'', '''', '' || '')').Expect(WIDE.Append('abc', '', ' || ')).Equals('abc');
    Test('WIDE.Append('''', ''def'', '' || '')').Expect(WIDE.Append('', 'def', ' || ')).Equals('def');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Insert;
  begin
    Test('WIDE.Insert(''foobar'', 4, ''.'')').Expect(WIDE.Insert('foobar', 4, '.')).Equals('foo.bar');
    Test('WIDE.Insert(''foobar'', 0, ''.'')').Expect(WIDE.Insert('foobar', 0, '.')).Equals('foobar');
    Test('WIDE.Insert(''foobar'', 10, ''.'')').Expect(WIDE.Insert('foobar', 10, '.')).Equals('foobar');

    Test('WIDE.Insert(''foobar'', 4, ''.'', ''/'')').Expect(WIDE.Insert('foobar', 4, '.', '/')).Equals('foo/./bar');
    Test('WIDE.Insert(''foobar'', 0, ''.'', ''/'')').Expect(WIDE.Insert('foobar', 0, '.', '/')).Equals('foobar');
    Test('WIDE.Insert(''foobar'', 1, ''.'', ''/'')').Expect(WIDE.Insert('foobar', 1, '.', '/')).Equals('foobar');
    Test('WIDE.Insert(''foobar'', 6, ''.'', ''/'')').Expect(WIDE.Insert('foobar', 6, '.', '/')).Equals('fooba/./r');
    Test('WIDE.Insert(''foobar'', 10, ''.'', ''/'')').Expect(WIDE.Insert('foobar', 10, '.', '/')).Equals('foobar');

    Test('WIDE.Insert(''foobar'', 4, ''middle'', '' || '')').Expect(WIDE.Insert('foobar', 4, 'middle', ' || ')).Equals('foo || middle || bar');
    Test('WIDE.Insert(''foobar'', 0, ''middle'', '' || '')').Expect(WIDE.Insert('foobar', 0, 'middle', ' || ')).Equals('foobar');
    Test('WIDE.Insert(''foobar'', 1, ''middle'', '' || '')').Expect(WIDE.Insert('foobar', 1, 'middle', ' || ')).Equals('foobar');
    Test('WIDE.Insert(''foobar'', 6, ''middle'', '' || '')').Expect(WIDE.Insert('foobar', 6, 'middle', ' || ')).Equals('fooba || middle || r');
    Test('WIDE.Insert(''foobar'', 10, ''middle'', '' || '')').Expect(WIDE.Insert('foobar', 10, 'middle', ' || ')).Equals('foobar');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Prepend;
  begin
    Test('WIDE.Prepend(''abc'', ''.'')').Expect(WIDE.Prepend('abc', '.')).Equals('.abc');
    Test('WIDE.Prepend('''', ''.'')').Expect(WIDE.Prepend('', '.')).Equals('.');

    Test('WIDE.Prepend(''abc'', ''def'')').Expect(WIDE.Prepend('abc', 'def')).Equals('defabc');
    Test('WIDE.Prepend(''abc'', '''')').Expect(WIDE.Prepend('abc', '')).Equals('abc');
    Test('WIDE.Prepend('''', ''def'')').Expect(WIDE.Prepend('', 'def')).Equals('def');

    Test('WIDE.Prepend(''abc'', ''def'', ''/'')').Expect(WIDE.Prepend('abc', 'def', '/')).Equals('def/abc');
    Test('WIDE.Prepend(''abc'', '''', ''/'')').Expect(WIDE.Prepend('abc', '', '/')).Equals('abc');
    Test('WIDE.Prepend('''', ''def'', ''/'')').Expect(WIDE.Prepend('', 'def', '/')).Equals('def');

    Test('WIDE.Prepend(''abc'', ''def'', '' || '')').Expect(WIDE.Prepend('abc', 'def', ' || ')).Equals('def || abc');
    Test('WIDE.Prepend(''abc'', '''', '' || '')').Expect(WIDE.Prepend('abc', '', ' || ')).Equals('abc');
    Test('WIDE.Prepend('''', ''def'', '' || '')').Expect(WIDE.Prepend('', 'def', ' || ')).Equals('def');
  end;






  procedure TWIDETests.fn_Embrace;
  begin
    // Default braces ( )
    Test('WIDE.Embrace()').Expect(WIDE.Embrace('')).Equals('()');
    Test('WIDE.Embrace(abc)').Expect(WIDE.Embrace('abc')).Equals('(abc)');

    // Embracing an empty string
    Test('WIDE.Embrace('''', [)').Expect(WIDE.Embrace('', '[')).Equals('[]');
    Test('WIDE.Embrace('''', {)').Expect(WIDE.Embrace('', '{')).Equals('{}');
    Test('WIDE.Embrace('''', <)').Expect(WIDE.Embrace('', '<')).Equals('<>');
    Test('WIDE.Embrace('''', #)').Expect(WIDE.Embrace('', '#')).Equals('##');
    Test('WIDE.Embrace('''', !)').Expect(WIDE.Embrace('', '!')).Equals('!!');

    // Embracing a string with a braced pair
    Test('WIDE.Embrace(abc, ()').Expect(WIDE.Embrace('abc', '(')).Equals('(abc)');
    Test('WIDE.Embrace(abc, [)').Expect(WIDE.Embrace('abc', '[')).Equals('[abc]');
    Test('WIDE.Embrace(abc, {)').Expect(WIDE.Embrace('abc', '{')).Equals('{abc}');
    Test('WIDE.Embrace(abc, <)').Expect(WIDE.Embrace('abc', '<')).Equals('<abc>');

    // Embracing a string with non-brace character
    Test('WIDE.Embrace(abc, #)').Expect(WIDE.Embrace('abc', '#')).Equals('#abc#');
    Test('WIDE.Embrace(abc, !)').Expect(WIDE.Embrace('abc', '!')).Equals('!abc!');
    Test('WIDE.Embrace(abc, @)').Expect(WIDE.Embrace('abc', '@')).Equals('@abc@');
    Test('WIDE.Embrace(abc, $)').Expect(WIDE.Embrace('abc', '$')).Equals('$abc$');
    Test('WIDE.Embrace(abc, &)').Expect(WIDE.Embrace('abc', '&')).Equals('&abc&');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Enquote;
  begin
    Test('WIDE.Enquote('''')').Expect(WIDE.Enquote('')).Equals('''''');
    Test('WIDE.Enquote('''', ''"'')').Expect(WIDE.Enquote('', '"')).Equals('""');

    Test('WIDE.Enquote(''Mother knows best'')').Expect(WIDE.Enquote('Mother knows best')).Equals('''Mother knows best''');
    Test('WIDE.Enquote(''Mother knows best'', ''"'')').Expect(WIDE.Enquote('Mother knows best', '"')).Equals('"Mother knows best"');

    Test('WIDE.Enquote(''Some Mothers Do ''Ave ''Em'')').Expect(WIDE.Enquote('Some Mothers Do ''Ave ''Em')).Equals('''Some Mothers Do ''''Ave ''''Em''');
    Test('WIDE.Enquote(''Some Mothers Do ''Ave ''Em'', '''''')').Expect(WIDE.Enquote('Some Mothers Do ''Ave ''Em', '''')).Equals('''Some Mothers Do ''''Ave ''''Em''');
    Test('WIDE.Enquote(''Some Mothers Do ''Ave ''Em'', ''"'')').Expect(WIDE.Enquote('Some Mothers Do ''Ave ''Em', '"')).Equals('"Some Mothers Do ''Ave ''Em"');
    Test('WIDE.Enquote(''Some Mothers Do ''Ave ''Em'', '''''', ''\'')').Expect(WIDE.Enquote('Some Mothers Do ''Ave ''Em', '''', '\')).Equals('''Some Mothers Do \''Ave \''Em''');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_PadLeft;
  begin
    Test('WIDE.PadLeft(42, 4)').Expect(WIDE.PadLeft(42, 4)).Equals('  42');
    Test('WIDE.PadLeft(42, 4, ''0'')').Expect(WIDE.PadLeft(42, 4, WIDEChar('0'))).Equals('0042');
    Test('WIDE.PadLeft(42, 4, ''0'')').Expect(WIDE.PadLeft(42, 4, WIDEChar('0'))).Equals('0042');

    Test('WIDE.PadLeft(''foo'', 10)').Expect(WIDE.PadLeft('foo', 10)).Equals('       foo');
    Test('WIDE.PadLeft(''foo'', 10, '' '')').Expect(WIDE.PadLeft('foo', 10, ' ')).Equals('       foo');
    Test('WIDE.PadLeft(''foo'', 10, ''x'')').Expect(WIDE.PadLeft('foo', 10, 'x')).Equals('xxxxxxxfoo');

    Test('WIDE.PadLeft(''foo'', 3, '' '')').Expect(WIDE.PadLeft('foo', 3, ' ')).Equals('foo');
    Test('WIDE.PadLeft(''foo'', 2, '' '')').Expect(WIDE.PadLeft('foo', 2, ' ')).Equals('foo');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_PadRight;
  begin
    Test('WIDE.PadRight(42, 4)').Expect(WIDE.PadRight(42, 4)).Equals('42  ');
    Test('WIDE.PadRight(42, 4, ''0'')').Expect(WIDE.PadRight(42, 4, WIDEChar('0'))).Equals('4200');
    Test('WIDE.PadRight(42, 4, ''0'')').Expect(WIDE.PadRight(42, 4, WIDEChar('0'))).Equals('4200');

    Test('WIDE.PadRight(''foo'', 10)').Expect(WIDE.PadRight('foo', 10)).Equals('foo       ');
    Test('WIDE.PadRight(''foo'', 10, '' '')').Expect(WIDE.PadRight('foo', 10, ' ')).Equals('foo       ');
    Test('WIDE.PadRight(''foo'', 10, ''x'')').Expect(WIDE.PadRight('foo', 10, 'x')).Equals('fooxxxxxxx');

    Test('WIDE.PadRight(''foo'', 3, '' '')').Expect(WIDE.PadRight('foo', 3, ' ')).Equals('foo');
    Test('WIDE.PadRight(''foo'', 2, '' '')').Expect(WIDE.PadRight('foo', 2, ' ')).Equals('foo');
  end;
















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Delete;
  const
    TEST_INDEX: array[1..4, 1..2] of Integer = (
                                                ( 0,  6),
                                                (-1,  6),
                                                ( 7,  1),
                                                ( 1, -1)
                                               );
  var
    i: Integer;
    s: UnicodeString;
  begin
    s := 'abcdef';
    WIDE.Delete(s, 1, 0);
    Test('WIDE.Delete(var ''abcdef'', 1, 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    WIDE.Delete(s, 1, 3);
    Test('WIDE.Delete(var ''abcdef'', 1, 3)').Expect(s).Equals('def');

    s := 'abcdef';
    WIDE.Delete(s, 2, 3);
    Test('WIDE.Delete(var ''abcdef'', 2, 3)').Expect(s).Equals('aef');

    s := 'abcdef';
    WIDE.Delete(s, 4, 3);
    Test('WIDE.Delete(var ''abcdef'', 4, 3)').Expect(s).Equals('abc');

    s := 'abcdef';
    WIDE.Delete(s, 4, 10);
    Test('WIDE.Delete(var ''abcdef'', 4, 10)').Expect(s).Equals('abc');

    s := 'abcdef';
    WIDE.Delete(s, 1, 6);
    Test('WIDE.Delete(var ''abcdef'', 1, 6)').Expect(s).Equals('');

    s := 'abcdef';
    WIDE.Delete(s, 1, 10);
    Test('WIDE.Delete(var ''abcdef'', 1, 10)').Expect(s).Equals('');

    Note('Contracts');
    s := 'abcdef';
    for i := Low(TEST_INDEX) to High(TEST_INDEX) do
      try
        WIDE.Delete(s, TEST_INDEX[i, 1], TEST_INDEX[i, 2]);
        Test.Expecting(EContractViolation);
      except
        Test.Expecting(EContractViolation);
      end;

    Note('Contract violations should not affect the input string');
    Test.Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('WIDE.Delete(var ''abcdef'', ''abc'') [result]').Expect(WIDE.Delete(s, 'abc')).IsTRUE;
    Test('WIDE.Delete(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.Delete(var ''abcdef'', ''bcd'') [result]').Expect(WIDE.Delete(s, 'bcd')).IsTRUE;
    Test('WIDE.Delete(var ''abcdef'', ''bcd'') [var]').Expect(s).Equals('aef');

    s := 'abcdef';
    Test('WIDE.Delete(var ''abcdef'', ''c'') [result]').Expect(WIDE.Delete(s, 'c')).IsTRUE;
    Test('WIDE.Delete(var ''abcdef'', ''c'') [var]').Expect(s).Equals('abdef');

    s := 'abcdef';
    Test('WIDE.Delete(var ''abcdef'', ''z'') [result]').Expect(WIDE.Delete(s, 'z')).IsFALSE;
    Test('WIDE.Delete(var ''abcdef'', ''z'') [var]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('WIDE.Delete(var ''abcdef'', ''ABC'') [result]').Expect(WIDE.Delete(s, 'ABC')).IsFALSE;
    Test('WIDE.Delete(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('abcdef');

  // DeleteText (only supports substring deletion, not index range)

    s := 'abcdef';
    Test('WIDE.DeleteText(var ''abcdef'', ''ABC'') [result]').Expect(WIDE.DeleteText(s, 'ABC')).IsTRUE;
    Test('WIDE.DeleteText(var ''abcdef'', ''ABC'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.DeleteText(var ''abcdef'', ''abc'') [result]').Expect(WIDE.DeleteText(s, 'abc')).IsTRUE;
    Test('WIDE.DeleteText(var ''abcdef'', ''abc'') [var]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.DeleteText(var ''abcdef'', ''xyz'') [result]').Expect(WIDE.DeleteText(s, 'xyz')).IsFALSE;
    Test('WIDE.DeleteText(var ''abcdef'', ''xyz'') [var]').Expect(s).Equals('abcdef');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_DeleteAll;
  var
    s: UnicodeString;
  begin
    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''a'') result').Expect(WIDE.DeleteAll(s, 'a')).Equals(2);
    Test('WIDE.DeleteAll(var ''abcabc'', ''a'') string').Expect(s).Equals('bcbc');

    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''A'') result').Expect(WIDE.DeleteAll(s, 'A')).Equals(0);
    Test('WIDE.DeleteAll(var ''abcabc'', ''A'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''d'') result').Expect(WIDE.DeleteAll(s, 'd')).Equals(0);
    Test('WIDE.DeleteAll(var ''abcabc'', ''d'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''abc'') result').Expect(WIDE.DeleteAll(s, 'abc')).Equals(2);
    Test('WIDE.DeleteAll(var ''abcabc'', ''abc'') string').Expect(s).Equals('');

    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''ABC'') result').Expect(WIDE.DeleteAll(s, 'ABC')).Equals(0);
    Test('WIDE.DeleteAll(var ''abcabc'', ''ABC'') string').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('WIDE.DeleteAll(var ''abcabc'', ''def'') result').Expect(WIDE.DeleteAll(s, 'def')).Equals(0);
    Test('WIDE.DeleteAll(var ''abcabc'', ''def'') string').Expect(s).Equals('abcabc');

    try
      WIDE.DeleteAll(s, #0);
      Test('WIDE.DeleteAll(var ''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.DeleteAll(var ''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.DeleteAll(s, '');
      Test('WIDE.DeleteAll(var ''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.DeleteAll(var ''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_DeleteLast;
  var
    s: UnicodeString;
  begin
  // DeleteLast (only supports substring deletion, not index range)

    s := 'abcdabc';
    Test('WIDE.DeleteLast(var ''abcdabc'', ''abc'') [result]').Expect(WIDE.DeleteLast(s, 'abc')).IsTRUE;
    Test('WIDE.DeleteLast(var ''abcdabc'', ''abc'') [var]').Expect(s).Equals('abcd');

    s := 'abcabc';
    Test('WIDE.DeleteLast(var ''abcabc'', ''bcd'') [result]').Expect(WIDE.DeleteLast(s, 'cab')).IsTRUE;
    Test('WIDE.DeleteLast(var ''abcabc'', ''bcd'') [var]').Expect(s).Equals('abc');

    s := 'abcabc';
    Test('WIDE.DeleteLast(var ''abcabc'', ''c'') [result]').Expect(WIDE.DeleteLast(s, 'c')).IsTRUE;
    Test('WIDE.DeleteLast(var ''abcabc'', ''c'') [var]').Expect(s).Equals('abcab');

    s := 'abcabc';
    Test('WIDE.DeleteLast(var ''abcabc'', ''z'') [result]').Expect(WIDE.DeleteLast(s, 'z')).IsFALSE;
    Test('WIDE.DeleteLast(var ''abcabc'', ''z'') [var]').Expect(s).Equals('abcabc');

    s := 'abcabc';
    Test('WIDE.DeleteLast(var ''abcabc'', ''ABC'') [result]').Expect(WIDE.DeleteLast(s, 'ABC')).IsFALSE;
    Test('WIDE.DeleteLast(var ''abcabc'', ''abc'') [var]').Expect(s).Equals('abcabc');

  // DeleteLastText (only supports substring deletion, not index range)

    s := 'abcdabc';
    Test('WIDE.DeleteLastText(var ''abcdabc'', ''ABC'') [result]').Expect(WIDE.DeleteLastText(s, 'ABC')).IsTRUE;
    Test('WIDE.DeleteLastText(var ''abcdabc'', ''ABC'') [var]').Expect(s).Equals('abcd');

    s := 'abcdabc';
    Test('WIDE.DeleteLastText(var ''abcdabc'', ''abc'') [result]').Expect(WIDE.DeleteLastText(s, 'abc')).IsTRUE;
    Test('WIDE.DeleteLastText(var ''abcdabc'', ''abc'') [var]').Expect(s).Equals('abcd');

    s := 'abcabc';
    Test('WIDE.DeleteLastText(var ''abcabc'', ''xyz'') [result]').Expect(WIDE.DeleteLastText(s, 'xyz')).IsFALSE;
    Test('WIDE.DeleteLastText(var ''abcabc'', ''xyz'') [var]').Expect(s).Equals('abcabc');

  // DeleteLast contracts

    try
      WIDE.DeleteLast(s, #0);
      Test('WIDE.DeleteLast(var ''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.DeleteLast(var ''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.DeleteLast(s, '');
      Test('WIDE.DeleteLast(var ''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.DeleteLast(var ''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_DeleteRange;
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
    s: UnicodeString;
  begin
    s := 'abcdef';
    WIDE.DeleteRange(s, 1, 3);
    Test('WIDE.DeleteRange(var ''abcdef'', 1, 3)').Expect(s).Equals('def');

    s := 'abcdef';
    WIDE.DeleteRange(s, 2, 3);
    Test('WIDE.DeleteRange(var ''abcdef'', 2, 3)').Expect(s).Equals('adef');

    s := 'abcdef';
    WIDE.DeleteRange(s, 2, 2);
    Test('WIDE.DeleteRange(var ''abcdef'', 2, 2)').Expect(s).Equals('acdef');

    s := 'abcdef';
    WIDE.DeleteRange(s, 4, 3);
    Test('WIDE.DeleteRange(var ''abcdef'', 4, 3)').Expect(s).Equals('abef');

    s := 'abcdef';
    WIDE.DeleteRange(s, 1, 6);
    Test('WIDE.DeleteRange(var ''abcdef'', 1, 6)').Expect(s).Equals('');

    Note('Contracts');

    s := 'abcdef';

    for i := Low(TEST_INDEX) to High(TEST_INDEX) do
      try
        WIDE.DeleteRange(s, TEST_INDEX[i, 1], TEST_INDEX[i, 2]);
        Test.Expecting(EContractViolation);
      except
        Test.Expecting(EContractViolation);
      end;

    Note('Contract violations should not affect the input string');
    Test.Expect(s).Equals('abcdef');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_DeleteLeft;
  var
    s: UnicodeString;
  begin
    s := 'abcdef';
    WIDE.DeleteLeft(s, 0);
    Test('WIDE.DeleteLeft(var ''abcdef'', 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    WIDE.DeleteLeft(s, 3);
    Test('WIDE.DeleteLeft(var ''abcdef'', 3)').Expect(s).Equals('def');

    s := 'abcdef';
    WIDE.DeleteLeft(s, 10);
    Test('WIDE.DeleteLeft(var ''abcdef'', 10)').Expect(s).Equals('');

    s := 'abcdef';
    Test('WIDE.DeleteLeft(var str, substr) [result]').Expect(WIDE.DeleteLeft(s, 'abc')).IsTRUE;
    Test('WIDE.DeleteLeft(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.DeleteLeft(var str, substr) [result]').Expect(WIDE.DeleteLeft(s, 'ABC')).IsFALSE;
    Test('WIDE.DeleteLeft(var str, substr) [str]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('WIDE.DeleteLeft(var str, substr, csIgnoreCase) [result]').Expect(WIDE.DeleteLeft(s, 'ABC', csIgnoreCase)).IsTRUE;
    Test('WIDE.DeleteLeft(var str, substr, csIgnoreCase) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.DeleteLeftText(var str, substr) [result]').Expect(WIDE.DeleteLeftText(s, 'ABC')).IsTRUE;
    Test('WIDE.DeleteLeftText(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    Test('WIDE.DeleteLeftText(var str, substr) [result]').Expect(WIDE.DeleteLeftText(s, 'abc')).IsTRUE;
    Test('WIDE.DeleteLeftText(var str, substr) [str]').Expect(s).Equals('def');

    s := 'abcdef';
    try
      WIDE.DeleteLeft(s, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_DeleteRight;
  var
    s: UnicodeString;
  begin
    s := 'abcdef';
    WIDE.DeleteRight(s, 0);
    Test('WIDE.DeleteRight(var ''abcdef'', 0)').Expect(s).Equals('abcdef');

    s := 'abcdef';
    WIDE.DeleteRight(s, 3);
    Test('WIDE.DeleteRight(var ''abcdef'', 3)').Expect(s).Equals('abc');

    s := 'abcdef';
    WIDE.DeleteRight(s, 10);
    Test('WIDE.DeleteRight(var ''abcdef'', 10)').Expect(s).Equals('');

    s := 'abcdef';
    Test('WIDE.DeleteRight(var str, substr) [result]').Expect(WIDE.DeleteRight(s, 'def')).IsTRUE;
    Test('WIDE.DeleteRight(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('WIDE.DeleteRight(var str, substr) [result]').Expect(WIDE.DeleteRight(s, 'DEF')).IsFALSE;
    Test('WIDE.DeleteRight(var str, substr) [str]').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('WIDE.DeleteRight(var str, substr, csIgnoreCase) [result]').Expect(WIDE.DeleteRight(s, 'DEF', csIgnoreCase)).IsTRUE;
    Test('WIDE.DeleteRight(var str, substr, csIgnoreCase) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('WIDE.DeleteRightText(var str, substr) [result]').Expect(WIDE.DeleteRightText(s, 'DEF')).IsTRUE;
    Test('WIDE.DeleteRightText(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    Test('WIDE.DeleteRightText(var str, substr) [result]').Expect(WIDE.DeleteRightText(s, 'def')).IsTRUE;
    Test('WIDE.DeleteRightText(var str, substr) [str]').Expect(s).Equals('abc');

    s := 'abcdef';
    try
      WIDE.DeleteRight(s, -1);
      Test.Expecting(EContractViolation);
    except
      Test.Expecting(EContractViolation);
    end;
  end;












  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Remove;
  const
    STR = 'abcabc';
  begin
    Test('WIDE.Remove(''abcabc'', ''a'')').Expect(WIDE.Remove(STR, 'a')).Equals('bcabc');
    Test('WIDE.Remove(''abcabc'', ''A'')').Expect(WIDE.Remove(STR, 'A')).Equals('abcabc');
    Test('WIDE.Remove(''abcabc'', ''d'')').Expect(WIDE.Remove(STR, 'd')).Equals('abcabc');

    Test('WIDE.Remove(''abcabc'', ''abc'')').Expect(WIDE.Remove(STR, 'abc')).Equals('abc');
    Test('WIDE.Remove(''abcabc'', ''ABC'')').Expect(WIDE.Remove(STR, 'ABC')).Equals('abcabc');
    Test('WIDE.Remove(''abcabc'', ''def'')').Expect(WIDE.Remove(STR, 'def')).Equals('abcabc');

    try
      WIDE.Remove(STR, #0);
      Test('WIDE.Remove(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.Remove(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.Remove(STR, '');
      Test('WIDE.Remove(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.Remove(''abcabc'', '''')').Expecting(EContractViolation);
    end;

    Test('WIDE.RemoveText(''abcabc'', ''a'')').Expect(WIDE.RemoveText(STR, 'a')).Equals('bcabc');
    Test('WIDE.RemoveText(''abcabc'', ''A'')').Expect(WIDE.RemoveText(STR, 'A')).Equals('bcabc');
    Test('WIDE.RemoveText(''abcabc'', ''d'')').Expect(WIDE.RemoveText(STR, 'd')).Equals('abcabc');

    Test('WIDE.RemoveText(''abcabc'', ''abc'')').Expect(WIDE.RemoveText(STR, 'abc')).Equals('abc');
    Test('WIDE.RemoveText(''abcabc'', ''ABC'')').Expect(WIDE.RemoveText(STR, 'ABC')).Equals('abc');
    Test('WIDE.RemoveText(''abcabc'', ''def'')').Expect(WIDE.RemoveText(STR, 'def')).Equals('abcabc');

    try
      WIDE.RemoveText(STR, #0);
      Test('WIDE.RemoveText(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveText(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.RemoveText(STR, '');
      Test('WIDE.RemoveText(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveText(''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_RemoveAll;
  const
    STR = 'abcabc';
  begin
    Test('WIDE.RemoveAll(''abcabc'', ''a'')').Expect(WIDE.RemoveAll(STR, 'a')).Equals('bcbc');
    Test('WIDE.RemoveAll(''abcabc'', ''A'')').Expect(WIDE.RemoveAll(STR, 'A')).Equals('abcabc');
    Test('WIDE.RemoveAll(''abcabc'', ''d'')').Expect(WIDE.RemoveAll(STR, 'd')).Equals('abcabc');

    Test('WIDE.RemoveAll(''abcabc'', ''abc'')').Expect(WIDE.RemoveAll(STR, 'abc')).Equals('');
    Test('WIDE.RemoveAll(''abcabc'', ''ABC'')').Expect(WIDE.RemoveAll(STR, 'ABC')).Equals('abcabc');
    Test('WIDE.RemoveAll(''abcabc'', ''def'')').Expect(WIDE.RemoveAll(STR, 'def')).Equals('abcabc');

    try
      WIDE.RemoveAll(STR, #0);
      Test('WIDE.RemoveAll(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveAll(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.RemoveAll(STR, '');
      Test('WIDE.RemoveAll(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveAll(''abcabc'', '''')').Expecting(EContractViolation);
    end;

    Test('WIDE.RemoveAllText(''abcabc'', ''a'')').Expect(WIDE.RemoveAllText(STR, 'a')).Equals('bcbc');
    Test('WIDE.RemoveAllText(''abcabc'', ''A'')').Expect(WIDE.RemoveAllText(STR, 'A')).Equals('bcbc');
    Test('WIDE.RemoveAllText(''abcabc'', ''d'')').Expect(WIDE.RemoveAllText(STR, 'd')).Equals('abcabc');

    Test('WIDE.RemoveAllText(''abcabc'', ''abc'')').Expect(WIDE.RemoveAllText(STR, 'abc')).Equals('');
    Test('WIDE.RemoveAllText(''abcabc'', ''ABC'')').Expect(WIDE.RemoveAllText(STR, 'ABC')).Equals('');
    Test('WIDE.RemoveAllText(''abcabc'', ''def'')').Expect(WIDE.RemoveAllText(STR, 'def')).Equals('abcabc');

    try
      WIDE.RemoveAllText(STR, #0);
      Test('WIDE.RemoveAllText(''abcabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveAllText(''abcabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.RemoveAllText(STR, '');
      Test('WIDE.RemoveAllText(''abcabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveAllText(''abcabc'', '''')').Expecting(EContractViolation);
    end;
  end;


  procedure TWIDETests.fn_RemoveLast;
  const
    STR = 'abcdabc';
  begin
    Test('WIDE.RemoveLast(''abcdabc'', ''a'')').Expect(WIDE.RemoveLast(STR, 'a')).Equals('abcdbc');
    Test('WIDE.RemoveLast(''abcdabc'', ''A'')').Expect(WIDE.RemoveLast(STR, 'A')).Equals('abcdabc');
    Test('WIDE.RemoveLast(''abcdabc'', ''x'')').Expect(WIDE.RemoveLast(STR, 'x')).Equals('abcdabc');

    Test('WIDE.RemoveLast(''abcdabc'', ''abc'')').Expect(WIDE.RemoveLast(STR, 'abc')).Equals('abcd');
    Test('WIDE.RemoveLast(''abcdabc'', ''ABC'')').Expect(WIDE.RemoveLast(STR, 'ABC')).Equals('abcdabc');
    Test('WIDE.RemoveLast(''abcdabc'', ''def'')').Expect(WIDE.RemoveLast(STR, 'def')).Equals('abcdabc');

    try
      WIDE.RemoveLast(STR, #0);
      Test('WIDE.RemoveLast(''abcdabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveLast(''abcdabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.RemoveLast(STR, '');
      Test('WIDE.RemoveLast(''abcdabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveLast(''abcdabc'', '''')').Expecting(EContractViolation);
    end;

    Test('WIDE.RemoveLastText(''abcdabc'', ''a'')').Expect(WIDE.RemoveLastText(STR, 'a')).Equals('abcdbc');
    Test('WIDE.RemoveLastText(''abcdabc'', ''A'')').Expect(WIDE.RemoveLastText(STR, 'A')).Equals('abcdbc');
    Test('WIDE.RemoveLastText(''abcdabc'', ''x'')').Expect(WIDE.RemoveLastText(STR, 'x')).Equals('abcdabc');

    Test('WIDE.RemoveLastText(''abcdabc'', ''abc'')').Expect(WIDE.RemoveLastText(STR, 'abc')).Equals('abcd');
    Test('WIDE.RemoveLastText(''abcdabc'', ''ABC'')').Expect(WIDE.RemoveLastText(STR, 'ABC')).Equals('abcd');
    Test('WIDE.RemoveLastText(''abcdabc'', ''def'')').Expect(WIDE.RemoveLastText(STR, 'def')).Equals('abcdabc');

    try
      WIDE.RemoveLastText(STR, #0);
      Test('WIDE.RemoveLastText(''abcdabc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveLastText(''abcdabc'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.RemoveLastText(STR, '');
      Test('WIDE.RemoveLastText(''abcdabc'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.RemoveLastText(''abcdabc'', '''')').Expecting(EContractViolation);
    end;
  end;


















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Extract;
  const
    SRC: UnicodeString = 'abcdefghi';
  var
    sSource: UnicodeString;
    sExtract: UnicodeString;
  begin
    sSource  := SRC;
    sExtract := 'z';
    try
      Test('WIDE.Extract(''abcdefghi'', -1, 1, var)').Expect(WIDE.Extract(sSource, -1, 1, sExtract)).IsTRUE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource  := SRC;
    sExtract := 'z';
    try
      Test('WIDE.Extract(''abcdefghi'', 7, 6, var)').Expect(WIDE.Extract(sSource, 7, 6, sExtract)).IsTRUE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource  := SRC;
    sExtract := 'z';
    try
      Test('WIDE.Extract(''abcdefghi'', 10, 1, var)').Expect(WIDE.Extract(sSource, 10, 1, sExtract)).IsFALSE;
      Test.Expecting(EContractViolation);

    except
      Test.Expecting(EContractViolation);
      Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
      Test('var = ''''').Expect(sExtract).Equals('');
    end;

    sSource := SRC;
    Test('WIDE.Extract(''abcdefghi'', 4, 3, var)').Expect(WIDE.Extract(sSource, 4, 3, sExtract)).IsTRUE;
    Test('source = ''abcghi''').Expect(sSource).Equals('abcghi');
    Test('var = ''def''').Expect(sExtract).Equals('def');

    sSource := SRC;
    Test('WIDE.Extract(''abcdefghi'', 1, 1, var)').Expect(WIDE.Extract(sSource, 1, 1, sExtract)).IsTRUE;
    Test('source = ''bcdefghi''').Expect(sSource).Equals('bcdefghi');
    Test('var = ''a''').Expect(sExtract).Equals('a');

    sSource := SRC;
    Test('WIDE.Extract(''abcdefghi'', 9, 1, var)').Expect(WIDE.Extract(sSource, 9, 1, sExtract)).IsTRUE;
    Test('source = ''abcdefgh''').Expect(sSource).Equals('abcdefgh');
    Test('var = ''i''').Expect(sExtract).Equals('i');

    sSource  := SRC;
    sExtract := 'z';
    Test('WIDE.Extract(''abcdefghi'', 1, 0, var)').Expect(WIDE.Extract(sSource, 1, 0, sExtract)).IsFALSE;
    Test('source = ''abcdefghi''').Expect(sSource).Equals('abcdefghi');
    Test('var = ''''').Expect(sExtract).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_ExtractLeft;
  const
    SRC: UnicodeString = 'abcdefghi';
  var
    s, e: UnicodeString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 0, var extract) result').Expect(WIDE.ExtractLeft(s, 0, e)).IsFALSE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 0, var extract) extract').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 0, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 3, var extract) result').Expect(WIDE.ExtractLeft(s, 3, e)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 3, var extract) extract').Expect(s).Equals('defghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 3, var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 10, var extract) result').Expect(WIDE.ExtractLeft(s, 10, e)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 10, var extract) s').Expect(s).Equals('');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', 10, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractLeft(s, -1, e);
      Test('WIDE.ExtractLeft(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractLeft(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

  // Extract up to specified char delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) result').Expect(WIDE.ExtractLeft(s, 'd', e)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) s').Expect(s).Equals('defghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) result').Expect(WIDE.ExtractLeft(s, 'a', e)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) result').Expect(WIDE.ExtractLeft(s, 'D', e)).IsFALSE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''D'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) result').Expect(WIDE.ExtractLeft(s, 'x', e)).IsFALSE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''x'', var extract) extract').Expect(e).Equals('');

  // Extract up to specified string delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) result').Expect(WIDE.ExtractLeft(s, 'def', e)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) s').Expect(s).Equals('defghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) result').Expect(WIDE.ExtractLeft(s, 'DEF', e)).IsFALSE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''DEF'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) result').Expect(WIDE.ExtractLeft(s, 'xyz', e)).IsFALSE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''xyz'', var extract) extract').Expect(e).Equals('');

  // Extract up to a char delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'd', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('efghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('abc');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'a', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('bcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract up to a string delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'def', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('ghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('abc');

  // Extract up to and including a char delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'd', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('efghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abcd');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'a', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('bcdefghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''a'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('a');

  // Extract up to a string delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'def', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('ghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abcdef');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractLeft(s, 'abc', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('defghi');
    Test('WIDE.ExtractLeft(var s = ''abcdefghi'', ''abc'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('abc');

  // Contracts

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractLeft(s, #0, e);
      Test('WIDE.ExtractLeft(''abcdefghi'', #0, var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractLeft(''abcdefghi'', #0, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractLeft(s, '', e);
      Test('WIDE.ExtractLeft(''abcdefghi'', '''', var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractLeft(''abcdefghi'', '''', var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_ExtractRight;
  const
    SRC: UnicodeString = 'abcdefghi';
  var
    s, e: UnicodeString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(''abcdefghi'', 0, var e) result').Expect(WIDE.ExtractRight(s, 0, e)).IsFALSE;
    Test('WIDE.ExtractRight(''abcdefghi'', 0, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(''abcdefghi'', 3, var e) result').Expect(WIDE.ExtractRight(s, 3, e)).IsTRUE;
    Test('WIDE.ExtractRight(''abcdefghi'', 3, var extract) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(''abcdefghi'', 10, var e) result').Expect(WIDE.ExtractRight(s, 10, e)).IsTRUE;
    Test('WIDE.ExtractRight(''abcdefghi'', 10, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractRight(s, -1, e);
      Test('WIDE.ExtractRight(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractRight(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchange)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

  // Extract from specified char delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) result').Expect(WIDE.ExtractRight(s, 'd', e)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) s').Expect(s).Equals('abcd');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract) extract').Expect(e).Equals('efghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) result').Expect(WIDE.ExtractRight(s, 'i', e)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) result').Expect(WIDE.ExtractRight(s, 'D', e)).IsFALSE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''D'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) result').Expect(WIDE.ExtractRight(s, 'x', e)).IsFALSE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''x'', var extract) extract').Expect(e).Equals('');

  // Extract from specified string delimiter (using default: leave the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) result').Expect(WIDE.ExtractRight(s, 'def', e)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) s').Expect(s).Equals('abcdef');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) result').Expect(WIDE.ExtractRight(s, 'DEF', e)).IsFALSE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''DEF'', var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) result').Expect(WIDE.ExtractRight(s, 'xyz', e)).IsFALSE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''xyz'', var extract) extract').Expect(e).Equals('');

  // Extract from a char delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'd', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('efghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'i', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abcdefgh');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract from a string delimiter (delete the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'def', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('ghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'ghi', e, doDeleteOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) s').Expect(s).Equals('abcdef');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doDeleteOptionalDelimiter) extract').Expect(e).Equals('');

  // Extract from and including a char delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'd', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''d'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'i', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abcdefgh');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''i'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('i');

  // Extract from a string delimiter (extract the delimiter)

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'def', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abc');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''def'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) result').Expect(WIDE.ExtractRight(s, 'ghi', e, doExtractOptionalDelimiter)).IsTRUE;
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) s').Expect(s).Equals('abcdef');
    Test('WIDE.ExtractRight(var s = ''abcdefghi'', ''ghi'', var extract, doExtractOptionalDelimiter) extract').Expect(e).Equals('ghi');

  // Contracts

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractRight(s, #0, e);
      Test('WIDE.ExtractRight(''abcdefghi'', #0, var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractRight(''abcdefghi'', #0, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractRight(s, '', e);
      Test('WIDE.ExtractRight(''abcdefghi'', '''', var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractRight(''abcdefghi'', '''', var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_ExtractRightFrom;
  const
    SRC: UnicodeString = 'abcdefghi';
  var
    s, e: UnicodeString;
  begin
  // Extract a specified number of characters

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) result').Expect(WIDE.ExtractRightFrom(s, 0, e)).IsTRUE;
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) s').Expect(s).Equals('');
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 0, var extract) extract').Expect(e).Equals('abcdefghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) result').Expect(WIDE.ExtractRightFrom(s, 3, e)).IsTRUE;
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) s').Expect(s).Equals('abc');
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 3, var extract) extract').Expect(e).Equals('defghi');

    s := SRC;
    e := 'z';
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) result').Expect(WIDE.ExtractRightFrom(s, 10, e)).IsFALSE;
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) s').Expect(s).Equals('abcdefghi');
    Test('WIDE.ExtractRightFrom(var s = ''abcdefghi'', 10, var extract) extract').Expect(e).Equals('');

    s := SRC;
    e := 'z';
    try
      WIDE.ExtractRightFrom(s, -1, e);
      Test('WIDE.ExtractRightFrom(''abcdefghi'', -1, var)').Expecting(EContractViolation);

    except
      Test('WIDE.ExtractRightFrom(''abcdefghi'', -1, var)').Expecting(EContractViolation);
      Test('source = ''abcdefghi'' (unchanged)').Expect(s).Equals('abcdefghi');
      Test('var = ''z'' (unchanged)').Expect(e).Equals('z');
    end;
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Copy;
  const
    STR = 'abcdef';
  begin
    Test('WIDE.Copy(''abcdef'', 1, 3)').Expect(WIDE.Copy(STR, 1, 3)).Equals('abc');
    Test('WIDE.Copy(''abcdef'', 2, 3)').Expect(WIDE.Copy(STR, 2, 3)).Equals('bcd');
    Test('WIDE.Copy(''abcdef'', 2, 7)').Expect(WIDE.Copy(STR, 2, 7)).Equals('bcdef');

    try
      WIDE.Copy(STR, 0, 3);
      Test('WIDE.Copy(''abcdef'', 0, 3)').Expecting(EContractViolation);
    except
      Test('WIDE.Copy(''abcdef'', 0, 3)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyFrom;
  const
    STR = 'abcdef';
  begin
    Test('WIDE.CopyFrom(''abcdef'', 1)').Expect(WIDE.CopyFrom(STR, 1)).Equals('abcdef');
    Test('WIDE.CopyFrom(''abcdef'', 2)').Expect(WIDE.CopyFrom(STR, 2)).Equals('bcdef');
    Test('WIDE.CopyFrom(''abcdef'', 7)').Expect(WIDE.CopyFrom(STR, 7)).Equals('');

    try
      WIDE.CopyFrom(STR, 0);
      Test('WIDE.CopyFrom(''abcdef'', 0)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyFrom(''abcdef'', 0)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyRange;
  const
    STR = 'abcdef';
  begin
    Test('WIDE.CopyRange(''abcdef'', 1, 3)').Expect(WIDE.CopyRange(STR, 1, 3)).Equals('abc');
    Test('WIDE.CopyRange(''abcdef'', 2, 3)').Expect(WIDE.CopyRange(STR, 2, 3)).Equals('bc');
    Test('WIDE.CopyRange(''abcdef'', 1, 7)').Expect(WIDE.CopyRange(STR, 1, 7)).Equals('abcdef');

    try
      WIDE.CopyRange(STR, 0, 3);
      Test('WIDE.CopyRange(''abcdef'', 0, 3)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyRange(''abcdef'', 0, 3)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyLeft;
  const
    STR = 'abcdef';
  begin
    Test('WIDE.CopyLeft(''abcdef'', 0)').Expect(WIDE.CopyLeft(STR, 0)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', 1)').Expect(WIDE.CopyLeft(STR, 1)).Equals('a');
    Test('WIDE.CopyLeft(''abcdef'', 3)').Expect(WIDE.CopyLeft(STR, 3)).Equals('abc');
    Test('WIDE.CopyLeft(''abcdef'', 10)').Expect(WIDE.CopyLeft(STR, 10)).Equals('abcdef');

    try
      WIDE.CopyLeft(STR, -1);
      Test('WIDE.CopyLeft(''abcdef'', -1)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyLeft(''abcdef'', -1)').Expecting(EContractViolation);
    end;

  // CopyLeft with Exclude Optional delimiter (default)

    Test('WIDE.CopyLeft(''abcdef'', ''a'')').Expect(WIDE.CopyLeft(STR, 'a')).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''d'')').Expect(WIDE.CopyLeft(STR, 'd')).Equals('abc');
    Test('WIDE.CopyLeft(''abcdef'', ''D'')').Expect(WIDE.CopyLeft(STR, 'D')).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', '','')').Expect(WIDE.CopyLeft(STR, ',')).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', ''ab'')').Expect(WIDE.CopyLeft(STR, 'ab')).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''def'')').Expect(WIDE.CopyLeft(STR, 'def')).Equals('abc');
    Test('WIDE.CopyLeft(''abcdef'', ''DEF'')').Expect(WIDE.CopyLeft(STR, 'DEF')).Equals('abcdef');

  // CopyLeft with Include Optional delimiter

    Test('WIDE.CopyLeft(''abcdef'', ''a'')').Expect(WIDE.CopyLeft(STR, 'a', doIncludeOptionalDelimiter)).Equals('a');
    Test('WIDE.CopyLeft(''abcdef'', ''d'')').Expect(WIDE.CopyLeft(STR, 'd', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeft(''abcdef'', ''D'')').Expect(WIDE.CopyLeft(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', '','')').Expect(WIDE.CopyLeft(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', ''ab'')').Expect(WIDE.CopyLeft(STR, 'ab', doIncludeOptionalDelimiter)).Equals('ab');
    Test('WIDE.CopyLeft(''abcdef'', ''def'')').Expect(WIDE.CopyLeft(STR, 'def', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', ''DEF'')').Expect(WIDE.CopyLeft(STR, 'DEF', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyLeft with Exclude Required delimiter

    Test('WIDE.CopyLeft(''abcdef'', ''a'')').Expect(WIDE.CopyLeft(STR, 'a', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''d'')').Expect(WIDE.CopyLeft(STR, 'd', doExcludeRequiredDelimiter)).Equals('abc');
    Test('WIDE.CopyLeft(''abcdef'', ''D'')').Expect(WIDE.CopyLeft(STR, 'D', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', '','')').Expect(WIDE.CopyLeft(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''ab'')').Expect(WIDE.CopyLeft(STR, 'ab', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''def'')').Expect(WIDE.CopyLeft(STR, 'def', doExcludeRequiredDelimiter)).Equals('abc');
    Test('WIDE.CopyLeft(''abcdef'', ''DEF'')').Expect(WIDE.CopyLeft(STR, 'DEF', doExcludeRequiredDelimiter)).Equals('');

  // CopyLeft with Include Required delimiter

    Test('WIDE.CopyLeft(''abcdef'', ''a'')').Expect(WIDE.CopyLeft(STR, 'a', doIncludeRequiredDelimiter)).Equals('a');
    Test('WIDE.CopyLeft(''abcdef'', ''d'')').Expect(WIDE.CopyLeft(STR, 'd', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeft(''abcdef'', ''D'')').Expect(WIDE.CopyLeft(STR, 'D', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', '','')').Expect(WIDE.CopyLeft(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeft(''abcdef'', ''ab'')').Expect(WIDE.CopyLeft(STR, 'ab', doIncludeRequiredDelimiter)).Equals('ab');
    Test('WIDE.CopyLeft(''abcdef'', ''def'')').Expect(WIDE.CopyLeft(STR, 'def', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeft(''abcdef'', ''DEF'')').Expect(WIDE.CopyLeft(STR, 'DEF', doIncludeRequiredDelimiter)).Equals('');

  // Case insensitive calls

  // CopyLeftText with Exclude Optional delimiter (default)

    Test('WIDE.CopyLeftText(''abcdef'', ''a'')').Expect(WIDE.CopyLeftText(STR, 'a')).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''d'')').Expect(WIDE.CopyLeftText(STR, 'd')).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', ''D'')').Expect(WIDE.CopyLeftText(STR, 'D')).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', '','')').Expect(WIDE.CopyLeftText(STR, ',')).Equals('abcdef');
    Test('WIDE.CopyLeftText(''abcdef'', ''ab'')').Expect(WIDE.CopyLeftText(STR, 'ab')).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''def'')').Expect(WIDE.CopyLeftText(STR, 'def')).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', ''DEF'')').Expect(WIDE.CopyLeftText(STR, 'DEF')).Equals('abc');

  // CopyLeftText with Include Optional delimiter

    Test('WIDE.CopyLeftText(''abcdef'', ''a'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'a', doIncludeOptionalDelimiter)).Equals('a');
    Test('WIDE.CopyLeftText(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'd', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeftText(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeftText(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeftText(''abcdef'', ''ab'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'ab', doIncludeOptionalDelimiter)).Equals('ab');
    Test('WIDE.CopyLeftText(''abcdef'', ''def'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'def', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeftText(''abcdef'', ''DEF'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyLeftText(STR, 'DEF', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyLeftText with Exclude Required delimiter

    Test('WIDE.CopyLeftText(''abcdef'', ''a'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'a', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'd', doExcludeRequiredDelimiter)).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'D', doExcludeRequiredDelimiter)).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''ab'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'ab', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''def'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'def', doExcludeRequiredDelimiter)).Equals('abc');
    Test('WIDE.CopyLeftText(''abcdef'', ''DEF'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'DEF', doExcludeRequiredDelimiter)).Equals('abc');

  // CopyLeftText with Include Required delimiter

    Test('WIDE.CopyLeftText(''abcdef'', ''a'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'a', doIncludeRequiredDelimiter)).Equals('a');
    Test('WIDE.CopyLeftText(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'd', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeftText(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'D', doIncludeRequiredDelimiter)).Equals('abcd');
    Test('WIDE.CopyLeftText(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyLeftText(''abcdef'', ''ab'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'ab', doIncludeRequiredDelimiter)).Equals('ab');
    Test('WIDE.CopyLeftText(''abcdef'', ''def'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'def', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('WIDE.CopyLeftText(''abcdef'', ''DEF'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyLeftText(STR, 'DEF', doIncludeRequiredDelimiter)).Equals('abcdef');

    try
      WIDE.CopyLeft(STR, #0);
      Test('WIDE.CopyLeft(''abcdef'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyLeft(''abcdef'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.CopyLeft(STR, '');
      Test('WIDE.CopyLeft(''abcdef'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.CopyLeft(''abcdef'', '''')').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_CopyRight;
  const
    STR = 'abcdef';
  begin
    Test('WIDE.CopyRight(''abcdef'', 0)').Expect(WIDE.CopyRight(STR, 0)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', 1)').Expect(WIDE.CopyRight(STR, 1)).Equals('f');
    Test('WIDE.CopyRight(''abcdef'', 3)').Expect(WIDE.CopyRight(STR, 3)).Equals('def');
    Test('WIDE.CopyRight(''abcdef'', 10)').Expect(WIDE.CopyRight(STR, 10)).Equals('abcdef');

    try
      WIDE.CopyRight(STR, -1);
      Test('WIDE.CopyRight(''abcdef'', -1)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyRight(''abcdef'', -1)').Expecting(EContractViolation);
    end;

  // CopyRight with Exclude Optional delimiter (default)

    Test('WIDE.CopyRight(''abcdef'', ''f'')').Expect(WIDE.CopyRight(STR, 'f')).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''d'')').Expect(WIDE.CopyRight(STR, 'd')).Equals('ef');
    Test('WIDE.CopyRight(''abcdef'', ''D'')').Expect(WIDE.CopyRight(STR, 'D')).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', '','')').Expect(WIDE.CopyRight(STR, ',')).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', ''ef'')').Expect(WIDE.CopyRight(STR, 'ef')).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''abc'')').Expect(WIDE.CopyRight(STR, 'abc')).Equals('def');
    Test('WIDE.CopyRight(''abcdef'', ''ABC'')').Expect(WIDE.CopyRight(STR, 'ABC')).Equals('abcdef');

  // CopyRight with Include Optional delimiter

    Test('WIDE.CopyRight(''abcdef'', ''f'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'f', doIncludeOptionalDelimiter)).Equals('f');
    Test('WIDE.CopyRight(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'd', doIncludeOptionalDelimiter)).Equals('def');
    Test('WIDE.CopyRight(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'D', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', ''ef'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'ef', doIncludeOptionalDelimiter)).Equals('ef');
    Test('WIDE.CopyRight(''abcdef'', ''abc'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'abc', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', ''ABC'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRight(STR, 'ABC', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyRight with Exclude Required delimiter

    Test('WIDE.CopyRight(''abcdef'', ''f'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'f', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'd', doExcludeRequiredDelimiter)).Equals('ef');
    Test('WIDE.CopyRight(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'D', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''ef'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'ef', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''abc'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'abc', doExcludeRequiredDelimiter)).Equals('def');
    Test('WIDE.CopyRight(''abcdef'', ''ABC'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'ABC', doExcludeRequiredDelimiter)).Equals('');

  // CopyRight with Include Required delimiter

    Test('WIDE.CopyRight(''abcdef'', ''f'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'f', doIncludeRequiredDelimiter)).Equals('f');
    Test('WIDE.CopyRight(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'd', doIncludeRequiredDelimiter)).Equals('def');
    Test('WIDE.CopyRight(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'D', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRight(''abcdef'', ''ef'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'ef', doIncludeRequiredDelimiter)).Equals('ef');
    Test('WIDE.CopyRight(''abcdef'', ''abc'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'abc', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRight(''abcdef'', ''ABC'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRight(STR, 'ABC', doIncludeRequiredDelimiter)).Equals('');

  // Case Insensitive calls

  // CopyRight with Exclude Optional delimiter (default)

    Test('WIDE.CopyRightText(''abcdef'', ''f'')').Expect(WIDE.CopyRightText(STR, 'f')).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''d'')').Expect(WIDE.CopyRightText(STR, 'd')).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', ''D'')').Expect(WIDE.CopyRightText(STR, 'D')).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', '','')').Expect(WIDE.CopyRightText(STR, ',')).Equals('abcdef');
    Test('WIDE.CopyRightText(''abcdef'', ''ef'')').Expect(WIDE.CopyRightText(STR, 'ef')).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''abc'')').Expect(WIDE.CopyRightText(STR, 'abc')).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', ''ABC'')').Expect(WIDE.CopyRightText(STR, 'ABC')).Equals('def');

  // CopyRightText with Include Optional delimiter

    Test('WIDE.CopyRightText(''abcdef'', ''f'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'f', doIncludeOptionalDelimiter)).Equals('f');
    Test('WIDE.CopyRightText(''abcdef'', ''d'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'd', doIncludeOptionalDelimiter)).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', ''D'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'D', doIncludeOptionalDelimiter)).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', '','', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, ',', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRightText(''abcdef'', ''ef'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'ef', doIncludeOptionalDelimiter)).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', ''abc'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'abc', doIncludeOptionalDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRightText(''abcdef'', ''ABC'', doIncludeOptionalDelimiter)').Expect(WIDE.CopyRightText(STR, 'ABC', doIncludeOptionalDelimiter)).Equals('abcdef');

  // CopyRightText with Exclude Required delimiter

    Test('WIDE.CopyRightText(''abcdef'', ''f'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'f', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''d'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'd', doExcludeRequiredDelimiter)).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', ''D'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'D', doExcludeRequiredDelimiter)).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', '','', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, ',', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''ef'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'ef', doExcludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''abc'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'abc', doExcludeRequiredDelimiter)).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', ''ABC'', doExcludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'ABC', doExcludeRequiredDelimiter)).Equals('def');

  // CopyRightText with Include Required delimiter

    Test('WIDE.CopyRightText(''abcdef'', ''f'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'f', doIncludeRequiredDelimiter)).Equals('f');
    Test('WIDE.CopyRightText(''abcdef'', ''d'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'd', doIncludeRequiredDelimiter)).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', ''D'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'D', doIncludeRequiredDelimiter)).Equals('def');
    Test('WIDE.CopyRightText(''abcdef'', '','', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, ',', doIncludeRequiredDelimiter)).Equals('');
    Test('WIDE.CopyRightText(''abcdef'', ''ef'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'ef', doIncludeRequiredDelimiter)).Equals('ef');
    Test('WIDE.CopyRightText(''abcdef'', ''abc'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'abc', doIncludeRequiredDelimiter)).Equals('abcdef');
    Test('WIDE.CopyRightText(''abcdef'', ''ABC'', doIncludeRequiredDelimiter)').Expect(WIDE.CopyRightText(STR, 'ABC', doIncludeRequiredDelimiter)).Equals('abcdef');

    try
      WIDE.CopyRight(STR, #0);
      Test('WIDE.CopyRight(''abcdef'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.CopyRight(''abcdef'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.CopyRight(STR, '');
      Test('WIDE.CopyRight(''abcdef'', '''')').Expecting(EContractViolation);
    except
      Test('WIDE.CopyRight(''abcdef'', '''')').Expecting(EContractViolation);
    end;
  end;














  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Replace;
  const
    STR = 'abcdef';
  var
    s: UnicodeString;
  begin
    Test('WIDE.Replace(''abcdef'', ''a'', ''X'')').Expect(WIDE.Replace(STR, 'a', 'X')).Equals('Xbcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', ''X'')').Expect(WIDE.Replace(STR, 'A', 'X')).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''a'', ''X'', var s) result').Expect(WIDE.Replace(STR, 'a', 'X', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''a'', ''X'', var s) var s').Expect(s).Equals('Xbcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', ''X'', var s) result').Expect(WIDE.Replace(STR, 'A', 'X', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcdef');

    Test('WIDE.Replace(''abcdef'', ''a'', ''XYZ'')').Expect(WIDE.Replace(STR, 'a', 'XYZ')).Equals('XYZbcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', ''XYZ'')').Expect(WIDE.Replace(STR, 'A', 'XYZ')).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''a'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'a', 'XYZ', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''a'', ''XYZ'', var s) var s').Expect(s).Equals('XYZbcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'A', 'XYZ', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcdef');

    s := 'abcdef';
    Test('WIDE.Replace(s, ''def'', ''abc'', var s) [where s = ''abcdef'']').Expect(WIDE.Replace(s, 'def', 'abc', s)).IsTRUE;
    Test('WIDE.Replace(s, ''def'', ''abc'', var s) [where s = ''abcdef'']').Expect(s).Equals('abcabc');

    s := 'x';
    Test('WIDE.Replace(''abcdef'', ''a'', s) [where s = ''x'']').Expect(WIDE.Replace(STR, 'a', s)).Equals('xbcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', s) [where s = ''x'']').Expect(WIDE.Replace(STR, 'abc', s)).Equals('xdef');

    Test('WIDE.Replace(''abcdef'', ''a'', '''')').Expect(WIDE.Replace(STR, 'a', '')).Equals('bcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', '''')').Expect(WIDE.Replace(STR, 'A', '')).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''a'', '''', var s) result').Expect(WIDE.Replace(STR, 'a', '', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''a'', '''', var s) var s').Expect(s).Equals('bcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', '''', var s) result').Expect(WIDE.Replace(STR, 'A', '', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''A'', '''', var s) var s').Expect(s).Equals('abcdef');

    Test('WIDE.Replace(''abcdef'', ''abc'', ''X'')').Expect(WIDE.Replace(STR, 'abc', 'X')).Equals('Xdef');
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''X'')').Expect(WIDE.Replace(STR, 'ABC', 'X')).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', ''X'', var s) result').Expect(WIDE.Replace(STR, 'abc', 'X', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''abc'', ''X'', var s) var s').Expect(s).Equals('Xdef');
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''X'', var s) result').Expect(WIDE.Replace(STR, 'ABC', 'X', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcdef');

    Test('WIDE.Replace(''abcdef'', ''abc'', '''')').Expect(WIDE.Replace(STR, 'abc', '')).Equals('def');
    Test('WIDE.Replace(''abcdef'', ''ab'', ''XYZ'')').Expect(WIDE.Replace(STR, 'ab', 'XYZ')).Equals('XYZcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', ''XYZ'')').Expect(WIDE.Replace(STR, 'abc', 'XYZ')).Equals('XYZdef');
    Test('WIDE.Replace(''abcdef'', ''abcd'', ''XYZ'')').Expect(WIDE.Replace(STR, 'abcd', 'XYZ')).Equals('XYZef');
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''XYZ'')').Expect(WIDE.Replace(STR, 'ABC', 'XYZ')).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', '''', var s) result').Expect(WIDE.Replace(STR, 'abc', '', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''abc'', '''', var s) var s').Expect(s).Equals('def');
    Test('WIDE.Replace(''abcdef'', ''ab'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'ab', 'XYZ', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''ab'', ''XYZ'', var s) var s').Expect(s).Equals('XYZcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'abc', 'XYZ', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''abc'', ''XYZ'', var s) var s').Expect(s).Equals('XYZdef');
    Test('WIDE.Replace(''abcdef'', ''abcd'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'abcd', 'XYZ', s)).IsTRUE;
    Test('WIDE.Replace(''abcdef'', ''abcd'', ''XYZ'', var s) var s').Expect(s).Equals('XYZef');
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''XYZ'', var s) result').Expect(WIDE.Replace(STR, 'ABC', 'XYZ', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''XYZ'', var s) var s').Expect(s).Equals('abcdef');

    Test('WIDE.Replace(''abcdef'', ''a'', ''a'', var s) result').Expect(WIDE.Replace(STR, 'a', 'a', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''a'', ''a'', var s) var s').Expect(s).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''A'', ''a'', var s) result').Expect(WIDE.Replace(STR, 'A', 'a', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''A'', ''a'', var s) var s').Expect(s).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''abc'', ''abc'', var s) result').Expect(WIDE.Replace(STR, 'abc', 'abc', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''abc'', ''abc'', var s) var s').Expect(s).Equals('abcdef');
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''abc'', var s) result').Expect(WIDE.Replace(STR, 'ABC', 'abc', s)).IsFALSE;
    Test('WIDE.Replace(''abcdef'', ''ABC'', ''abc'', var s) var s').Expect(s).Equals('abcdef');

    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''X'')').Expect(WIDE.ReplaceText(STR, 'A', 'X')).Equals('Xbcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''XYZ'')').Expect(WIDE.ReplaceText(STR, 'A', 'XYZ')).Equals('XYZbcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''A'', '''')').Expect(WIDE.ReplaceText(STR, 'A', '')).Equals('bcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''ABC'', ''X'')').Expect(WIDE.ReplaceText(STR, 'ABC', 'X')).Equals('Xdef');
    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''X'', var s) result').Expect(WIDE.ReplaceText(STR, 'A', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''X'', var s) var s').Expect(s).Equals('Xbcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''XYZ'', var s) result').Expect(WIDE.ReplaceText(STR, 'A', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceText(''abcdef'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('XYZbcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''A'', '''', var s) result').Expect(WIDE.ReplaceText(STR, 'A', '', s)).IsTRUE;
    Test('WIDE.ReplaceText(''abcdef'', ''A'', '''', var s) var s').Expect(s).Equals('bcdef');
    Test('WIDE.ReplaceText(''abcdef'', ''ABC'', ''X'', var s) result').Expect(WIDE.ReplaceText(STR, 'ABC', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceText(''abcdef'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('Xdef');

    try
      WIDE.Replace(STR, #0, 'a');
      Test('WIDE.Replace(''abcdef'', #0, ''a'')').Expecting(EContractViolation);
    except
      Test('WIDE.Replace(''abcdef'', #0, ''a'')').Expecting(EContractViolation);
    end;

    try
      WIDE.Replace(STR, '', 'a');
      Test('WIDE.Replace(''abcdef'', '''', ''a'')').Expecting(EContractViolation);
    except
      Test('WIDE.Replace(''abcdef'', '''', ''a'')').Expecting(EContractViolation);
    end;

    try
      WIDE.Replace(STR, 'a', #0);
      Test('WIDE.Replace(''abcdef'', ''a'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.Replace(''abcdef'', ''a'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.Replace(STR, 'abc', #0);
      Test('WIDE.Replace(''abcdef'', ''abc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.Replace(''abcdef'', ''abc'', #0)').Expecting(EContractViolation);
    end;
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_ReplaceAll;
  const
    STR = 'abracadabra';
  var
    s: UnicodeString;
  begin
    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''o'')').Expect(WIDE.ReplaceAll(STR, 'a', 'o')).Equals('obrocodobro');
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''o'')').Expect(WIDE.ReplaceAll(STR, 'A', 'o')).Equals('abracadabra');
    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''o'', var s) result').Expect(WIDE.ReplaceAll(STR, 'a', 'o', s)).IsTRUE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''o'', var s) var s').Expect(s).Equals('obrocodobro');
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''o'', var s) result').Expect(WIDE.ReplaceAll(STR, 'A', 'o', s)).IsFALSE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''o'', var s) var s').Expect(s).Equals('abracadabra');

    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''oo'')').Expect(WIDE.ReplaceAll(STR, 'a', 'oo')).Equals('oobroocoodoobroo');
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''oo'')').Expect(WIDE.ReplaceAll(STR, 'A', 'oo')).Equals('abracadabra');
    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''oo'', var s) result').Expect(WIDE.ReplaceAll(STR, 'a', 'oo', s)).IsTRUE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''a'', ''oo'', var s) var s').Expect(s).Equals('oobroocoodoobroo');
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''oo'', var s) result').Expect(WIDE.ReplaceAll(STR, 'A', 'oo', s)).IsFALSE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''A'', ''oo'', var s) var s').Expect(s).Equals('abracadabra');

    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''y'')').Expect(WIDE.ReplaceAll(STR, 'bra', 'y')).Equals('aycaday');
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''y'')').Expect(WIDE.ReplaceAll(STR, 'BRA', 'y')).Equals('abracadabra');
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''y'', var s) result').Expect(WIDE.ReplaceAll(STR, 'bra', 'y', s)).IsTRUE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''y'', var s) var s').Expect(s).Equals('aycaday');
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''y'', var s) result').Expect(WIDE.ReplaceAll(STR, 'BRA', 'y', s)).IsFALSE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''y'', var s) var s').Expect(s).Equals('abracadabra');

    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''ky'')').Expect(WIDE.ReplaceAll(STR, 'bra', 'ky')).Equals('akycadaky');
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''cky'')').Expect(WIDE.ReplaceAll(STR, 'bra', 'cky')).Equals('ackycadacky');
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''ckys'')').Expect(WIDE.ReplaceAll(STR, 'bra', 'ckys')).Equals('ackyscadackys');
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''cky'')').Expect(WIDE.ReplaceAll(STR, 'BRA', 'cky')).Equals('abracadabra');
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''cky'', var s) result').Expect(WIDE.ReplaceAll(STR, 'bra', 'cky', s)).IsTRUE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''bra'', ''cky'', var s) var s').Expect(s).Equals('ackycadacky');
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''cky'', var s) result').Expect(WIDE.ReplaceAll(STR, 'BRA', 'kyy', s)).IsFALSE;
    Test('WIDE.ReplaceAll(''abracadabra'', ''BRA'', ''cky'', var s) var s').Expect(s).Equals('abracadabra');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_ReplaceLast;
  const
    STR = 'abcabc';
  var
    s: UnicodeString;
  begin
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''X'')').Expect(WIDE.ReplaceLast(STR, 'a', 'X')).Equals('abcXbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''X'')').Expect(WIDE.ReplaceLast(STR, 'A', 'X')).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''X'', var s) result').Expect(WIDE.ReplaceLast(STR, 'a', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''X'', var s) var s').Expect(s).Equals('abcXbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''X'', var s) result').Expect(WIDE.ReplaceLast(STR, 'A', 'X', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcabc');

    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''XYZ'')').Expect(WIDE.ReplaceLast(STR, 'a', 'XYZ')).Equals('abcXYZbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''XYZ'')').Expect(WIDE.ReplaceLast(STR, 'A', 'XYZ')).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast(STR, 'a', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast(STR, 'A', 'XYZ', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcabc');

    s := 'x';
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', s) [where s = ''x'']').Expect(WIDE.ReplaceLast(STR, 'a', s)).Equals('abcxbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', s) [where s = ''x'']').Expect(WIDE.ReplaceLast(STR, 'abc', s)).Equals('abcx');

    Test('WIDE.ReplaceLast(''abcabc'', ''a'', '''')').Expect(WIDE.ReplaceLast(STR, 'a', '')).Equals('abcbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', '''')').Expect(WIDE.ReplaceLast(STR, 'A', '')).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', '''', var s) result').Expect(WIDE.ReplaceLast(STR, 'a', '', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', '''', var s) var s').Expect(s).Equals('abcbc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', '''', var s) result').Expect(WIDE.ReplaceLast(STR, 'A', '', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', '''', var s) var s').Expect(s).Equals('abcabc');

    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''X'')').Expect(WIDE.ReplaceLast(STR, 'abc', 'X')).Equals('abcX');
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''X'')').Expect(WIDE.ReplaceLast(STR, 'ABC', 'X')).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''X'', var s) result').Expect(WIDE.ReplaceLast(STR, 'abc', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''X'', var s) var s').Expect(s).Equals('abcX');
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''X'', var s) result').Expect(WIDE.ReplaceLast(STR, 'ABC', 'X', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcabc');

    Test('WIDE.ReplaceLast(''abcdabc'', ''abc'', '''')').Expect(WIDE.ReplaceLast('abcdabc', 'abc', '')).Equals('abcd');
    Test('WIDE.ReplaceLast(''abcabc'', ''ab'', ''XYZ'')').Expect(WIDE.ReplaceLast(STR, 'ab', 'XYZ')).Equals('abcXYZc');
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''XYZ'')').Expect(WIDE.ReplaceLast(STR, 'abc', 'XYZ')).Equals('abcXYZ');
    Test('WIDE.ReplaceLast(''abcabca'', ''abca'', ''XYZ'')').Expect(WIDE.ReplaceLast('abcabca', 'abca', 'XYZ')).Equals('abcXYZ');
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'')').Expect(WIDE.ReplaceLast(STR, 'ABC', 'XYZ')).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcdabc'', ''abc'', '''', var s) result').Expect(WIDE.ReplaceLast('abcdabc', 'abc', '', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', '''', var s) var s').Expect(s).Equals('abcd');
    Test('WIDE.ReplaceLast(''abcabc'', ''ab'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast(STR, 'ab', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''ab'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZc');
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast(STR, 'abc', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZ');
    Test('WIDE.ReplaceLast(''abcabca'', ''abcd'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast('abcabca', 'abca', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceLast(''abcabc'', ''abcd'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZ');
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLast(STR, 'ABC', 'XYZ', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''XYZ'', var s) var s').Expect(s).Equals('abcabc');

    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''a'', var s) result').Expect(WIDE.ReplaceLast(STR, 'a', 'a', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''a'', ''a'', var s) var s').Expect(s).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''a'', var s) result').Expect(WIDE.ReplaceLast(STR, 'A', 'a', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''A'', ''a'', var s) var s').Expect(s).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''abc'', var s) result').Expect(WIDE.ReplaceLast(STR, 'abc', 'abc', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''abc'', ''abc'', var s) var s').Expect(s).Equals('abcabc');
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''abc'', var s) result').Expect(WIDE.ReplaceLast(STR, 'ABC', 'abc', s)).IsFALSE;
    Test('WIDE.ReplaceLast(''abcabc'', ''ABC'', ''abc'', var s) var s').Expect(s).Equals('abcabc');

    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''X'')').Expect(WIDE.ReplaceLastText(STR, 'A', 'X')).Equals('abcXbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''XYZ'')').Expect(WIDE.ReplaceLastText(STR, 'A', 'XYZ')).Equals('abcXYZbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', '''')').Expect(WIDE.ReplaceLastText(STR, 'A', '')).Equals('abcbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''ABC'', ''X'')').Expect(WIDE.ReplaceLastText(STR, 'ABC', 'X')).Equals('abcX');
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''X'', var s) result').Expect(WIDE.ReplaceLastText(STR, 'A', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''X'', var s) var s').Expect(s).Equals('abcXbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''XYZ'', var s) result').Expect(WIDE.ReplaceLastText(STR, 'A', 'XYZ', s)).IsTRUE;
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', ''XYZ'', var s) var s').Expect(s).Equals('abcXYZbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', '''', var s) result').Expect(WIDE.ReplaceLastText(STR, 'A', '', s)).IsTRUE;
    Test('WIDE.ReplaceLastText(''abcabc'', ''A'', '''', var s) var s').Expect(s).Equals('abcbc');
    Test('WIDE.ReplaceLastText(''abcabc'', ''ABC'', ''X'', var s) result').Expect(WIDE.ReplaceLastText(STR, 'ABC', 'X', s)).IsTRUE;
    Test('WIDE.ReplaceLastText(''abcabc'', ''ABC'', ''X'', var s) var s').Expect(s).Equals('abcX');

    try
      WIDE.ReplaceLast(STR, #0, 'a');
      Test('WIDE.ReplaceLast(''abcabc'', #0, ''a'')').Expecting(EContractViolation);
    except
      Test('WIDE.ReplaceLast(''abcabc'', #0, ''a'')').Expecting(EContractViolation);
    end;

    try
      WIDE.ReplaceLast(STR, '', 'a');
      Test('WIDE.ReplaceLast(''abcabc'', '''', ''a'')').Expecting(EContractViolation);
    except
      Test('WIDE.ReplaceLast(''abcabc'', '''', ''a'')').Expecting(EContractViolation);
    end;

    try
      WIDE.ReplaceLast(STR, 'a', #0);
      Test('WIDE.ReplaceLast(''abcabc'', ''a'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.ReplaceLast(''abcabc'', ''a'', #0)').Expecting(EContractViolation);
    end;

    try
      WIDE.ReplaceLast(STR, 'abc', #0);
      Test('WIDE.ReplaceLast(''abcabc'', ''abc'', #0)').Expecting(EContractViolation);
    except
      Test('WIDE.ReplaceLast(''abcabc'', ''abc'', #0)').Expecting(EContractViolation);
    end;
  end;

















  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Trim;
  begin
    Test('WIDE.Trim(''   foo   '')').Expect(WIDE.Trim('   foo   ')).Equals('foo');
    Test('WIDE.Trim(''   foo   '', ''.'')').Expect(WIDE.Trim('   foo   ', WIDEChar('.'))).Equals('   foo   ');
    Test('WIDE.Trim(''   foo   '', 1)').Expect(WIDE.Trim('   foo   ', 1)).Equals('  foo  ');
    Test('WIDE.Trim(''   foo   '', 4)').Expect(WIDE.Trim('   foo   ', 4)).Equals('o');
    Test('WIDE.Trim(''   foo   '', 5)').Expect(WIDE.Trim('   foo   ', 5)).Equals('');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_TrimLeft;
  begin
    Test('WIDE.TrimLeft(''   foo'')').Expect(WIDE.LTrim('   foo')).Equals('foo');
    Test('WIDE.TrimLeft(''   foo'', ''.'')').Expect(WIDE.LTrim('   foo', WIDEChar('.'))).Equals('   foo');
    Test('WIDE.TrimLeft(''   foo'', 1)').Expect(WIDE.LTrim('   foo', 1)).Equals('  foo');
    Test('WIDE.TrimLeft(''   foo'', 4)').Expect(WIDE.LTrim('   foo', 4)).Equals('oo');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_TrimRight;
  begin
    Test('WIDE.TrimRight(''foo   '')').Expect(WIDE.RTrim('foo   ')).Equals('foo');
    Test('WIDE.TrimRight(''foo   '', ''.'')').Expect(WIDE.RTrim('foo   ', WIDEChar('.'))).Equals('foo   ');
    Test('WIDE.TrimRight(''foo   '', 1)').Expect(WIDE.RTrim('foo   ', 1)).Equals('foo  ');
    Test('WIDE.TrimRight(''foo   '', 4)').Expect(WIDE.RTrim('foo   ', 4)).Equals('fo');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Unbrace;
  begin
    Test('WIDE.Unbrace(''(abc)'')').Expect(WIDE.Unbrace('(abc)')).Equals('abc');
    Test('WIDE.Unbrace(''(abc)'')').Expect(WIDE.Unbrace('(abc)')).Equals('abc');
    Test('WIDE.Unbrace(''[abc]'')').Expect(WIDE.Unbrace('[abc]')).Equals('abc');
    Test('WIDE.Unbrace(''{abc}'')').Expect(WIDE.Unbrace('{abc}')).Equals('abc');
    Test('WIDE.Unbrace(''<abc>'')').Expect(WIDE.Unbrace('<abc>')).Equals('abc');
    Test('WIDE.Unbrace(''#abc#'')').Expect(WIDE.Unbrace('#abc#')).Equals('abc');
    Test('WIDE.Unbrace(''?abc?'')').Expect(WIDE.Unbrace('?abc?')).Equals('abc');
    Test('WIDE.Unbrace(''abc'')').Expect(WIDE.Unbrace('abc')).Equals('abc');
  end;


  { - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - }
  procedure TWIDETests.fn_Unquote;
  begin
    Test('WIDE.Unquote(''Some Mothers Do ''''Ave ''''Em'')').Expect(WIDE.Unquote('''Some Mothers Do ''''Ave ''''Em''')).Equals('Some Mothers Do ''Ave ''Em');
    Test('WIDE.Unquote("Some Mothers Do ''Ave ''Em")').Expect(WIDE.Unquote('"Some Mothers Do ''Ave ''Em"')).Equals('Some Mothers Do ''Ave ''Em');
    Test('WIDE.Unquote(''Mother knows best'')').Expect(WIDE.Unquote('''Mother knows best''')).Equals('Mother knows best');
    Test('WIDE.Unquote("Mother knows best")').Expect(WIDE.Unquote('"Mother knows best"')).Equals('Mother knows best');
  end;















end.

