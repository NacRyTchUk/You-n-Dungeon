unit BackGround;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, mmsystem, nicestuff,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.MPlayer;

type
  TBackGroundForm = class(TForm)
    BackGroundImage: TImage;
    StartTimer: TTimer;
    ImageForReload: TImage;
    LoadingBar: TProgressBar;
    LoadingBarLabel: TLabel;
    AnimTimer: TTimer;
    procedure StartTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AnimTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    MediaSounds: array [1 .. SFX_COUNT] of TMediaPlayer;
    AnimCounter: Integer;
    procedure SoundLoad();
    procedure StartAnim();
    procedure FlagsCheck();
  public
    procedure SaveGameData();
    procedure LoadGameData();
  end;

procedure GameSound(sName: string; isPlay: BOOL);
procedure GameSoundMute(sName: string);

var
  BackGroundForm: TBackGroundForm;
  IsDebugOn, IsConsole, IsReloadVisible: BOOL;

implementation

{$R *.dfm}

uses mainscreen, SelectDifficult, Game, TCardStatsClass, console;

procedure TBackGroundForm.FlagsCheck();
begin
  IsDebugOn := FileExists(DEBUG_MODE_FILENAME);
  IsConsole := FileExists(CONSOLE_ON_FILENAME);
end;

procedure GameSound(sName: string; isPlay: BOOL);
var
  I: Integer;
begin
  for I := 1 to SFX_COUNT do
    if SFX_NAMES[I] = sName then
    begin

      if isPlay and (((GameData.MusicIsOn) and (I <= 2)) or
        ((GameData.SoundIsOn) and (I > 2))) then
        BackGroundForm.MediaSounds[I].Play
      else
        BackGroundForm.MediaSounds[I].Position := 0;
      exit;
    end;
  if GameData.HintIsOn then
    msg('"' + sName + '" song not found');

end;

procedure GameSoundMute(sName: string);
var
  I: Integer;
begin
  for I := 1 to SFX_COUNT do
  begin
    if (I <= 2) and ((sName = 'm') or (sName = 'all')) then
      GameSound(SFX_NAMES[I], false);
    if (I > 2) and ((sName = 's') or (sName = 'all')) then
      GameSound(SFX_NAMES[I], false);
  end;
end;

procedure TBackGroundForm.SaveGameData();
var
  DataFile: file of TSaveData;
begin
  AssignFile(DataFile, GAMEDATA_FILENAME);
  Rewrite(DataFile);
  Write(DataFile, GameData);
  CloseFile(DataFile);
end;

procedure TBackGroundForm.LoadGameData();
var
  DataFile: file of TSaveData;
begin
  if FileExists(GAMEDATA_FILENAME) then
  begin
    AssignFile(DataFile, GAMEDATA_FILENAME);
    Reset(DataFile);
    Read(DataFile, GameData);
    CloseFile(DataFile);
  end
  else
  begin
    with GameData do
    begin
      Money := 0;
      HeroSelected := 0;
      AbilitySelected := 0;
      MusicIsOn := DEF_MUSIC_ON;
      SoundIsOn := DEF_SOUND_ON;
      HintIsOn := DEF_HINT;
      GamePadIsOn := DEF_GAMEPAD_ON;
      ReloadInterval := DEF_RELOAD_INTERVAL;
      SaveGameData;
    end;
  end;
end;

procedure TBackGroundForm.AnimTimerTimer(Sender: TObject);
begin
  StartAnim;
end;

procedure TBackGroundForm.StartAnim();
var
  screenProp: real;
begin
  inc(AnimCounter);
  if AnimCounter <= 25 then
    AlphaBlendValue := AnimCounter * 10 + 5;

  if AnimCounter = 30 then
  begin

    LoadingBarLabel.Visible := true;
    LoadingBar.Visible := true;

    FlagsCheck;
    InitCardStat;
    GlobalInit;
    SoundLoad;
    GameSound('Bonus', true);
  end;

  if AnimCounter = 120 then
  begin
    AnimTimer.Enabled := false;

    screenProp := Screen.Width / Screen.Height;
    if GameData.HintIsOn and (round(screenProp * 10) <> 18) then
      ShowException
        (exception.Create
        ('��������!!! �� ���������� ���� �� �������� � �� �������������� ������������ ������! ����������, �� �����������, ������������� �� ���������� ������ ������� � 16:9. ���� You''n''Dungeon ��������� ������ � ����������� ������������ UI.'),
        0);
    MainForm.Show;
    if IsConsole then
      ConsoleForm.Show;

    ImageForReload.Picture := BackGroundImage.Picture;
  end;
end;

procedure TBackGroundForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveGameData;
end;

procedure TBackGroundForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TBackGroundForm.FormDestroy(Sender: TObject);
begin
  RemoveFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
end;

procedure TBackGroundForm.FormShow(Sender: TObject);
begin

  Randomize;
  StartTimer.Enabled := true;

end;

procedure TBackGroundForm.StartTimerTimer(Sender: TObject);
var
  screenProp: real;
  gamePad: tjoyinfo;
  keypad: Integer;
begin
  LoadGameData();

  AnimCounter := 0;
  AnimTimer.Enabled := true;
  StartTimer.Enabled := false;

end;

procedure TBackGroundForm.SoundLoad();
var
  I: Integer;
  str: TSearchRec;
begin
  try
    for I := 1 to SFX_COUNT do
    begin
      MediaSounds[I] := TMediaPlayer.Create(self);
      with MediaSounds[I] do
      begin
        Parent := self;
        Visible := false;
        FileName := 'Assets\Sound\' + SFX_NAMES[I] + '.mp3';
        LoadingBar.StepBy(10);
        Open;
        if (I mod 4) = 0 then
        begin
          LoadingBarLabel.Caption := LoadingBarLabel.Caption + '.';
          Application.ProcessMessages;
        end;

      end;

    end;
  except
    ShowException(exception.Create('������ ��� �������� �������� ������ (#' +
      tstr(I) + ')'), 0);
    Close;
  end;
  LoadingBar.Visible := false;
  LoadingBarLabel.Visible := false;
end;

end.
