object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Expression Parser'
  ClientHeight = 337
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    635
    337)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 257
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Lucida Console'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 304
    Width = 121
    Height = 25
    Caption = 'File Open to parse'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 0
    Top = 264
    Width = 627
    Height = 21
    TabOrder = 2
    OnKeyPress = Edit1KeyPress
  end
  object OpenDialog1: TOpenDialog
    Left = 152
    Top = 304
  end
end
