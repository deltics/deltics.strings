
{$i deltics.strings.inc}

{$ifNdef debug_DelticsStrings}
  {$ifdef InlineMethodsSupported}
    {$define InlineMethods}
  {$endif}
  {$debuginfo OFF}
{$endif}

{$ifdef debug_DelticsStringsParsers}
  {$undef InlineMethods}
  {$debuginfo ON}
{$endif}
