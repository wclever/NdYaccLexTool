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

sentence: simple_sentence   { writecallback('Parsed a simple sentence.'); }
	| compound_sentence { writecallback('Parsed a compound sentence.'); }
	; 

simple_sentence: subject verb object
	|	subject verb object prep_phrase
	;

compound_sentence: simple_sentence CONJUNCTION simple_sentence
	|	compound_sentence CONJUNCTION simple_sentence
	;

subject:	NOUN
	|	PRONOUN
	|	ADJECTIVE subject
	;

verb:		VERB
	|	ADVERB VERB
	|	verb VERB
	;
	
object:		NOUN
	|	ADJECTIVE object
	;

prep_phrase:	PREPOSITION NOUN
	;

%%

{$I exprlex.pas}

end.
