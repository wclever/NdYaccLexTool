	var
		charCount : Integer = 0;
		wordCount : Integer = 0;
		lineCount : Integer = 0;


function TExprLexer.parse() : integer;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
begin
  (* actions: *)
  case yyruleno of
  1:
      	begin Inc(wordCount); charCount := charCount + yysleng; end;
  2:
     	begin Inc(charCount); Inc(lineCount); end;
  3:
 	Inc(charCount);
  end;
end(*yyaction*);

(* DFA table: *)

type YYTRec = record
                cc : set of Char;
                s  : Integer;
              end;

const

yynmarks   = 5;
yynmatches = 5;
yyntrans   = 8;
yynstates  = 6;

yyk : array [1..yynmarks] of Integer = (
  { 0: }
  { 1: }
  { 2: }
  1,
  3,
  { 3: }
  2,
  { 4: }
  3,
  { 5: }
  1
);

yym : array [1..yynmatches] of Integer = (
{ 0: }
{ 1: }
{ 2: }
  1,
  3,
{ 3: }
  2,
{ 4: }
  3,
{ 5: }
  1
);

yyt : array [1..yyntrans] of YYTrec = (
{ 0: }
  ( cc: [ #1..#8,#11..#31,'!'..#255 ]; s: 2),
  ( cc: [ #9,' ' ]; s: 4),
  ( cc: [ #10 ]; s: 3),
{ 1: }
  ( cc: [ #1..#8,#11..#31,'!'..#255 ]; s: 2),
  ( cc: [ #9,' ' ]; s: 4),
  ( cc: [ #10 ]; s: 3),
{ 2: }
  ( cc: [ #1..#8,#11..#31,'!'..#255 ]; s: 5),
{ 3: }
{ 4: }
{ 5: }
  ( cc: [ #1..#8,#11..#31,'!'..#255 ]; s: 5)
);

yykl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 4,
{ 5: } 5
);

yykh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 3,
{ 4: } 4,
{ 5: } 5
);

yyml : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1,
{ 2: } 1,
{ 3: } 3,
{ 4: } 4,
{ 5: } 5
);

yymh : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 0,
{ 2: } 2,
{ 3: } 3,
{ 4: } 4,
{ 5: } 5
);

yytl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 4,
{ 2: } 7,
{ 3: } 8,
{ 4: } 8,
{ 5: } 8
);

yyth : array [0..yynstates-1] of Integer = (
{ 0: } 3,
{ 1: } 6,
{ 2: } 7,
{ 3: } 7,
{ 4: } 7,
{ 5: } 8
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
  writecallback(  'charCount: ' + IntToStr(charCount) +
                  ' wordCount: ' + IntToStr(wordCount)  +
                  ' lineCount: ' + IntToStr(lineCount));
end(*yylex*);



