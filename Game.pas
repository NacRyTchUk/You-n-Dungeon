unit Game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, TFieldClass, TCardClass, NiceStuff, System.ImageList,
  Vcl.ImgList, mmsystem,
  TCardStatsClass;

type
  TGameForm = class(TForm)
    BackGroundImage: TImage;
    BackBtnImage: TImage;
    CardsImagesList: TImageList;
    CardBorderList: TImageList;
    UpDate: TTimer;
    CardPlayersImageList: TImageList;
    CardEnemyImageList: TImageList;
    CardBonusImageList: TImageList;
    CardTrapsImageList: TImageList;
    CoinImage: TImage;
    CoinCountLabel: TLabel;
    CardWeaponImageList: TImageList;
    InputLockcooldown: TTimer;
    FormShowInputFreze: TTimer;
    StepsCountLabel: TLabel;
    AbilitySelectBackImage: TImage;
    AbilitySelectImage: TImage;
    AbillityChargeProgressLabel: TLabel;
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpDateTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InputLockcooldownTimer(Sender: TObject);
    procedure FormShowInputFrezeTimer(Sender: TObject);
  private
    GameStartMode: Integer;
    isFormActive: Boolean;
    BufferLoadData: TFieldOfCardSaveData;
    procedure DoJoyKey();
  public
    procedure DoKeyDown(Key: Integer);
    procedure BackToMenu();
    procedure SetDifficult(Difficult: Integer);
    procedure GameStart(); overload;
    procedure GameStart(LoadData: TFieldOfCardSaveData); overload;
  end;

var
  GameForm: TGameForm;
  FieldOfCards: TField;
  BaseDifficult: Integer;

implementation

{$R *.dfm}

uses mainscreen, BackGround, SelectDifficult;

procedure TGameForm.DoJoyKey();
// Обработка нажатий с контроллера
var
  gamePad: tjoyinfo;
begin
  if InputLockcooldown.Enabled or not GAME_PAD_CONNECTED or not GameData.GamePadIsOn
  then
    exit;

  if not IsGamePadIsConnected then
  begin
    GAME_PAD_CONNECTED := False;
    if GameData.HintIsOn then
      Msg('Похоже, что геймпад был отключен...');
    exit;
  end;

  joygetpos(joystickid1, @gamePad);

  if gamePad.wXpos > 65400 then
    DoKeyDown(VK_RIGHT);
  if gamePad.wXpos < 100 then
    DoKeyDown(VK_LEFT);
  if gamePad.wYpos > 65400 then
    DoKeyDown(VK_DOWN);
  if gamePad.wYpos < 100 then
    DoKeyDown(VK_UP);

  case gamePad.wButtons of
    1:
      DoKeyDown(VK_DOWN);
    2:
      DoKeyDown(VK_RIGHT);
    4:
      DoKeyDown(VK_LEFT); // L
    8:
      DoKeyDown(VK_UP); // R
    16:
      DoKeyDown(82);
    32:
      DoKeyDown(76);
    64:
      DoKeyDown(VK_ESCAPE);
  end;
end;

procedure TGameForm.DoKeyDown(Key: Integer);
// Обработка нажатий клавиш с клавиатуры
begin
  if InputLockcooldown.Enabled then
    exit;
  InputLockcooldown.Enabled := true;

  if Key = 27 then
    BackToMenu();
  case KeyToChar(Key) of
    'R':
      SelectDifficultForm.GameReset(BaseDifficult);
    'L':
      SelectDifficultForm.GameReload;
    'W':
      if FieldOfCards.GetPlayerPos.Y - 1 >= 0 then
        FieldOfCards.GetFieldOfCards[FieldOfCards.GetPlayerPos.X,
          FieldOfCards.GetPlayerPos.Y - 1].DoClick;
    'S':
      if FieldOfCards.GetPlayerPos.Y + 1 <= FIELD_SIZE_Y - 1 then
        FieldOfCards.GetFieldOfCards[FieldOfCards.GetPlayerPos.X,
          FieldOfCards.GetPlayerPos.Y + 1].DoClick;
    'A':
      if FieldOfCards.GetPlayerPos.X - 1 >= 0 then
        FieldOfCards.GetFieldOfCards[FieldOfCards.GetPlayerPos.X - 1,
          FieldOfCards.GetPlayerPos.Y].DoClick;
    'D':
      if FieldOfCards.GetPlayerPos.X + 1 <= FIELD_SIZE_X - 1 then
        FieldOfCards.GetFieldOfCards[FieldOfCards.GetPlayerPos.X + 1,
          FieldOfCards.GetPlayerPos.Y].DoClick;
  end;
end;

procedure TGameForm.BackToMenu();
// Возвращение в меню
begin
  GameSound('Click', true);
  GameSound('GameTheme', False);
  SelectDifficultForm.MusicLoopTimer.Enabled := False;
  GameData.Money := GameData.Money + FieldOfCards.GetMoneyRecived;
  MainForm.Show();
  GameForm.free;
end;

procedure TGameForm.SetDifficult(Difficult: Integer);
// Установка сложности
begin
  BaseDifficult := Difficult;
end;

procedure TGameForm.GameStart();
// Обычный запуск игры
begin
  GameStartMode := 0;
end;

procedure TGameForm.GameStart(LoadData: TFieldOfCardSaveData);
// Запуск игры с подгруженными данными
begin
  GameStartMode := 1;
  BufferLoadData := LoadData;
end;

procedure TGameForm.BackBtnImageClick(Sender: TObject);
begin
  BackToMenu();
end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  DoKeyDown(Key);
end;

procedure TGameForm.FormShow(Sender: TObject);
begin
  InitForm(self);
  AbilitySelectImage.Picture := MainForm.AbilitySelectImage.Picture;

  if GameStartMode = 0 then
    FieldOfCards := TField.Create(BaseDifficult)
  else
    FieldOfCards := TField.Create(BufferLoadData.BaseDifficult, BufferLoadData);

end;

procedure TGameForm.FormShowInputFrezeTimer(Sender: TObject);
begin
  isFormActive := true;
  FormShowInputFreze.Enabled := False;
end;

procedure TGameForm.InputLockcooldownTimer(Sender: TObject);
begin
  InputLockcooldown.Enabled := False;
end;

procedure TGameForm.UpDateTimer(Sender: TObject);
begin
  DoJoyKey();
  FieldOfCards.UpdateAnim;
end;

end.
