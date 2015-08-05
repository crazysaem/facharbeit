object Form1: TForm1
  Left = 430
  Top = 120
  BorderStyle = bsSingle
  Caption = 'Komplexe Funktion im 3-Dimensionalen'
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Interval = 40
    OnTimer = Timer1Timer
    Left = 96
    Top = 128
  end
  object Timer2: TTimer
    Interval = 20
    OnTimer = Timer2Timer
    Left = 256
    Top = 160
  end
end
