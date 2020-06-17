unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  nicestuff,
  Vcl.StdCtrls, mmsystem, shellapi;

type
  THelpForm = class(TForm)
    BackGroundImage: TImage;
    OkBtn: TImage;
    ControlsHelpLabel: TImage;
    ControlsHelpImg: TImage;
    AnimTimer: TTimer;
    SiteLabel: TLabel;
    procedure OkBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ControlsHelpLabelClick(Sender: TObject);
    procedure AnimTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SiteLabelClick(Sender: TObject);
  private
    AnimCounter, AnimMode: Integer;
  public
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.dfm}

uses MainScreen, BackGround;

procedure THelpForm.AnimTimerTimer(Sender: TObject);
begin
  MainForm.AnimWindowBlend(self, AnimMode, 50, 10, AnimCounter, AnimTimer);
end;

procedure THelpForm.ControlsHelpLabelClick(Sender: TObject);
begin
  GameSound('Click', true);
  ControlsHelpImg.Visible := not ControlsHelpImg.Visible;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
  InitForm(self);
end;

procedure THelpForm.FormShow(Sender: TObject);
begin

  AnimCounter := 0;
  AnimMode := 1;
  AnimTimer.Enabled := true;
  MainForm.Enabled := False;
end;

procedure THelpForm.OkBtnClick(Sender: TObject);
begin
  GameSound('Click', true);
  AnimCounter := 0;
  AnimMode := 2;
  AnimTimer.Enabled := true;
  MainForm.Enabled := true;
end;

procedure THelpForm.SiteLabelClick(Sender: TObject);
begin
  GameSound('Click', true);
  ShellExecute(Handle, 'open', 'www.nrtu.studio/projects/You-n-Dungeon/Help',
    nil, nil, SW_NORMAL);
end;

end.
