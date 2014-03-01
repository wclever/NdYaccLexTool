%{
//*
// * We now build a lexical analyzer to be used by a higher-level parser.
// */

//#include "ch1-05y.h"	/* token codes from the parser */

//#define LOOKUP 0 /* default - not a defined word type. */

//int state; 
const LOOKUP = 0;

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
			VERB: return( VERB);
			ADJECTIVE: return( ADJECTIVE);
			ADVERB: return( ADVERB);
			NOUN: return( NOUN);
			PREPOSITION:  return( PREPOSITION);
			PRONOUN: return( PRONOUN);
			CONJUNCTION: return( CONJUNCTION);
		else
		  writecallback(yytext+':  dont recognize');
		  //* don't return, just ignore it */
          end;
          end;
          end;

.	; //* ignore anything else */} 

%%
function TExprLexer.addWord(_type:Integer; word: String):Integer;
    var
       newWp : pWord;
       givenWp : pWord;
    begin
      if lookupWord(word) <> LOOKUP then
      begin
        writecallback('warning: word '+word+' already defined');
        result := 0;
        exit;
      end;
      {/* word not there, allocate a new entry and link it on the list */}

      new(newWp);
      givenWp := Addr(wordList);
      newWp^.next := givenWp^.next;
      newWp^.wordName:= word;
      newWp^.wordType := _type;
      givenWp^.next := newWp;
      result := 1; {it worked}
    end;

    function TExprLexer.lookupWord(word: String):Integer;
    var
      wp : TWord;
    begin
      wp := wordList;
      {/* search down the list looking for the word */}
      while true do
      begin
        if wp.wordName=word then
        begin
          result := wp.wordType;
          exit;
        end;
        if wp.next=nil then break;
        wp := wp.next^;
      end;
      result := LOOKUP;
    end;