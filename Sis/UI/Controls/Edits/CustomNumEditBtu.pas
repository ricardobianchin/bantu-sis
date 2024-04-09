unit CustomNumEditBtu;

interface

uses
  SysUtils, Classes, ExtCtrls, CustomEditBtu, dialogs;

type
  TCustomNumEditBtu = class(TCustomEditBtu)
  private
    FCharDecimal: char;
    FNCasas: integer;
    FNCasasEsq: integer;
    FMascEsq: string;
    procedure SetNCasas(const Value: integer);
    procedure SetNCasasEsq(const Value: integer);

    procedure ComerChar;
    { Private declarations }
  protected
    { Protected declarations }
    Expoente:byte;
    TemVirgula:boolean;
    Encerrado:boolean;

    //property
    property NCasas:integer read FNCasas write SetNCasas;
    property NCasasEsq:integer read FNCasasEsq write SetNCasasEsq;
    property MascEsq:string read FMascEsq write FMascEsq;

    //vcl
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
    procedure Click; override;
    procedure PreencherText;override;
    procedure SetValor(const Value: Variant); override;

    procedure DoExit; override;

  public
    { Public declarations }
    procedure Clear; override;
    function SQLString:string;override;
    constructor Create(AOwner: TComponent); override;
    function AsStrZero(pNCasas:integer):string;
    property CharDecimal:char read FCharDecimal write FCharDecimal default ',';

  published
    { Published declarations }
  end;

procedure Register;

implementation

uses Controls, StdCtrls, windows, Variants, Math, StrUtils;

procedure Register;
begin
//  RegisterComponents('Ricardo', [TCustomNumEditBtu]);
end;

{ TCustomNumEditBtu }

function TCustomNumEditBtu.AsStrZero(pNCasas: integer): string;
begin
  result:=IntToStrZero(Valor,pNCasas);
end;

procedure TCustomNumEditBtu.Change;
begin
  inherited;
  SelStart:=Length(Text);
end;

procedure TCustomNumEditBtu.Clear;
begin
  inherited;
end;

procedure TCustomNumEditBtu.Click;
begin
  inherited;
  SelStart:=Length(Text);
end;

procedure TCustomNumEditBtu.ComerChar;
begin
  FDigitado:=LeftStr(FDigitado,length(FDigitado)-1);
  if SoDig(FDigitado)=fdigitado then
    TemVirgula:=false;
PreencherText;
end;

constructor TCustomNumEditBtu.Create(AOwner: TComponent);
begin
//  NCasas:=2;
  inherited;
//  FMascEsq:='###,###,##0';
  FMascEsq:='########0';
  CharDecimal:=',';
  Alignment:=taRightJustify;
  Expoente:=0;
  TemVirgula:=false;
  Encerrado:=false;
  AutoSize:=false;
  Ctl3D:=true;

  LabelPosition := lpLeft;
  LabelSpacing := 4;
end;

procedure TCustomNumEditBtu.DoExit;
begin
  inherited;
  Encerrado:=true;
end;

procedure TCustomNumEditBtu.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not readonly then
  begin
    case key of
      8,46:if not Encerrado then comerchar;
      9:;
//      127:begin SetValor('0'); key:=0; end;
      else key:=0;
    end;
  end;
end;

procedure TCustomNumEditBtu.KeyPress(var Key: Char);
begin
  inherited;
  try
    if readonly then
      exit;

    if pos(key,'0123456789,.')=0 then
      exit;

    if Encerrado then
    begin

      Encerrado:=false;
      Expoente:=0;
      TemVirgula:=false;
      SetDigitado('');
    end;
    if ((key='.') or (key=',')) then
    begin
      if (NCasas=0) then
        exit
      else
        if not TemVirgula then
        begin
          TemVirgula:=true;
          SetDigitado(FDigitado+FCharDecimal);
        end;
    end
    else
    begin
      if TemVirgula then
      begin
        if (Length(FDigitado)-pos(FCharDecimal,fdigitado))<NCasas then
          SetDigitado(FDigitado+key)
      end
      else
        if Length(StrAEsqDoCaracter(FCharDecimal,FDigitado))<FNCasasEsq then
          SetDigitado(FDigitado+key);
      inc(Expoente);
    end;
  finally
    if key<>#9 then
      key:=#0;
  end;
end;

procedure TCustomNumEditBtu.PreencherText;
var
  s,se,m:string;
  v, lendeve:integer;
begin
  try
  m:=MascEsq;
  if ncasas>0 then
  begin
    m:=m+'.';
    for v := 1 to NCasas do
      m:=m+'0';
  end;
  s:=formatfloat(m, StrToNum(FDigitado));
  if Length(s)>Length(m) then
    s:=RightStr(s, Length(m));
  Text:=s;
  except on e:exception do
  begin
    showmessage(e.classname+' '+e.Message+' PreencherText em '+name);
  end;
  end;
end;

procedure TCustomNumEditBtu.SetNCasas(const Value: integer);
begin
  FNCasas := Value;
  PreencherText;
end;

procedure TCustomNumEditBtu.SetNCasasEsq(const Value: integer);
begin
  FNCasasEsq := Value;
  FMascEsq := StringOfChar('#', Value - 1) + '0';
  PreencherText;
end;

procedure TCustomNumEditBtu.SetValor(const Value: Variant);
begin
  inherited setvalor(SemZeroAEsquerda( strtonumstr(Value)));

  Encerrado:=true;
end;

function TCustomNumEditBtu.SQLString: string;
begin
  result := StrToNumStrPonto(text);
end;

end.
