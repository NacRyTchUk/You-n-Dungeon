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

    Button1: TButton;
    Button2: TButton;
    UpDate: TTimer;
    CardPlayersImageList: TImageList;
    CardEnemyImageList: TImageList;
    CardBonusImageList: TImageList;
    CardTrapsImageList: TImageList;
    CoinImage: TImage;
    CoinCountLabel: TLabel;
    CardWeaponImageList: TImageList;
    Label1: TLabel;
    InputLockcooldown: TTimer;
    FormShowInputFreze: TTimer;
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UpDateTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure InputLockcooldownTimer(Sender: TObject);
    procedure FormShowInputFrezeTimer(Sender: TObject);
  private
    GameStartMode: Integer;
    isFormActive: Boolean;
    BufferLoadData: TFieldOfCardSaveData;
    procedure BackToMenu();
    procedure DoKeyDown(Key: Integer);
    procedure DoJoyKey();
  public
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

procedure TGameForm.BackBtnImageClick(Sender: TObject);
begin
  BackToMenu();
end;

procedure TGameForm.BackToMenu();
begin
  GameData.Money := GameData.Money + FieldOfCards.GetMoneyRecived;
  MainForm.Show();
  GameForm.free;
end;

procedure TGameForm.Button1Click(Sender: TObject);
var
  I: Integer;
  s: string;

  gamePad: tjoyinfo;
begin
  joygetpos(joystickid2, @gamePad);

  Msg(gamePad.wXpos.ToString + ' ' + gamePad.wYpos.ToString);
end;

procedure TGameForm.Button2Click(Sender: TObject);
begin

  FieldOfCards.ToggleAnimOn(5, 2, 2, 142);

end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

begin

  // Msg(KeyToChar(Key) + ' ' + tStr(Key));
  DoKeyDown(Key);
end;

procedure TGameForm.DoKeyDown(Key: Integer);
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

procedure TGameForm.FormShow(Sender: TObject);
begin
  InitForm(self);

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

procedure TGameForm.GameStart();
begin
  GameStartMode := 0;
end;

procedure TGameForm.GameStart(LoadData: TFieldOfCardSaveData);
begin
  GameStartMode := 1;
  BufferLoadData := LoadData;
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

procedure TGameForm.DoJoyKey();
var
  gamePad: tjoyinfo;
  keypad: Integer;
begin
  if InputLockcooldown.Enabled or not GAME_PAD_CONNECTED or not SETT_GAMEPAD_ON then
    exit;

  if not IsGamePadIsConnected then
  begin
    GAME_PAD_CONNECTED := False;
    Msg('Похоже, что геймпад был отключен...');
    exit;
  end;

  joygetpos(joystickid1, @gamePad);

  Label1.Caption := tStr(gamePad.wXpos) + ' ' + tStr(gamePad.wYpos) + ' ' +
    tStr(gamePad.wZpos) + ' ' + tStr(gamePad.wZpos) + ' ' +
    tStr(gamePad.wButtons) + ' ' + tStr(FieldOfCards.IsCardAnimPlayed(3)) + ' '
    + tStr(FieldOfCards.IsCardAnimPlayed(1));

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

procedure TGameForm.SetDifficult(Difficult: Integer);
begin
  BaseDifficult := Difficult;
end;

end.
