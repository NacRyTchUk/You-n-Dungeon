program YnD;



uses
  Vcl.Forms,
  GifImg,
  Winapi.Windows,
  MainScreen in 'MainScreen.pas' {MainForm},
  Configurate in 'Configurate.pas',
  SelectDifficult in 'SelectDifficult.pas' {SelectDifficultForm},
  BackGround in 'BackGround.pas' {BackGroundForm},
  Game in 'Game.pas' {GameForm},
  TCardClass in 'TCardClass.pas',
  TFieldClass in 'TFieldClass.pas',
  NiceStuff in 'NiceStuff.pas',
  TCardStatsClass in 'TCardStatsClass.pas',
  SelectPlayer in 'SelectPlayer.pas' {SelectPlayerForm},
  SelectAbility in 'SelectAbility.pas' {SelectAbillityForm},
  Settings in 'Settings.pas' {SettingsForm};

{$R *.res}

begin
  AddFontResourceEx('Assets\Fonts\Gnomoria.ttf', FR_PRIVATE, 0);
  GIFImageDefaultAnimate := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'You''n''Dungeon';
  Application.CreateForm(TBackGroundForm, BackGroundForm);
  Application.CreateForm(TSelectDifficultForm, SelectDifficultForm);
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSelectPlayerForm, SelectPlayerForm);
  Application.CreateForm(TSelectAbillityForm, SelectAbillityForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.
