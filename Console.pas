unit Console;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, ShellApi,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, configurate, System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg,
  GifImg, SelectDifficult, mmsystem,
  NiceStuff, Vcl.OleCtrls, SHDocVw, Vcl.ComCtrls;

type
  TConsoleForm = class(TForm)
    InputBox: TLabeledEdit;
    ResponseLabel: TLabel;
    BackGround: TImage;
    procedure InputBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure DoCommand();
  public
  end;

var
  ConsoleForm: TConsoleForm;

implementation

{$R *.dfm}

uses mainscreen, BackGround;

procedure TConsoleForm.DoCommand();
var
  Cmd: string;
begin
  Cmd := copy(InputBox.Text, 1, 4);
  if Cmd = '-bnd' then
  begin
    try
      Cmd := InputBox.Text;
      delete(Cmd, 1, 5);
      AlphaBlendValue := round(255 * (tInt(Cmd) / 100));
      InputBox.Text := '';
      ResponseLabel.Caption := 'Успех';
    except
      ResponseLabel.Caption := 'Ошибка';
    end;
  end;
  if Cmd = '-ext' then
    BackGroundForm.Close;
  if Cmd = '-h' then
    Close;
  if Cmd = '-gmn' then
  begin
    if IsDebugOn then
      try
        Cmd := InputBox.Text;
        delete(Cmd, 1, 5);
        GameData.Money := GameData.Money + tInt(Cmd);
        MainForm.CoinCountLabel.Caption := IntToStr(GameData.Money);
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

  if Cmd = '-smn' then
  begin
    if IsDebugOn then
      try
        Cmd := InputBox.Text;
        delete(Cmd, 1, 5);
        GameData.Money := tInt(Cmd);
        MainForm.CoinCountLabel.Caption := IntToStr(GameData.Money);
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

  if Cmd = '-god' then
  begin
    if IsDebugOn then
      try
        IsGodMode := not IsGodMode;
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

  if Cmd = '-mut' then
  begin
    if IsDebugOn then
      try
        Cmd := InputBox.Text;
        delete(Cmd, 1, 5);
        GameSoundMute(Cmd);
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

  if Cmd = '-rld' then
  begin
    if IsDebugOn then
      try
        IsReloadVisible := not IsReloadVisible;
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

  if Cmd = '-m' then
  begin
    if IsDebugOn then
      try
        InputBox.Text := '';
        ResponseLabel.Caption := 'Успех: ' + tstr(GameData.Money);
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;


  if Cmd = '-rls' then
  begin
    if IsDebugOn then
      try
        InputBox.Text := '';
        MainForm.AchiveBtnImage.Visible := not MainForm.AchiveBtnImage.Visible;
        MainForm.LiderBoardBtnImage.Visible := not MainForm.LiderBoardBtnImage.Visible;
        ResponseLabel.Caption := 'Успех';
      except
        ResponseLabel.Caption := 'Ошибка';
      end
    else
      ResponseLabel.Caption := 'Ошибка: Режим отладки отключен';
  end;

end;

procedure TConsoleForm.InputBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    DoCommand;
end;

end.
