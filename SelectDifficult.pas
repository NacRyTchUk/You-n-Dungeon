unit SelectDifficult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  nicestuff;

type
  TSelectDifficultForm = class(TForm)
    BackGroundImage: TImage;
    BackBtnImage: TImage;
    LevelSelectBrn1: TImage;
    LevelSelectBrn2: TImage;
    LevelSelectBrn3: TImage;
    procedure BackBtnImageClick(Sender: TObject);
    procedure LevelSelectBrn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LevelSelectBrn2Click(Sender: TObject);
    procedure LevelSelectBrn3Click(Sender: TObject);
  private
    procedure GameStart(Difficult : integer);
  public
    { Public declarations }
  end;

var
  SelectDifficultForm: TSelectDifficultForm;

implementation

{$R *.dfm}

uses MainScreen, Game;

procedure TSelectDifficultForm.BackBtnImageClick(Sender: TObject);
begin
  SelectDifficultForm.Hide;
  MainForm.Show;
end;

procedure TSelectDifficultForm.FormCreate(Sender: TObject);
begin

  InitForm(self);
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

  GameStart(10);
end;

procedure TSelectDifficultForm.GameStart(Difficult : integer);
begin
  GameForm := TGameForm.Create(Application);
  GameForm.SetDifficult(Difficult);
  GameForm.Show;
  SelectDifficultForm.Close;
end;

end.
