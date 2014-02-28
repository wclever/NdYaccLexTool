//*
// * We now build a lexical analyzer to be used by a higher-level parser.
// */

//#include "ch1-05y.h"	/* token codes from the parser */

//#define LOOKUP 0 /* default - not a defined word type. */

//int state; 



function TExprLexer.parse() : integer;

function yyaction ( yyruleno : Integer ):Integer;
  (* local definitions: *)

begin
  (* actions: *)
  case yyruleno of
  1:
  	 state := LOOKUP; 	{/* end of line, reset/return to default state */}

  2:
    	begin
	state := LOOKUP;
	result := 0; //* end of sentence */
	end;
	

  3:
     	 state := VERB; 
  4:
    	 state := ADJECTIVE; 
  5:
    	 state := ADVERB; 
  6:
     	 state := NOUN; 
  7:
     	 state := PREPOSITION; 
  8:
     	 state := PRONOUN; 
  9:
     	 state := CONJUNCTION; 

  10:
          begin 
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

  11:
 	; //* ignore anything else */} 

  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 41;
yynmatches = 41;
yyntrans   = 55;
yynstates  = 30;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  { 3: }
  11,
  { 4: }
  10,
  11,
  { 5: }
  11,
  { 6: }
  10,
  11,
  { 7: }
  10,
  11,
  { 8: }
  10,
  11,
  { 9: }
  10,
  11,
  { 10: }
  2,
  { 11: }
  10,
  { 12: }
  10,
  { 13: }
  10,
  { 14: }
  10,
  { 15: }
  10,
  { 16: }
  10,
  { 17: }
  10,
  { 18: }
  4,
  10,
  { 19: }
  5,
  10,
  { 20: }
  10,
  { 21: }
  10,
  { 22: }
  3,
  10,
  { 23: }
  6,
  10,
  { 24: }
  7,
  10,
  { 25: }
  8,
  10,
  { 26: }
  9,
  10,
  { 27: }
  10,
  11,
  { 28: }
  10,
  { 29: }
  10
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
{ 3: }
  11,
{ 4: }
  10,
  11,
{ 5: }
  11,
{ 6: }
  10,
  11,
{ 7: }
  10,
  11,
{ 8: }
  10,
  11,
{ 9: }
  10,
  11,
{ 10: }
  2,
{ 11: }
  10,
{ 12: }
  10,
{ 13: }
  10,
{ 14: }
  10,
{ 15: }
  10,
{ 16: }
  10,
{ 17: }
  10,
{ 18: }
  4,
  10,
{ 19: }
  5,
  10,
{ 20: }
  10,
{ 21: }
  10,
{ 22: }
  3,
  10,
{ 23: }
  6,
  10,
{ 24: }
  7,
  10,
{ 25: }
  8,
  10,
{ 26: }
  9,
  10,
{ 27: }
  10,
  11,
{ 28: }
  10,
{ 29: }
  10
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#9,#11..'-','/'..'@','['..'`','{'..#255 ]; s: 5),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ '.' ]; s: 3),
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 4),
{ 1: }
  ( cc: [ #1..#9,#11..'-','/'..'@','['..'`','{'..#255 ]; s: 5),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ '.' ]; s: 3),
  ( cc: [ 'A'..'Z','b','d'..'m','o','q'..'u','w'..'z' ]; s: 4),
  ( cc: [ 'a' ]; s: 7),
  ( cc: [ 'c' ]; s: 27),
  ( cc: [ 'n' ]; s: 8),
  ( cc: [ 'p' ]; s: 9),
  ( cc: [ 'v' ]; s: 6),
{ 2: }
{ 3: }
  ( cc: [ #10 ]; s: 10),
{ 4: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 5: }
{ 6: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'z' ]; s: 11),
  ( cc: [ 'e' ]; s: 12),
{ 7: }
  ( cc: [ 'A'..'Z','a'..'c','e'..'z' ]; s: 11),
  ( cc: [ 'd' ]; s: 13),
{ 8: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 11),
  ( cc: [ 'o' ]; s: 14),
{ 9: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 11),
  ( cc: [ 'r' ]; s: 15),
{ 10: }
{ 11: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 12: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 11),
  ( cc: [ 'r' ]; s: 17),
{ 13: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'u','w'..'z' ]; s: 11),
  ( cc: [ 'j' ]; s: 18),
  ( cc: [ 'v' ]; s: 19),
{ 14: }
  ( cc: [ 'A'..'Z','a'..'t','v'..'z' ]; s: 11),
  ( cc: [ 'u' ]; s: 28),
{ 15: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'n','p'..'z' ]; s: 11),
  ( cc: [ 'e' ]; s: 20),
  ( cc: [ 'o' ]; s: 29),
{ 16: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 11),
  ( cc: [ 'n' ]; s: 21),
{ 17: }
  ( cc: [ 'A'..'Z','a','c'..'z' ]; s: 11),
  ( cc: [ 'b' ]; s: 22),
{ 18: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 19: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 20: }
  ( cc: [ 'A'..'Z','a'..'o','q'..'z' ]; s: 11),
  ( cc: [ 'p' ]; s: 24),
{ 21: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'z' ]; s: 11),
  ( cc: [ 'j' ]; s: 26),
{ 22: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 23: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 24: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 25: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 26: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 11),
{ 27: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 11),
  ( cc: [ 'o' ]; s: 16),
{ 28: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 11),
  ( cc: [ 'n' ]; s: 23),
{ 29: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 11),
  ( cc: [ 'n' ]; s: 25)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 5,
{ 6: } 6,
{ 7: } 8,
{ 8: } 10,
{ 9: } 12,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 20,
{ 17: } 21,
{ 18: } 22,
{ 19: } 24,
{ 20: } 26,
{ 21: } 27,
{ 22: } 28,
{ 23: } 30,
{ 24: } 32,
{ 25: } 34,
{ 26: } 36,
{ 27: } 38,
{ 28: } 40,
{ 29: } 41
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
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
{ 17: } 21,
{ 18: } 23,
{ 19: } 25,
{ 20: } 26,
{ 21: } 27,
{ 22: } 29,
{ 23: } 31,
{ 24: } 33,
{ 25: } 35,
{ 26: } 37,
{ 27: } 39,
{ 28: } 40,
{ 29: } 41
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 2,
{ 4: } 3,
{ 5: } 5,
{ 6: } 6,
{ 7: } 8,
{ 8: } 10,
{ 9: } 12,
{ 10: } 14,
{ 11: } 15,
{ 12: } 16,
{ 13: } 17,
{ 14: } 18,
{ 15: } 19,
{ 16: } 20,
{ 17: } 21,
{ 18: } 22,
{ 19: } 24,
{ 20: } 26,
{ 21: } 27,
{ 22: } 28,
{ 23: } 30,
{ 24: } 32,
{ 25: } 34,
{ 26: } 36,
{ 27: } 38,
{ 28: } 40,
{ 29: } 41
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
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
{ 17: } 21,
{ 18: } 23,
{ 19: } 25,
{ 20: } 26,
{ 21: } 27,
{ 22: } 29,
{ 23: } 31,
{ 24: } 33,
{ 25: } 35,
{ 26: } 37,
{ 27: } 39,
{ 28: } 40,
{ 29: } 41
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 5,
{ 2: } 14,
{ 3: } 14,
{ 4: } 15,
{ 5: } 16,
{ 6: } 16,
{ 7: } 18,
{ 8: } 20,
{ 9: } 22,
{ 10: } 24,
{ 11: } 24,
{ 12: } 25,
{ 13: } 27,
{ 14: } 30,
{ 15: } 32,
{ 16: } 35,
{ 17: } 37,
{ 18: } 39,
{ 19: } 40,
{ 20: } 41,
{ 21: } 43,
{ 22: } 45,
{ 23: } 46,
{ 24: } 47,
{ 25: } 48,
{ 26: } 49,
{ 27: } 50,
{ 28: } 52,
{ 29: } 54
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 4,
{ 1: } 13,
{ 2: } 13,
{ 3: } 14,
{ 4: } 15,
{ 5: } 15,
{ 6: } 17,
{ 7: } 19,
{ 8: } 21,
{ 9: } 23,
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
{ 22: } 45,
{ 23: } 46,
{ 24: } 47,
{ 25: } 48,
{ 26: } 49,
{ 27: } 51,
{ 28: } 53,
{ 29: } 55
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


