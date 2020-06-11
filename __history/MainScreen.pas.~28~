unit MainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, mmsystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw;

type
  TMainForm = class(TForm)
    BackGroundImage: TImage;
    CloseBtnImage: TImage;
    SettingsBtnImage: TImage;
    InfoBtnImage: TImage;
    NewGameBtnImage: TImage;
    NewGameBorderBtnImage: TImage;
    ContinueBtnImage: TImage;
    ContinueBorderBtnImage: TImage;
    AchiveBtnImage: TImage;
    AchiveBorderBtnImage: TImage;
    LiderBoardBorderBtnImage: TImage;
    LiderBoardBtnImage: TImage;
    PlayerSelectBackImage: TImage;
    AbilitySelectBackImage: TImage;
    PlayerSelectImage: TImage;
    AbilitySelectImage: TImage;
    HeroLabel: TLabel;
    AbilityLabel: TLabel;
    CoinImage: TImage;
    CoinCountLabel: TLabel;
    UpDate: TTimer;
    FormShowInputFreze: TTimer;
    Label1: TLabel;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CloseBtnImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewGameBtnImageMouseEnter(Sender: TObject);
    procedure NewGameBtnImageMouseLeave(Sender: TObject);
    procedure ContinueBtnImageMouseEnter(Sender: TObject);
    procedure ContinueBtnImageMouseLeave(Sender: TObject);
    procedure LiderBoardBtnImageMouseEnter(Sender: TObject);
    procedure LiderBoardBtnImageMouseLeave(Sender: TObject);
    procedure AchiveBtnImageMouseEnter(Sender: TObject);
    procedure AchiveBtnImageMouseLeave(Sender: TObject);
    procedure InfoBtnImageClick(Sender: TObject);
    procedure SettingsBtnImageClick(Sender: TObject);
    procedure NewGameBtnImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ContinueBtnImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AchiveBtnImageClick(Sender: TObject);
    procedure LiderBoardBtnImageClick(Sender: TObject);
    procedure PlayerSelectImageClick(Sender: TObject);
    procedure AbilitySelectImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure UpDateTimer(Sender: TObject);
    procedure FormShowInputFrezeTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    SelectPlayerIndex: Integer;
    isFormActive: boolean;
    procedure GameStart(mode: BOOL);

  public
    function GetSelectedPlayerIndex(): Integer;
  end;

var
  MainForm: TMainForm;
  GameData: TSaveData;

implementation

{$R *.dfm}

uses BackGround;

function CentrX(weight: Integer): Integer;
begin
  CentrX := round((MainForm.Width - weight) / 2);
end;

function CentrY(height: Integer): Integer;
begin
  CentrY := round((MainForm.height - height) / 2);
end;

procedure TMainForm.AbilitySelectImageClick(Sender: TObject);
begin
  showmessage('ability');
end;

procedure TMainForm.AchiveBtnImageClick(Sender: TObject);
begin
  // Msg('trophey');
end;

procedure TMainForm.AchiveBtnImageMouseEnter(Sender: TObject);
begin
  AchiveBorderBtnImage.Visible := true;
end;

procedure TMainForm.AchiveBtnImageMouseLeave(Sender: TObject);
begin
  AchiveBorderBtnImage.Visible := false;
end;

procedure TMainForm.CloseBtnImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  BackGroundForm.Close;

end;

procedure TMainForm.ContinueBtnImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  showmessage('continue');
end;

procedure TMainForm.ContinueBtnImageMouseEnter(Sender: TObject);
begin
  ContinueBorderBtnImage.Visible := true;
end;

procedure TMainForm.ContinueBtnImageMouseLeave(Sender: TObject);
begin
  ContinueBorderBtnImage.Visible := false;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  InitForm(self);

  MainForm.font.Color := RGB(222, 185, 56);

end;

procedure TMainForm.FormHide(Sender: TObject);
begin
  isFormActive := false;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = 27 then
    BackGroundForm.Close;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  i: Integer;
begin

end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // BackGroundForm.Show();
  GAME_PAD_CONNECTED := IsGamePadIsConnected;
  FormShowInputFreze.Enabled := true;
  CoinCountLabel.Caption := IntToStr(GameData.Money);
  AbilityLabel.Width := 200;
  AbilityLabel.height := 200;
  HeroLabel.Width := 200;
  HeroLabel.height := 200;
  CoinCountLabel.Width := 200;
  CoinCountLabel.height := 200;
end;

procedure TMainForm.FormShowInputFrezeTimer(Sender: TObject);
begin
  isFormActive := true;
  FormShowInputFreze.Enabled := false
end;

procedure TMainForm.InfoBtnImageClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', 'www.nrtu.studio/projects/You-n-Dungeon', nil,
    nil, SW_NORMAL);
end;

procedure TMainForm.LiderBoardBtnImageClick(Sender: TObject);
begin
  showmessage('lider board');
end;

procedure TMainForm.LiderBoardBtnImageMouseEnter(Sender: TObject);
begin
  LiderBoardBorderBtnImage.Visible := true;
end;

procedure TMainForm.LiderBoardBtnImageMouseLeave(Sender: TObject);
begin
  LiderBoardBorderBtnImage.Visible := false;

end;

procedure TMainForm.NewGameBtnImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// New Game
begin
  GameStart(false);
end;

procedure TMainForm.NewGameBtnImageMouseEnter(Sender: TObject);
begin
  NewGameBorderBtnImage.Visible := true;
end;

procedure TMainForm.NewGameBtnImageMouseLeave(Sender: TObject);
begin
  NewGameBorderBtnImage.Visible := false;
end;

procedure TMainForm.PlayerSelectImageClick(Sender: TObject);
begin
  showmessage('hero');
end;

procedure TMainForm.SettingsBtnImageClick(Sender: TObject);
begin

  showmessage('settings');
end;

procedure TMainForm.UpDateTimer(Sender: TObject);
var
  gamePad: tjoyinfo;
  keypad: Integer;
begin
  if not isFormActive then
    exit;

  joygetpos(joystickid1, @gamePad);

  Label1.Caption := tStr(gamePad.wXpos) + ' ' + tStr(gamePad.wYpos) + ' ' +
    tStr(gamePad.wZpos) + ' ' + tStr(gamePad.wZpos) + ' ' +
    tStr(gamePad.wButtons);

  if GAME_PAD_CONNECTED then
  begin
    if not IsGamePadIsConnected then
    begin
      GAME_PAD_CONNECTED := false;
      Msg('Похоже, что геймпад был отключен...');
      exit;
    end;
  end
  else
  begin

    if IsGamePadIsConnected then
    begin
      GAME_PAD_CONNECTED := true;
      Msg('Был обнаружен подключенный GamePad. Вы можете играть в игру с его помощью.');
    end;
    exit;
  end;

  case gamePad.wButtons of
    128:
      GameStart(false);
    64:
      BackGroundForm.Close;
    4:
      ; // L
    8:
      ; // R
  end;
end;

procedure TMainForm.GameStart(mode: BOOL);
begin
  if mode then
  else
  begin
    SelectDifficultForm.Show;
    MainForm.hide;
  end;
end;

function TMainForm.GetSelectedPlayerIndex(): Integer;
begin

  SelectPlayerIndex := 0;
  GetSelectedPlayerIndex := SelectPlayerIndex;
end;

end.
