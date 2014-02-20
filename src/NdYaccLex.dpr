program NdYaccLex;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
