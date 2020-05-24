program YnD;

uses
  Vcl.Forms,
  MainScreen in 'MainScreen.pas' {MainForm},
  Configurate in 'Configurate.pas',
  SelectDifficult in 'SelectDifficult.pas' {SelectDifficultForm},
  BackGround in 'BackGround.pas' {BackGroundForm},
  Game in 'Game.pas' {GameForm},
  TCardClass in 'TCardClass.pas',
  TFieldClass in 'TFieldClass.pas',
  NiceStuff in 'NiceStuff.pas',
  TCardStatsClass in 'TCardStatsClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TBackGroundForm, BackGroundForm);
  Application.CreateForm(TSelectDifficultForm, SelectDifficultForm);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
