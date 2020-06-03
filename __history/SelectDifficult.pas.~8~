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
    LevelSelectBrnBack1: TImage;
    LevelSelectBrn2: TImage;
    LevelSelectBrnBack2: TImage;
    LevelSelectBrn3: TImage;
    LevelSelectBrnBack3: TImage;
    LevelSelectBrnBack4: TImage;
    LevelSelectBrn4: TImage;
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

procedure TSelectDifficultForm.LevelSelectBrn1MouseEnter(Sender: TObject);
begin
  LevelSelectBrnBack1.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn1MouseLeave(Sender: TObject);
begin
  LevelSelectBrnBack1.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn2Click(Sender: TObject);
begin

  GameStart(5);
end;

procedure TSelectDifficultForm.LevelSelectBrn2MouseEnter(Sender: TObject);
begin
   LevelSelectBrnBack2.Visible := True;
end;

procedure TSelectDifficultForm.LevelSelectBrn2MouseLeave(Sender: TObject);
begin
   LevelSelectBrnBack2.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn3Click(Sender: TObject);
begin

  GameStart(10);
end;

procedure TSelectDifficultForm.LevelSelectBrn3MouseEnter(Sender: TObject);
begin
    LevelSelectBrnBack3.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn3MouseLeave(Sender: TObject);
begin
    LevelSelectBrnBack3.Visible := false;
end;

procedure TSelectDifficultForm.LevelSelectBrn4Click(Sender: TObject);
begin
  GameStart(15);
end;

procedure TSelectDifficultForm.LevelSelectBrn4MouseEnter(Sender: TObject);
begin
     LevelSelectBrnBack4.Visible := true;
end;

procedure TSelectDifficultForm.LevelSelectBrn4MouseLeave(Sender: TObject);
begin
     LevelSelectBrnBack4.Visible := false;
end;

procedure TSelectDifficultForm.GameStart(Difficult : integer);
begin
  GameForm := TGameForm.Create(Application);
  GameForm.SetDifficult(Difficult);
  GameForm.Show;
  SelectDifficultForm.Close;
end;

end.
