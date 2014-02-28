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
        
            const
	    NOUN = 257;
	    PRONOUN = 258;
	    VERB = 259;
	    ADVERB = 260;
	    ADJECTIVE = 261;
	    PREPOSITION = 262;
	    CONJUNCTION = 263;
	    LOOKUP = 0;

%}

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
