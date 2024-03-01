unit CustomEditBtu;

interface

uses
  System.SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Messages,
  windows, Graphics;

type
  TCustomEditBtu = class(TCustomLabeledEdit)
  private

    { Private declarations }
    FAlignment: TAlignment;
    FOnF1Down: TNotifyEvent;
    FOnF2Down: TNotifyEvent;
    FOnF3Down: TNotifyEvent;
    FOnF4Down: TNotifyEvent;
    FOnF5Down: TNotifyEvent;
    FOnF6Down: TNotifyEvent;
    FOnF7Down: TNotifyEvent;
    FOnF8Down: TNotifyEvent;
    FOnF9Down: TNotifyEvent;
    FOnF10Down: TNotifyEvent;
    FOnF11Down: TNotifyEvent;
    FOnF12Down: TNotifyEvent;
    FAutoExit: boolean;

    function GetCaption: string;
    procedure SetAlignment(const Value: TAlignment);

  protected
    { Protected declarations }
    FDigitado: string;
    FOverwrite:boolean;
    FPosCursor:integer;

    procedure SetCaption(const Value: string);
    procedure SetPosCursor(const Value: integer);virtual;
    procedure IndicarPosCursor;virtual;

    procedure AtualizarDigitado;virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetDigitado(const Value: string);virtual;

    property Caption:string read GetCaption write SetCaption;
//    function AceitaKey(pKey:integer):boolean;virtual;

    procedure PreencherText;virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;

    procedure DoExit; override;
    procedure DoEnter; override;
    function CanExit:boolean;virtual;

    procedure SetValor(const Value: variant);virtual;
    function GetValor: variant;virtual;
    property Valor:variant read GetValor write SetValor;
    property OnF1Down: TNotifyEvent read FOnF1Down write FOnF1Down;
    property OnF2Down: TNotifyEvent read FOnF2Down write FOnF2Down;
    property OnF3Down: TNotifyEvent read FOnF3Down write FOnF3Down;
    property OnF4Down: TNotifyEvent read FOnF4Down write FOnF4Down;
    property OnF5Down: TNotifyEvent read FOnF5Down write FOnF5Down;
    property OnF6Down: TNotifyEvent read FOnF6Down write FOnF6Down;
    property OnF7Down: TNotifyEvent read FOnF7Down write FOnF7Down;
    property OnF8Down: TNotifyEvent read FOnF8Down write FOnF8Down;
    property OnF9Down: TNotifyEvent read FOnF9Down write FOnF9Down;
    property OnF10Down: TNotifyEvent read FOnF10Down write FOnF10Down;
    property OnF11Down: TNotifyEvent read FOnF11Down write FOnF11Down;
    property OnF12Down: TNotifyEvent read FOnF12Down write FOnF12Down;
    property PosCursor:integer read FPosCursor write SetPosCursor;

    function StrToNumStr(S:string):string;
    function SemZeroAEsquerda(S: string): string;
    function StrDireita(S: string; NCharsDir: integer): string;
    function StrToNum(S:string):double;
    function StrToNumStrPonto(S:string):string;
    function IntToStrZero(pI:int64;pNCasas:integer):string;
    function SoDig(s:string):string;overload;
    function EhDig(C:Char):boolean;
    function StrAEsqDoCaracter(pCaracter,pStr:string):string;
    const CorFundoReadOnly=$E6E8CB; //$DADDB3;
    const DecimalSeparator = ',';

    function GetReadOnly: Boolean;
    procedure SetReadOnly(Value: Boolean);
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;

    function GetAsCurrency: currency;
    procedure SetParent(AParent: TWinControl); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function SQLString:string;virtual;
    function ValorAceitavel:boolean;virtual;
    function AsInteger:integer;
    function AsFloat:double;
    property Digitado:string read FDigitado write SetDigitado;
    property AsCurrency: currency read GetAsCurrency;
  published
    { Published declarations }
    property Alignment: TAlignment read FAlignment write SetAlignment default taRightJustify;
    property AutoExit:boolean read FAutoExit write FAutoExit;
  end;

procedure Register;

implementation

uses Variants, Math{, dialogs};

procedure Register;
begin
//  RegisterComponents('Edits', [TCustomEditBtu]);
end;

{ TCustomEditBtu }

{function TCustomEditBtu.AceitaKey(pKey: integer): boolean;
begin
  result:=true;
end;}

function TCustomEditBtu.GetAsCurrency: currency;
var
  s:string;
begin
  try
    s:=StrToNumStr(GetValor);

    result:=StrToCurr(s);
  except on EVariantError do
    result:=0;
  end;

end;

function TCustomEditBtu.AsFloat: double;
var
  s:string;
begin
  try
    s:=StrToNumStr(GetValor);

    result:=StrToNum(s);
//  except on EVariantError do
  except
    result:=0;
  end;
end;

function TCustomEditBtu.AsInteger: integer;
var
  s:string;
begin
  try
    s:=GetValor;
    if s='' then
    begin
      result:=0;
      exit;
    end;
  result:=GetValor
  except
  on EVariantError do result:=0;
  end;
end;

procedure TCustomEditBtu.AtualizarDigitado;
begin

end;

function TCustomEditBtu.CanExit: boolean;
begin
  result:=ValorAceitavel;
end;

constructor TCustomEditBtu.Create(AOwner: TComponent);
begin
  inherited;
  if AOwner is TWinControl then
    Parent:=TWinControl(AOwner);
  LabelSpacing:=1;
  FOverwrite:=false;
  FPosCursor:=0;
  FAutoExit:=true;
end;

procedure TCustomEditBtu.CreateParams(var Params: TCreateParams);
const
  Alinhamentos: array[TAlignment] of Cardinal = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or Alinhamentos[FAlignment];
end;

procedure TCustomEditBtu.DoEnter;
begin
  inherited;

end;

procedure TCustomEditBtu.DoExit;
begin
  inherited;
//  if not CanExit then
//    SetFocus;
end;

function TCustomEditBtu.EhDig(C: Char): boolean;
begin
  result:=pos(C,'0123456789')>0;
end;

function TCustomEditBtu.GetCaption: string;
begin
  result:=EditLabel.Caption;
end;

function TCustomEditBtu.GetReadOnly: Boolean;
begin
  Result := inherited ReadOnly;
end;

function TCustomEditBtu.GetValor: variant;
begin
  if FDigitado='' then
    result:=0
  else
    result:=FDigitado;
end;

procedure TCustomEditBtu.IndicarPosCursor;
begin
  if not FOverwrite then
    exit;
  if Length(text)=0 then
  begin
    SetDigitado('');
    exit;
  end;
  SelStart:=FPosCursor;
  SelLength:=1;
end;

function TCustomEditBtu.IntToStrZero(pI: int64; pNCasas: integer): string;
var
  tavanegativo:boolean;
begin
  tavanegativo:=pi<0;
  pi:=abs(pi);

  result:=inttostr(pi);
  while Length(Result)<pNCasas do
    Result:='0'+Result;

  if tavanegativo then
    result:='-'+result;
end;

procedure TCustomEditBtu.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    13:
    begin
      if autoexit then
        if owner is twincontrol then
        begin
          SendMessage(twincontrol(owner).Handle,WM_NEXTDLGCTL,0,0);
          //showmessage('pulou');
        end;
    end;
    vk_f1: if Assigned(FOnF1Down) then FOnF1Down(self);
    vk_f2: if Assigned(FOnF2Down) then FOnF2Down(self);
    vk_f3: if Assigned(FOnF3Down) then FOnF3Down(self);
    vk_f4: if Assigned(FOnF4Down) then FOnF4Down(self);
    vk_f5: if Assigned(FOnF5Down) then FOnF5Down(self);
    vk_f6: if Assigned(FOnF6Down) then FOnF6Down(self);
    vk_f7: if Assigned(FOnF7Down) then FOnF7Down(self);
    vk_f8: if Assigned(FOnF8Down) then FOnF8Down(self);
    vk_f9: if Assigned(FOnF9Down) then FOnF9Down(self);
    vk_f10: if Assigned(FOnF10Down) then FOnF10Down(self);
    vk_f11: if Assigned(FOnF11Down) then FOnF11Down(self);
    vk_f12: if Assigned(FOnF12Down) then FOnF12Down(self);
  end;
//  key:=0;
end;

procedure TCustomEditBtu.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  IndicarPosCursor;
end;

procedure TCustomEditBtu.PreencherText;
begin
  //deverá preencher text a partir de digitado
end;

function TCustomEditBtu.SemZeroAEsquerda(S: string): string;
begin
  s:=trim(s);
  while Length(s)>0 do
  begin
    if s[1]='0' then
      s:=StrDireita(s,length(s)-1)
    else
    begin
      result:=s;
      break;
    end;
  end;
  s:=trim(s);
  if s='' then
    result:='0';
  if (result[1]=',') or (result[1]='.') then
    result:='0'+result;
end;

procedure TCustomEditBtu.SetAlignment(const Value: TAlignment);
begin
  FAlignment := Value;
  RecreateWnd;
end;

procedure TCustomEditBtu.SetCaption(const Value: string);
begin
  EditLabel.Caption:=Value;
end;

procedure TCustomEditBtu.SetDigitado(const Value: string);
begin
  FDigitado := Value;
  PreencherText;
end;

procedure TCustomEditBtu.SetParent(AParent: TWinControl);
begin
  inherited;
  EditLabel.BringToFront;
  EditLabel.Repaint;
end;

procedure TCustomEditBtu.SetPosCursor(const Value: integer);
begin
  FPosCursor:=value;
  if FOverwrite then
  begin
    SelStart:=Value;
    SelLength:=1;
  end;
end;

procedure TCustomEditBtu.SetReadOnly(Value: Boolean);
begin
  if Value = inherited ReadOnly then
    exit;

  inherited ReadOnly := Value;

  if Value then
//    e.Color:=UCores.CorFundoReadOnly// $00F2F3E4
    Color := CorFundoReadOnly// $00F2F3E4
  else
    Color := clWindow;

end;

procedure TCustomEditBtu.SetValor(const Value: variant);
begin
  if VarIsNull(Value) then
    SetDigitado('')
  else
  begin
    if value<0.00001 then
      SetDigitado('')
    else
      SetDigitado(Trim(value));
  end;
end;

function TCustomEditBtu.SoDig(s: string): string;
var
  t:integer;
begin
  result:='';
  for t := 1 to Length(s) do
    if EhDig(s[t]) then
      result:=result+s[t];
end;

function TCustomEditBtu.SQLString: string;
begin
  result:=QuotedStr(Text);
end;

function TCustomEditBtu.StrAEsqDoCaracter(pCaracter, pStr: string): string;
var
  t:integer;
begin
  if pos(pCaracter,pStr)=0 then
  begin
    result:=pStr;
    exit;
  end;

  result:='';
  t := 1;
  while t<=Length(pstr) do
  begin
    if pstr[t]=pcaracter then
      break;
    result:=result+pstr[t];
    inc(t);
  end;
end;

function TCustomEditBtu.StrDireita(S: string; NCharsDir: integer): string;
var
  Posicao:integer;
begin
  result:='';
  if Length(s)<=NCharsDir then
    result:=s
  else
    for Posicao:=length(s) downto length(s)-NCharsdir+1 do
      result:=s[Posicao]+result;
end;

function TCustomEditBtu.StrToNum(S: string): double;
begin
  if Trim(s)='' then
    s:='0';


  if DecimalSeparator='.' then
    result:=StrToFloat(StrToNumStrPonto(s))
  else
    result:=StrToFloat(StrToNumStr(s));

//  result:=strtofloat(StrToNumStrPonto(s));
//  result:=strtofloat(StrToNumStr(s));
end;

function TCustomEditBtu.StrToNumStr(S: string): string;
var
  npontos,t:integer;
  c:string;
  function TemVirg:boolean;
  begin
    result:=pos(',',s)>0;
  end;
  procedure TirarPontos;
  var
    tmp,c:string;
    t:integer;
  begin
    tmp:='';
    for t := 1 to Length(s) do
    begin
      c:=s[t];
      if c<>'.' then
      begin
        tmp:=tmp+c;
      end;
    end;
    s:=tmp;
  end;
begin
  if temvirg then
    tirarpontos;

  npontos:=0;
  result:='';
  for t:= 1 to Length(s) do
  begin
    c:=s[t];
    if c='.' then
      c:=',';
    if c=',' then
    begin
      if npontos=0 then
        result:=result+c;
      inc(npontos);
    end
    else
    begin
      if pos(c,'0123456789-')<>0 then
        result:=result+c;
    end;
  end;
  result:=SemZeroAEsquerda(result);
  if result='' then
    result:='0';
  if result[1]=',' then
    result:='0'+result;
  if result[length(result)]=',' then
    result:=result+'0';
end;

function TCustomEditBtu.StrToNumStrPonto(S: string): string;
var
  npontos,t:integer;
  c:string;
begin
  npontos:=0;
  result:='';
  for t:= 1 to Length(s) do
  begin
    c:=s[t];
    if c=',' then
      c:='.';
    if c='.' then
    begin
      if npontos=0 then
        result:=result+c;
      inc(npontos);
    end
    else
    begin
      if pos(c,'0123456789-')<>0 then
        result:=result+c;
    end;
  end;

  if result='' then
    result:='0';
  if result[1]='.' then
    result:='0'+result;
  if result[length(result)]='.' then
    result:=result+'0';
end;

function TCustomEditBtu.ValorAceitavel: boolean;
begin
  result:=true;
end;

end.
