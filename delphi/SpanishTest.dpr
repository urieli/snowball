program SpanishTest;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  SnowballProgram in 'SnowballProgram.pas',
  SpanishStemmer in 'SpanishStemmer.pas';

Var
    Stemmer : TSpanishStemmer;
    CurWord : AnsiString;

Const
    Delimiters : Set Of Char = [' ', #9, #10, #13];

Function NextWord : Boolean;
Var C : Char;
Begin
    CurWord := '';

    While Not Eof Do
    Begin
        Read(C);
        If IOResult <> 0 Then Break;
        If C In Delimiters Then Break;
        CurWord := CurWord + C;
    End;

    Result := Length(CurWord) <> 0;
End;

begin
    Stemmer := TSpanishStemmer.Create;

    Try
        While Not Eof Do
        Begin
            While NextWord Do
            Begin
                Stemmer.Current := CurWord;
                Stemmer.Stem;
                WriteLn(Stemmer.Current);
            End;
        End;
    Finally
        Stemmer.Free;
    End;
end.
