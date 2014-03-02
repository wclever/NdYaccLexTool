%{
//*
// * ch2-03.l
// *
// * The word counter example for multiple files
// *
// */

%}

word [^ \t\n]+
eol  \n
%%
{word}	begin Inc(wordCount); charCount := charCount + length(yytext); end;
{eol}	begin Inc(charCount); Inc(lineCount); end;
.	Inc(charCount);
%%

