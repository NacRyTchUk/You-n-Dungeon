unit Info;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, nicestuff, shellapi;

type
  TInfoForm = class(TForm)
    BackGroundImage: TImage;
    OkBtn: TImage;
    VerLabel: TLabel;
    OriginalLabel: TLabel;
    AdaptLabel: TLabel;
    LinksLabel: TLabel;
    SiteImg: TImage;
    GameJoltImg: TImage;
    AnimTimer: TTimer;
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AnimTimerTimer(Sender: TObject);
    procedure SiteImgClick(Sender: TObject);
    procedure GameJoltImgClick(Sender: TObject);
  private
    AnimCounter, AnimMode: Integer;
  public
  end;

var
  InfoForm: TInfoForm;

implementation

{$R *.dfm}

uses MainScreen, BackGround;

procedure TInfoForm.AnimTimerTimer(Sender: TObject);
// Обработка анимаций
begin
  MainForm.AnimWindowBlend(self, AnimMode, 50, 10, AnimCounter, AnimTimer);
end;

procedure TInfoForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TInfoForm.FormShow(Sender: TObject);
begin
  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
end;

procedure TInfoForm.GameJoltImgClick(Sender: TObject);
begin
  GameSound('Click', true);
  ShellExecute(Handle, 'open',
    'https://gamejolt.com/games/You-n-Dungeon/507988', nil, nil, SW_NORMAL);
end;

procedure TInfoForm.OkBtnClick(Sender: TObject);
begin
  GameSound('Click', true);
  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Enabled := true;
end;

procedure TInfoForm.SiteImgClick(Sender: TObject);
begin
  GameSound('Click', true);
  ShellExecute(Handle, 'open', 'www.nrtu.studio/projects/you-n-dungeon', nil,
    nil, SW_NORMAL);
end;

end.
