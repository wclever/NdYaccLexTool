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
    yaccFile: TEdit;
    lexFile: TEdit;
    uStreamLexerLocationEdit: TEdit;
    lexlibLocationEdit: TEdit;
    uStreamLexerLocationBitBtn: TBitBtn;
    lexlibLocationBitBtn: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure OutputProjectDirectoryBitBtnClick(Sender: TObject);
    procedure NDYaccLexExecutableDirectoryBitBtnClick(Sender: TObject);
    procedure EnableNDYaccLexDirectoryControlCheckBoxClick(Sender: TObject);
    procedure uStreamLexerLocationBitBtnClick(Sender: TObject);
    procedure lexlibLocationBitBtnClick(Sender: TObject);
  private
    function readSettingsIniFile(ident : String):String;
    procedure writeSettingsIniFile(ident: String; directory : String);
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

procedure TMainForm.EnableNDYaccLexDirectoryControlCheckBoxClick(Sender: TObject);
begin
  NDYaccLexDirectoryEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  NDYaccLexDirectoryBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  uStreamLexerLocationEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  lexlibLocationEdit.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  uStreamLexerLocationBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
  lexlibLocationBitBtn.Enabled := EnableNDYaccLexDirectoryControlCheckBox.Checked;
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
  fileName := readSettingsIniFile('StreamLexerFile');
  if fileName <> '' then
    uStreamLexerLocationEdit.Text := fileName;
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
