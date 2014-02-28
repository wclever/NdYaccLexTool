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