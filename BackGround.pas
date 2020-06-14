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
    procedure StartTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    MediaSounds: array [1 .. SFX_COUNT] of TMediaPlayer;
    procedure SoundLoad();
  public

  end;

procedure GameSound(sName: string; isPlay: BOOL);

var
  BackGroundForm: TBackGroundForm;

implementation

{$R *.dfm}

uses mainscreen, SelectDifficult, Game, TCardStatsClass;

procedure GameSound(sName: string; isPlay: BOOL);
var
  I: Integer;
begin
  for I := 1 to SFX_COUNT do
    if SFX_NAMES[I] = sName then
    begin

      if isPlay then
        BackGroundForm.MediaSounds[I].Play
      else
        BackGroundForm.MediaSounds[I].Position := 0;
      exit;
    end;
  msg('"' +sName + '" song not found');
end;

procedure TBackGroundForm.FormDestroy(Sender: TObject);
begin
  RemoveFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
end;

procedure TBackGroundForm.FormShow(Sender: TObject);
begin

  Randomize;
  StartTimer.Enabled := true;
  InitForm(self);
end;

procedure TBackGroundForm.StartTimerTimer(Sender: TObject);
var
  screenProp: real;
  gamePad: tjoyinfo;
  keypad: Integer;
begin

  joygetpos(joystickid1, @gamePad);

  screenProp := Screen.Width / Screen.Height;
  StartTimer.Enabled := false;

  if (round(screenProp * 10) <> 18) then
    ShowException(exception.Create
      ('��������!!! �� ���������� ���� �� �������� � �� �������������� ������������ ������! ����������, �� �����������, ������������� �� ���������� ������ ������� � 16:9. ���� You''n''Dungeon ��������� ������ � ����������� ������������ UI.'),
      0);

  InitCardStat;
  GlobalInit;
  SoundLoad;

  MainForm.Show;
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
    ShowException(exception.Create('������ ��� �������� �������� ������ (#' + tstr(i) + ')'), 0);
    Close;
  end;
  LoadingBar.Visible := false;
  LoadingBarLabel.Visible := false;
end;

end.
