unit NiceMsg;

interface
 uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;
implementation
 {$R *.dfm}

procedure Msg(text : string); overload;
begin
  showmessage(text);
end;

procedure Msg(numb : integer); overload;
begin
   showmessage(IntToStr(numb));
end;

end.