unit App.Est.Promo_u;

interface

uses Sis.Types, App.Est.Prod, System.Generics.Collections, Sis.Entities.Types,
  App.Est.Promo, App.Est.PromoItem, App.Loja, Sis.Sis.Constants;

type
  TEstPromo = class(TInterfacedObject, IEstPromo)
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
    procedure LimparEnt;
  protected

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

    function GetLastActiveItemIndex: integer;

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

{ TEstPromo }

constructor TEstPromo.Create(pLoja: IAppLoja; pPromoId: integer; pNome: string;
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

destructor TEstPromo.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TEstPromo.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

function TEstPromo.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(FLoja.Id, 0, PromoId, 'PROMO',
    pSeparador);
end;

function TEstPromo.GetEditandoItem: Boolean;
begin
  Result := FEditandoItem;
end;

function TEstPromo.GetIniciaEm: TDateTime;
begin
  Result := FIniciaEm;
end;

function TEstPromo.GetItemIndex: integer;
begin
  Result := FItemIndex;
end;

function TEstPromo.GetItems: TList<IEstPromoItem>;
begin
  Result := FItems;
//  Result := TList<IEstPromoItem>(Items);
end;

function TEstPromo.GetLastActiveItemIndex: integer;
begin
  Result := -1;
  for var i := FItems.Count - 1 downto 0 do
  begin
    if FItems[i].Ativo then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TEstPromo.GetLoja: IAppLoja;
begin
  Result := FLoja;
end;

function TEstPromo.GetNome: string;
begin
  Result := FNome;
end;

function TEstPromo.GetPromoId: integer;
begin
  Result := FPromoId;
end;

function TEstPromo.GetTerminaEm: TDateTime;
begin
  Result := FTerminaEm;
end;

procedure TEstPromo.LimparEnt;
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

  FItems.Clear;
end;

procedure TEstPromo.SetAtivo(Value: Boolean);
begin
  FAtivo := Value;
end;

procedure TEstPromo.SetEditandoItem(Value: Boolean);
begin
  FEditandoItem := Value;
end;

procedure TEstPromo.SetIniciaEm(Value: TDateTime);
begin
  FIniciaEm := Value;
end;

procedure TEstPromo.SetItemIndex(Value: integer);
begin
  FItemIndex := Value;
  if (FItemIndex < 0) or (FItemIndex >= FItems.Count) then
    FItemIndex := -1; // Reset to invalid index if out of bounds
end;

procedure TEstPromo.SetNome(Value: string);
begin
  FNome := Value;
end;

procedure TEstPromo.SetPromoId(Value: integer);
begin
  FPromoId := Value;
end;

procedure TEstPromo.SetTerminaEm(Value: TDateTime);
begin
  FTerminaEm := Value;
end;

procedure TEstPromo.Zerar;
begin
  LimparEnt;
end;

end.
