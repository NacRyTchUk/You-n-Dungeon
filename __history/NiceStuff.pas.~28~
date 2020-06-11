unit NiceStuff;

interface

uses Dialogs, System.SysUtils, TPositionLib, Forms, mmsystem;

const
  SIZE_SPACE = 14;
  SIZE_CARD_X = 110;
  SIZE_CARD_Y = 145;
  SIZE_TAB_X = 145;
  SIZE_TAB_Y = 21;
  FIELD_SIZE_X = 5;
  FIELD_SIZE_Y = 3;

  COUNT_OF_BONUS_CARDS = 14;
  COUNT_OF_ENEMIES = 25;
  COUNT_OF_TRAPS = 17;
  COUNTS_OF_CARDS = COUNT_OF_BONUS_CARDS + COUNT_OF_ENEMIES + COUNT_OF_TRAPS;

  CHANCE_OF_NOTHING = 5;
  CHANCE_OF_BONUS = 50;
  CHANCE_OF_ENEMIES = 60;
  CHANCE_OF_TRAPS = 15;
  CHEST_INDEX = 3;

  SPEED_OF_ANIM_SIZE_OUT = 10;
  SPEED_OF_ANIM_SIZE_IN = 10;
  SPEED_OF_ANIM_SLIDE_FROM_TO = 10;
  SPEED_OF_ANIM_FIELD_SIZE_IN = 6;
  SPEED_OF_ANIM_CHANGE_CARD = 6;

  CARD_ANIM_COUNT = 5;

  COUNT_OF_STEPS_TO_RELOAD = 30;

  PLAYER_CARD_BASE_HEALTH = 10;

type
  TIndexOfCardMsg = (OK, OutOfBorder, FAIL);

type
  TItemType = (nothing, bonus, enemy, trap);

type
  TCardStat = record
    CardName: string;
    CardType: TItemType;
    CardIndex: integer;
    CardWeight: integer;

    MinDifToBe: integer;

    HaveAValue: Boolean;
    ValueType: string;
    BaseValue: integer;
    ValueRange: integer;
    Increaseable: Boolean;
    IncValue: integer;

    ReplaceACard: Boolean;
    ReplacebleCardIndex: integer;
    DropCoin: Boolean;
    isSwapable: Boolean;
    DontNeedbeNear: Boolean;
    EventCard: Boolean;
    OneClick: Boolean;

  end;

type
  TPosition = record
    X: integer;
    Y: integer;
  end;

type
  TCardGen = record
    ItemType: TItemType;
    ItemIndex: integer;
  end;

type
  TCardSendingData = record
    IntData: integer;
    CardGenData: TCardGen;
  end;

type
  TSaveData = record
    Money: integer;
    HeroSelected: integer;
    AbilitySelected: integer;
  end;

type
  TCardSaveData = record
    Position: TPosition;
    BorderIndex: integer;
    ItemIndex: integer;
    ItemType: TItemType;
    IsCardIsPlayer: Boolean;
    Value: integer;
    HasAItem: integer;
    PlayerItemValue: integer;
    IsMinimized: Boolean;
  end;

type
  TFieldOfCardSaveData = record
    FieldOfCardsSaveData: array [0 .. FIELD_SIZE_X - 1, 0 .. FIELD_SIZE_Y - 1]
      of TCardSaveData;

    Size: TPosition;
    PlayerCard: TPosition;
    BaseDifficult: integer;
    RecivedMoney: integer;
  end;

procedure Msg(text: string); overload;
procedure Msg(numb: integer); overload;
function tStr(i: integer): string; overload;
function tStr(i: Boolean): string; overload;
function tInt(s: string): integer;
function CTP(X, Y: integer): TPosition;
procedure ReSizeResolution(oForm: TForm);
procedure InitForm(oForm: TForm);
function CoordToVector(Coord: TPosition): integer;
function VectorToCoord(vector: integer): TPosition;
function Rnd(min, max: integer): integer; overload;
function Rnd(max: integer): integer; overload;
function Rnd(min, max, wmin, wmax: integer): integer; overload;
function RndWWeight(var weight: array of integer): integer;
function CGTDT(CardGen: TCardGen): integer;
function KeyToChar(Key: integer): Char;
function IsGamePadIsConnected(): Boolean;

procedure SaveGameData(); overload;
procedure SaveGameData(path: string); overload;
procedure LoadGameDataFrom(); overload;
procedure LoadGameDataFrom(path: string); overload;

const
  MinimizeWinWight = 896;
  MinimizeWinHeight = 504;

var
  iPercentage: integer;
  GAME_PAD_CONNECTED: Boolean = false;
  SETT_GAMEPAD_ON : Boolean = true;

implementation

procedure ReSizeResolution(oForm: TForm);
begin
  if Screen.Width > MinimizeWinWight then
  begin
    iPercentage := Round(((Screen.Width - MinimizeWinWight) / MinimizeWinWight)
      * 100) + 100;
    oForm.ScaleBy(iPercentage, 100);
  end;

end;

procedure InitForm(oForm: TForm);
begin
  ReSizeResolution(oForm);
  oForm.Font.Name := 'Gnomoria_rus';
end;

function CoordToVector(Coord: TPosition): integer;
begin

  case Coord.X of
    1:
      begin
        CoordToVector := 2;
      end;
    0:
      begin
        if Coord.Y = 1 then
          CoordToVector := 1
        else
          CoordToVector := 3;
      end;

    -1:
      begin
        CoordToVector := 4;
      end;
  end;
end;

function VectorToCoord(vector: integer): TPosition;
begin
  case vector of
    1:
      VectorToCoord := CTP(0, -1);
    2:
      VectorToCoord := CTP(1, 0);
    3:
      VectorToCoord := CTP(0, 1);
    4:
      VectorToCoord := CTP(-1, 0);
  end;
end;

function Rnd(min, max: integer): integer;
begin
  Rnd := Random(abs(max - min + 1)) + min;
end;

function Rnd(max: integer): integer;
begin
  Rnd := Random(max + 1);
end;

function Rnd(min, max, wmin, wmax: integer): integer;
var
  RndNumb: integer;
begin
  repeat
    RndNumb := Rnd(min, max);
  until (RndNumb < wmin) or (RndNumb > wmax);
  Rnd := RndNumb;

end;

function CTP(X, Y: integer): TPosition;
var
  pos: TPosition;
begin
  pos.X := X;
  pos.Y := Y;
  CTP := pos;
end;

procedure Msg(text: string); overload;
begin
  showmessage(text);
end;

procedure Msg(numb: integer); overload;
begin
  showmessage(IntToStr(numb));
end;

function tStr(i: integer): string;
begin
  tStr := IntToStr(i);
end;

function tStr(i: Boolean): string;
begin
  if i then
    tStr := 'true'
  else
    tStr := 'false';
end;

function tInt(s: string): integer;
begin
  tInt := StrToInt(s);
end;

function RndWWeight(var weight: array of integer): integer;
var
  lenghtOfArray: integer;
  i, n: integer;
  RandNumb: integer;
  SumOfWeight: integer;
begin
  lenghtOfArray := Length(weight);

  SumOfWeight := 0;
  for i := 1 to lenghtOfArray do
    SumOfWeight := SumOfWeight + weight[i];

  RandNumb := Rnd(0, SumOfWeight);

  n := 0;
  for i := lenghtOfArray downto 0 do
  begin
    n := n + weight[i];

    if (n >= RandNumb) then
    begin
      RndWWeight := i;
      exit;
    end;
  end;

end;

function CGTDT(CardGen: TCardGen): integer;
var
  data: integer;
begin
  data := 0;
  data := CardGen.ItemIndex * 10;
  case CardGen.ItemType of
    nothing:
      data := data + 1;
    bonus:
      data := data + 2;
    enemy:
      data := data + 3;
    trap:
      data := data + 4;
  end;
  CGTDT := data;
end;

procedure SaveGameData();
begin
  //
end;

procedure SaveGameData(path: string);
begin
  //
end;

procedure LoadGameDataFrom();
begin
  //
end;

procedure LoadGameDataFrom(path: string);
begin
  //
end;

function KeyToChar(Key: integer): Char;
var
  chKey: Char;
begin
  chKey := Chr(Key);
  case Key of
    37:
      chKey := 'A';
    38:
      chKey := 'W';
    39:
      chKey := 'D';
    40:
      chKey := 'S';
  end;
  KeyToChar := chKey;
end;

function IsGamePadIsConnected(): Boolean;
var
  gamePad: tjoyinfo;
  jr : Cardinal;
begin
jr :=  joygetpos(joystickid1, @gamePad);
IsGamePadIsConnected := jr = JOYERR_NOERROR;
end;


end.
