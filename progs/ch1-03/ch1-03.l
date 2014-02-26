%{
{/*
 * We expand upon the first example by adding recognition of some other
 * parts of speech.
 */}

%}
%%

[\t ]+		/* ignore white space */ ;

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
go		 writecallback(yytext+': is a verb\n'); 

very |
simply |
gently |
quietly |
calmly |
angrily		writecallback(yytext+': is an adverb\n'); 

to |
from |
behind |
above |
below |
between |
below		writecallback(yytext+': is a preposition\n'); 

if |
then |
and |
but |
or		writecallback(yytext+': is a conjunction\n'); 

their |
my |
your |
his |
her |
its		writecallback(yytext+': is an adjective\n'); 

I |
you |
he |
she |
we |
they		writecallback(yytext+': in a pronoun\n'); 


[a-zA-Z]+ {
	 writecallback(yytext+':  don't recognize, might be a noun\n');
	}

\&.|\n		writecallback(yytext);

%%

{main()
{
	yylex();
}}
