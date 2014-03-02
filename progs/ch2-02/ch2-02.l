%{
	var
		charCount : Integer = 0;
		wordCount : Integer = 0;
		lineCount : Integer = 0;
%}

word [^ \t\n]+
eol  \n
%%
{word}	begin Inc(wordCount); charCount := charCount + length(yytext); end;
{eol}	begin Inc(charCount); Inc(lineCount); end;
.	Inc(charCount);
%%
