object Form2: TForm2
  Left = 192
  Top = 122
  BorderStyle = bsSingle
  Caption = 'Mandelbrot'
  ClientHeight = 132
  ClientWidth = 191
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 53
    Top = 12
    Width = 95
    Height = 13
    Caption = 'Fraktal wird geladen'
    Visible = False
  end
  object Label1: TLabel
    Left = 10
    Top = 41
    Width = 53
    Height = 13
    Caption = 'Iterationen:'
  end
  object Label2: TLabel
    Left = 12
    Top = 74
    Width = 52
    Height = 13
    Caption = 'Werkzeug:'
  end
  object Label3: TLabel
    Left = 52
    Top = 105
    Width = 95
    Height = 13
    Caption = 'Fraktal wird geladen'
    Visible = False
  end
  object Button1: TButton
    Left = 64
    Top = 7
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 74
    Top = 41
    Width = 97
    Height = 21
    MaxLength = 4
    TabOrder = 1
    Text = '100'
    OnChange = Edit1Change
  end
  object ComboBox1: TComboBox
    Left = 74
    Top = 70
    Width = 97
    Height = 22
    Style = csOwnerDrawFixed
    ItemHeight = 16
    ItemIndex = 0
    TabOrder = 2
    Text = 'Zoom'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Zoom'
      'Verschieben')
  end
  object Button2: TButton
    Left = 62
    Top = 100
    Width = 75
    Height = 25
    Caption = 'Aktualisieren'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MainMenu1: TMainMenu
    Left = 9
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
      object Info1: TMenuItem
        Caption = 'Info'
        OnClick = Info1Click
      end
    end
  end
end
