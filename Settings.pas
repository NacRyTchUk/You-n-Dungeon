unit Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, mmsystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls;

type
  TSettingsForm = class(TForm)
    BackGroundImage: TImage;
    CancelBtn: TImage;
    YesBtn: TImage;
    HintCheckBox: TImage;
    HintCheckBoxOn: TImage;
    MusicCheckBox: TImage;
    MusicCheckBoxOn: TImage;
    SoundCheckBox: TImage;
    SoundCheckBoxOn: TImage;
    ControllerCheckBox: TImage;
    ControllerCheckBoxOn: TImage;
    AutoSavePlus: TImage;
    AutoSaveMinus: TImage;
    AutoSaveRateLabel: TLabel;
    AnimTimer: TTimer;
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure YesBtnClick(Sender: TObject);
    procedure MusicCheckBoxClick(Sender: TObject);
    procedure SoundCheckBoxClick(Sender: TObject);
    procedure HintCheckBoxClick(Sender: TObject);
    procedure ControllerCheckBoxClick(Sender: TObject);
    procedure AutoSavePlusClick(Sender: TObject);
    procedure AutoSaveMinusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AnimTimerTimer(Sender: TObject);
  private

    AnimCounter, AnimMode: Integer;
    procedure CheckBoxClick(var CheckB: TImage);
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}

uses mainscreen, BackGround;

procedure TSettingsForm.AnimTimerTimer(Sender: TObject);
begin
  MainForm.AnimWindowBlend(self, AnimMode, 90, 10, AnimCounter, AnimTimer);
end;

procedure TSettingsForm.AutoSaveMinusClick(Sender: TObject);
begin
  GameSound('Click', true);
  AutoSaveRateLabel.Caption := tStr(Delta(tInt(AutoSaveRateLabel.Caption),
    -RELOAD_INTERVAL_STEP, RELOAD_INTERVAL_MIN, RELOAD_INTERVAL_MAX));
end;

procedure TSettingsForm.AutoSavePlusClick(Sender: TObject);
begin
  GameSound('Click', true);
  AutoSaveRateLabel.Caption := tStr(Delta(tInt(AutoSaveRateLabel.Caption),
    RELOAD_INTERVAL_STEP, RELOAD_INTERVAL_MIN, RELOAD_INTERVAL_MAX));
end;

procedure TSettingsForm.CancelBtnClick(Sender: TObject);
begin

  GameSound('Click', true);
  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Enabled := true;
end;

procedure TSettingsForm.ControllerCheckBoxClick(Sender: TObject);
begin
  CheckBoxClick(ControllerCheckBoxOn);
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
  MusicCheckBoxOn.Visible := GameData.MusicIsOn;
  SoundCheckBoxOn.Visible := GameData.SoundIsOn;
  HintCheckBoxOn.Visible := GameData.HintIsOn;
  ControllerCheckBoxOn.Visible := GameData.GamePadIsOn;
  AutoSaveRateLabel.Caption := tStr(GameData.ReloadInterval);
end;

procedure TSettingsForm.HintCheckBoxClick(Sender: TObject);
begin
  CheckBoxClick(HintCheckBoxOn);
end;

procedure TSettingsForm.MusicCheckBoxClick(Sender: TObject);
begin
  CheckBoxClick(MusicCheckBoxOn);
end;

procedure TSettingsForm.SoundCheckBoxClick(Sender: TObject);
begin
  CheckBoxClick(SoundCheckBoxOn);
end;

procedure TSettingsForm.CheckBoxClick(var CheckB: TImage);
begin
  GameSound('Click', true);
  CheckB.Visible := not CheckB.Visible;
end;

procedure TSettingsForm.YesBtnClick(Sender: TObject);
begin
  GameSound('Click', true);

  GameData.MusicIsOn := MusicCheckBoxOn.Visible;
  GameData.SoundIsOn := SoundCheckBoxOn.Visible;
  GameData.HintIsOn := HintCheckBoxOn.Visible;
  GameData.GamePadIsOn := ControllerCheckBoxOn.Visible;
  GameData.ReloadInterval := tInt(AutoSaveRateLabel.Caption);

  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Close;
  MainForm.Show;
  MainForm.Enabled := true;
end;

end.
