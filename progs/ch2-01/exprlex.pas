
function TExprLexer.parse() : integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
  case yyruleno of
  1:
       	;

  2:
                                                writecallback(yytext+': number');

  3:
 	writecallback(yytext+': not a number');
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 11;
yynmatches = 11;
yyntrans   = 26;
yynstates  = 14;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  { 3: }
  3,
  { 4: }
  2,
  3,
  { 5: }
  3,
  { 6: }
  1,
  3,
  { 7: }
  3,
  { 8: }
  2,
  { 9: }
  { 10: }
  2,
  { 11: }
  { 12: }
  2
  { 13: }
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
{ 3: }
  3,
{ 4: }
  2,
  3,
{ 5: }
  3,
{ 6: }
  1,
  3,
{ 7: }
  3,
{ 8: }
  2,
{ 9: }
{ 10: }
  2,
{ 11: }
{ 12: }
  2
{ 13: }
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11..#31,'!'..',','/',':'..#255 ]; s: 7),
  ( cc: [ #9,' ' ]; s: 6),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '.' ]; s: 5),
  ( cc: [ '0'..'9' ]; s: 4),
{ 1: }
  ( cc: [ #1..#8,#11..#31,'!'..',','/',':'..#255 ]; s: 7),
  ( cc: [ #9,' ' ]; s: 6),
  ( cc: [ #10 ]; s: 2),
  ( cc: [ '-' ]; s: 3),
  ( cc: [ '.' ]; s: 5),
  ( cc: [ '0'..'9' ]; s: 4),
{ 2: }
{ 3: }
  ( cc: [ '.' ]; s: 9),
  ( cc: [ '0'..'9' ]; s: 8),
{ 4: }
  ( cc: [ '.' ]; s: 9),
  ( cc: [ '0'..'9' ]; s: 8),
{ 5: }
  ( cc: [ '0'..'9' ]; s: 10),
{ 6: }
{ 7: }
{ 8: }
  ( cc: [ '.' ]; s: 9),
  ( cc: [ '0'..'9' ]; s: 8),
{ 9: }
  ( cc: [ '0'..'9' ]; s: 10),
{ 10: }
  ( cc: [ '0'..'9' ]; s: 10),
  ( cc: [ 'E','e' ]; s: 11),
{ 11: }
  ( cc: [ '+','-' ]; s: 13),
  ( cc: [ '0'..'9' ]; s: 12),
{ 12: }
  ( cc: [ '0'..'9' ]; s: 12),
{ 13: }
  ( cc: [ '0'..'9' ]; s: 12)
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
{ 8: } 9,
{ 9: } 10,
{ 10: } 10,
{ 11: } 11,
{ 12: } 11,
{ 13: } 12
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 2,
{ 4: } 4,
{ 5: } 5,
{ 6: } 7,
{ 7: } 8,
{ 8: } 9,
{ 9: } 9,
{ 10: } 10,
{ 11: } 10,
{ 12: } 11,
{ 13: } 11
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
{ 8: } 9,
{ 9: } 10,
{ 10: } 10,
{ 11: } 11,
{ 12: } 11,
{ 13: } 12
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 1,
{ 3: } 2,
{ 4: } 4,
{ 5: } 5,
{ 6: } 7,
{ 7: } 8,
{ 8: } 9,
{ 9: } 9,
{ 10: } 10,
{ 11: } 10,
{ 12: } 11,
{ 13: } 11
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 7,
{ 2: } 13,
{ 3: } 13,
{ 4: } 15,
{ 5: } 17,
{ 6: } 18,
{ 7: } 18,
{ 8: } 18,
{ 9: } 20,
{ 10: } 21,
{ 11: } 23,
{ 12: } 25,
{ 13: } 26
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 6,
{ 1: } 12,
{ 2: } 12,
{ 3: } 14,
{ 4: } 16,
{ 5: } 17,
{ 6: } 17,
{ 7: } 17,
{ 8: } 19,
{ 9: } 20,
{ 10: } 22,
{ 11: } 24,
{ 12: } 25,
{ 13: } 26
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


