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
    procedure BackBtnImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelectPlayerForm: TSelectPlayerForm;

implementation

{$R *.dfm}

procedure TSelectPlayerForm.BackBtnImageClick(Sender: TObject);
begin
self.Close;
end;

procedure TSelectPlayerForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

end.
