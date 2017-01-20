{==============================================================================
 Lizenshinweise:  Dieses Programm wurde geschrieben von Alexander Roth

    Dieses Programm ist freie Software. Sie können es unter den Bedingungen
    der GNU General Public License, wie von der Free Software Foundation
    veröffentlicht, weitergeben und/oder modifizieren, gemäß Version 2 der Lizenz.
==============================================================================}
unit UColoredBox;  //Version 0.2

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType;

type

  { TColoredListBox }

  TColoredListBox = class(TListBox)
  private
    FItemColors: TStrings;
    FItemBackgroundColors: TStrings;

    FAdd2ItemColors: TColor;
    FAdd2ItemBackgroundColors: TColor;


    procedure WriteFItemBackgroundColors(ItemBackgroundColors: TStrings);
    procedure WriteFItemColors(ItemColors: TStrings);

    function ReadFAdd2ItemColors: TColor;
    procedure WriteFAdd2ItemColors(Add2ItemColors: TColor);

    function ReadFAdd2ItemBackgroundColors: TColor;
    procedure WriteFAdd2ItemBackgroundColors(Add2ItemBackgroundColors: TColor);

    procedure DrawItem(Index: integer; ARect: TRect; State: TOwnerDrawState); override;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure AddItem(atext: string; aColor: TColor = clWindowText; aBackgroundColor: TColor = clWindow);
    procedure InsertItem(idx: integer; atext: string; aColor: TColor = clWindowText; aBackgroundColor: TColor = clWindow);
    procedure DeleteItem(idx: integer);

    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ItemBackgroundColors: TStrings read FItemBackgroundColors write WriteFItemBackgroundColors;
    property ItemColors: TStrings read FItemColors write WriteFItemColors;
    property Add2ItemColors: TColor read FAdd2ItemColors write WriteFAdd2ItemColors;
    property Add2ItemBackgroundColors: TColor read FAdd2ItemBackgroundColors write WriteFAdd2ItemBackgroundColors;
  end;



  { TColoredComboBox }

  TColoredComboBox = class(TComboBox)
  private
    FItemColors: TStrings;
    FItemBackgroundColors: TStrings;

    FAdd2ItemColors: TColor;
    FAdd2ItemBackgroundColors: TColor;


    procedure WriteFItemBackgroundColors(ItemBackgroundColors: TStrings);
    procedure WriteFItemColors(ItemColors: TStrings);

    function ReadFAdd2ItemColors: TColor;
    procedure WriteFAdd2ItemColors(Add2ItemColors: TColor);

    function ReadFAdd2ItemBackgroundColors: TColor;
    procedure WriteFAdd2ItemBackgroundColors(Add2ItemBackgroundColors: TColor);

    procedure DrawItem(Index: integer; ARect: TRect; State: TOwnerDrawState); override;
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure AddItem(atext: string; aColor: TColor = clWindowText; aBackgroundColor: TColor = clWindow);
    procedure InsertItem(idx: integer; atext: string; aColor: TColor = clWindowText; aBackgroundColor: TColor = clWindow);
    procedure DeleteItem(idx: integer);

    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property ItemBackgroundColors: TStrings read FItemBackgroundColors write WriteFItemBackgroundColors;
    property ItemColors: TStrings read FItemColors write WriteFItemColors;
    property Add2ItemColors: TColor read FAdd2ItemColors write WriteFAdd2ItemColors;
    property Add2ItemBackgroundColors: TColor read FAdd2ItemBackgroundColors write WriteFAdd2ItemBackgroundColors;
  end;



procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Misc', [TColoredListBox]);
  RegisterComponents('Misc', [TColoredComboBox]);
end;




{ TColoredListBox }

procedure TColoredListBox.WriteFItemBackgroundColors(ItemBackgroundColors: TStrings);
begin
  FItemBackgroundColors.Assign(ItemBackgroundColors);
  Update;
end;

procedure TColoredListBox.WriteFItemColors(ItemColors: TStrings);
begin
  FItemColors.Assign(ItemColors);
  Update;
end;

function TColoredListBox.ReadFAdd2ItemColors: TColor;
begin
  if (FItemColors.Count >= 1) then
    Result := StringToColor(FItemColors.Strings[FItemColors.Count - 1])
  else
    Result := clWindowText;
end;

procedure TColoredListBox.WriteFAdd2ItemBackgroundColors(Add2ItemBackgroundColors: TColor);
begin
  FItemBackgroundColors.Add(ColorToString(Add2ItemBackgroundColors));
end;

procedure TColoredListBox.WriteFAdd2ItemColors(Add2ItemColors: TColor);
begin
  FItemColors.Add(ColorToString(Add2ItemColors));
end;

function TColoredListBox.ReadFAdd2ItemBackgroundColors: TColor;
begin
  if FItemBackgroundColors.Count >= 1 then
    Result := StringToColor(FItemBackgroundColors.Strings[FItemBackgroundColors.Count - 1])
  else
    Result := clWindow;
end;

procedure TColoredListBox.DrawItem(Index: integer; ARect: TRect; State: TOwnerDrawState);
var
  l, t: integer;
begin
  if Assigned(OnDrawItem) then
    OnDrawItem(Self, Index, ARect, State)
  else if (Index >= 0) and (Index < Items.Count) then
    begin
    if (0 <= Index) and (Index <= FItemColors.Count - 1) then
      if not Selected[Index] then
        Canvas.Font.Color := StringToColor(FItemColors.Strings[Index])
      else
        Canvas.Font.Color := clHighlightText;
    if (0 <= Index) and (Index <= FItemBackgroundColors.Count - 1) then
      //      if not Selected[Index] then
      Canvas.Brush.Color := StringToColor(FItemBackgroundColors.Strings[Index]);
    //else
    //Canvas.Brush.Color:=clHighlight;

    t := aRect.Top;
    t := t + ((aRect.Bottom - t - Canvas.TextHeight('Qq')) shr 1);
    l := aRect.Left + 2;

    Canvas.FillRect(aRect);
    Canvas.Brush.Style := bsClear;
    Canvas.TextRect(aRect, l, t, Items[Index]);
    end;
end;


procedure TColoredListBox.AddItem(atext: string; aColor: TColor; aBackgroundColor: TColor);
begin
  Items.Add(atext);
  FItemColors.Add(ColorToString(aColor));
  FItemBackgroundColors.Add(ColorToString(aBackgroundColor));
end;

procedure TColoredListBox.InsertItem(idx: integer; atext: string; aColor: TColor; aBackgroundColor: TColor);
begin
  if (0 <= idx) and (idx <= Items.Count - 1) then
    Items.Insert(idx, atext);
  if (0 <= idx) and (idx <= FItemColors.Count - 1) then
    FItemColors.Insert(idx, ColorToString(aColor));
  if (0 <= idx) and (idx <= FItemBackgroundColors.Count - 1) then
    FItemBackgroundColors.Insert(idx, ColorToString(aBackgroundColor));
end;

procedure TColoredListBox.DeleteItem(idx: integer);
begin
  if (0 <= idx) and (idx <= Items.Count - 1) then
    Items.Delete(idx);
  if (0 <= idx) and (idx <= FItemColors.Count - 1) then
    FItemColors.Delete(idx);
  if (0 <= idx) and (idx <= FItemBackgroundColors.Count - 1) then
    FItemBackgroundColors.Delete(idx);
end;

constructor TColoredListBox.Create(TheOwner: TComponent);
begin
  inherited;
  FItemColors := TStringList.Create;
  FItemBackgroundColors := TStringList.Create;

  Style := lbOwnerDrawFixed;
  FAdd2ItemColors := clBlue;
  FAdd2ItemBackgroundColors := clWhite;
end;

destructor TColoredListBox.Destroy;
begin
  FreeAndNil(FItemColors);
  FreeAndNil(FItemBackgroundColors);
  inherited;
end;




{ TColoredComboBox }

procedure TColoredComboBox.WriteFItemBackgroundColors(ItemBackgroundColors: TStrings);
begin
  FItemBackgroundColors.Assign(ItemBackgroundColors);
  Update;
end;

procedure TColoredComboBox.WriteFItemColors(ItemColors: TStrings);
begin
  FItemColors.Assign(ItemColors);
  Update;
end;

function TColoredComboBox.ReadFAdd2ItemColors: TColor;
begin
  if (FItemColors.Count >= 1) then
    Result := StringToColor(FItemColors.Strings[FItemColors.Count - 1])
  else
    Result := clWindowText;
end;

procedure TColoredComboBox.WriteFAdd2ItemBackgroundColors(Add2ItemBackgroundColors: TColor);
begin
  FItemBackgroundColors.Add(ColorToString(Add2ItemBackgroundColors));
end;

procedure TColoredComboBox.WriteFAdd2ItemColors(Add2ItemColors: TColor);
begin
  FItemColors.Add(ColorToString(Add2ItemColors));
end;

function TColoredComboBox.ReadFAdd2ItemBackgroundColors: TColor;
begin
  if FItemBackgroundColors.Count >= 1 then
    Result := StringToColor(FItemBackgroundColors.Strings[FItemBackgroundColors.Count - 1])
  else
    Result := clWindow;
end;

procedure TColoredComboBox.DrawItem(Index: integer; ARect: TRect; State: TOwnerDrawState);
begin
  if Assigned(OnDrawItem) then
    OnDrawItem(Self, Index, ARect, State)
  else if (Index >= 0) and (Index < Items.Count) then
    begin
    if (0 <= Index) and (Index <= FItemColors.Count - 1) then
      if DroppedDown and (odSelected in State) then
        Canvas.Font.Color := clHighlightText
      else
        Canvas.Font.Color := StringToColor(FItemColors.Strings[Index]);
    if (0 <= Index) and (Index <= FItemBackgroundColors.Count - 1) then
      if DroppedDown and (odSelected in State) then
        Canvas.Brush.Color := clHighlight
      else
        Canvas.Brush.Color := StringToColor(FItemBackgroundColors.Strings[Index]);

    Canvas.FillRect(aRect);
    Canvas.Brush.Style := bsClear;
    Canvas.TextRect(aRect, aRect.Left + 2, aRect.Top, Items[Index]);
    end;
end;


procedure TColoredComboBox.AddItem(atext: string; aColor: TColor; aBackgroundColor: TColor);
begin
  Items.Add(atext);
  FItemColors.Add(ColorToString(aColor));
  FItemBackgroundColors.Add(ColorToString(aBackgroundColor));
end;

procedure TColoredComboBox.InsertItem(idx: integer; atext: string; aColor: TColor; aBackgroundColor: TColor);
begin
  if (0 <= idx) and (idx <= Items.Count - 1) then
    Items.Insert(idx, atext);
  if (0 <= idx) and (idx <= FItemColors.Count - 1) then
    FItemColors.Insert(idx, ColorToString(aColor));
  if (0 <= idx) and (idx <= FItemBackgroundColors.Count - 1) then
    FItemBackgroundColors.Insert(idx, ColorToString(aBackgroundColor));
end;

procedure TColoredComboBox.DeleteItem(idx: integer);
begin
  if (0 <= idx) and (idx <= Items.Count - 1) then
    Items.Delete(idx);
  if (0 <= idx) and (idx <= FItemColors.Count - 1) then
    FItemColors.Delete(idx);
  if (0 <= idx) and (idx <= FItemBackgroundColors.Count - 1) then
    FItemBackgroundColors.Delete(idx);
end;

constructor TColoredComboBox.Create(TheOwner: TComponent);
begin
  inherited;
  FItemColors := TStringList.Create;
  FItemBackgroundColors := TStringList.Create;

  Style := csOwnerDrawFixed;
  FAdd2ItemColors := clBlue;
  FAdd2ItemBackgroundColors := clBtnFace;
end;

destructor TColoredComboBox.Destroy;
begin
  FreeAndNil(FItemColors);
  FreeAndNil(FItemBackgroundColors);
  inherited;
end;

end.
