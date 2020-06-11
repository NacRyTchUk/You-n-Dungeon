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
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AnimTimerTimer(Sender: TObject);
    procedure SelectPanelItem1Click(Sender: TObject);
    procedure SelectPanelItem2Click(Sender: TObject);
    procedure SelectPanelItem3Click(Sender: TObject);
  private
    AnimCounter, AnimMode: Integer;

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
  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
end;

procedure TSelectPlayerForm.AnimTimerTimer(Sender: TObject);
begin
  case AnimMode of
    1:
      begin
        if AnimCounter <= 10 then
        begin
          self.AlphaBlendValue := round(AnimCounter * 25.5);
          MainForm.AlphaBlendValue := round((10 - AnimCounter / 2) * 25.5);
          inc(AnimCounter);
        end
        else
          AnimTimer.Enabled := False;
      end;
    2:
      begin
        if AnimCounter <= 10 then
        begin
          self.AlphaBlendValue := round((10 - AnimCounter) * 25.5);
          MainForm.AlphaBlendValue := round((5 + AnimCounter / 2) * 25.5);
          inc(AnimCounter);
        end
        else
          self.Close;
      end;
  end;

end;

procedure TSelectPlayerForm.SelectItem(Number: Integer);
begin
SelectPanelBorder1.Visible := (Number = 1);
SelectPanelBorder2.Visible := (Number = 2);
SelectPanelBorder3.Visible := (Number = 3);
end;

procedure TSelectPlayerForm.SelectPanelItem1Click(Sender: TObject);
begin
   SelectItem(1);
end;

procedure TSelectPlayerForm.SelectPanelItem2Click(Sender: TObject);
begin
   SelectItem(2);
end;

procedure TSelectPlayerForm.SelectPanelItem3Click(Sender: TObject);
begin
   SelectItem(3);
end;

end.
