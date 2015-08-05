object Form3: TForm3
  Left = 193
  Top = 314
  BorderStyle = bsSingle
  Caption = 'Einstellungen'
  ClientHeight = 253
  ClientWidth = 191
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
    Left = 33
    Top = 93
    Width = 46
    Height = 20
    Caption = 'Breite:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 33
    Top = 125
    Width = 52
    Height = 20
    Caption = 'Hoehe:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label3: TLabel
    Left = 17
    Top = 66
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 8
    Top = 164
    Width = 59
    Height = 20
    Caption = 'Farbset:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 19
    Top = 10
    Width = 151
    Height = 13
    Caption = 'Gr'#246#223'e des Mandelbrot Fensters:'
  end
  object Edit1: TEdit
    Left = 89
    Top = 93
    Width = 57
    Height = 21
    MaxLength = 3
    TabOrder = 0
    Text = '900'
    Visible = False
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 89
    Top = 125
    Width = 57
    Height = 21
    MaxLength = 3
    TabOrder = 1
    Text = '600'
    Visible = False
    OnChange = Edit2Change
  end
  object Button1: TButton
    Left = 57
    Top = 217
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 2
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 9
    Top = 142
    Width = 113
    Height = 17
    Caption = 'Fenster andocken'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 81
    Top = 164
    Width = 105
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 4
    Text = 'Standart'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Standart'
      'Schwarz-Wei'#223
      'Rot'
      'Gruen'
      'Blau')
  end
  object CheckBox2: TCheckBox
    Left = 9
    Top = 193
    Width = 137
    Height = 17
    Caption = 'Fraktal beim Start laden'
    Checked = True
    State = cbChecked
    TabOrder = 5
  end
  object ComboBox2: TComboBox
    Left = 43
    Top = 33
    Width = 97
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    TabOrder = 6
    OnChange = ComboBox2Change
    Items.Strings = (
      '150 x 100'
      '300 x 200'
      '450 x 300'
      '900 x 600')
  end
  object Timer1: TTimer
    Interval = 50
    OnTimer = Timer1Timer
    Left = 137
    Top = 101
  end
  object Timer2: TTimer
    Interval = 20
    OnTimer = Timer2Timer
    Left = 152
    Top = 216
  end
end
