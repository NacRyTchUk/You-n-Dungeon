unit TCardClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.StdCtrls,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  nicestuff, math;

type
  TCard = class
  private
    Position: TPosition;
    BorderIndex: integer;
    ItemIndex: integer;
    ItemType: TItemType;
    CardBackIm: timage;
    CardItemIm: timage;
    CardBorderIm: timage;
    HealthValueText: tlabel;
    ValueText: tlabel;
    IsCardIsPlayer: bool;
    Value: integer;

    procedure CreateImage(var Image: timage);
    procedure CreateBackImage();
    procedure CreateItemImage();
    procedure CreateBorderImage();
    procedure CreateLabel(var Labeel: tlabel; mode: integer);
    procedure CreateValueLabel();
    procedure CreateHealthValueLabel();

    procedure MoveImageOn(var Image: timage; dx, dy: integer);
    procedure MoveImageAt(var Image: timage; dx, dy: integer);
    procedure ScaleImageOn(var Image: timage; ds: real);
    procedure ScaleImageAt(var Image: timage; ds: real);
    procedure MoveLabelOn(var Labeel: tlabel; dx, dy: integer);
    procedure MoveLabelAt(var Labeel: tlabel; dx, dy: integer);
    procedure ScaleLabelOn(var Labeel: tlabel; ds: real; mode: integer);
    procedure ScaleLabelAt(var Labeel: tlabel; ds: real; mode: integer);
    procedure ReScaleToNormal(var Image: timage);
    procedure ReScaleToNone(var Image: timage);
    procedure ReScaleLabelToNormal(var Labeel: tlabel; mode: integer);
    procedure ReScaleLabelToNone(var Labeel: tlabel);

    procedure ImMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ImMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure ImMouseEnter(Sender: TObject);
    procedure ImMouseLeave(Sender: TObject);

    function GenerateItemIndex(Difficult: integer): integer;

    function DamageDeal(Value: integer): integer;
    function isTrapsFacing(trapX, trapY: integer): bool;
    function CardLootGen(KilledCardType: TItemType; KilleCardIndex: integer)
      : TCardGen;
    function BonusPick(BonusItemIndex: integer): integer;
  public
    procedure SetPosition(Position: TPosition);
    procedure SetBorderIndex(BorderIndex: integer);
    procedure SetItemIndex(ItemIndex: integer);
    procedure SetVisible(isVisible: bool);
    procedure SetCardStat(CardStat: TCard);

    function GetCardStat(): TCard;
    function GetPosition(): TPosition;
    function GetBorderIndex(): integer;
    function GetItemIndex(): integer;
    function IsCurCardIsPlayer(): bool;

    // ====
    function OnClick(SCard: TCard): integer;
    procedure OnMoveCursorIn();
    procedure OnMoveCursorOut();
    procedure MoveOn(dx, dy: integer);
    procedure MoveAt(dx, dy: integer);
    procedure ScaleOn(ds: real);
    procedure ScaleAt(ds: real);
    procedure ReSetPosToMode(ScaleModeIndex: integer);

    procedure CardCreate(Position: TPosition; IsPlayer: bool;
      Difficult: integer);
    Constructor Create(Position: TPosition; IsPlayer: bool;
      Difficult: integer); overload;
    Constructor Create(Position: TPosition; IsPlayer: bool; Difficult: integer;
      CardGen: TCardGen); overload;
    // Destructor  Destroy;
  end;

implementation

uses Game;

procedure TCard.SetPosition(Position: TPosition);
begin
  Self.Position := Position;
end;

procedure TCard.SetBorderIndex(BorderIndex: integer);
begin
  //
end;

procedure TCard.SetItemIndex(ItemIndex: integer);
begin
  //
end;

function TCard.GetPosition(): TPosition;
begin
  GetPosition := Position;
end;

function TCard.GetBorderIndex(): integer;
var
  pos: integer;
begin
  //
  GetBorderIndex := pos;
end;

function TCard.GetItemIndex(): integer;
var
  pos: integer;
begin
  //
  GetItemIndex := pos;
end;

function TCard.IsCurCardIsPlayer(): bool;
begin
  IsCurCardIsPlayer := IsCurCardIsPlayer;
end;

// ====
function TCard.OnClick(SCard: TCard): integer;
// var
// card: TCardMessage;
begin
  //
end;

procedure TCard.OnMoveCursorIn();
begin
  //
end;

procedure TCard.OnMoveCursorOut();
begin
  //
end;

procedure TCard.CardCreate(Position: TPosition; IsPlayer: bool;
  Difficult: integer);
var
  RndMin, RndMax: integer;
begin
  if IsCardIsPlayer then
  begin
    BorderIndex := 1;
    Self.Value := 10;
  end
  else
  begin

    RndMin := Round(sqrt(1 + (0.05 + Difficult / 100) * power(ItemIndex, 2.5)) +
      Difficult div 2);
    RndMax := Round(sqrt(3 + (0.1 + Difficult / 100) * power(ItemIndex, 2.5)) +
      2 + Difficult);
    Self.Value := Rnd(RndMin, RndMax);

    BorderIndex := 0;
  end;

  CreateBorderImage();
  CreateBackImage();
  CreateItemImage();
  CreateValueLabel();
  CreateHealthValueLabel();

  ReSetPosToMode(2);
end;

Constructor TCard.Create(Position: TPosition; IsPlayer: bool;
  Difficult: integer);

begin

  IsCardIsPlayer := IsPlayer;
  Self.ItemIndex := GenerateItemIndex(Difficult);

  Self.Position := Position;

  CardCreate(Position, IsPlayer, Difficult);

end;

Constructor TCard.Create(Position: TPosition; IsPlayer: bool;
  Difficult: integer; CardGen: TCardGen);
begin

  Self.Position := Position;
  IsCardIsPlayer := IsPlayer;
  Self.ItemIndex := CardGen.ItemIndex;
  Self.ItemType := CardGen.ItemType;

  CardCreate(Position, IsPlayer, Difficult);
end;

procedure TCard.CreateImage(var Image: timage);
begin
  with Image do
  begin
    Image := timage.Create(GameForm);
    Parent := GameForm;

    Visible := false;
    Stretch := true;
    Proportional := true;
  end;
end;

procedure TCard.CreateLabel(var Labeel: tlabel; mode: integer);
begin
  with Labeel do
  begin
    Labeel := tlabel.Create(GameForm);
    Parent := GameForm;

    if (mode = 0) then
      Font.Color := RGB(222, 185, 56)
    else
      Font.Color := RGB(105, 128, 156);

    Visible := false;
    Caption := IntToStr(Value);
    BringToFront;
  end;

end;

procedure TCard.CreateBackImage();
begin
  CreateImage(CardBackIm);
  ScaleImageAt(CardBackIm, 0);
  CardBackIm.Visible := true;
  GameForm.CardBorderList.GetBitmap(3, CardBackIm.Picture.Bitmap);
end;

procedure TCard.CreateItemImage();
begin

  CreateImage(CardItemIm);
  ScaleImageAt(CardItemIm, 0);
  CardItemIm.Visible := true;

  CardItemIm.Transparent := true;

  if IsCardIsPlayer then
    GameForm.CardPlayersImageList.GetBitmap(ItemIndex,
      CardItemIm.Picture.Bitmap)
  else
  begin
    case ItemType of
      nothing:
        GameForm.CardsImagesList.GetBitmap(0, CardItemIm.Picture.Bitmap);
      bonus:
        GameForm.CardBonusImageList.GetBitmap(ItemIndex,
          CardItemIm.Picture.Bitmap);
      enemy:
        GameForm.CardEnemyImageList.GetBitmap(ItemIndex,
          CardItemIm.Picture.Bitmap);
      trap:
        GameForm.CardTrapsImageList.GetBitmap(ItemIndex,
          CardItemIm.Picture.Bitmap);
    end;
  end;

  CardItemIm.OnMouseDown := ImMouseDown;
  CardItemIm.OnMouseUp := ImMouseUp;
  CardItemIm.OnMouseEnter := ImMouseEnter;
  CardItemIm.OnMouseLeave := ImMouseLeave;
end;

procedure TCard.CreateBorderImage();

begin
  CreateImage(CardBorderIm);
  ScaleImageAt(CardBorderIm, 0);
  CardBorderIm.Visible := IsCardIsPlayer;

  GameForm.CardBorderList.GetBitmap(BorderIndex, CardBorderIm.Picture.Bitmap);
end;

procedure TCard.CreateValueLabel();
begin
  CreateLabel(ValueText, 1);
  if (ItemType = TItemType.bonus) or (ItemType = TItemType.trap) then
  begin
    if not((ItemIndex = 14) and (ItemType = TItemType.bonus)) then
      ValueText.Visible := true;
  end;
end;

procedure TCard.CreateHealthValueLabel();
begin
  CreateLabel(HealthValueText, 0);
  if (ItemType = TItemType.enemy) or IsCardIsPlayer then
    HealthValueText.Visible := true;
  if IsCardIsPlayer then
    HealthValueText.Caption := IntToStr(Value) + '/10';

end;

procedure TCard.ReScaleToNormal(var Image: timage);
begin
  with Image do
  begin
    Width := SIZE_CARD_X * iPercentage div 100;
    Height := SIZE_CARD_Y * iPercentage div 100;

    Left := SIZE_TAB_X * iPercentage div 100 + (SIZE_SPACE + SIZE_CARD_X) *
      Position.X * iPercentage div 100;
    Top := SIZE_TAB_Y * iPercentage div 100 + (SIZE_SPACE + SIZE_CARD_Y) *
      Position.Y * iPercentage div 100;
  end;
end;

procedure TCard.ReScaleToNone(var Image: timage);
begin
  with Image do
  begin
    Left := Left + Width div 2;
    Top := Top + Height div 2;

    Width := 0;
    Height := 0;
  end;
end;

procedure TCard.ReScaleLabelToNormal(var Labeel: tlabel; mode: integer);
begin
  with Labeel do
  begin
    // Width := SIZE_CARD_X * iPercentage div 100;
    // Height := SIZE_CARD_Y * iPercentage div 100;
    Font.Size := 10;
    Left := CardItemIm.Left + CardItemIm.Width div 10;
    if mode = 0 then
      Labeel.Top := CardItemIm.Top + CardItemIm.Height div 20
    else
      Labeel.Top := CardItemIm.Top + 8 * CardItemIm.Height div 10;
  end;
end;

procedure TCard.ReScaleLabelToNone(var Labeel: tlabel);
begin
  with Labeel do
  begin
    Left := Left + Width div 2;
    Top := Top + Height div 2;
    Font.Size := 1;
  end;
end;

procedure TCard.ScaleOn(ds: real);
begin
  ScaleImageOn(CardBackIm, ds);
  ScaleImageOn(CardItemIm, ds);
  ScaleImageOn(CardBorderIm, ds);
  ScaleLabelOn(HealthValueText, ds, 0);
  ScaleLabelOn(ValueText, ds, 1);
end;

procedure TCard.ScaleAt(ds: real);
begin
  ScaleImageAt(CardBackIm, ds);
  ScaleImageAt(CardItemIm, ds);
  ScaleImageAt(CardBorderIm, ds + ds * 0.08);
  ScaleLabelAt(HealthValueText, 0.1, 0);
  ScaleLabelAt(ValueText, 0.1, 1);
end;

procedure TCard.ReSetPosToMode(ScaleModeIndex: integer);
begin
  case ScaleModeIndex of
    1:
      begin
        ReScaleToNormal(CardBackIm);
        ReScaleToNormal(CardItemIm);
        ReScaleToNormal(CardBorderIm);
        ReScaleLabelToNormal(HealthValueText, 0);
        ReScaleLabelToNormal(ValueText, 1);

        ScaleImageOn(CardBorderIm, 1.08);
      end;
    2:
      begin
        ReSetPosToMode(1);
        ReScaleToNone(CardBackIm);
        ReScaleToNone(CardItemIm);
        ReScaleToNone(CardBorderIm);
        ReScaleLabelToNone(HealthValueText);
        ReScaleLabelToNone(ValueText);
      end;
  end;
end;

procedure TCard.MoveOn(dx, dy: integer);
begin
  MoveImageOn(CardBackIm, dx, dy);
  MoveImageOn(CardItemIm, dx, dy);
  MoveImageOn(CardBorderIm, dx, dy);
  MoveLabelOn(HealthValueText, dx, dy);
  MoveLabelOn(ValueText, dx, dy);
end;

procedure TCard.MoveAt(dx, dy: integer);
begin
  MoveImageAt(CardBackIm, dx, dy);
  MoveImageAt(CardItemIm, dx, dy);
  MoveImageAt(CardBorderIm, dx, dy);
  MoveLabelAt(HealthValueText, dx, dy);
  MoveLabelAt(ValueText, dx, dy);
end;

procedure TCard.MoveImageOn(var Image: timage; dx, dy: integer);
begin
  Image.Left := Image.Left + dx;
  Image.Top := Image.Top + dy;
end;

procedure TCard.MoveImageAt(var Image: timage; dx, dy: integer);
begin
  Image.Left := dx;
  Image.Top := dy;
end;

procedure TCard.ScaleImageOn(var Image: timage; ds: real);
var
  wMultiple, hMultiple: integer;
begin
  wMultiple := Round(Image.Width * ds);
  hMultiple := Round(Image.Height * ds);
  Image.Left := Image.Left + (Image.Width - wMultiple) div 2;
  Image.Top := Image.Top + (Image.Height - hMultiple) div 2;
  Image.Width := wMultiple;
  Image.Height := hMultiple;
end;

procedure TCard.ScaleImageAt(var Image: timage; ds: real);
var
  wMultiple, hMultiple: integer;
begin
  wMultiple := Round(SIZE_CARD_X * iPercentage * ds / 100);
  hMultiple := Round(SIZE_CARD_Y * iPercentage * ds / 100);
  Image.Left := Image.Left + (Image.Width - wMultiple) div 2;
  Image.Top := Image.Top + (Image.Height - hMultiple) div 2;
  Image.Width := wMultiple;
  Image.Height := hMultiple;
end;

procedure TCard.MoveLabelOn(var Labeel: tlabel; dx, dy: integer);
begin
  Labeel.Left := Labeel.Left + dx;
  Labeel.Top := Labeel.Top + dy;
end;

procedure TCard.MoveLabelAt(var Labeel: tlabel; dx, dy: integer);
begin
  Labeel.Left := dx;
  Labeel.Top := dy;
end;

procedure TCard.ScaleLabelOn(var Labeel: tlabel; ds: real; mode: integer);
var
  wMultiple, hMultiple: integer;
begin
  wMultiple := Round(ds * 10);
  Labeel.Font.Size := wMultiple;
  Labeel.Left := CardItemIm.Left + CardItemIm.Width div 10;
  if mode = 0 then
    Labeel.Top := CardItemIm.Top + CardItemIm.Height div 20
  else
    Labeel.Top := CardItemIm.Top + 9 * CardItemIm.Height div 10;

  Labeel.BringToFront;
end;

procedure TCard.ScaleLabelAt(var Labeel: tlabel; ds: real; mode: integer);
var
  wMultiple, hMultiple: integer;
begin
  wMultiple := Round(ds * 10);
  Labeel.Font.Size := wMultiple;
  Labeel.Left := CardItemIm.Left + CardItemIm.Width div 10;
  if mode = 0 then
    Labeel.Top := CardItemIm.Top + CardItemIm.Height div 20
  else
    Labeel.Top := CardItemIm.Top + 9 * CardItemIm.Height div 10;
  Labeel.BringToFront;
end;

procedure TCard.SetVisible(isVisible: bool);
begin
  CardBackIm.Visible := isVisible;
  CardItemIm.Visible := isVisible;
  CardBorderIm.Visible := isVisible;
  HealthValueText.Visible := isVisible;
  ValueText.Visible := isVisible;
end;

procedure TCard.SetCardStat(CardStat: TCard);
begin
  Position := CardStat.Position;
  BorderIndex := CardStat.BorderIndex;
  ItemIndex := CardStat.ItemIndex;
  CardBackIm.Picture.Bitmap := CardStat.CardBackIm.Picture.Bitmap;
  CardItemIm.Picture.Bitmap := CardStat.CardItemIm.Picture.Bitmap;
  CardBorderIm.Picture.Bitmap := CardStat.CardBorderIm.Picture.Bitmap;
  Value := CardStat.Value;
  ValueText.Visible := CardStat.ValueText.Visible;
  HealthValueText.Visible := CardStat.HealthValueText.Visible;
  ValueText.Caption := CardStat.ValueText.Caption;
  HealthValueText.Caption := CardStat.HealthValueText.Caption;
  IsCardIsPlayer := CardStat.IsCardIsPlayer;
  CardBorderIm.Visible := IsCardIsPlayer;
end;

function TCard.GetCardStat(): TCard;
begin
  GetCardStat := Self;
end;

procedure TCard.ImMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  dx, dy: integer;
begin
  dx := Abs(FieldOfCards.GetPlayerPos.X - Position.X);
  dy := Abs(FieldOfCards.GetPlayerPos.Y - Position.Y);
  if (((dx = 1) and (dy = 0)) or ((dx = 0) and (dy = 1))) and
    not FieldOfCards.IsCardAnimPlayed(3) then
  begin
    dx := Position.X - FieldOfCards.GetPlayerPos.X;
    dy := FieldOfCards.GetPlayerPos.Y - Position.Y;

    FieldOfCards.ToggleAnimOn(3, FieldOfCards.GetPlayerPos.X,
      FieldOfCards.GetPlayerPos.Y, CoordToVector(CTP(dx, dy)));
    FieldOfCards.ToggleAnimOn(1, Position.X, Position.Y);

  end;
end;

procedure TCard.ImMouseEnter(Sender: TObject);
begin
  if not IsCardIsPlayer then
    CardBorderIm.Visible := (true);
end;

procedure TCard.ImMouseLeave(Sender: TObject);
begin
  if not IsCardIsPlayer then
    CardBorderIm.Visible := false;
end;

function TCard.GenerateItemIndex(Difficult: integer): integer;

var
  randomR: integer;
  CO_NO, CO_BO, CO_EN, CO_TR, CO_MX: integer;
begin
  if IsCardIsPlayer then
  begin
    GenerateItemIndex := 0;
  end
  else
  begin
    Randomize;

    CO_NO := CHANCE_OF_NOTHING;
    CO_BO := Round(CHANCE_OF_BONUS * (0.5 + 1 / Difficult)) + CO_NO;
    CO_EN := Round(CHANCE_OF_ENEMIES * (Difficult * Difficult)) + CO_BO;
    CO_TR := Round(CHANCE_OF_TRAPS * (Difficult * Difficult)) + CO_EN;

    randomR := Rnd(0, CO_TR);

    if (0 <= randomR) and (randomR < CO_NO) then
      ItemType := TItemType.nothing
    else if (CO_NO <= randomR) and (randomR < CO_BO) then
      ItemType := TItemType.bonus
    else if (CO_BO <= randomR) and (randomR < CO_EN) then
      ItemType := TItemType.enemy
    else if (CO_EN <= randomR) and (randomR <= CO_TR) then
      ItemType := TItemType.trap
    else
      Msg('rand ind err');

    case ItemType of
      nothing:
        GenerateItemIndex := 0;
      bonus:
        GenerateItemIndex := Rnd(1, COUNT_OF_BONUS_CARDS);
      enemy:
        GenerateItemIndex := Rnd(1, COUNT_OF_ENEMIES);
      trap:
        GenerateItemIndex := Rnd(1, COUNT_OF_TRAPS);
    else
      Msg('rand ind err');
    end;

  end;

end;

function TCard.DamageDeal(Value: integer): integer;
begin
  //
end;

function TCard.isTrapsFacing(trapX, trapY: integer): bool;
begin
  //
end;

function TCard.CardLootGen(KilledCardType: TItemType; KilleCardIndex: integer)
  : TCardGen;
begin
  //
end;

function TCard.BonusPick(BonusItemIndex: integer): integer;
begin
  //
end;

procedure TCard.ImMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  //
end;

end.
