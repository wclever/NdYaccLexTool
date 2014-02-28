//*
// * We now build a lexical analyzer to be used by a higher-level parser.
// */

//#include "ch1-05y.h"	/* token codes from the parser */

//#define LOOKUP 0 /* default - not a defined word type. */

//int state; 
const LOOKUP = 0;



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
  10,
  11,
  { 11: }
  2,
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
  10,
  { 19: }
  4,
  10,
  { 20: }
  5,
  10,
  { 21: }
  10,
  { 22: }
  10,
  { 23: }
  10,
  { 24: }
  10,
  { 25: }
  3,
  10,
  { 26: }
  6,
  10,
  { 27: }
  7,
  10,
  { 28: }
  8,
  10,
  { 29: }
  9,
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
  10,
  11,
{ 11: }
  2,
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
  10,
{ 19: }
  4,
  10,
{ 20: }
  5,
  10,
{ 21: }
  10,
{ 22: }
  10,
{ 23: }
  10,
{ 24: }
  10,
{ 25: }
  3,
  10,
{ 26: }
  6,
  10,
{ 27: }
  7,
  10,
{ 28: }
  8,
  10,
{ 29: }
  9,
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
  ( cc: [ 'c' ]; s: 10),
  ( cc: [ 'n' ]; s: 8),
  ( cc: [ 'p' ]; s: 9),
  ( cc: [ 'v' ]; s: 6),
{ 2: }
{ 3: }
  ( cc: [ #10 ]; s: 11),
{ 4: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 5: }
{ 6: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'z' ]; s: 12),
  ( cc: [ 'e' ]; s: 13),
{ 7: }
  ( cc: [ 'A'..'Z','a'..'c','e'..'z' ]; s: 12),
  ( cc: [ 'd' ]; s: 14),
{ 8: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 12),
  ( cc: [ 'o' ]; s: 15),
{ 9: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 12),
  ( cc: [ 'r' ]; s: 16),
{ 10: }
  ( cc: [ 'A'..'Z','a'..'n','p'..'z' ]; s: 12),
  ( cc: [ 'o' ]; s: 17),
{ 11: }
{ 12: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 13: }
  ( cc: [ 'A'..'Z','a'..'q','s'..'z' ]; s: 12),
  ( cc: [ 'r' ]; s: 18),
{ 14: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'u','w'..'z' ]; s: 12),
  ( cc: [ 'j' ]; s: 19),
  ( cc: [ 'v' ]; s: 20),
{ 15: }
  ( cc: [ 'A'..'Z','a'..'t','v'..'z' ]; s: 12),
  ( cc: [ 'u' ]; s: 21),
{ 16: }
  ( cc: [ 'A'..'Z','a'..'d','f'..'n','p'..'z' ]; s: 12),
  ( cc: [ 'e' ]; s: 22),
  ( cc: [ 'o' ]; s: 23),
{ 17: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 12),
  ( cc: [ 'n' ]; s: 24),
{ 18: }
  ( cc: [ 'A'..'Z','a','c'..'z' ]; s: 12),
  ( cc: [ 'b' ]; s: 25),
{ 19: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 20: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 21: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 12),
  ( cc: [ 'n' ]; s: 26),
{ 22: }
  ( cc: [ 'A'..'Z','a'..'o','q'..'z' ]; s: 12),
  ( cc: [ 'p' ]; s: 27),
{ 23: }
  ( cc: [ 'A'..'Z','a'..'m','o'..'z' ]; s: 12),
  ( cc: [ 'n' ]; s: 28),
{ 24: }
  ( cc: [ 'A'..'Z','a'..'i','k'..'z' ]; s: 12),
  ( cc: [ 'j' ]; s: 29),
{ 25: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 26: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 27: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 28: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12),
{ 29: }
  ( cc: [ 'A'..'Z','a'..'z' ]; s: 12)
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
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 23,
{ 19: } 24,
{ 20: } 26,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 31,
{ 25: } 32,
{ 26: } 34,
{ 27: } 36,
{ 28: } 38,
{ 29: } 40
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
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 23,
{ 19: } 25,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 31,
{ 25: } 33,
{ 26: } 35,
{ 27: } 37,
{ 28: } 39,
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
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 23,
{ 19: } 24,
{ 20: } 26,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 31,
{ 25: } 32,
{ 26: } 34,
{ 27: } 36,
{ 28: } 38,
{ 29: } 40
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
{ 10: } 15,
{ 11: } 16,
{ 12: } 17,
{ 13: } 18,
{ 14: } 19,
{ 15: } 20,
{ 16: } 21,
{ 17: } 22,
{ 18: } 23,
{ 19: } 25,
{ 20: } 27,
{ 21: } 28,
{ 22: } 29,
{ 23: } 30,
{ 24: } 31,
{ 25: } 33,
{ 26: } 35,
{ 27: } 37,
{ 28: } 39,
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
{ 11: } 26,
{ 12: } 26,
{ 13: } 27,
{ 14: } 29,
{ 15: } 32,
{ 16: } 34,
{ 17: } 37,
{ 18: } 39,
{ 19: } 41,
{ 20: } 42,
{ 21: } 43,
{ 22: } 45,
{ 23: } 47,
{ 24: } 49,
{ 25: } 51,
{ 26: } 52,
{ 27: } 53,
{ 28: } 54,
{ 29: } 55
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
{ 10: } 25,
{ 11: } 25,
{ 12: } 26,
{ 13: } 28,
{ 14: } 31,
{ 15: } 33,
{ 16: } 36,
{ 17: } 38,
{ 18: } 40,
{ 19: } 41,
{ 20: } 42,
{ 21: } 44,
{ 22: } 46,
{ 23: } 48,
{ 24: } 50,
{ 25: } 51,
{ 26: } 52,
{ 27: } 53,
{ 28: } 54,
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
