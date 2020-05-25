unit TCardStatsClass;

interface

uses Dialogs, System.SysUtils, TPositionLib, Forms, nicestuff;


var
  BonusCardsStats : array[0..COUNT_OF_BONUS_CARDS] of TCardStat;
  EnemyCardsStats : array[0..COUNT_OF_ENEMIES] of TCardStat;
  TrapsCardsStats : array[0..COUNT_OF_TRAPS] of TCardStat;

const
  CHANCE_TRASH = 40;
  CHANCE_COMMON = 20;
  CHANCE_BASE = 10;
  CHANCE_RARE = 5;
  CHANCE_ULTRA_RARE = 1;



procedure InitCardStat();


implementation



procedure InitCardStat();
begin
  with BonusCardsStats[1] do
  begin
    CardIndex := 1;
    CardName := 'Coin';
    CardType := TItemType.bonus;
    CardWeight := CHANCE_BASE;


    HaveAValue := true;
    ValueType := 'B';
    BaseValue :=  3;
    ValueRange := 2;
    Increaseable := True;
    IncValue := 2;

    OneClick := True;
  end;

  with BonusCardsStats[2] do
  begin
    CardIndex := 2;
    CardName := 'Ruby';
    CardType := TItemType.bonus;
    CardWeight := CHANCE_RARE;


    HaveAValue := true;
    ValueType := 'B';
    BaseValue :=  6;
    ValueRange := 5;
    Increaseable := True;
    IncValue := 5;

    OneClick := True;
  end;








  with EnemyCardsStats[1] do
  begin
    CardIndex := 1;
    CardName := 'Mouse';
    CardType := TItemType.enemy;
    CardWeight := CHANCE_BASE;


    HaveAValue := true;
    ValueType := 'H';
    BaseValue :=  3;
    ValueRange := 2;
    Increaseable := True;
    IncValue := 2;
    DropCoin := true;

  end;



    {


    CardName: string;
    CardType: TItemType;
    CardIndex: integer;
    CardWeight : Integer;

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
    OneClick : Boolean;

    }




  with TrapsCardsStats[1] do
  begin
    CardIndex := 1;
    CardName := 'Coin';
    CardType := TItemType.bonus;
    CardWeight := CHANCE_BASE;


    HaveAValue := true;
    ValueType := 'B';
    BaseValue :=  3;
    ValueRange := 2;
    Increaseable := True;
    IncValue := 2;

    OneClick := True;
  end;

end;


end.
