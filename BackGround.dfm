object BackGroundForm: TBackGroundForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'BackGroundForm'
  ClientHeight = 240
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    463
    240)
  PixelsPerInch = 96
  TextHeight = 13
  object BackGroundImage: TImage
    Left = 0
    Top = 0
    Width = 463
    Height = 240
    Anchors = [akLeft, akTop, akRight, akBottom]
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
      0010080200000090916836000000097048597300000B1200000B1201D2DD7EFC
      000000174944415478DA63D4D030612005308E6A18D5307C35000078BB0851E4
      EF0E3F0000000049454E44AE426082}
    Stretch = True
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = StartTimerTimer
    Left = 360
    Top = 208
  end
end
