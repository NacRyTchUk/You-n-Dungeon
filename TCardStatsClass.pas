unit TCardStatsClass;

interface

uses Dialogs, System.SysUtils, TPositionLib, Forms, nicestuff;


var
  TrapsFacingStats : array[0..COUNT_OF_TRAPS,1..4] of Integer;
  BonusTypesStats : array[0..COUNT_OF_BONUS_CARDS] of Integer;
const
  CHANCE_TRASH = 40;
  CHANCE_COMMON = 20;
  CHANCE_BASE = 10;
  CHANCE_RARE = 5;
  CHANCE_ULTRA_RARE = 1;



procedure InitCardStat();


implementation



procedure InitCardStat();
var
  ItemId : Integer;
begin
///Oooooooohh shit...
ItemId := 0;
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 1;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 1;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 1;

Inc(ItemId);                    //5
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 1;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 1;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 1;


Inc(ItemId);
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 1;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);                    //15
TrapsFacingStats[ItemId,1] := 1;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 1;
TrapsFacingStats[ItemId,4] := 0;

Inc(ItemId);
TrapsFacingStats[ItemId,1] := 0;
TrapsFacingStats[ItemId,2] := 0;
TrapsFacingStats[ItemId,3] := 0;
TrapsFacingStats[ItemId,4] := 1;


////////////////////////////////////////

ItemId := 0;

Inc(ItemId);
BonusTypesStats[ItemId] := 0;
Inc(ItemId);
BonusTypesStats[ItemId] := 1;
Inc(ItemId);
BonusTypesStats[ItemId] := 3;
Inc(ItemId);
BonusTypesStats[ItemId] := 0;
Inc(ItemId);
BonusTypesStats[ItemId] := 0;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := -1;
Inc(ItemId);
BonusTypesStats[ItemId] := 1;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;
Inc(ItemId);
BonusTypesStats[ItemId] := 2;




end;


end.
