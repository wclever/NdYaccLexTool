object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'ROSA NDYaccLexTool'
  ClientHeight = 334
  ClientWidth = 864
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
  PixelsPerInch = 96
  TextHeight = 13
  object NDYaccLexDirectoryBitBtn: TBitBtn
    Left = 464
    Top = 8
    Width = 161
    Height = 25
    Caption = 'Choose NDYaccLexDirectory'
    Enabled = False
    TabOrder = 0
    OnClick = NDYaccLexExecutableDirectoryBitBtnClick
  end
  object NDYaccLexDirectoryEdit: TEdit
    Left = 8
    Top = 10
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object OutputProjectDirectoryBitBtn: TBitBtn
    Left = 464
    Top = 125
    Width = 161
    Height = 25
    Caption = 'Choose OutputProjectDirectory'
    TabOrder = 2
    OnClick = OutputProjectDirectoryBitBtnClick
  end
  object OutputProjectDirectoryEdit: TEdit
    Left = 8
    Top = 127
    Width = 450
    Height = 21
    TabOrder = 3
  end
  object EnableNDYaccLexDirectoryControlCheckBox: TCheckBox
    Left = 631
    Top = 12
    Width = 200
    Height = 17
    Caption = 'Enable NDYaccLexDirectoryControl'
    TabOrder = 4
    OnClick = EnableNDYaccLexDirectoryControlCheckBoxClick
  end
  object yaccFileEdit: TEdit
    Left = 8
    Top = 154
    Width = 450
    Height = 21
    TabOrder = 5
  end
  object lexFileEdit: TEdit
    Left = 8
    Top = 181
    Width = 450
    Height = 21
    TabOrder = 6
  end
  object uStreamLexerLocationEdit: TEdit
    Left = 8
    Top = 37
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object lexlibLocationEdit: TEdit
    Left = 8
    Top = 65
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object uStreamLexerLocationBitBtn: TBitBtn
    Left = 464
    Top = 35
    Width = 161
    Height = 25
    Caption = 'Choose uStreamLexerLocation'
    Enabled = False
    TabOrder = 9
    OnClick = uStreamLexerLocationBitBtnClick
  end
  object lexlibLocationBitBtn: TBitBtn
    Left = 464
    Top = 61
    Width = 161
    Height = 25
    Caption = 'Choose lexlibLocation'
    Enabled = False
    TabOrder = 10
    OnClick = lexlibLocationBitBtnClick
  end
  object yaccFileBitBtn: TBitBtn
    Left = 464
    Top = 152
    Width = 161
    Height = 25
    Caption = 'Choose Yacc-file'
    TabOrder = 11
    OnClick = yaccFileBitBtnClick
  end
  object lexFileBitBtn: TBitBtn
    Left = 464
    Top = 179
    Width = 161
    Height = 25
    Caption = 'Choose LexFile'
    TabOrder = 12
    OnClick = lexFileBitBtnClick
  end
  object yacclibLocationBitBtn: TBitBtn
    Left = 464
    Top = 90
    Width = 161
    Height = 25
    Caption = 'Choose yacclibLocation'
    Enabled = False
    TabOrder = 13
    OnClick = yacclibLocationBitBtnClick
  end
  object yacclibLocationEdit: TEdit
    Left = 8
    Top = 92
    Width = 450
    Height = 21
    Enabled = False
    TabOrder = 14
  end
  object OpenDialog: TOpenDialog
    Filter = '*.pas|*.pas'
    Title = 'NDYaccLex Directory'
    Left = 640
    Top = 32
  end
end
