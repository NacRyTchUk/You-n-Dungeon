unit TFieldClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  TCardClass, nicestuff;

// 14    110x145
// 145  606
// 41   463

type
  TFieldOfCards = array [0 .. FIELD_SIZE_X - 1, 0 .. FIELD_SIZE_Y - 1] of TCard;

type
  TField = class
  private
    Size: TPosition;
    PlayerCard: TPosition;
    FieldOfCards: TFieldOfCards;
    BufferCard: TCard;
    BaseDifficult: integer;
    RecivedMoney: integer;

    CardAnimState: array [0 .. CARD_ANIM_COUNT] of bool;
    CardAnimStage: array [0 .. CARD_ANIM_COUNT] of integer;
    CardAnimFrame: array [0 .. CARD_ANIM_COUNT] of integer;
    CardAnimIndex: array [0 .. CARD_ANIM_COUNT, 1 .. 3] of integer;

    function AnimProc(AnimIndex, AnimSpeed: integer): bool;
  public

    procedure SetFieldVisible(isVisible: bool);
    procedure AddMoneyOn(count: integer);

    function GetFieldSize(): TPosition;
    function GetPlayerPos(): TPosition;
    function GetFieldOfCards(): TFieldOfCards;
    function GetMoneyRecived(): Integer;
    function IsCardAnimPlayed(): bool; overload;
    function IsCardAnimPlayed(AnimIndex: integer): bool; overload;

    procedure ToggleAnimOn(AnimIndex, x, y: integer); overload;
    procedure ToggleAnimOn(AnimIndex, x, y, data: integer); overload;
    procedure ToggleAnimOn(AnimIndex: integer); overload;
    procedure UpdateAnim();
    procedure PlayAnim_SizeOut(x, y: integer);
    procedure PlayAnim_SizeIn(x, y: integer);
    procedure PlayAnim_SlideFromTo(x, y, side: integer);
    procedure PlayAnim_FieldSizeIn();
    procedure PlayAnim_ChangeCard(x, y, data: integer);

    Constructor Create(BaseDifficult: integer);
    // Destructor  Destroy;
  end;

implementation

function TField.GetFieldSize;
begin
  GetFieldSize := Size;
end;

function TField.GetPlayerPos(): TPosition;
begin
  GetPlayerPos := PlayerCard;
end;

function TField.GetFieldOfCards(): TFieldOfCards;
begin
  GetFieldOfCards := FieldOfCards;
end;


    function TField.GetMoneyRecived(): Integer;
    begin
      GetMoneyRecived := RecivedMoney;
    end;

Constructor TField.Create(BaseDifficult: integer);
var
  i, j, x, y: integer;
  cardisplayer: bool;
begin
  Self.BaseDifficult := BaseDifficult;

  PlayerCard.x := (FIELD_SIZE_X - 1) div 2;
  PlayerCard.y := (FIELD_SIZE_Y - 1) div 2;

  for i := 0 to FIELD_SIZE_X - 1 do
    for j := 0 to FIELD_SIZE_Y - 1 do
    begin
      cardisplayer := ((i = PlayerCard.x) and (j = PlayerCard.y));
      FieldOfCards[i, j] := TCard.Create(CTP(i, j), cardisplayer,
        BaseDifficult);
    end;
  ToggleAnimOn(4);
end;

function TField.IsCardAnimPlayed(): bool;
begin
  IsCardAnimPlayed := CardAnimState[0];
end;

function TField.IsCardAnimPlayed(AnimIndex: integer): bool;
begin
  IsCardAnimPlayed := CardAnimState[AnimIndex];
end;

procedure TField.ToggleAnimOn(AnimIndex, x, y: integer);
begin
  if (AnimIndex <= CARD_ANIM_COUNT) and (not CardAnimState[AnimIndex]) then
  begin
    CardAnimIndex[AnimIndex, 1] := x;
    CardAnimIndex[AnimIndex, 2] := y;
    CardAnimState[AnimIndex] := true;
  end;

end;

procedure TField.ToggleAnimOn(AnimIndex, x, y, data: integer);
begin
  if (AnimIndex <= CARD_ANIM_COUNT) and (not CardAnimState[AnimIndex]) then
  begin
    CardAnimIndex[AnimIndex, 1] := x;
    CardAnimIndex[AnimIndex, 2] := y;
    CardAnimIndex[AnimIndex, 3] := data;
    CardAnimState[AnimIndex] := true;
  end;
end;

procedure TField.ToggleAnimOn(AnimIndex: integer);
begin
  if (AnimIndex <= CARD_ANIM_COUNT) and (not CardAnimState[AnimIndex]) then
  begin
    CardAnimState[AnimIndex] := true;
  end;
end;

procedure TField.UpdateAnim();
var
  i: integer;
begin
  if CardAnimState[1] then
    PlayAnim_SizeOut(CardAnimIndex[1, 1], CardAnimIndex[1, 2]);
  if CardAnimState[2] then
    PlayAnim_SizeIn(CardAnimIndex[2, 1], CardAnimIndex[2, 2]);
  if CardAnimState[3] then
    PlayAnim_SlideFromTo(CardAnimIndex[3, 1], CardAnimIndex[3, 2],
      CardAnimIndex[3, 3]);
  if CardAnimState[4] then
    PlayAnim_FieldSizeIn();
  if CardAnimState[5] then
    PlayAnim_ChangeCard(CardAnimIndex[5, 1], CardAnimIndex[5, 2],
      CardAnimIndex[5, 3]);

end;

procedure TField.PlayAnim_SizeOut(x, y: integer);
const
  OneStageStepsAmount = 1;
  FrameAmount = 10;
  AnimID = 1;
begin
  if AnimProc(AnimID, OneStageStepsAmount) then
    exit;

  FieldOfCards[x, y].ScaleAt((FrameAmount - CardAnimFrame[AnimID]) /
    FrameAmount);

  if CardAnimFrame[AnimID] >= FrameAmount then
  begin
    CardAnimFrame[AnimID] := 0;
    CardAnimState[AnimID] := false;
    CardAnimStage[AnimID] := 0;
    FieldOfCards[x, y].SetMinimized(true);
  end;
end;

procedure TField.PlayAnim_SizeIn(x, y: integer);
const
  OneStageStepsAmount = 2;
  FrameAmount = 10;
  AnimID = 2;
begin
  if AnimProc(AnimID, OneStageStepsAmount) then
    exit;

  FieldOfCards[x, y].ScaleAt((CardAnimFrame[AnimID]) / FrameAmount);

  if CardAnimFrame[AnimID] >= FrameAmount then
  begin
    CardAnimFrame[AnimID] := 0;
    CardAnimState[AnimID] := false;
    CardAnimStage[AnimID] := 0;
    FieldOfCards[x, y].SetMinimized(false);
    FieldOfCards[x, y].ReSetPosToMode(1);
  end;
end;

procedure TField.PlayAnim_SlideFromTo(x, y, side: integer);
const
  OneStageStepsAmount = 2;
  FrameAmount = 10;
  AnimID = 3;
var
  dx, dy: integer;
begin
  if AnimProc(AnimID, OneStageStepsAmount) then
    exit;
  dy := 0;
  dx := 0;
  case side of
    1:
      dy := -round(SIZE_CARD_Y * iPercentage / 100 / FrameAmount);
    2:
      dx := round(SIZE_CARD_X * iPercentage / 100 / FrameAmount);
    3:
      dy := round(SIZE_CARD_Y * iPercentage / 100 / FrameAmount);
    4:
      dx := -round(SIZE_CARD_X * iPercentage / 100 / FrameAmount);
  end;

  FieldOfCards[x, y].MoveOn(dx, dy);
  if CardAnimFrame[AnimID] > FrameAmount then
  begin
    // FieldOfCards[x, y]

    PlayerCard.x := PlayerCard.x + VectorToCoord(side).x;
    PlayerCard.y := PlayerCard.y + VectorToCoord(side).y;

    FieldOfCards[PlayerCard.x, PlayerCard.y].ReSetPosToMode(1);
    FieldOfCards[PlayerCard.x, PlayerCard.y].SetCardStat(FieldOfCards[x, y]);

    FieldOfCards[x, y].SetVisible(false);

    FieldOfCards[x, y].Create(CTP(x, y), false, BaseDifficult);
    ToggleAnimOn(2, x, y);

    CardAnimFrame[AnimID] := 0;
    CardAnimState[AnimID] := false;
    CardAnimStage[AnimID] := 0;
    // FieldOfCards[x, y].ReSetPosToMode(1);
  end;

end;

procedure TField.PlayAnim_FieldSizeIn();
const
  OneStageStepsAmount = 8;
  FrameAmount = 6;
  AnimID = 4;
var
  x, y: integer;
begin
  if AnimProc(AnimID, OneStageStepsAmount) then
    exit;

  for x := 0 to FIELD_SIZE_X - 1 do
    for y := 0 to FIELD_SIZE_Y - 1 do
      FieldOfCards[x, y].ScaleAt((CardAnimFrame[AnimID]) / FrameAmount);

  if CardAnimFrame[AnimID] >= FrameAmount then
  begin
    CardAnimFrame[AnimID] := 0;
    CardAnimState[AnimID] := false;
    CardAnimStage[AnimID] := 0;

    for x := 0 to FIELD_SIZE_X - 1 do
      for y := 0 to FIELD_SIZE_Y - 1 do
        FieldOfCards[x, y].ReSetPosToMode(1);
  end;
end;

procedure TField.PlayAnim_ChangeCard(x, y, data: integer);
const
  OneStageStepsAmount = 8;
  FrameAmount = 6;
  AnimID = 5;
var
  ChangeCardStat: TCardGen;
begin

  if AnimProc(AnimID, OneStageStepsAmount) then
    exit;

  if CardAnimFrame[AnimID] >= FrameAmount then
  begin
    CardAnimFrame[AnimID] := 0;
    CardAnimState[AnimID] := false;
    CardAnimStage[AnimID] := 0;
  end;

  if (IsCardAnimPlayed(2) = false) and (FieldOfCards[x, y].IsCardMinimized) then
  begin
    case (data mod 10) of
      1:
        ChangeCardStat.ItemType := TItemType.nothing;
      2:
        ChangeCardStat.ItemType := TItemType.bonus;
      3:
        ChangeCardStat.ItemType := TItemType.enemy;
      4:
        ChangeCardStat.ItemType := TItemType.trap;
    else
      msg('replace anim err');
    end;
    ChangeCardStat.ItemIndex := data div 10;
    FieldOfCards[x, y].Create(CTP(x, y), false, BaseDifficult, ChangeCardStat);
    ToggleAnimOn(2, x, y);
    CardAnimStage[AnimID] := 2;
    CardAnimFrame[AnimID] := FrameAmount + 1;
    exit;
  end;

  if (IsCardAnimPlayed(1) = false) and (not FieldOfCards[x, y].IsCardMinimized)
  then
  begin
    ToggleAnimOn(1, x, y);
    exit;
  end;
end;

function TField.AnimProc(AnimIndex, AnimSpeed: integer): bool;
begin
  if not IsCardAnimPlayed(AnimIndex) then
  begin
    AnimProc := true;
    exit;
  end;

  Inc(CardAnimStage[AnimIndex]);

  if CardAnimStage[AnimIndex] < AnimSpeed then
  begin
    AnimProc := true;
    exit;
  end;

  CardAnimStage[AnimIndex] := 0;
  Inc(CardAnimFrame[AnimIndex]);

  AnimProc := false;
end;

procedure TField.SetFieldVisible(isVisible: bool);
var
  i, j: integer;
begin
  for i := 0 to FIELD_SIZE_X - 1 do
    for j := 0 to FIELD_SIZE_Y - 1 do
    begin
      FieldOfCards[i, j].SetVisible(isVisible);
    end;
end;

procedure TField.AddMoneyOn(count: integer);
begin
  RecivedMoney := RecivedMoney + count;
end;

end.
