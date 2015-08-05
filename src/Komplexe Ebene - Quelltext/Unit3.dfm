object Form3: TForm3
  Left = 195
  Top = 304
  Width = 211
  Height = 280
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
  object Label1: TLabel
    Left = 10
    Top = 17
    Width = 54
    Height = 20
    Caption = 'Breite:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 10
    Top = 46
    Width = 49
    Height = 20
    Caption = 'H'#246'he:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 11
    Top = 95
    Width = 143
    Height = 13
    Caption = 'Die oben gennanten Angaben'
  end
  object Edit1: TEdit
    Left = 112
    Top = 17
    Width = 65
    Height = 21
    MaxLength = 3
    TabOrder = 0
    Text = '700'
  end
  object Edit2: TEdit
    Left = 112
    Top = 46
    Width = 65
    Height = 21
    MaxLength = 3
    TabOrder = 1
    Text = '500'
  end
  object Button1: TButton
    Left = 56
    Top = 211
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 10
    Top = 73
    Width = 113
    Height = 17
    Caption = 'Fenster andocken'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object CheckBox2: TCheckBox
    Left = 11
    Top = 166
    Width = 142
    Height = 17
    Caption = 'Beschriftungen anzeigen'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object ComboBox1: TComboBox
    Left = 32
    Top = 185
    Width = 129
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 5
    Text = 'Kartesiche Koordinaten'
    Items.Strings = (
      'Kartesiche Koordinaten'
      'Polarkoordinaten')
  end
end
