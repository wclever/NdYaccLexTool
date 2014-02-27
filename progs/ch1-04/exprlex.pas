{/*
 * Word recognizer with a symbol table.
 */}


function TExprLexer.parse() : integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)

begin
  (* actions: *)
  case yyruleno of
  1:
  	 state := LOOKUP; 	{/* end of line, reset/return to default state */}

 //* whenever a line startse with a reseved part of speechname
 //* start defining words of that type

  2:
     	state := VERB; 
  3:
    	state := ADJ; 
  4:
    	state := ADV; 
  5:
     	state := NOUN; 
  6:
     	state := PREP; 
  7:
     	state := PRON; 
  8:
     	state := CONJ; 

  9:
           
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
          
  10:
     ; //* ignore anything else */} 


  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 39;
yynmatches = 39;
yyntrans   = 52;
yynstates  = 28;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  { 3: }
  9,
  10,
  { 4: }
  10,
  { 5: }
  9,
  10,
  { 6: }
  9,
  10,
  { 7: }
  9,
  10,
  { 8: }
  9,
  10,
  { 9: }
  9,
  { 10: }
  9,
  { 11: }
  9,
  { 12: }
  9,
  { 13: }
  9,
  { 14: }
  9,
  { 15: }
  9,
  { 16: }
  3,
  9,
  { 17: }
  4,
  9,
  { 18: }
  9,
  { 19: }
  9,
  { 20: }
  2,
  9,
  { 21: }
  5,
  9,
  { 22: }
  6,
  9,
  { 23: }
  7,
  9,
  { 24: }
  8,
  9,
  { 25: }
  9,
  10,
  { 26: }
  9,
  { 27: }
  9
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
{ 3: }
  9,
  10,
{ 4: }
  10,
{ 5: }
  9,
  10,
{ 6: }
  9,
  10,
{ 7: }
  9,
  10,
{ 8: }
  9,
  10,
{ 9: }
  9,
{ 10: }
  9,
{ 11: }
  9,
{ 12: }
  9,
{ 13: }
  9,
{ 14: }
  9,
{ 15: }
  9,
{ 16: }
  3,
  9,
{ 17: }
  4,
  9,
{ 18: }
  9,
{ 19: }
  9,
{ 20: }
  2,
  9,
{ 21: }
  5,
  9,
{ 22: }
  6,
  9,
{ 23: }
  7,
  9,
{ 24: }
  8,
  9,
{ 25: }
  9,
  10,
{ 26: }
  9,
{ 27: }
  9
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#9,#11..'@','['..'`','{'..#255 ]; s: 4),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 3),
{ 1: }
  ( cc: [ #1..#9,#11..'@','['..'`','{'..#255 ]; s: 4),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ 'A'..'Z','b','d'..'m','o','q'..'u','w'..'z' ]; s: 3),
  ( cc: [ 'a' ]; s: 6),
  ( cc: [ 'c' ]; s: 25),
  ( cc: [ 'n' ]; s: 7),
  ( cc: [ 'p' ]; s: 8),
  ( cc: [ 'v' ]; s: 5),
{ 2: }
{ 3: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 4: }
{ 5: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'z' ]; s: 9),
  ( cc: [ 'e' ]; s: 10),
{ 6: }
  ( cc: [ 'A'..'Z','a'..'c','e'..'z' ]; s: 9),
  ( cc: [ 'd' ]; s: 11),
{ 7: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 9),
  ( cc: [ 'o' ]; s: 12),
{ 8: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 9),
  ( cc: [ 'r' ]; s: 13),
{ 9: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 10: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 9),
  ( cc: [ 'r' ]; s: 15),
{ 11: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'u','w'..'z' ]; s: 9),
  ( cc: [ 'j' ]; s: 16),
  ( cc: [ 'v' ]; s: 17),
{ 12: }
  ( cc: [ 'A'..'Z','a'..'t','v'..'z' ]; s: 9),
  ( cc: [ 'u' ]; s: 26),
{ 13: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'n','p'..'z' ]; s: 9),
  ( cc: [ 'e' ]; s: 18),
  ( cc: [ 'o' ]; s: 27),
{ 14: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 9),
  ( cc: [ 'n' ]; s: 19),
{ 15: }
  ( cc: [ 'A'..'Z','a','c'..'z' ]; s: 9),
  ( cc: [ 'b' ]; s: 20),
{ 16: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 17: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 18: }
  ( cc: [ 'A'..'Z','a'..'o','q'..'z' ]; s: 9),
  ( cc: [ 'p' ]; s: 22),
{ 19: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'z' ]; s: 9),
  ( cc: [ 'j' ]; s: 24),
{ 20: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 21: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 22: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 23: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 24: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 9),
{ 25: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 9),
  ( cc: [ 'o' ]; s: 14),
{ 26: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 9),
  ( cc: [ 'n' ]; s: 21),
{ 27: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 9),
  ( cc: [ 'n' ]; s: 23)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 4,
{ 5: } 5,
{ 6: } 7,
{ 7: } 9,
{ 8: } 11,
{ 9: } 13,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 20,
{ 17: } 22,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 28,
{ 22: } 30,
{ 23: } 32,
{ 24: } 34,
{ 25: } 36,
{ 26: } 38,
{ 27: } 39
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 3,
{ 4: } 4,
{ 5: } 6,
{ 6: } 8,
{ 7: } 10,
{ 8: } 12,
{ 9: } 13,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 21,
{ 17: } 23,
{ 18: } 24,
{ 19: } 25,
{ 20: } 27,
{ 21: } 29,
{ 22: } 31,
{ 23: } 33,
{ 24: } 35,
{ 25: } 37,
{ 26: } 38,
{ 27: } 39
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 4,
{ 5: } 5,
{ 6: } 7,
{ 7: } 9,
{ 8: } 11,
{ 9: } 13,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 20,
{ 17: } 22,
{ 18: } 24,
{ 19: } 25,
{ 20: } 26,
{ 21: } 28,
{ 22: } 30,
{ 23: } 32,
{ 24: } 34,
{ 25: } 36,
{ 26: } 38,
{ 27: } 39
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 3,
{ 4: } 4,
{ 5: } 6,
{ 6: } 8,
{ 7: } 10,
{ 8: } 12,
{ 9: } 13,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 21,
{ 17: } 23,
{ 18: } 24,
{ 19: } 25,
{ 20: } 27,
{ 21: } 29,
{ 22: } 31,
{ 23: } 33,
{ 24: } 35,
{ 25: } 37,
{ 26: } 38,
{ 27: } 39
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 4,
{ 2: } 12,
{ 3: } 12,
{ 4: } 13,
{ 5: } 13,
{ 6: } 15,
{ 7: } 17,
{ 8: } 19,
{ 9: } 21,
{ 10: } 22,
{ 11: } 24,
{ 12: } 27,
{ 13: } 29,
{ 14: } 32,
{ 15: } 34,
{ 16: } 36,
{ 17: } 37,
{ 18: } 38,
{ 19: } 40,
{ 20: } 42,
{ 21: } 43,
{ 22: } 44,
{ 23: } 45,
{ 24: } 46,
{ 25: } 47,
{ 26: } 49,
{ 27: } 51
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 3,
{ 1: } 11,
{ 2: } 11,
{ 3: } 12,
{ 4: } 12,
{ 5: } 14,
{ 6: } 16,
{ 7: } 18,
{ 8: } 20,
{ 9: } 21,
{ 10: } 23,
{ 11: } 26,
{ 12: } 28,
{ 13: } 31,
{ 14: } 33,
{ 15: } 35,
{ 16: } 36,
{ 17: } 37,
{ 18: } 39,
{ 19: } 41,
{ 20: } 42,
{ 21: } 43,
{ 22: } 44,
{ 23: } 45,
{ 24: } 46,
{ 25: } 48,
{ 26: } 50,
{ 27: } 52
);


var 
	yyn : Integer;

label start, scan, action;

begin
start:

  (* initialize: *)

  yynew;

scan:

  (* mark positions and matches: *)

  for yyn := yykl[yystate] to     yykh[yystate] do yymark(yyk[yyn]);
  for yyn := yymh[yystate] downto yyml[yystate] do yymatch(yym[yyn]);

  if yytl[yystate]>yyth[yystate] then goto action; (* dead state *)

  (* get next character: *)

  yyscan;

  (* determine action: *)

  yyn := yytl[yystate];
  while (yyn<=yyth[yystate]) and not (yyactchar in yyt[yyn].cc) do inc(yyn);
  if yyn>yyth[yystate] then goto action;
    (* no transition on yyactchar in this state *)

  (* switch to new state: *)

  yystate := yyt[yyn].s;

  goto scan;

action:

  (* execute action: *)

  if yyfind(yyrule) then
    begin
      yyaction(yyrule);
      if yyreject then goto action;
    end
  else if not yydefault and yywrap then
    begin
      yyclear;
      return(0);
    end;

  if not yydone then goto start;

  Result := yyretval;

end(*yylex*);



