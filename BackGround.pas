unit BackGround;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TBackGroundForm = class(TForm)
    BackGroundImage: TImage;
    StartTimer: TTimer;
    procedure StartTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BackGroundForm: TBackGroundForm;



implementation

{$R *.dfm}

uses mainscreen, SelectDifficult, Game;



procedure TBackGroundForm.FormDestroy(Sender: TObject);
begin
  RemoveFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
end;

procedure TBackGroundForm.FormShow(Sender: TObject);
begin
  StartTimer.Enabled := true;
end;



procedure TBackGroundForm.StartTimerTimer(Sender: TObject);
begin
  StartTimer.Enabled := false;


  Randomize;
  AddFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);


  MainForm.Show;
end;

end.