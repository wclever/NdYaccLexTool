%{
//*
// * We now build a lexical analyzer to be used by a higher-level parser.
// */

//#include "ch1-05y.h"	/* token codes from the parser */

//#define LOOKUP 0 /* default - not a defined word type. */

//int state; 

%}

%%

\n	 state := LOOKUP; 	{/* end of line, reset/return to default state */}

\.\n	begin
	state := LOOKUP;
	result := 0; //* end of sentence */
	end;
	

^verb	 state := VERB; 
^adj	 state := ADJECTIVE; 
^adv	 state := ADVERB; 
^noun	 state := NOUN; 
^prep	 state := PREPOSITION; 
^pron	 state := PRONOUN; 
^conj	 state := CONJUNCTION; 

[a-zA-Z]+ begin 
	     if state <> LOOKUP then
	     begin
	     	//{/* define the current word */}
	     	addWord(state, yytext);
	     end
	     else
	     begin
		case lookupWord(yytext) of
			VERB: result := VERB;
			ADJECTIVE: result := ADJECTIVE;
			ADVERB: result := ADVERB;
			NOUN: result := NOUN;
			PREPOSITION:  result := PREPOSITION;
			PRONOUN: result := PRONOUN;
			CONJUNCTION: result := CONJUNCTION;
		else
		  writecallback(yytext+':  dont recognize');
		  //* don't return, just ignore it */
          end;
          end;
          end;

.	; //* ignore anything else */} 

%%