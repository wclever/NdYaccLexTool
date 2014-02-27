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
  10,
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
  9,
  { 17: }
  3,
  9,
  { 18: }
  4,
  9,
  { 19: }
  9,
  { 20: }
  9,
  { 21: }
  9,
  { 22: }
  9,
  { 23: }
  2,
  9,
  { 24: }
  5,
  9,
  { 25: }
  6,
  9,
  { 26: }
  7,
  9,
  { 27: }
  8,
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
  10,
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
  9,
{ 17: }
  3,
  9,
{ 18: }
  4,
  9,
{ 19: }
  9,
{ 20: }
  9,
{ 21: }
  9,
{ 22: }
  9,
{ 23: }
  2,
  9,
{ 24: }
  5,
  9,
{ 25: }
  6,
  9,
{ 26: }
  7,
  9,
{ 27: }
  8,
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
  ( cc: [ 'c' ]; s: 9),
  ( cc: [ 'n' ]; s: 7),
  ( cc: [ 'p' ]; s: 8),
  ( cc: [ 'v' ]; s: 5),
{ 2: }
{ 3: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 4: }
{ 5: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'z' ]; s: 10),
  ( cc: [ 'e' ]; s: 11),
{ 6: }
  ( cc: [ 'A'..'Z','a'..'c','e'..'z' ]; s: 10),
  ( cc: [ 'd' ]; s: 12),
{ 7: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 10),
  ( cc: [ 'o' ]; s: 13),
{ 8: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 10),
  ( cc: [ 'r' ]; s: 14),
{ 9: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 10),
  ( cc: [ 'o' ]; s: 15),
{ 10: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 11: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 10),
  ( cc: [ 'r' ]; s: 16),
{ 12: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'u','w'..'z' ]; s: 10),
  ( cc: [ 'j' ]; s: 17),
  ( cc: [ 'v' ]; s: 18),
{ 13: }
  ( cc: [ 'A'..'Z','a'..'t','v'..'z' ]; s: 10),
  ( cc: [ 'u' ]; s: 19),
{ 14: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'n','p'..'z' ]; s: 10),
  ( cc: [ 'e' ]; s: 20),
  ( cc: [ 'o' ]; s: 21),
{ 15: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 10),
  ( cc: [ 'n' ]; s: 22),
{ 16: }
  ( cc: [ 'A'..'Z','a','c'..'z' ]; s: 10),
  ( cc: [ 'b' ]; s: 23),
{ 17: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 18: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 19: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 10),
  ( cc: [ 'n' ]; s: 24),
{ 20: }
  ( cc: [ 'A'..'Z','a'..'o','q'..'z' ]; s: 10),
  ( cc: [ 'p' ]; s: 25),
{ 21: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 10),
  ( cc: [ 'n' ]; s: 26),
{ 22: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'z' ]; s: 10),
  ( cc: [ 'j' ]; s: 27),
{ 23: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 24: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 25: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 26: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10),
{ 27: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 10)
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
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 24,
{ 19: } 26,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 32,
{ 25: } 34,
{ 26: } 36,
{ 27: } 38
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
{ 9: } 14,
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 23,
{ 18: } 25,
{ 19: } 26,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 31,
{ 24: } 33,
{ 25: } 35,
{ 26: } 37,
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
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 24,
{ 19: } 26,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 32,
{ 25: } 34,
{ 26: } 36,
{ 27: } 38
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
{ 9: } 14,
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 23,
{ 18: } 25,
{ 19: } 26,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 31,
{ 24: } 33,
{ 25: } 35,
{ 26: } 37,
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
{ 10: } 23,
{ 11: } 24,
{ 12: } 26,
{ 13: } 29,
{ 14: } 31,
{ 15: } 34,
{ 16: } 36,
{ 17: } 38,
{ 18: } 39,
{ 19: } 40,
{ 20: } 42,
{ 21: } 44,
{ 22: } 46,
{ 23: } 48,
{ 24: } 49,
{ 25: } 50,
{ 26: } 51,
{ 27: } 52
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
{ 9: } 22,
{ 10: } 23,
{ 11: } 25,
{ 12: } 28,
{ 13: } 30,
{ 14: } 33,
{ 15: } 35,
{ 16: } 37,
{ 17: } 38,
{ 18: } 39,
{ 19: } 41,
{ 20: } 43,
{ 21: } 45,
{ 22: } 47,
{ 23: } 48,
{ 24: } 49,
{ 25: } 50,
{ 26: } 51,
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



