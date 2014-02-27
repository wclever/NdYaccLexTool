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
    debugInfoCheckBox: TCheckBox;
    optimizeCheckBox: TCheckBox;
    SaveSettingsBitBtn: TBitBtn;
    commandlineQuotesCheckBox: TCheckBox;
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
    procedure debugInfoCheckBoxClick(Sender: TObject);
    procedure optimizeCheckBoxClick(Sender: TObject);
    procedure SaveSettingsBitBtnClick(Sender: TObject);
    procedure commandlineQuotesCheckBoxClick(Sender: TObject);
  private
    lastLine:String;
    lastLineNumber : Integer;
    function readSettingsIniFile(ident : String):String;
    procedure writeSettingsIniFile(ident: String; value : String);
    procedure addLine(s: String);
    procedure addToLine(s: String);
    function checkDirectory(d : String):Integer;
    function checkFile(d : String):Integer;
    function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
    procedure FileCopy(source : String; dest : String);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.SaveSettingsBitBtnClick(Sender: TObject);
begin
  writeSettingsIniFile('OutputProjectDirectory', NDYaccLexDirectoryEdit.Text);
  writeSettingsIniFile('StreamLexerFile', uStreamLexerLocationEdit.Text);
  writeSettingsIniFile('LexlibFile', lexlibLocationEdit.Text);
  writeSettingsIniFile('YacclibFile', yacclibLocationEdit.Text);
  writeSettingsIniFile('yaccFile', yaccFileEdit.Text);
  writeSettingsIniFile('lexFile', lexFileEdit.Text);
end;

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

procedure TMainForm.optimizeCheckBoxClick(Sender: TObject);
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  iniFile.WriteBool('Settings','optimize',debugInfoCheckBox.Checked);
  iniFile.Free;
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
  if System.SysUtils.DirectoryExists(d) then addToLine(': OK')
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

procedure TMainForm.commandlineQuotesCheckBoxClick(Sender: TObject);
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  iniFile.WriteBool('Settings','commandlinequotes',commandlineQuotesCheckBox.Checked);
  iniFile.Free;
end;

function TMainForm.GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    OutputMemo.Lines.Add('');
    OutputMemo.Lines.Add(CommandLine);

    Handle := CreateProcess(nil, PChar( CommandLine),
                            nil, nil, True, 0, nil,
                            PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            Result := Result + Buffer;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TMainForm.FileCopy(source : String; dest : String);
begin
  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('copy '+source);
  OutputMemo.Lines.Add('to '+dest);
  CopyFile(PChar(source), PChar(dest), False);
end;

procedure TMainForm.CreateBitBtnClick(Sender: TObject);
var
  buffer : TStringList;
  ndyaccParameter : String;
  ndlexParameter : String;
  commandLine : String;
begin
  OutputMemo.Clear;
  //check if all needed files exist
  if checkDirectory(NDYaccLexDirectoryEdit.Text)=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\default.y')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\test.dpr')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\frmTest.dfm')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\frmTest.pas')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\ndlex.exe')=1 then exit;
  if checkFile(NDYaccLexDirectoryEdit.Text+'\ndyacc.exe')=1 then exit;
  FileCopy(OutputProjectDirectoryEdit.Text+'\yyparse.cod', NDYaccLexDirectoryEdit.Text+'\yyparse.cod');
  FileCopy(OutputProjectDirectoryEdit.Text+'\yylex.cod', NDYaccLexDirectoryEdit.Text+'\yylex.cod');
  OutputMemo.Lines.Add('');
  if checkFile(lexlibLocationEdit.Text)=1 then exit;
  if checkFile(yacclibLocationEdit.Text)=1 then exit;
  if checkDirectory(OutputProjectDirectoryEdit.Text)=1 then exit;
  if checkFile(uStreamLexerLocationEdit.Text)=1 then exit;
  if checkFile(lexFileEdit.Text)=1 then exit;

  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('copying projectfiles');
  FileCopy(NDYaccLexDirectoryEdit.Text+'\test.dpr', OutputProjectDirectoryEdit.Text+'\test.dpr');
  FileCopy(NDYaccLexDirectoryEdit.Text+'\frmTest.dfm', OutputProjectDirectoryEdit.Text+'\frmTest.dfm');
  FileCopy(NDYaccLexDirectoryEdit.Text+'\frmTest.pas', OutputProjectDirectoryEdit.Text+'\frmTest.pas');
  FileCopy(lexlibLocationEdit.Text, OutputProjectDirectoryEdit.Text+'\'+ExtractFileName(lexlibLocationEdit.Text));
  FileCopy(yacclibLocationEdit.Text, OutputProjectDirectoryEdit.Text+'\'+ExtractFileName(yacclibLocationEdit.Text));

  if (yaccFileEdit.Text='') or (yaccFileEdit.Text=NDYaccLexDirectoryEdit.Text+'\default.y') then
  begin
    FileCopy(NDYaccLexDirectoryEdit.Text+'\default.y', OutputProjectDirectoryEdit.Text+'\expr.y');
    yaccFileEdit.Text := OutputProjectDirectoryEdit.Text+'\expr.y';
    writeSettingsIniFile('yaccFile', yaccFileEdit.Text);
  end;

  if checkFile(yaccFileEdit.Text)=1 then exit;

  FileCopy(uStreamLexerLocationEdit.Text, OutputProjectDirectoryEdit.Text+'\'+ExtractFileName(uStreamLexerLocationEdit.Text));

  if debugInfoCheckbox.Checked then  ndyaccParameter := ' -v -d '
  else  ndyaccParameter := ' -v ';
  if optimizeCheckbox.Checked then  ndlexParameter := ' -v -o '
  else  ndlexParameter := ' -v ';

  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('');

  ChDir(OutputProjectDirectoryEdit.Text);
  buffer := TStringList.Create();

  if commandlineQuotesCheckBox.Checked then
    commandLine := '"'+NDYaccLexDirectoryEdit.Text+'\ndyacc.exe"'+
  ndyaccParameter+'"'+yaccFileEdit.Text+'" "'+OutputProjectDirectoryEdit.Text+'\expr.pas"'
  else
    commandLine := NDYaccLexDirectoryEdit.Text+'\ndyacc.exe'+
  ndyaccParameter+yaccFileEdit.Text+' '+OutputProjectDirectoryEdit.Text+'\expr.pas';

  buffer.Text := GetDosOutput(commandLine);
  OutPutMemo.Lines.AddStrings(buffer);
  ChDir(OutputProjectDirectoryEdit.Text);

  buffer.Clear;
  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('');

  if commandlineQuotesCheckBox.Checked then
    commandLine := '"'+NDYaccLexDirectoryEdit.Text+'\ndlex.exe"'+
  ndlexParameter+'"'+lexFileEdit.Text+'" "'+OutputProjectDirectoryEdit.Text+'\exprlex.pas"'
  else
    commandLine := NDYaccLexDirectoryEdit.Text+'\ndlex.exe'+
  ndlexParameter+lexFileEdit.Text+' '+OutputProjectDirectoryEdit.Text+'\exprlex.pas';

  buffer.Text := GetDosOutput(commandLine);
  OutPutMemo.Lines.AddStrings(buffer);
  buffer.Free;

  OutputMemo.Lines.Add('');
  OutputMemo.Lines.Add('Finished, see messages.');
end;

procedure TMainForm.debugInfoCheckBoxClick(Sender: TObject);
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  iniFile.WriteBool('Settings','debugInfo',debugInfoCheckBox.Checked);
  iniFile.Free;
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
  iniFile : TIniFile;
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
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  debugInfoCheckbox.Checked := iniFile.ReadBool('Settings','debugInfo',false);
  optimizeCheckBox.Checked := iniFile.ReadBool('Settings','optimize',false);
  commandlineQuotesCheckBox.Checked := iniFile.ReadBool('Settings','commandlineQuotes',false);
  iniFile.Free;
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

procedure TMainForm.writeSettingsIniFile(ident: String; value: string);
var
  iniFile : TIniFile;
begin
  iniFile :=  TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NDYaccLexTool.ini');
  iniFile.WriteString('Settings',ident, value);
  iniFile.Free;
end;


end.
