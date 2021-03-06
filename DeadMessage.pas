unit DeadMessage;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, NiceStuff;

type
  TDeadMessageForm = class(TForm)
    BackGroundImage: TImage;
    YouDiedImage: TImage;
    OkBtn: TImage;
    BackToMenuImg: TImage;
    StatsLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BackToMenuImgClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DeadMessageForm: TDeadMessageForm;

implementation

{$R *.dfm}

uses game, BackGround;

procedure TDeadMessageForm.BackToMenuImgClick(Sender: TObject);
begin
    GameForm.Enabled := true;
   GameForm.BackToMenu;
   close;
end;

procedure TDeadMessageForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure TDeadMessageForm.FormShow(Sender: TObject);
begin
  GameSound('Boom', true);
  StatsLabel.Caption := 'Заработано: ' + tStr(FieldOfCards.GetMoneyRecived) + ' C.';
  GameForm.Enabled := false;
end;

procedure TDeadMessageForm.OkBtnClick(Sender: TObject);
begin
GameForm.DoKeyDown(Ord('R'));
Close;
end;

end.
