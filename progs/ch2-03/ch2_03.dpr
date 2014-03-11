program ch2_03;

uses
  {$IFDEF FPC}
  {$IFDEF UNIX}
  {$IFDEF UseCThreads}
  cthreads,
  {$ENDIF }
  {$ENDIF }
  Interfaces,
  {$ELSE}
  Vcl.Forms,
  {$ENDIF }
  frmTest in 'frmTest.pas' {Form1},
  expr in 'expr.pas',
  uStreamLexer in 'uStreamLexer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.