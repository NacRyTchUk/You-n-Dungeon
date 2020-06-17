unit SelectDifficult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, mmsystem,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  nicestuff, System.ImageList, Vcl.ImgList, Vcl.StdCtrls;

type
  TSelectDifficultForm = class(TForm)
    BackGroundImage: TImage;
    BackBtnImage: TImage;
    LevelSelectBrn1: TImage;
    LevelSelectBrnBack1: TImage;
    LevelSelectBrn2: TImage;
    LevelSelectBrnBack2: TImage;
    LevelSelectBrn3: TImage;
    LevelSelectBrnBack3: TImage;
    LevelSelectBrnBack4: TImage;
    LevelSelectBrn4: TImage;
    UpDate: TTimer;
    FormShowInputFreze: TTimer;
    ReloadTimer: TTimer;
    MusicLoopTimer: TTimer;
    HardPrice: TLabel;
    Label1: TLabel;
    procedure BackBtnImageClick(Sender: TObject);
    procedure LevelSelectBrn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LevelSelectBrn2Click(Sender: TObject);
    procedure LevelSelectBrn3Click(Sender: TObject);
    procedure LevelSelectBrn1MouseEnter(Sender: TObject);
    procedure LevelSelectBrn1MouseLeave(Sender: TObject);
    procedure LevelSelectBrn2MouseEnter(Sender: TObject);
    procedure LevelSelectBrn2MouseLeave(Sender: TObject);
    procedure LevelSelectBrn3MouseEnter(Sender: TObject);
    procedure LevelSelectBrn3MouseLeave(Sender: TObject);
    procedure LevelSelectBrn4Click(Sender: TObject);
    procedure LevelSelectBrn4MouseEnter(Sender: TObject);
    procedure LevelSelectBrn4MouseLeave(Sender: TObject);
    procedure UpDateTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormShowInputFrezeTimer(Sender: TObject);
    procedure ReloadTimerTimer(Sender: TObject);
    procedure MusicLoopTimerTimer(Sender: TObject);
  private
    BufferFieldData: TFieldOfCardSaveData;
    isFormActive: boolean;
    procedure GameStart(Difficult: integer);
  public
    procedure GameReset(Difficult: integer);
    procedure GameSave();
    procedure GameLoad();
    procedure GameReload();
  end;

var
  SelectDifficultForm: TSelectDifficultForm;

implementation

{$R *.dfm}

uses MainScreen, Game, BackGround;

procedure TSelectDifficultForm.GameStart(Difficult: integer);
// Запуск игры без параметров
begin
  GameSound('Click', true);
  GameSound('MenuTheme', false);
  GameSound('GameTheme', true);
  MainForm.MusicLoopTimer.Enabled := false;
  MusicLoopTimer.Enabled := true;
  GameForm := TGameForm.Create(Application);
  GameForm.SetDifficult(Difficult);
  GameForm.Show;
  SelectDifficultForm.Close;
end;

procedure TSelectDifficultForm.GameReset(Difficult: integer);
// Обработка рестарта уровня
begin
  GameSound('Swap', true);
  if (Difficult >= 10) and (Difficult < 15) then
  begin
    if GameData.Money >= HARD_LEVEL_PRICE then
      GameData.Money := GameData.Money - HARD_LEVEL_PRICE
    else
      exit;
  end
  else if (Difficult >= 15) then
  begin
    if GameData.Money >= ULTRAHARD_LEVEL_PRICE then
      GameData.Money := GameData.Money - ULTRAHARD_LEVEL_PRICE
    else
      exit;
  end;

  GameData.Money := GameData.Money + FieldOfCards.GetMoneyRecived;
  GameForm.Free;

  GameForm := TGameForm.Create(Application);
  GameForm.SetDifficult(Difficult);
  GameForm.GameStart();
  GameForm.Show;
end;

procedure TSelectDifficultForm.GameSave();
// Сохранение данных об текущей игре
begin
  BufferFieldData := FieldOfCards.SaveField;
end;

procedure TSelectDifficultForm.GameLoad();
// Загрузка данных о текущей игре
begin
  GameForm := TGameForm.Create(Application);
  GameForm.GameStart(BufferFieldData);
  GameForm.Show;
end;

procedure TSelectDifficultForm.GameReload();
// Осуществление перезагрузки игры
var
  gameBit, backBit: TBitmap;
begin
  GameSound('Swap', true);
  backBit := TBitmap.Create;
  gameBit := TBitmap.Create;
  backBit := BackGroundForm.ImageForReload.Picture.Bitmap;
  TakeScreenShot(gameBit);
  BackGroundForm.ImageForReload.Picture.Bitmap := gameBit;
  ReloadTimer.Enabled := true;
  GameSave;
  GameForm.Free;
end;

procedure TSelectDifficultForm.UpDateTimer(Sender: TObject);
// Обработка нажатий гемпада
var
  gamePad: tjoyinfo;
  keypad: integer;
begin
  if not isFormActive or not GAME_PAD_CONNECTED or not GameData.GamePadIsOn then
    exit;

  joygetpos(joystickid1, @gamePad);

  case gamePad.wButtons of
    1:
      GameStart(1);
    2:
      GameStart(5);
    4:
      if GameData.Money >= HARD_LEVEL_PRICE then
      begin
        GameData.Money := GameData.Money - HARD_LEVEL_PRICE;
        GameStart(10);
      end;
    8:
      if GameData.Money >= ULTRAHARD_LEVEL_PRICE then
      begin
        GameData.Money := GameData.Money - ULTRAHARD_LEVEL_PRICE;
        GameStart(15);
      end;
  end;
end;

procedure TSelectDifficultForm.BackBtnImageClick(Sender: TObject);
begin
  GameSound('Click', true);
  SelectDifficultForm.Hide;
  MainForm.Show;
end;

procedure TSelectDifficultForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TSelectDifficultForm.FormHide(Sender: TObject);
begin
  isFormActive := false;
end;

procedure TSelectDifficultForm.FormShow(Sender: TObject);
begin
  FormShowInputFreze.Enabled := true;
end;

procedure TSelectDifficultForm.FormShowInputFrezeTimer(Sender: TObject);
begin
  FormShowInputFreze.Enabled := false;
  isFormActive := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn1MouseEnter(Sender: TObject);
begin
  LevelSelectBrnBack1.Visible := true;

end;

procedure TSelectDifficultForm.LevelSelectBrn1MouseLeave(Sender: TObject);
begin
  LevelSelectBrnBack1.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn2MouseEnter(Sender: TObject);
begin
  LevelSelectBrnBack2.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn2MouseLeave(Sender: TObject);
begin
  LevelSelectBrnBack2.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn3MouseEnter(Sender: TObject);
begin
  LevelSelectBrnBack3.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn3MouseLeave(Sender: TObject);
begin
  LevelSelectBrnBack3.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn4MouseEnter(Sender: TObject);
begin
  LevelSelectBrnBack4.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn4MouseLeave(Sender: TObject);
begin
  LevelSelectBrnBack4.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn1Click(Sender: TObject);
begin
  GameStart(1);
end;

procedure TSelectDifficultForm.LevelSelectBrn2Click(Sender: TObject);
begin

  GameStart(5);
end;

procedure TSelectDifficultForm.LevelSelectBrn3Click(Sender: TObject);
begin
  if GameData.Money >= HARD_LEVEL_PRICE then
  begin
    GameData.Money := GameData.Money - HARD_LEVEL_PRICE;
    GameStart(10);
  end;
end;

procedure TSelectDifficultForm.LevelSelectBrn4Click(Sender: TObject);
begin
  if GameData.Money >= ULTRAHARD_LEVEL_PRICE then
  begin
    GameData.Money := GameData.Money - ULTRAHARD_LEVEL_PRICE;
    GameStart(15);
  end;
end;

procedure TSelectDifficultForm.MusicLoopTimerTimer(Sender: TObject);
begin
  GameSound('GameTheme', false);
  GameSound('GameTheme', true);
end;

procedure TSelectDifficultForm.ReloadTimerTimer(Sender: TObject);
// Таймер, необходимый для корректной работы перезагрузки
begin
  ReloadTimer.Enabled := false;

  GameLoad;
  BackGroundForm.ImageForReload.Picture :=
    BackGroundForm.BackGroundImage.Picture;
end;

end.
