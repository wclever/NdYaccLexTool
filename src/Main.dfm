object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ROSA NDYaccLexTool'
  ClientHeight = 621
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    0000000080000080000000808000800000008000800080800000C0C0C0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000002000000000000000000000000000000020000000000000000000
    0000000000002000000AAA000000000000000000000000000AAAAA2000000000
    00000000000020000AAAA222200000000000002000002000AAA2222220000000
    0000002200002000AA222222AAA00000002000AA0000200AA220000200000000
    00022A22A0A2200A2220000000000000222FA2220A0020222200000000000000
    0022222000002022200000000000000000000000000020000000000000000000
    0000000000002000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000
    00000000000200000000000000000000000000B0000200000000000000000000
    00000000000200000000000000000000000000BAB2B220000000000000000000
    0BBBBBBAABB2F2BB000000000000000000BBBBBBBDB99BBAB000000000000000
    0BBBBBBBBABBBBBBBB000000000000000BBBBBBBABBBBBBAAB00000000000000
    0AAABBBBBBBBBBABBB000000000000000AABBBDBBBBBBBBBBB00000000000000
    00ABBBBDBBBBBABBAB000000000000000ABBBBBABBBBBAABBA00000000000000
    00BB9BBBBBBBBABAAA000000000000000B00BBBBBBBBBBBBA000000000000000
    00B000B0BBBBBBB0000000000000000000000000000B0000000000000000FFFF
    7FFFFFFF7FFFFFFF7E3FFFFFF81FFFFF7807FFDF7007FFCF7001FDCF61EFFE04
    61FFF00B43FFFC1F47FFFFFF7FFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE
    FFFFFFDEFFFFFFFEFFFFFFC07FFFF8000FFFFC0007FFF80003FFF80003FFF800
    03FFF80003FFFC0003FFF80003FFFC0003FFFB0007FFFDD01FFFFFFEFFFF}
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    713
    621)
  PixelsPerInch = 96
  TextHeight = 13
  object NDYaccLexDirectoryBitBtn: TBitBtn
    Left = 464
    Top = 38
    Width = 161
    Height = 25
    Caption = 'Choose NDYaccLexDirectory'
    Enabled = False
    TabOrder = 0
    OnClick = NDYaccLexExecutableDirectoryBitBtnClick
  end
  object NDYaccLexDirectoryEdit: TEdit
    Left = 8
    Top = 40
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object OutputProjectDirectoryBitBtn: TBitBtn
    Left = 464
    Top = 155
    Width = 161
    Height = 25
    Caption = 'Choose OutputProjectDirectory'
    TabOrder = 2
    OnClick = OutputProjectDirectoryBitBtnClick
  end
  object OutputProjectDirectoryEdit: TEdit
    Left = 8
    Top = 156
    Width = 450
    Height = 21
    TabOrder = 3
  end
  object EnableNDYaccLexDirectoryControlCheckBox: TCheckBox
    Left = 464
    Top = 15
    Width = 200
    Height = 17
    Caption = 'Enable NDYaccLexDirectoryControl'
    TabOrder = 4
    OnClick = EnableNDYaccLexDirectoryControlCheckBoxClick
  end
  object yaccFileEdit: TEdit
    Left = 8
    Top = 183
    Width = 450
    Height = 21
    TabOrder = 5
  end
  object lexFileEdit: TEdit
    Left = 8
    Top = 210
    Width = 450
    Height = 21
    TabOrder = 6
  end
  object uStreamLexerLocationEdit: TEdit
    Left = 8
    Top = 66
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object lexlibLocationEdit: TEdit
    Left = 8
    Top = 93
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object uStreamLexerLocationBitBtn: TBitBtn
    Left = 464
    Top = 65
    Width = 161
    Height = 25
    Caption = 'Choose uStreamLexerLocation'
    Enabled = False
    TabOrder = 9
    OnClick = uStreamLexerLocationBitBtnClick
  end
  object lexlibLocationBitBtn: TBitBtn
    Left = 464
    Top = 91
    Width = 161
    Height = 25
    Caption = 'Choose lexlibLocation'
    Enabled = False
    TabOrder = 10
    OnClick = lexlibLocationBitBtnClick
  end
  object yaccFileBitBtn: TBitBtn
    Left = 464
    Top = 182
    Width = 161
    Height = 25
    Caption = 'Choose Yacc-file'
    TabOrder = 11
    OnClick = yaccFileBitBtnClick
  end
  object lexFileBitBtn: TBitBtn
    Left = 464
    Top = 209
    Width = 161
    Height = 25
    Caption = 'Choose LexFile'
    TabOrder = 12
    OnClick = lexFileBitBtnClick
  end
  object yacclibLocationBitBtn: TBitBtn
    Left = 464
    Top = 120
    Width = 161
    Height = 25
    Caption = 'Choose yacclibLocation'
    Enabled = False
    TabOrder = 13
    OnClick = yacclibLocationBitBtnClick
  end
  object yacclibLocationEdit: TEdit
    Left = 8
    Top = 121
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 14
  end
  object CreateBitBtn: TBitBtn
    Left = 8
    Top = 246
    Width = 161
    Height = 25
    Caption = 'Create Delphi Test Project'
    TabOrder = 15
    OnClick = CreateBitBtnClick
  end
  object OutputMemo: TMemo
    Left = 8
    Top = 304
    Width = 689
    Height = 315
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssBoth
    TabOrder = 16
  end
  object DefaultBitBtn: TBitBtn
    Left = 632
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Default'
    TabOrder = 17
    OnClick = DefaultBitBtnClick
  end
  object debugInfoCheckBox: TCheckBox
    Left = 184
    Top = 250
    Width = 113
    Height = 17
    Caption = 'debug info ndyacc'
    TabOrder = 18
    OnClick = debugInfoCheckBoxClick
  end
  object optimizeCheckBox: TCheckBox
    Left = 296
    Top = 250
    Width = 97
    Height = 17
    Caption = 'optimize ndlex'
    TabOrder = 19
    OnClick = optimizeCheckBoxClick
  end
  object SaveSettingsBitBtn: TBitBtn
    Left = 464
    Top = 240
    Width = 161
    Height = 25
    Caption = 'Save Settings'
    TabOrder = 20
    OnClick = SaveSettingsBitBtnClick
  end
  object commandlineQuotesCheckBox: TCheckBox
    Left = 16
    Top = 280
    Width = 153
    Height = 17
    Caption = 'Use commandline quotes'
    TabOrder = 21
    OnClick = commandlineQuotesCheckBoxClick
  end
  object copyCheckBox: TCheckBox
    Left = 184
    Top = 280
    Width = 209
    Height = 17
    Caption = 'Do copy Delphi-form/project -files'
    TabOrder = 22
  end
  object copyCODCheckBox: TCheckBox
    Left = 399
    Top = 281
    Width = 202
    Height = 17
    Caption = 'Copy default COD (code-templates)'
    TabOrder = 23
  end
  object OpenDialog: TOpenDialog
    Filter = '*.pas|*.pas'
    Title = 'NDYaccLex Directory'
    Left = 504
    Top = 288
  end
end
