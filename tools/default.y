%{
unit expr;

interface

uses
	SysUtils,
	Classes,
	yacclib,
	lexlib,
        uStreamLexer;



%}


%%

input	: /* empty */
	;

expr    : ;

%%

{$I exprlex.pas}

end.