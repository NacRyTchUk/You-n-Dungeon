unit Game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, TFieldClass, TCardClass, NiceStuff, System.ImageList,
  Vcl.ImgList,
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
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UpDateTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    GameStartMode : Integer;
    BufferLoadData : TFieldOfCardSaveData;
  public
    procedure SetDifficult(Difficult: integer);
    procedure GameStart(); overload;
    procedure GameStart(LoadData: TFieldOfCardSaveData); overload;
  end;

var
  GameForm: TGameForm;
  FieldOfCards: TField;
  BaseDifficult: integer;

implementation

{$R *.dfm}

uses mainscreen, BackGround, SelectDifficult;

procedure TGameForm.BackBtnImageClick(Sender: TObject);
begin
  GameData.Money := GameData.Money + FieldOfCards.GetMoneyRecived;
  MainForm.Show();
  GameForm.free;
end;

procedure TGameForm.Button1Click(Sender: TObject);
var
  I: integer;
  s: string;
begin
  s := '';
  for I := 0 to 10 do
  begin
    s := s + IntToStr(Rnd(1, 3, 2, 2)) + ';';
  end;
  msg(s);
end;

procedure TGameForm.Button2Click(Sender: TObject);
begin

  FieldOfCards.ToggleAnimOn(5, 2, 2, 142);

end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    BackGroundForm.Close;
  if (Key = 82) or (Key = 114) or (Key = 202) or (Key = 234) then
    SelectDifficultForm.GameReset(BaseDifficult);
    if (Key = 76) or (Key = 108) or (Key = 196) or (Key = 228) then
   SelectDifficultForm.GameReload;
end;

procedure TGameForm.FormShow(Sender: TObject);
begin
  InitForm(self);

  if GameStartMode = 0 then
      FieldOfCards := TField.Create(BaseDifficult)
      else
      FieldOfCards := TField.Create(BufferLoadData.BaseDifficult, BufferLoadData);
  font.Color := RGB(222, 185, 56);
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

procedure TGameForm.UpDateTimer(Sender: TObject);
begin
  FieldOfCards.UpdateAnim;
end;

procedure TGameForm.SetDifficult(Difficult: integer);
begin
  BaseDifficult := Difficult;
end;

end.
