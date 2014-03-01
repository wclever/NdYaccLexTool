unit frmTest;

interface

uses
  {$IFDEF FPC}
  Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, expr, StdCtrls;
  {$ELSE}
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, expr, Vcl.StdCtrls;
  {$ENDIF}

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    Parser: TExprParser;
    procedure WriteCB(Value: String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  StrStream: TFileStream;
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog1.Execute then
  begin
    Memo1.clear;
    Memo1.Lines.Add('> ' + OpenDialog1.FileName);
    StrStream := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
    try
      try
        Parser.parse(StrStream, WriteCB);
      except
        on E: EExprParserException do
          Memo1.Lines.Add(E.Message);
      end;
    finally
       StrStream.Free;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Parser.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Parser := TExprParser.Create;
end;

procedure TForm1.WriteCB(Value: String);
begin
  Memo1.Lines.Add(Value);
end;

end.
