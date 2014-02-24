unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, IniFiles, FileCtrl;

type
  TMainForm = class(TForm)
    OpenDialog: TOpenDialog;
    NDYaccLexDirectoryBitBtn: TBitBtn;
    NDYaccLexDirectoryEdit: TEdit;
    OutputProjectDirectoryBitBtn: TBitBtn;
    OutputProjectDirectoryEdit: TEdit;
    EnableNDYaccLexDirectoryControlCheckBox: TCheckBox;
    yaccFileEdit: TEdit;
    lexFileEdit: TEdit;
    uStreamLexerLocationEdit: TEdit;
    lexlibLocationEdit: TEdit;
    uStreamLexerLocationBitBtn: TBitBtn;
    lexlibLocationBitBtn: TBitBtn;
    yaccFileBitBtn: TBitBtn;
    lexFileBitBtn: TBitBtn;
    yacclibLocationBitBtn: TBitBtn;
    yacclibLocationEdit: TEdit;
    CreateBitBtn: TBitBtn;
    OutputMemo: TMemo;
    DefaultBitBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure OutputProjectDirectoryBitBtnClick(Sender: TObject);
    procedure NDYaccLexExecutableDirectoryBitBtnClick(Sender: TObject);
    procedure EnableNDYaccLexDirectoryControlCheckBoxClick(Sender: TObject);
    procedure uStreamLexerLocationBitBtnClick(Sender: TObject);
    procedure lexlibLocationBitBtnClick(Sender: TObject);
    procedure yaccFileBitBtnClick(Sender: TObject);
    procedure lexFileBitBtnClick(Sender: TObject);
    procedure yacclibLocationBitBtnClick(Sender: TObject);
    procedure CreateBitBtnClick(Sender: TObject);
    procedure DefaultBitBtnClick(Sender: TObject);
  private
    lastLine:String;
    lastLineNumber : Integer;
    function readSettingsIniFile(ident : String):String;
    procedure writeSettingsIniFile(ident: String; directory : String);
    procedure addLine(s: String);
    procedure addToLine(s: String);
    function checkDirectory(d : String):Integer;
    function checkFile(d : String):Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.OutputProjectDirectoryBitBtnClick(Sender: TObject);
var
  options : TSelectDirOpts;
  directory : String;
begin
  directory := readSettingsIniFile('OutputProjectDirectory');
  if SelectDirectory(directory, options, 0) then
  begin
     writeSettingsIniFile('OutputProjectDirectory', directory);
     OutputProjectDirectoryEdit.Text := directory
  end;
end;

procedure TMainForm.NDYaccLexExecutableDirectoryBitBtnClick(Sender: TObject);
var
  options : TSelectDirOpts;
  directory : String;
begin
  directory := readSettingsIniFile('NDYaccLexExecutableDirectory');
  if SelectDirectory(directory, options, 0) then
  begin
     writeSettingsIniFile('NDYaccLexExecutableDirectory', directory);
     NDYaccLexDirectoryEdit.Text := directory;
  end;
end;

procedure TMainForm.yaccFileBitBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.y|*.y';
  OpenDialog.Title := 'Location Yacc-file';
  if yaccFileEdit.Text <> '' then
    OpenDialog.InitialDir := ExtractFilePath(yaccFileEdit.Text)
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog.Execute then
  begin
     yaccFileEdit.Text := OpenDialog.FileName;
     writeSettingsIniFile('yaccFile', OpenDialog.FileName);
  end;
end;

procedure TMainForm.yacclibLocationBitBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.pas|*.pas';
  OpenDialog.Title := 'Location Yacclib';
  if yacclibLocationEdit.Text <> '' then
    OpenDialog.InitialDir := ExtractFilePath(yacclibLocationEdit.Text)
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog.Execute then
  begin
     yacclibLocationEdit.Text := OpenDialog.FileName;
     writeSettingsIniFile('YacclibFile', OpenDialog.FileName);
  end;
end;

procedure TMainForm.lexFileBitBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.l|*.l';
  OpenDialog.Title := 'Location Yacc-file';
  if lexFileEdit.Text <> '' then
    OpenDialog.InitialDir := ExtractFilePath(lexFileEdit.Text)
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog.Execute then
  begin
     lexFileEdit.Text := OpenDialog.FileName;
     writeSettingsIniFile('lexFile', OpenDialog.FileName);
  end;
end;

function TMainForm.checkDirectory(d:String):Integer;
begin
  addLine('checking directory ... '+d);
  if DirectoryExists(d) then addToLine(': OK')
  else
  begin
     addToLine(': Failed!');
     exit(1);
  end;
  exit(0);
end;

function TMainForm.checkFile(d:String):Integer;
begin
  addLine('checking file ... '+d);
  if FileExists(d) then addToLine(': OK')
  else
  begin
     addToLine(': Failed!');
     exit(1);
  end;
  exit(0);
end;

procedure TMainForm.CreateBitBtnClick(Sender: TObject);
begin
  OutputMemo.Clear;
  //check if all needed files exist
  if checkDirectory(NDYaccLexDirectoryEdit.Text)=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\default.y')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\frmTest.dfm')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\frmTest.pas')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\ndlex.exe')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\ndyacc.exe')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\yylex.cod')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\yyparse.cod')=1 then exit;
end;

procedure TMainForm.DefaultBitBtnClick(Sender: TObject);
begin
  yaccFileEdit.Text :=  NDYaccLexDirectoryEdit.Text+'\default.y';
end;

procedure  TMainForm.addLine(s: String);
begin
  OutputMemo.Lines.Add(s);
  lastLineNumber := OutputMemo.Lines.Count-1;
  lastLine := s;
end;

procedure  TMainForm.addToLine(s: String);
begin
   OutputMemo.Lines[lastLineNumber] := lastLine + s;
end;


procedure TMainForm.EnableNDYaccLexDirectoryControlCheckBoxClick(Sender: TObject);
begin
  NDYaccLexDirectoryEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  NDYaccLexDirectoryBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  uStreamLexerLocationEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  lexlibLocationEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  yacclibLocationEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  uStreamLexerLocationBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  lexlibLocationBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  yacclibLocationBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  fileName : String;
begin
  NDYaccLexDirectoryEdit.Text := readSettingsIniFile('NDYaccLexExecutableDirectory');
  OutputProjectDirectoryEdit.Text := readSettingsIniFile('OutputProjectDirectory');
  fileName := readSettingsIniFile('LexlibFile');
  if fileName <> '' then
    lexlibLocationEdit.Text := fileName;
  fileName := readSettingsIniFile('YacclibFile');
  if fileName <> '' then
    yacclibLocationEdit.Text := fileName;
  fileName := readSettingsIniFile('StreamLexerFile');
  if fileName <> '' then
    uStreamLexerLocationEdit.Text := fileName;
  fileName := readSettingsIniFile('yaccFile');
  if fileName <> '' then
    yaccFileEdit.Text := fileName;
  fileName := readSettingsIniFile('lexFile');
  if fileName <> '' then
    lexFileEdit.Text := fileName;
end;

procedure TMainForm.lexlibLocationBitBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.pas|*.pas';
  OpenDialog.Title := 'Location Lexlib';
  if lexlibLocationEdit.Text <> '' then
    OpenDialog.InitialDir := ExtractFilePath(lexlibLocationEdit.Text)
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog.Execute then
  begin
     lexlibLocationEdit.Text := OpenDialog.FileName;
     writeSettingsIniFile('LexlibFile', OpenDialog.FileName);
  end;
end;

function TMainForm.readSettingsIniFile(ident: String):String;
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  result := iniFile.ReadString('Settings',ident,GetCurrentDir);
  iniFile.Free;
end;

procedure TMainForm.uStreamLexerLocationBitBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := '*.pas|*.pas';
  OpenDialog.Title := 'Location StreamerLexer';
  if uStreamLexerLocationEdit.Text <> '' then
    OpenDialog.InitialDir := ExtractFilePath(uStreamLexerLocationEdit.Text)
  else
    OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  if OpenDialog.Execute then
  begin
     uStreamLexerLocationEdit.Text := OpenDialog.FileName;
     writeSettingsIniFile('StreamLexerFile', OpenDialog.FileName);
  end;
end;

procedure TMainForm.writeSettingsIniFile(ident: String; directory: string);
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  iniFile.WriteString('Settings',ident, directory);
  iniFile.Free;
end;

end.
