unit SelectAbility;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, mmsystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls;

type
  TSelectAbillityForm = class(TForm)
    BackGroundImage: TImage;
    BackBtnImage: TImage;
    ArrowBack: TImage;
    ArrowForward: TImage;
    SelectPanelBack1: TImage;
    SelectPanelBack2: TImage;
    SelectPanelBack3: TImage;
    SelectPanelItem1: TImage;
    SelectPanelItem3: TImage;
    SelectPanelItem2: TImage;
    SelectPanelBorder3: TImage;
    SelectPanelBorder2: TImage;
    SelectPanelBorder1: TImage;
    DescriptionLabel: TLabel;
    AnimTimer: TTimer;
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AnimTimerTimer(Sender: TObject);
    procedure SelectPanelItem1Click(Sender: TObject);
    procedure SelectPanelItem2Click(Sender: TObject);
    procedure SelectPanelItem3Click(Sender: TObject);
  private
    AnimCounter, AnimMode, ItemSelected: Integer;

    procedure SelectItem(Number: Integer);
  public
    { Public declarations }
  end;

var
  SelectAbillityForm: TSelectAbillityForm;

implementation

{$R *.dfm}

uses mainscreen;

procedure TSelectAbillityForm.AnimTimerTimer(Sender: TObject);
begin
  MainForm.AnimWindowBlend(Self, AnimMode, 75, 10, AnimCounter, AnimTimer);
end;

procedure TSelectAbillityForm.BackBtnImageClick(Sender: TObject);
begin

  GameData.AbilitySelected := ItemSelected;
  MainForm.RefreshIconImg;

  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Enabled := true;
end;

procedure TSelectAbillityForm.FormCreate(Sender: TObject);
begin
  InitForm(Self);
end;

procedure TSelectAbillityForm.FormShow(Sender: TObject);
begin

  SelectItem(GameData.AbilitySelected);
  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
end;

procedure TSelectAbillityForm.SelectPanelItem1Click(Sender: TObject);
begin
  SelectItem(0);
end;

procedure TSelectAbillityForm.SelectPanelItem2Click(Sender: TObject);
begin
  SelectItem(1);
end;

procedure TSelectAbillityForm.SelectPanelItem3Click(Sender: TObject);
begin
  SelectItem(2);
end;

procedure TSelectAbillityForm.SelectItem(Number: Integer);
begin
  SelectPanelBorder1.Visible := (Number = 0);
  SelectPanelBorder2.Visible := (Number = 1);
  SelectPanelBorder3.Visible := (Number = 2);

ItemSelected := Number;
end;

end.
