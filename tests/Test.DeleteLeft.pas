

  unit Test.DeleteLeft;

interface

  uses
    Deltics.Smoketest;


  type
    DeleteLeft = class(TTest)
      procedure RaisesArgumentExceptionIfDeletingNegativeNumberOfCharacters;
      procedure RemovesNumberOfCharsFromNonEmptyString;
      procedure YieldsEmptyStringWhenDeletingMoreCharactersThanAreInTheOriginalString;
      procedure YieldsEmptyStringWhenInputStringIsEmpty;
    end;

implementation

  uses
    Deltics.Exceptions,
    Deltics.Strings;


{ TAnsiDeletion }

  procedure DeleteLeft.RaisesArgumentExceptionIfDeletingNegativeNumberOfCharacters;
  var
    sa: AnsiString;
    sw: UnicodeString;
  begin
    sa := 'abcdef';
    sw := 'abcdef';

    try
      ANSI.DeleteLeft(sa, -1);

      Test.FailedToRaiseException;
    except
      Test('ANSI.').RaisedException(EArgumentException);
    end;

    try
      WIDE.DeleteLeft(sw, -1);

      Test.FailedToRaiseException;
    except
      Test('WIDE.').RaisedException(EArgumentException);
    end;
  end;


  procedure DeleteLeft.RemovesNumberOfCharsFromNonEmptyString;
  var
    sa: AnsiString;
    sw: UnicodeString;
  begin
    sa := 'abcdef';
    sw := 'abcdef';

    ANSI.DeleteLeft(sa, 1);
    WIDE.DeleteLeft(sw, 1);

    Test('ANSI.(''abcdef'', 1)').Assert(sa).Equals('bcdef');
    Test('WIDE.(''abcdef'', 1)').Assert(sw).Equals('bcdef');
  end;


  procedure DeleteLeft.YieldsEmptyStringWhenDeletingMoreCharactersThanAreInTheOriginalString;
  var
    sa: AnsiString;
    sw: UnicodeString;
  begin
    sa := 'abcdef';
    sw := 'abcdef';

    ANSI.DeleteLeft(sa, 8);
    WIDE.DeleteLeft(sw, 8);

    Test('ANSI.(''abcdef'', 8)').Assert(sa).Equals('');
    Test('WIDE.(''abcdef'', 8)').Assert(sw).Equals('');
  end;


  procedure DeleteLeft.YieldsEmptyStringWhenInputStringIsEmpty;
  var
    sa: AnsiString;
    sw: UnicodeString;
  begin
    sa := '';
    sw := '';

    ANSI.DeleteLeft(sa, 8);
    WIDE.DeleteLeft(sw, 8);

    Test('ANSI.('''', 8)').Assert(sa).Equals('');
    Test('WIDE.('''', 8)').Assert(sw).Equals('');
  end;



end.
