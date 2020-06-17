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
    Energy: integer;
    Steps: integer;

    CardAnimState: array [0 .. CARD_ANIM_COUNT] of bool;
    CardAnimStage: array [0 .. CARD_ANIM_COUNT] of integer;
    CardAnimFrame: array [0 .. CARD_ANIM_COUNT] of integer;
    CardAnimIndex: array [0 .. CARD_ANIM_COUNT, 1 .. 3] of integer;

    function AnimProc(AnimIndex, AnimSpeed: integer): bool;
    procedure RefreshAbilValue();
    procedure AbilityDo();
  public

    procedure SetFieldVisible(isVisible: bool);
    procedure AddMoneyOn(count: integer);

    function GetFieldSize(): TPosition;
    function GetPlayerPos(): TPosition;
    function GetFieldOfCards(): TFieldOfCards;
    function GetMoneyRecived(): integer;
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
    procedure CheckForNoAnim();
    function IsReloadTime(): bool;
    procedure DoStep();
    procedure ChargeTheAbilityOn(cValue: integer);

    procedure BrokePlayerItem();
    function SaveField(): TFieldOfCardSaveData;
    procedure LoadField(LoadData: TFieldOfCardSaveData);

    Constructor Create(BaseDifficult: integer); overload;
    Constructor Create(BaseDifficult: integer;
      LoadData: TFieldOfCardSaveData); overload;
    // Destructor  Destroy;
  end;

implementation

uses Game, SelectDifficult, MainScreen, BackGround;

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

function TField.GetMoneyRecived(): integer;
begin
  GetMoneyRecived := RecivedMoney;
end;

function TField.SaveField(): TFieldOfCardSaveData;
var
  i, j, x, y: integer;
  cardisplayer: bool;
  SaveData: TFieldOfCardSaveData;
begin

  GameForm.StepsCountLabel.Visible := IsReloadVisible;
  SaveData.BaseDifficult := BaseDifficult;
  SaveData.PlayerCard := PlayerCard;
  SaveData.RecivedMoney := RecivedMoney;
  SaveData.Energy := Energy;
  for i := 0 to FIELD_SIZE_X - 1 do
    for j := 0 to FIELD_SIZE_Y - 1 do
    begin

      SaveData.FieldOfCardsSaveData[i, j] := FieldOfCards[i, j].SaveCardData;
      if SaveData.FieldOfCardsSaveData[i, j].IsCardIsPlayer then
      begin
        SaveData.PlayerCard := CTP(i, j);
        SaveData.FieldOfCardsSaveData[i, j].Position := CTP(i, j);
      end;
    end;

  SaveField := SaveData;
end;

procedure TField.LoadField(LoadData: TFieldOfCardSaveData);
begin
  //
end;

Constructor TField.Create(BaseDifficult: integer);
var
  i, j, x, y: integer;
  cardisplayer: bool;
begin
  RefreshAbilValue;
  Self.BaseDifficult := BaseDifficult;
  GameForm.StepsCountLabel.Visible := IsReloadVisible;

  PlayerCard.x := (FIELD_SIZE_X - 1) div 2;
  PlayerCard.y := (FIELD_SIZE_Y - 1) div 2;

  for i := 0 to FIELD_SIZE_X - 1 do
    for j := 0 to FIELD_SIZE_Y - 1 do
    begin
      cardisplayer := ((i = PlayerCard.x) and (j = PlayerCard.y));
      FieldOfCards[i, j] := TCard.Create(CTP(i, j), cardisplayer,
        BaseDifficult);
    end;

  if GameData.HeroSelected = 1 then
    FieldOfCards[PlayerCard.x, PlayerCard.y].GiveAItem;

  ToggleAnimOn(4);
end;

Constructor TField.Create(BaseDifficult: integer;
  LoadData: TFieldOfCardSaveData);
var
  i, j, x, y: integer;
  cardisplayer: bool;
begin
  Self.BaseDifficult := BaseDifficult;
  Energy := LoadData.Energy;
  RefreshAbilValue;
  PlayerCard := LoadData.PlayerCard;

  Self.RecivedMoney := LoadData.RecivedMoney;
  AddMoneyOn(0);

  for i := 0 to FIELD_SIZE_X - 1 do
    for j := 0 to FIELD_SIZE_Y - 1 do
    begin
      FieldOfCards[i, j] := TCard.Create(LoadData.FieldOfCardsSaveData[i, j]);
    end;
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
  FrameAmount = SPEED_OF_ANIM_SIZE_OUT;
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
    CheckForNoAnim;
    FieldOfCards[x, y].SetMinimized(true);
  end;
end;

procedure TField.PlayAnim_SizeIn(x, y: integer);
const
  OneStageStepsAmount = 2;
  FrameAmount = SPEED_OF_ANIM_SIZE_IN;
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
    GameForm.InputLockcooldown.Enabled := false;
    CheckForNoAnim;
    FieldOfCards[x, y].SetMinimized(false);
    FieldOfCards[x, y].ReSetPosToMode(1);
  end;
end;

procedure TField.PlayAnim_SlideFromTo(x, y, side: integer);
const
  OneStageStepsAmount = 2;
  FrameAmount = SPEED_OF_ANIM_SLIDE_FROM_TO;
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
    CheckForNoAnim;

    // if
    IsReloadTime;
    // then
    // exit;
    // FieldOfCards[x, y].ReSetPosToMode(1);
  end;

end;

procedure TField.PlayAnim_FieldSizeIn();
const
  OneStageStepsAmount = 8;
  FrameAmount = SPEED_OF_ANIM_FIELD_SIZE_IN;
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
    CheckForNoAnim;
    for x := 0 to FIELD_SIZE_X - 1 do
      for y := 0 to FIELD_SIZE_Y - 1 do
        FieldOfCards[x, y].ReSetPosToMode(1);
  end;
end;

procedure TField.PlayAnim_ChangeCard(x, y, data: integer);
const
  OneStageStepsAmount = 8;
  FrameAmount = SPEED_OF_ANIM_CHANGE_CARD;
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
    CheckForNoAnim;
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

procedure TField.CheckForNoAnim();
var
  i: integer;
begin
  for i := 1 to CARD_ANIM_COUNT do
    if CardAnimState[i] then
      exit;
  CardAnimState[0] := false;
end;

function TField.IsReloadTime(): bool;
begin

  if Steps > GameData.ReloadInterval then
  begin
    IsReloadTime := true;
    SelectDifficultForm.GameReload;
    exit;
  end;
  IsReloadTime := false;

end;

procedure TField.DoStep();
var
  str: string;
begin
  inc(Steps);
  str := GameForm.StepsCountLabel.Caption;
  delete(str, 1, 11);

  GameForm.StepsCountLabel.Visible := IsReloadVisible;
  GameForm.StepsCountLabel.Caption := 'До сохранения: ' +
    tStr(GameData.ReloadInterval - Steps);
end;

procedure TField.ChargeTheAbilityOn(cValue: integer);
var
  boost: integer;
begin
  if GameData.HeroSelected = 0 then
    boost := YNL_BOOST;

  Energy := Energy + cValue;
  if Energy >= ABILITY_CHARDGE_VALUE_BASE + GameData.AbilitySelected * 2 - boost
  then
  begin
    Energy := 0;
    AbilityDo;
  end;
  RefreshAbilValue;
end;

procedure TField.AbilityDo();
begin
  GameSound('Ability', true);
  case GameData.AbilitySelected of
    0:
      AddMoneyOn(rnd(5, 25));
    1:
      FieldOfCards[PlayerCard.x, PlayerCard.y].HealthUp(rnd(2, 7));
    2:
      FieldOfCards[PlayerCard.x, PlayerCard.y].GiveAItem;
  end;
end;

procedure TField.RefreshAbilValue();
var
  boost: integer;
begin
  if GameData.HeroSelected = 0 then
    boost := YNL_BOOST;

  GameForm.AbillityChargeProgressLabel.Caption := tStr(Energy) + '/' +
    tStr(ABILITY_CHARDGE_VALUE_BASE + GameData.AbilitySelected * 2 - boost);
end;

function TField.AnimProc(AnimIndex, AnimSpeed: integer): bool;
begin
  CardAnimState[0] := true;

  if not IsCardAnimPlayed(AnimIndex) then
  begin
    AnimProc := true;
    exit;
  end;

  inc(CardAnimStage[AnimIndex]);

  if CardAnimStage[AnimIndex] < AnimSpeed then
  begin
    AnimProc := true;
    exit;
  end;

  CardAnimStage[AnimIndex] := 0;
  inc(CardAnimFrame[AnimIndex]);

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
  GameForm.CoinCountLabel.Caption := tStr(RecivedMoney);
end;

procedure TField.BrokePlayerItem();
begin

  FieldOfCards[PlayerCard.x, PlayerCard.y].BrokeItem;
  // FieldOfCards[PlayerCard.X, PlayerCard.Y].HasAItem := 0;
end;

end.
