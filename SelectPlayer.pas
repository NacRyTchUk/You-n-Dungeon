unit SelectPlayer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, mmsystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls;

type
  TSelectPlayerForm = class(TForm)
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
    DiscriptionList: TListView;
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
  SelectPlayerForm: TSelectPlayerForm;

implementation

{$R *.dfm}

uses mainscreen;

procedure TSelectPlayerForm.BackBtnImageClick(Sender: TObject);
begin
    GameData.HeroSelected := ItemSelected;
    MainForm.RefreshIconImg;

  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Enabled := true;
end;

procedure TSelectPlayerForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TSelectPlayerForm.FormShow(Sender: TObject);
begin
  SelectItem(GameData.HeroSelected);
  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
end;

procedure TSelectPlayerForm.AnimTimerTimer(Sender: TObject);
begin
MainForm.AnimWindowBlend(Self, AnimMode,75, 10, AnimCounter, AnimTimer);
end;

procedure TSelectPlayerForm.SelectItem(Number: Integer);
begin
SelectPanelBorder1.Visible := (Number = 0);
SelectPanelBorder2.Visible := (Number = 1);
SelectPanelBorder3.Visible := (Number = 2);
DescriptionLabel.Caption := DiscriptionList.Items[Number].Caption.Replace(';',#10);
ItemSelected := Number;
end;

procedure TSelectPlayerForm.SelectPanelItem1Click(Sender: TObject);
begin
   SelectItem(0);
end;

procedure TSelectPlayerForm.SelectPanelItem2Click(Sender: TObject);
begin
   SelectItem(1);
end;

procedure TSelectPlayerForm.SelectPanelItem3Click(Sender: TObject);
begin
   SelectItem(2);
end;

end.
