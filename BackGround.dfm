object BackGroundForm: TBackGroundForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'BackGroundForm'
  ClientHeight = 504
  ClientWidth = 896
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
    896
    504)
  PixelsPerInch = 96
  TextHeight = 13
  object BackGroundImage: TImage
    Left = 0
    Top = 0
    Width = 896
    Height = 504
    Anchors = [akLeft, akTop, akRight, akBottom]
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
      0010080200000090916836000000097048597300000B1200000B1201D2DD7EFC
      000000174944415478DA63D4D030612005308E6A18D5307C35000078BB0851E4
      EF0E3F0000000049454E44AE426082}
    Stretch = True
    ExplicitWidth = 463
    ExplicitHeight = 240
  end
  object ImageForReload: TImage
    Left = 0
    Top = 0
    Width = 896
    Height = 504
    Anchors = [akLeft, akTop, akRight]
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
      0010080200000090916836000000097048597300000B1200000B1201D2DD7EFC
      000000174944415478DA63D4D030612005308E6A18D5307C35000078BB0851E4
      EF0E3F0000000049454E44AE426082}
    Stretch = True
    ExplicitWidth = 463
  end
  object LoadingBarLabel: TLabel
    Left = 416
    Top = 469
    Width = 37
    Height = 13
    Caption = 'Loading'
  end
  object LoadingBar: TProgressBar
    Left = 40
    Top = 488
    Width = 817
    Height = 8
    Anchors = [akLeft, akTop, akRight]
    DoubleBuffered = True
    ParentDoubleBuffered = False
    Smooth = True
    SmoothReverse = True
    State = pbsPaused
    TabOrder = 0
  end
  object StartTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = StartTimerTimer
    Left = 856
    Top = 8
  end
end
