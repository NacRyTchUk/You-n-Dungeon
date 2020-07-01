unit MainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, MMSystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls, Vcl.MPlayer;

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
    LeftFireGif: TImage;
    RightFireGif: TImage;
    PlayerDemoImages: TImageList;
    AbilityDemoImages: TImageList;
    MusicLoopTimer: TTimer;
    HelpImg: TImage;
    MsgHitBox: TImage;
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
    procedure GamePadKeyDo();
    procedure FormShowInputFrezeTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure MusicLoopTimerTimer(Sender: TObject);
    procedure RightFireGifClick(Sender: TObject);
    procedure LeftFireGifClick(Sender: TObject);
    procedure HelpImgClick(Sender: TObject);
    procedure MsgHitBoxClick(Sender: TObject);
  private
    SelectPlayerIndex: Integer;
    isFormActive: boolean;
    procedure GameStart(mode: BOOL);
    procedure DemoWarn();
  public
    function GetSelectedPlayerIndex(): Integer;
    procedure AnimWindowBlend(oForm: TForm;
      mode, blendPercent, maxCouter: Integer; var counter: Integer;
      var animTimer: TTimer);
    procedure RefreshIconImg();
  end;

var
  MainForm: TMainForm;
  GameData: TSaveData;

implementation

{$R *.dfm}

uses BackGround, selectplayer, selectability, settings, info, help;

procedure TMainForm.GameStart(mode: BOOL);
// Запуск игры (В данном случае только новой игры)
begin
  GameSound('Click', true);
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

procedure TMainForm.AnimWindowBlend(oForm: TForm;
  mode, blendPercent, maxCouter: Integer; var counter: Integer;
  var animTimer: TTimer);
// Обработчик анимации для окон в меню, с настройкой скорости, силы и режима
var
  stepNormValue, normalizevValue, minValue: real;
begin
  stepNormValue := blendPercent / 100;
  minValue := maxCouter / stepNormValue - maxCouter;
  normalizevValue := 256 / (maxCouter + minValue);

  case mode of
    1: // Появление
      begin
        if counter <= maxCouter then
        begin
          oForm.AlphaBlendValue := round(counter * normalizevValue);
          MainForm.AlphaBlendValue :=
            round((maxCouter - counter * stepNormValue) * normalizevValue);
          inc(counter);
        end
        else
        begin
          animTimer.Enabled := false;
          oForm.AlphaBlendValue := 255;
        end;
      end;
    2: // Изчезновение
      begin
        if counter <= maxCouter then
        begin
          oForm.AlphaBlendValue :=
            round((maxCouter - counter) * normalizevValue);
          MainForm.AlphaBlendValue :=
            round((minValue + counter * stepNormValue) * normalizevValue);
          inc(counter);
        end
        else
        begin
          oForm.Close;
          animTimer.Enabled := false;
          MainForm.AlphaBlendValue := 255;
        end;
      end;
  end;
end;

procedure TMainForm.RefreshIconImg();
// Обновление иконок выбранных персоонажей и навыков
var
  bm: TBitmap;
begin
  bm := TBitmap.Create;
  bm.Width := PlayerSelectImage.Width;
  bm.height := PlayerSelectImage.height;
  PlayerDemoImages.GetBitmap(GameData.HeroSelected, bm);
  PlayerSelectImage.Picture.Bitmap := bm;
  AbilityDemoImages.GetBitmap(GameData.AbilitySelected, bm);
  AbilitySelectImage.Picture.Bitmap := bm;
  bm.Free;
end;

procedure TMainForm.GamePadKeyDo();
// Обработка нажатий клавиш контроллера
var
  gamePad: tjoyinfo;
  keypad: Integer;
begin
  if not isFormActive or not GameData.GamePadIsOn then
    exit;

  joygetpos(joystickid1, @gamePad);

  if GAME_PAD_CONNECTED then
  begin
    if not IsGamePadIsConnected then
    begin
      GAME_PAD_CONNECTED := false;
      if GameData.HintIsOn then
        msg('Похоже, что геймпад был отключен...');
      UpDate.Interval := 1000;
      exit;
    end;
  end
  else
  begin
    if IsGamePadIsConnected then
    begin
      GAME_PAD_CONNECTED := true;
      if GameData.HintIsOn then
        msg('Был обнаружен подключенный GamePad. Вы можете играть в игру с его помощью.');
      UpDate.Interval := 15;
    end;
    exit;
  end;

  case gamePad.wButtons of
    128:
      GameStart(false);
    64:
      BackGroundForm.Close;
  end;
end;

procedure TMainForm.AbilitySelectImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  SelectAbillityForm.Show;
end;

procedure TMainForm.AchiveBtnImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  DemoWarn;
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
  GameSound('Click', true);
  Sleep(50);
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
var
  tGif: TGIFImage;
begin
  InitForm(self);
  RefreshIconImg;
end;

procedure TMainForm.FormHide(Sender: TObject);
begin
  isFormActive := false;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
// Обработка нажатий с клавиатуры
begin
  case Key of
    113:
      TakeScreenShot();
    27:
      BackGroundForm.Close;
  end;

  case KeyToChar(Key) of
    ' ':
      GameStart(false);
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  GameSound('MenuTheme', true);
  MusicLoopTimer.Enabled := true;

  GAME_PAD_CONNECTED := IsGamePadIsConnected;
  if not GAME_PAD_CONNECTED then
    UpDate.Interval := 5000;

  FormShowInputFreze.Enabled := true;
  CoinCountLabel.Caption := IntToStr(GameData.Money);

  RefreshIconImg;
end;

procedure TMainForm.FormShowInputFrezeTimer(Sender: TObject);
begin
  isFormActive := true;
  FormShowInputFreze.Enabled := false;
end;

procedure TMainForm.InfoBtnImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  InfoForm.Show;
end;

procedure TMainForm.LeftFireGifClick(Sender: TObject);
begin
  GameSound('Fire', false);
  GameSound('Fire', true);
end;

procedure TMainForm.LiderBoardBtnImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  DemoWarn;
end;

procedure TMainForm.DemoWarn();
begin
  msg('О нет, что-то пошло не так в этой Demo версии...' + #10 + 'Попробуй кликнуть еще раз!');
  LiderBoardBtnImage.Visible := false;
  AchiveBtnImage.Visible := false;
end;

procedure TMainForm.LiderBoardBtnImageMouseEnter(Sender: TObject);
begin
  LiderBoardBorderBtnImage.Visible := true;
end;

procedure TMainForm.LiderBoardBtnImageMouseLeave(Sender: TObject);
begin
  LiderBoardBorderBtnImage.Visible := false;
end;

procedure TMainForm.MsgHitBoxClick(Sender: TObject);
begin
  msg('id jst wnt t d');
end;

procedure TMainForm.MusicLoopTimerTimer(Sender: TObject);
begin
  GameSound('MenuTheme', false);
  GameSound('MenuTheme', true);
end;

procedure TMainForm.NewGameBtnImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
// Новая игра
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
  GameSound('Click', true);
  SelectPlayerForm.Show;
end;

procedure TMainForm.SettingsBtnImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  SettingsForm.Show;
end;

procedure TMainForm.UpDateTimer(Sender: TObject);
begin
  GamePadKeyDo;
end;

procedure TMainForm.HelpImgClick(Sender: TObject);
begin
  GameSound('Click', true);
  HelpForm.Show;
end;

procedure TMainForm.RightFireGifClick(Sender: TObject);
begin

  GameSound('Fire', false);
  GameSound('Fire', true);
end;

end.
