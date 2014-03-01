%{
	var
		charCount : Integer = 0;
		wordCount : Integer = 0;
		lineCount : Integer = 0;
%}

word [^ \t\n]+
eol  \n
%%
{word}	begin Inc(wordCount); charCount := charCount + yyleng; end;
{eol}	begin Inc(charCount); Inc(lineCount); end;
.	Inc(charCount);
%%
main(argc,argv)
int argc;
char **argv;
{

	if (argc > 1) {
		FILE *file;

		file = fopen(argv[1], "r");
		if (!file) {
			fprintf(stderr,"could not open %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	yylex();
	printf("%d %d %d\n",charCount, wordCount, lineCount);
	return 0;
}
