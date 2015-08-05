object Form3: TForm3
  Left = 200
  Top = 350
  Width = 211
  Height = 70
  Caption = 'Einstellungen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object CheckBox1: TCheckBox
    Left = 10
    Top = 9
    Width = 113
    Height = 17
    Caption = 'Fenster andocken'
    Checked = True
    State = cbChecked
    TabOrder = 0
  end
  object Button2: TButton
    Left = 144
    Top = 13
    Width = 25
    Height = 10
    Caption = 'Button2'
    TabOrder = 1
    Visible = False
    OnClick = Button2Click
  end
  object Timer1: TTimer
    Interval = 20
    OnTimer = Timer1Timer
    Left = 119
    Top = 3
  end
end
