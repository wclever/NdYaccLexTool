%{
{
 * this sample demonstrates (very) simple recognition:
 * a verb/not a verb.
 }

%}
%%

[\t ]+		{ ignore white space } ;

is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go		 writecallback(yytext+' is a verb'); 

[a-zA-Z]+ 	writecallback(yytext+' is not a verb');

.|\n		writecallback(yytext); { normal default anyway }
%%

