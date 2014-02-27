{$DEFINE YYDEBUG}
{$DEFINE YYEXTRADEBUG}

unit expr;

interface

uses
	SysUtils,
	Classes,
	yacclib,
	lexlib,
        uStreamLexer;



type YYSType = Integer(*YYSType*);
// source: D:\Users\verhees\Documents\GitHub\NdYaccLexTool\tools\yyparse.cod line# 2
var yylval : YYSType;

type
  TState = (LOOKUP = 0, { default - looking rather than defining. }
	          VERB,
	          ADJ,
	          ADV,
	          NOUN,
	          PREP,
	          PRON,
	          CONJ);

  pWord = ^TWord;

  TWord = record
  	wordName : String[100];
  	wordType : TState;
  	next : pWord;
  end;

  TWriteCallback = procedure(Value: String) of object;
  TExprLexer = class(TStreamLexer)
  public
    writecallback: TWriteCallback;
    state: TState;
//    wordList : TWord;
    function parse() : integer; override;
    function addWord(_type:TState; word: String):Integer;
    function lookupWord(word: String):TState;
  end;

  EExprParserException = class(Exception);
  TExprParser = class(TCustomParser)
  private
    x: array [1..26] of Real;
    writecallback: TWriteCallback;
  public
    constructor Create;
    function parse(AStream: TStream; AWriteCB: TWriteCallback) : integer; reintroduce;
  end;

implementation

var wordList : TWord;


function TExprLexer.addWord(_type:TState; word: String):Integer;
var
   wp : TWord;
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
//  wordList.next :=  Addr(newWp);
	result := 1; {it worked}
end;

function TExprLexer.lookupWord(word: String):TState;
var
	wp : TWord;
  state : TState;
begin
  wp := wordList;
	{/* search down the list looking for the word */}
	while wp.next<>nil do
	begin
		if wp.wordName=word then
		begin
			result := wp.wordType;
			exit;
		end;
		wp := wp.next^;
	end;
	result := TState.LOOKUP;
end;

constructor TExprParser.Create;
var
  I: Integer;
begin
  inherited;
  for i := 1 to 26 do 
    x[i] := 0.0;
end;

function TExprParser.parse(AStream: TStream; AWriteCB: TWriteCallback) : integer;

var 
  lexer : TExprLexer;
  yystate, yysp, yyn : Integer;
  yys : array [1..yymaxdepth] of Integer;
  yyv : array [1..yymaxdepth] of YYSType;
  yyval : YYSType;

procedure yyaction ( yyruleno : Integer );
  (* local definitions: *)
// source: D:\Users\verhees\Documents\GitHub\NdYaccLexTool\tools\yyparse.cod line# 109
begin
  (* actions: *)
  case yyruleno of
1 : begin
       end;
2 : begin
       end;
// source: D:\Users\verhees\Documents\GitHub\NdYaccLexTool\tools\yyparse.cod line# 113
  end;
end(*yyaction*);

(* parse table: *)

type YYARec = record
                sym, act : Integer;
              end;
     YYRRec = record
                len, sym : Integer;
                symname : String;
              end;
     YYTokenRec = record
                tokenname : String;
              end;

const

yynacts   = 1;
yyngotos  = 1;
yynstates = 2;
yynrules  = 2;
yymaxtoken = 256;

yya : array [1..yynacts] of YYARec = (
{ 0: }
{ 1: }
  ( sym: 0; act: 0 )
);

yyg : array [1..yyngotos] of YYARec = (
{ 0: }
  ( sym: -2; act: 1 )
{ 1: }
);

yyd : array [0..yynstates-1] of Integer = (
{ 0: } -1,
{ 1: } 0
);

yyal : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1
);

yyah : array [0..yynstates-1] of Integer = (
{ 0: } 0,
{ 1: } 1
);

yygl : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 2
);

yygh : array [0..yynstates-1] of Integer = (
{ 0: } 1,
{ 1: } 1
);

yyr : array [1..yynrules] of YYRRec = (
{ 1: } ( len: 0; sym: -2; symname: 'input' ),
{ 2: } ( len: 0; sym: -3; symname: 'expr' )
);

yytokens : array [256..yymaxtoken] of YYTokenRec = (
{ 256: } ( tokenname: 'error' )
);

// source: D:\Users\verhees\Documents\GitHub\NdYaccLexTool\tools\yyparse.cod line# 118

const _error = 256; (* error token *)

function yyact(state, sym : Integer; var act : Integer) : Boolean;
  (* search action table *)
  var k : Integer;
  begin
    k := yyal[state];
    while (k<=yyah[state]) and (yya[k].sym<>sym) do inc(k);
    if k>yyah[state] then
      yyact := false
    else
      begin
        act := yya[k].act;
        yyact := true;
      end;
  end(*yyact*);

function yygoto(state, sym : Integer; var nstate : Integer) : Boolean;
  (* search goto table *)
  var k : Integer;
  begin
    k := yygl[state];
    while (k<=yygh[state]) and (yyg[k].sym<>sym) do inc(k);
    if k>yygh[state] then
      yygoto := false
    else
      begin
        nstate := yyg[k].act;
        yygoto := true;
      end;
  end(*yygoto*);

function yycharsym(i : Integer) : String;
begin
  if (i >= 1) and (i <= 255) then
    begin
      if i < 32 then
        begin
          if i = 9 then
            Result := #39'\t'#39
          else if i = 10 then
            Result := #39'\f'#39
          else if i = 13 then
            Result := #39'\n'#39
          else
            Result := #39'\0x' + IntToHex(i,2) + #39;
        end
      else
        Result := #39 + Char(i) + #39;
      Result := ' literal ' + Result;
    end
  else
    begin
      if i < -1 then
        Result := ' unknown'
      else if i = -1 then
        Result := ' token $accept'
      else if i = 0 then
        Result := ' token $eof'
      else if i = 256 then
        Result := ' token $error'
{$ifdef yyextradebug}
      else if i <= yymaxtoken then
        Result := ' token ' + yytokens[yychar].tokenname
      else
        Result := ' unknown token';
{$else}
      else
        Result := ' token';
{$endif}
    end;
  Result := Result + ' ' + IntToStr(yychar);
end;

label parse, next, error, errlab, shift, reduce, accept, abort;

begin(*yyparse*)

  (* initialize: *)
  lexer := TExprLexer.Create(AStream, nil);
  writecallback := AWriteCB;
  lexer.writecallback := AWriteCB; 
  try

  yystate := 0; yychar := -1; yynerrs := 0; yyerrflag := 0; yysp := 0;

parse:

  (* push state and value: *)

  inc(yysp);
  if yysp>yymaxdepth then
    begin
      raise EExprParserException.Create('yyparse stack overflow');
      goto abort;
    end;
  yys[yysp] := yystate; yyv[yysp] := yyval;

next:

  if (yyd[yystate]=0) and (yychar=-1) then
    (* get next symbol *)
    begin
      yychar := lexer.parse(); if yychar<0 then yychar := 0;
    end;

  {$IFDEF YYDEBUG}writecallback('**** state '+ IntToStr(yystate) + ' ' + yycharsym(yychar));{$ENDIF}

  (* determine parse action: *)

  yyn := yyd[yystate];
  if yyn<>0 then goto reduce; (* simple state *)

  (* no default action; search parse table *)

  if not yyact(yystate, yychar, yyn) then goto error
  else if yyn>0 then                      goto shift
  else if yyn<0 then                      goto reduce
  else                                    goto accept;

error:

  (* error; start error recovery: *)

  if yyerrflag=0 then raise EExprParserException.Create('syntax error');

errlab:

  if yyerrflag=0 then inc(yynerrs);     (* new error *)

  if yyerrflag<=2 then                  (* incomplete recovery; try again *)
    begin
      yyerrflag := 3;
      (* uncover a state with shift action on error token *)
      while (yysp>0) and not ( yyact(yys[yysp], _error, yyn) and
                               (yyn>0) ) do
        begin
          {$IFDEF YYDEBUG}
            if yysp>1 then
              writecallback('**** error recovery pops state ' + IntToStr(yys[yysp]) + ', uncovers ' + IntToStr(yys[yysp-1]) )
            else
              writecallback('**** error recovery fails ... abort');
          {$ENDIF}
          dec(yysp);
        end;
      if yysp=0 then goto abort; (* parser has fallen from stack; abort *)
      yystate := yyn;            (* simulate shift on error *)
      goto parse;
    end
  else                                  (* no shift yet; discard symbol *)
    begin
      {$IFDEF YYDEBUG}writecallback('**** error recovery discards ' + yycharsym(yychar));{$ENDIF}
      if yychar=0 then goto abort; (* end of input; abort *)
      yychar := -1; goto next;     (* clear lookahead char and try again *)
    end;

shift:

  (* go to new state, clear lookahead character: *)

  yystate := yyn; yychar := -1; yyval := yylval;
  if yyerrflag>0 then dec(yyerrflag);

  goto parse;

reduce:

  (* execute action, pop rule from stack, and go to next state: *)

  {$IFDEF YYDEBUG}writecallback('**** reduce ' + IntToStr(-yyn) {$IFDEF YYEXTRADEBUG} + ' rule ' + yyr[-yyn].symname {$ENDIF});{$ENDIF}

  yyflag := yyfnone; yyaction(-yyn);
  dec(yysp, yyr[-yyn].len);
  if yygoto(yys[yysp], yyr[-yyn].sym, yyn) then yystate := yyn;

  (* handle action calls to yyaccept, yyabort and yyerror: *)

  case yyflag of
    yyfaccept : goto accept;
    yyfabort  : goto abort;
    yyferror  : goto errlab;
  end;

  goto parse;

accept:

  Result := 0; exit;

abort:

  Result := 1; exit;
finally
  lexer.Free;
end;
end(*yyparse*);


{$I exprlex.pas}

end.