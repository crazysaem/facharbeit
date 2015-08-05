object Form2: TForm2
  Left = 192
  Top = 122
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderStyle = bsSingle
  Caption = 'Funktion'
  ClientHeight = 338
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 30
    Top = 40
    Width = 53
    Height = 16
    Caption = 'Funktion:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 144
    Top = 11
    Width = 23
    Height = 16
    Caption = 'x 10'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 32
    Top = 12
    Width = 77
    Height = 16
    Caption = 'Gitterfl'#228'chen:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 80
    Top = 177
    Width = 49
    Height = 16
    Caption = 'Bereich:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 201
    Width = 108
    Height = 16
    Caption = 'Realteil (X-Werte):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 161
    Top = 200
    Width = 4
    Height = 16
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 231
    Width = 110
    Height = 16
    Caption = 'Imagteil (Y-Werte):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 161
    Top = 230
    Width = 4
    Height = 16
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 43
    Top = 310
    Width = 133
    Height = 13
    Caption = 'Berechne Funktionswerte ...'
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 261
    Width = 114
    Height = 16
    Caption = 'Funktionswerte (Z): '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 72
    Top = 304
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 87
    Top = 37
    Width = 81
    Height = 21
    TabOrder = 1
    Text = 'Z^(2)'
  end
  object Edit2: TEdit
    Left = 115
    Top = 9
    Width = 24
    Height = 21
    MaxLength = 2
    TabOrder = 2
    Text = '10'
    OnChange = Edit2Change
  end
  object CheckBox1: TCheckBox
    Left = 56
    Top = 96
    Width = 97
    Height = 17
    Caption = 'Schwarzer Rand'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
  object CAA: TCheckBox
    Left = 56
    Top = 116
    Width = 89
    Height = 17
    Caption = 'Anti Aliasing'
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object Edit3: TEdit
    Left = 168
    Top = 120
    Width = 33
    Height = 21
    TabOrder = 5
    Text = 'Edit3'
    Visible = False
    OnChange = Edit3Change
  end
  object Edit4: TEdit
    Left = 168
    Top = 152
    Width = 33
    Height = 21
    TabOrder = 6
    Text = 'Edit4'
    Visible = False
    OnChange = Edit4Change
  end
  object ComboBox1: TComboBox
    Left = 48
    Top = 65
    Width = 113
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 7
    Text = 'Re f(z)'
    Items.Strings = (
      'Re f(z)'
      'Im f(z)'
      'Betrag f(z)')
  end
  object Edit5: TEdit
    Left = 124
    Top = 199
    Width = 33
    Height = 21
    TabOrder = 8
    Text = '-1'
  end
  object Edit6: TEdit
    Left = 170
    Top = 199
    Width = 33
    Height = 21
    TabOrder = 9
    Text = '1'
  end
  object Edit7: TEdit
    Left = 124
    Top = 229
    Width = 33
    Height = 21
    TabOrder = 10
    Text = '-1'
  end
  object Edit8: TEdit
    Left = 170
    Top = 229
    Width = 33
    Height = 21
    TabOrder = 11
    Text = '1'
  end
  object CheckBox2: TCheckBox
    Left = 56
    Top = 136
    Width = 89
    Height = 17
    Caption = 'Beschriftung'
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object Button2: TButton
    Left = 176
    Top = 64
    Width = 25
    Height = 17
    Caption = 'Button2'
    TabOrder = 13
    Visible = False
    OnClick = Button2Click
  end
  object CheckBox3: TCheckBox
    Left = 56
    Top = 156
    Width = 113
    Height = 17
    Caption = 'Fenster andocken'
    Checked = True
    State = cbChecked
    TabOrder = 14
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 96
    object Datei1: TMenuItem
      Caption = 'Datei'
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        OnClick = Beenden1Click
      end
    end
    object Extras1: TMenuItem
      Caption = 'Extras'
      object Info1: TMenuItem
        Caption = 'Info'
        OnClick = Info1Click
      end
    end
  end
end
