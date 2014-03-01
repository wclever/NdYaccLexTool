%%
[\n\t ]	;

-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) writecallback(yytext+': number');

.	writecallback(yytext+': not a number');
%%
