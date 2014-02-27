%{
{/*
 * Word recognizer with a symbol table.
 */}

%}
%%

\n	 state := LOOKUP; 	{/* end of line, reset/return to default state */}

 //* whenever a line startse with a reseved part of speechname
 //* start defining words of that type

^verb	state := VERB; 
^adj	state := ADJ; 
^adv	state := ADV; 
^noun	state := NOUN; 
^prep	state := PREP; 
^pron	state := PRON; 
^conj	state := CONJ; 

[a-zA-Z]+  
		begin
			        if state <> LOOKUP then
		          begin
			          //{/* define the current word */}
			     	    addWord(state, yytext);
			        end
			        else
			        begin
				        case lookupWord(yytext) of
				          VERB: writecallback(yytext+': verb');
				          ADJ: writecallback(yytext+': adjective');
				          ADV: writecallback(yytext+': adverb');
				          NOUN: writecallback(yytext+': noun');
				          PREP: writecallback(yytext+': preposition');
				          PRON: writecallback(yytext+': pronoun');
				          CONJ: writecallback(yytext+': conjunction');
				          else
					          writecallback(yytext+':  dont recognize');
                end;
		          end;
       end;
          
.    ; //* ignore anything else */} 


%%

