object ConsoleForm: TConsoleForm
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderStyle = bsToolWindow
  Caption = 'Console'
  ClientHeight = 69
  ClientWidth = 209
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindow
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object BackGround: TImage
    Left = 0
    Top = 0
    Width = 209
    Height = 69
    Align = alClient
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000100000
      0010080200000090916836000000097048597300000B1200000B1201D2DD7EFC
      000000174944415478DA63D4D030612005308E6A18D5307C35000078BB0851E4
      EF0E3F0000000049454E44AE426082}
    Stretch = True
    ExplicitLeft = 88
    ExplicitTop = 48
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object ResponseLabel: TLabel
    Left = 8
    Top = 49
    Width = 3
    Height = 13
  end
  object InputBox: TLabeledEdit
    Left = 8
    Top = 22
    Width = 193
    Height = 21
    EditLabel.Width = 93
    EditLabel.Height = 13
    EditLabel.Caption = #1042#1074#1077#1076#1080#1090#1077' '#1082#1086#1084#1072#1085#1076#1091':'
    TabOrder = 0
    OnKeyDown = InputBoxKeyDown
  end
end
