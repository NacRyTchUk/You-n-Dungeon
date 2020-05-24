unit MainScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult,
  NiceStuff;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

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
  Msg('trophey');
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
  MainForm.font.Color := RGB(222,185,56);
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
end;

procedure TMainForm.InfoBtnImageClick(Sender: TObject);
begin
ShellExecute( Handle, 'open', 'www.nrtu.studio/projects/You-n-Dungeon', nil, nil, SW_NORMAL );
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
  SelectDifficultForm.Show;
  MainForm.hide;
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

end.
