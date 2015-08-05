object Form2: TForm2
  Left = 200
  Top = 120
  BorderStyle = bsSingle
  Caption = 'Komplexe Zahl'
  ClientHeight = 124
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
    Left = 10
    Top = 17
    Width = 67
    Height = 20
    Caption = 'Realteil:'
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
    Width = 100
    Height = 20
    Caption = 'Imagin'#228'rteil:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 10
    Top = 96
    Width = 79
    Height = 20
    Caption = 'Z = x + i*y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 10
    Top = 74
    Width = 123
    Height = 20
    Caption = 'Komplexe Zahl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 112
    Top = 17
    Width = 65
    Height = 21
    MaxLength = 2
    TabOrder = 0
    Text = '0'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Left = 112
    Top = 46
    Width = 65
    Height = 21
    MaxLength = 2
    TabOrder = 1
    Text = '0'
    OnChange = Edit2Change
  end
  object MainMenu1: TMainMenu
    Left = 144
    Top = 76
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
