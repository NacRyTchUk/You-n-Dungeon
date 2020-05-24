unit Game;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, TFieldClass, TCardClass,NiceStuff, System.ImageList, Vcl.ImgList,
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
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure UpDateTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
  procedure SetDifficult(Difficult : integer);
  end;

var
  GameForm: TGameForm;
  FieldOfCards : TField;
  BaseDifficult : Integer;
implementation

{$R *.dfm}

uses mainscreen, BackGround;






procedure TGameForm.BackBtnImageClick(Sender: TObject);
begin

  MainForm.Show();
  GameForm.free;
end;






procedure TGameForm.Button1Click(Sender: TObject);
begin
FieldOfCards.ToggleAnimOn(3,2,2,1);
end;

procedure TGameForm.Button2Click(Sender: TObject);
begin

FieldOfCards.GetFieldOfCards[1,1].SetVisible(False);


end;

procedure TGameForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = 27 then
    BackGroundForm.Close;

end;

procedure TGameForm.FormShow(Sender: TObject);
begin
InitForm(self);
FieldOfCards := TField.Create(BaseDifficult);
end;


procedure TGameForm.UpDateTimer(Sender: TObject);
begin
FieldOfCards.UpdateAnim;
end;


procedure TGameForm.SetDifficult(Difficult : integer);
begin
   BaseDifficult := Difficult;
end;


end.
