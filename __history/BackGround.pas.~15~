unit BackGround;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

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

uses mainscreen, SelectDifficult, Game, TCardStatsClass, NiceStuff;

procedure TBackGroundForm.FormDestroy(Sender: TObject);
begin
  RemoveFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
end;

procedure TBackGroundForm.FormShow(Sender: TObject);
begin

  Randomize;
  StartTimer.Enabled := true;
  InitForm(self);
end;

procedure TBackGroundForm.StartTimerTimer(Sender: TObject);
var
  screenProp: real;
begin
  screenProp := Screen.Width / Screen.Height;
  StartTimer.Enabled := false;
  if (round(screenProp * 10) <> 18) then
    ShowException(exception.Create
      ('ВНИМАНИЕ!!! Вы запускаете игру на мониторе с не поддерживаемым соотношением сторон! Пожалуйста, по возможности, переключитесь на разрешение сторон близким к 16:9. Игра You''n''Dungeon продолжит работу с некоректным отображением UI.'),
      0);

  AddFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
  InitCardStat;

  MainForm.Show;
end;

end.
