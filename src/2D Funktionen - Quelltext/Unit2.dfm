object Form2: TForm2
  Left = 200
  Top = 120
  BorderStyle = bsSingle
  Caption = 'Funktion'
  ClientHeight = 168
  ClientWidth = 195
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 9
    Width = 65
    Height = 16
    Caption = 'Gitterlinien:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 45
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
  object Label3: TLabel
    Left = 24
    Top = 137
    Width = 146
    Height = 13
    Caption = 'Funktionsgraph wird berechnet'
    Visible = False
  end
  object Label4: TLabel
    Left = 8
    Top = 71
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
  object Label5: TLabel
    Left = 8
    Top = 95
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
  object Label6: TLabel
    Left = 154
    Top = 73
    Width = 3
    Height = 13
    Caption = '-'
  end
  object Label7: TLabel
    Left = 155
    Top = 98
    Width = 3
    Height = 13
    Caption = '-'
  end
  object Label8: TLabel
    Left = 118
    Top = 12
    Width = 16
    Height = 16
    Caption = 'x 4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 88
    Top = 10
    Width = 25
    Height = 21
    MaxLength = 2
    TabOrder = 0
    Text = '4'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 58
    Top = 132
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit2: TEdit
    Left = 88
    Top = 36
    Width = 57
    Height = 21
    MaxLength = -1
    TabOrder = 2
    Text = 'Z^(2)'
    OnChange = Edit1Change
  end
  object Edit3: TEdit
    Left = 124
    Top = 71
    Width = 25
    Height = 21
    TabOrder = 3
    Text = '-1'
  end
  object Edit4: TEdit
    Left = 164
    Top = 71
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '1'
  end
  object Edit5: TEdit
    Left = 124
    Top = 95
    Width = 25
    Height = 21
    TabOrder = 5
    Text = '-1'
  end
  object Edit6: TEdit
    Left = 164
    Top = 95
    Width = 25
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object MainMenu1: TMainMenu
    Left = 160
    Top = 13
    object Datei1: TMenuItem
      Caption = 'Datei'
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        OnClick = Beenden1Click
      end
    end
    object Extras1: TMenuItem
      Caption = 'Extras'
      object ber1: TMenuItem
        Caption = 'Info'
        OnClick = ber1Click
      end
    end
  end
end
