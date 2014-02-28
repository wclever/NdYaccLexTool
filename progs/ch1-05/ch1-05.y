%{
///*
 //* A lexer for the basic grammar to use for recognizing english sentences.
 //*/
 
 unit expr;
 
 interface
 
 uses
 	SysUtils,
 	Classes,
 	yacclib,
 	lexlib,
        uStreamLexer;
        
%}

%token NOUN PRONOUN VERB ADVERB ADJECTIVE PREPOSITION CONJUNCTION
%%
sentence: subject VERB object	{ writecallback('Sentence is valid'); }
	;

subject:	NOUN
	|	PRONOUN
	;

object:		NOUN
	;
%%

{$I exprlex.pas}

end.