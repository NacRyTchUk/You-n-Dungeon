unit NiceInt;

interface
 uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

implementation
 {$R *.dfm}

function tStr(i : integer) : string;
begin
  tStr := IntToStr(i);
end;

function tInt(s : string) : integer;
begin
  tInt := StrToInt(s);
end;

end.