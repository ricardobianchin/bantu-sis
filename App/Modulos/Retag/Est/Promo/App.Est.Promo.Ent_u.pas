unit App.Est.Promo.Ent_u;

interface

uses Sis.Types, App.Est.Prod, System.Generics.Collections, Sis.Entities.Types,
  App.Est.Promo.Ent, App.Est.PromoItem, App.Loja, Sis.Sis.Constants, App.Ent.Ed_u;

type
  TEstPromoEnt = class(TEntEd, IEstPromoEnt)
  private
    FLoja: IAppLoja;

    FPromoId: integer;
    FNome: string;
    FAtivo: Boolean;
    FIniciaEm: TDateTime;
    FTerminaEm: TDateTime;

    FItems: TList<IEstPromoItem>;

    FEditandoItem: Boolean;
    FItemIndex: integer;

    FGravaCabec: Boolean;
    FAcaoSisId: Char;
 
    function GetPromoId: integer;
    procedure SetPromoId(Value: integer);

    function GetNome: string;
    procedure SetNome(Value: string);

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);

    function GetIniciaEm: TDateTime;
    procedure SetIniciaEm(Value: TDateTime);

    function GetTerminaEm: TDateTime;
    procedure SetTerminaEm(Value: TDateTime);

    function GetItems: TList<IEstPromoItem>;
    function GetLoja: IAppLoja;

    function GetEditandoItem: Boolean;
    procedure SetEditandoItem(Value: Boolean);

    function GetItemIndex: integer;
    procedure SetItemIndex(Value: integer);

    function GetGravaCabec: Boolean;
    procedure SetGravaCabec(Value: Boolean);

    function GetAcaoSisId: Char;
    procedure SetAcaoSisId(Value: Char);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    procedure LimparEnt; override;

  public
    procedure Zerar;
    property Loja: IAppLoja read GetLoja;

    property PromoId: integer read GetPromoId write SetPromoId;
    property Nome: string read GetNome write SetNome;
    property Items: TList<IEstPromoItem> read GetItems;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property IniciaEm: TDateTime read GetIniciaEm write SetIniciaEm;
    property TerminaEm: TDateTime read GetTerminaEm write SetTerminaEm;
    function GetCod(pSeparador: string = '-'): string;

    property EditandoItem: Boolean read GetEditandoItem write SetEditandoItem;
    property ItemIndex: integer read GetItemIndex write SetItemIndex;
    property GravaCabec: Boolean read GetGravaCabec write SetGravaCabec;
    property AcaoSisId: Char read GetAcaoSisId write SetAcaoSisId;

//    function GetLastActiveItemIndex: integer;

    constructor Create( //
      pLoja: IAppLoja; //
      pPromoId: integer; //
      pNome: string; //
      pAtivo: Boolean; //
      pIniciaEm: TDateTime; //
      pTerminaEm: TDateTime //
      );
    destructor Destroy; override;
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats;

{ TEstPromo }

constructor TEstPromoEnt.Create(pLoja: IAppLoja; pPromoId: integer; pNome: string;
  pAtivo: Boolean; pIniciaEm, pTerminaEm: TDateTime);
begin
  FLoja := pLoja;

  FPromoId := pPromoId;
  FNome := pNome;
  FAtivo := pAtivo;
  FIniciaEm := pIniciaEm;
  FTerminaEm := pTerminaEm;

  FItems := TList<IEstPromoItem>.Create;
end;

destructor TEstPromoEnt.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TEstPromoEnt.GetAcaoSisId: Char;
begin
  Result := FAcaoSisId;
end;

function TEstPromoEnt.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TEstPromoEnt.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(FLoja.Id, PromoId, 'PROMO',
    pSeparador);
end;

function TEstPromoEnt.GetEditandoItem: Boolean;
begin
  Result := FEditandoItem;
end;

function TEstPromoEnt.GetGravaCabec: Boolean;
begin
  Result := FGravaCabec;
end;

function TEstPromoEnt.GetIniciaEm: TDateTime;
begin
  Result := FIniciaEm;
end;

function TEstPromoEnt.GetItemIndex: integer;
begin
  Result := FItemIndex;
end;

function TEstPromoEnt.GetItems: TList<IEstPromoItem>;
begin
  Result := FItems;
//  Result := TList<IEstPromoItem>(Items);
end;

//function TEstPromoEnt.GetLastActiveItemIndex: integer;
//begin
//  Result := -1;
//  for var i := FItems.Count - 1 downto 0 do
//  begin
//    if FItems[i].Ativo then
//    begin
//      Result := i;
//      Break;
//    end;
//  end;
//end;

function TEstPromoEnt.GetLoja: IAppLoja;
begin
  Result := FLoja;
end;

function TEstPromoEnt.GetNome: string;
begin
  Result := FNome;
end;

function TEstPromoEnt.GetNomeEnt: string;
begin
  Result := 'Promoção';
end;

function TEstPromoEnt.GetNomeEntAbrev: string;
begin
  Result := 'PROMO';
end;

function TEstPromoEnt.GetPromoId: integer;
begin
  Result := FPromoId;
end;

function TEstPromoEnt.GetTerminaEm: TDateTime;
begin
  Result := FTerminaEm;
end;

function TEstPromoEnt.GetTitulo: string;
begin
  Result := 'Promoções';
end;

procedure TEstPromoEnt.LimparEnt;
begin
  if EditandoItem then
    exit;
  inherited;

  FPromoId := 0;
  FItemIndex := -1;
  FNome := '';
  FAtivo := True;
  FIniciaEm := DATA_ZERADA;
  FTerminaEm := DATA_ZERADA;

  FGravaCabec := False;

  FItems.Clear;
end;

procedure TEstPromoEnt.SetAcaoSisId(Value: Char);
begin
  FAcaoSisId := Value;
end;

procedure TEstPromoEnt.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TEstPromoEnt.SetEditandoItem(Value: Boolean);
begin
  FEditandoItem := Value;
end;

procedure TEstPromoEnt.SetGravaCabec(Value: Boolean);
begin
  FGravaCabec := Value;
end;

procedure TEstPromoEnt.SetIniciaEm(Value: TDateTime);
begin
  FIniciaEm := Value;
end;

procedure TEstPromoEnt.SetItemIndex(Value: integer);
begin
  FItemIndex := Value;
  if (FItemIndex < 0) or (FItemIndex >= FItems.Count) then
    FItemIndex := -1; // Reset to invalid index if out of bounds
end;

procedure TEstPromoEnt.SetNome(Value: string);
begin
  FNome := Value;
end;

procedure TEstPromoEnt.SetPromoId(Value: integer);
begin
  FPromoId := Value;
end;

procedure TEstPromoEnt.SetTerminaEm(Value: TDateTime);
begin
  FTerminaEm := Value;
end;

procedure TEstPromoEnt.Zerar;
begin
  LimparEnt;
end;

end.
