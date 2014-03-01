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

function TExprLexer.addWord(_type:TState; word: String):Integer;
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

    function TExprLexer.lookupWord(word: String):TState;
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
      result := TState.LOOKUP;
    end;