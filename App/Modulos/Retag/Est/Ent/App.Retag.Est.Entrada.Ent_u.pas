unit App.Retag.Est.Entrada.Ent_u;

interface

uses App.Retag.Est.Entrada.Ent, Sis.Types, App.Est.EstMovEnt_u, App.Loja,
  App.Retag.Est.EntradaItem, System.Generics.Collections, Sis.Sis.Constants,
  Sis.Entities.Types;

type
  TEntradaEnt = class(TEstMovEnt, IEntradaEnt)
  private
    FEntradaId: TId;
    FNDoc: integer;
    FSerie: SmallInt;
    FFornecedorId: TId;
    FFornecedorApelido: string;

    function GetEntradaId: TId;
    procedure SetEntradaId(Value: TId);

    function GetNDoc: integer;
    procedure SetNDoc(Value: integer);

    function GetSerie: SmallInt;
    procedure SetSerie(Value: SmallInt);

    function GetFornecedorId: TId;
    procedure SetFornecedorId(Value: TId);

    function GetFornecedorApelido: string;
    procedure SetFornecedorApelido(Value: string);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    function GetItems: TList<IRetagEntradaItem>;
    procedure LimparEnt; override;
  public
    property EntradaId: TId read GetEntradaId write SetEntradaId;
    property NDoc: integer read GetNDoc write SetNDoc;
    property Serie: SmallInt read GetSerie write SetSerie;
    property FornecedorId: TId read GetFornecedorId write SetFornecedorId;
    property FornecedorApelido: string read GetFornecedorApelido
      write SetFornecedorApelido;

    function GetCod(pSeparador: string = '-'): string;

    constructor Create( //
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pDtHDoc: TDateTime; //
      pEstMovCriadoEm: TDateTime; //

      pEntradaId: TId = 0; //
      pNDoc: integer = 0; //
      pSerie: SmallInt = 0; //
      pFornecedorId: TId = 0; //
      pFornecedorApelido: string = ''; //

      pEstMovId: Int64 = 0; //
      pEstMovFinalizado: Boolean = False; //
      pEstMovCancelado: Boolean = False; //
      pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
      pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
      pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

uses App.Est.Types_u;

{ TEntradaEnt }

constructor TEntradaEnt.Create( //
  pLoja: IAppLoja; //
  pTerminalId: TTerminalId; //
  pDtHDoc: TDateTime; //
  pEstMovCriadoEm: TDateTime; //

  pEntradaId: TId = 0; //
  pNDoc: integer = 0; //
  pSerie: SmallInt = 0; //
  pFornecedorId: TId = 0; //
  pFornecedorApelido: string = ''; //

  pEstMovId: Int64 = 0; //
  pEstMovFinalizado: Boolean = False; //
  pEstMovCancelado: Boolean = False; //
  pEstMovAlteradoEm: TDateTime = DATA_ZERADA; //
  pEstMovFinalizadoEm: TDateTime = DATA_ZERADA; //
  pEstMovCanceladoEm: TDateTime = DATA_ZERADA //
  );
begin
  inherited Create( //
    pLoja //
    , pTerminalId //
    , TEstMovTipo.emtipoSaida //
    , pDtHDoc //
    , pEstMovCriadoEm //
    , pEstMovId

    , pEstMovFinalizado //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovFinalizadoEm //
    , pEstMovCanceladoEm //
    );

  FEntradaId := pEntradaId;
  FNDoc := pNDoc;
  FSerie := pSerie;
  FFornecedorId := pFornecedorId;
  FFornecedorApelido := pFornecedorApelido;
end;

function TEntradaEnt.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(Loja.Id, TerminalId, EntradaId, 'ENT',
    pSeparador);
end;

function TEntradaEnt.GetEntradaId: TId;
begin
  Result := FEntradaId;
end;

function TEntradaEnt.GetFornecedorApelido: string;
begin
  Result := FFornecedorApelido;
end;

function TEntradaEnt.GetFornecedorId: TId;
begin
  Result := FFornecedorId;
end;

function TEntradaEnt.GetItems: TList<IRetagEntradaItem>;
begin
  Result := TList<IRetagEntradaItem>(inherited Items);
end;

function TEntradaEnt.GetNDoc: integer;
begin
  Result := FNDoc;
end;

function TEntradaEnt.GetNomeEnt: string;
begin
  Result := 'Entrada';
end;

function TEntradaEnt.GetNomeEntAbrev: string;
begin
  Result := 'ENT';
end;

function TEntradaEnt.GetSerie: SmallInt;
begin
  Result := FSerie;
end;

function TEntradaEnt.GetTitulo: string;
begin
  Result := 'Entradas';
end;

procedure TEntradaEnt.LimparEnt;
begin
  if EditandoItem then
    exit;
  inherited;
  FEntradaId := 0;
  FNDoc := 0;
  FSerie := 0;
  FFornecedorId := 0;
  FFornecedorApelido := '';
end;

procedure TEntradaEnt.SetEntradaId(Value: TId);
begin
  FEntradaId := Value;
end;

procedure TEntradaEnt.SetFornecedorApelido(Value: string);
begin
  FFornecedorApelido := Value;
end;

procedure TEntradaEnt.SetFornecedorId(Value: TId);
begin
  FFornecedorId := Value;
end;

procedure TEntradaEnt.SetNDoc(Value: integer);
begin
  FNDoc := Value;
end;

procedure TEntradaEnt.SetSerie(Value: SmallInt);
begin
  FSerie := Value;
end;

end.
