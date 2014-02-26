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
go		 writecallback(yytext+': is a verb'); 

very |
simply |
gently |
quietly |
calmly |
angrily		writecallback(yytext+': is an adverb'); 

to |
from |
behind |
above |
below |
between |
below		writecallback(yytext+': is a preposition'); 

if |
then |
and |
but |
or		writecallback(yytext+': is a conjunction'); 

their |
my |
your |
his |
her |
its		writecallback(yytext+': is an adjective'); 

I |
you |
he |
she |
we |
they		writecallback(yytext+': in a pronoun'); 


[a-zA-Z]+ 
	 writecallback(yytext+':  don't recognize, might be a noun');
	

\&.|		writecallback(yytext);

%%

