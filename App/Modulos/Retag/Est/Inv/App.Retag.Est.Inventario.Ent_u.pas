unit App.Retag.Est.Inventario.Ent_u;

interface

uses App.Retag.Est.Inventario.Ent, Sis.Types, App.Est.EstMovEnt_u, App.Loja,
  App.Retag.Est.InventarioItem, System.Generics.Collections, Sis.Sis.Constants,
  Sis.Entities.Types;

type
  TInventarioEnt = class(TEstMovEnt, IInventarioEnt)
  private
    FInventarioId: TId;

    function GetInventarioId: TId;
    procedure SetInventarioId(Value: TId);

  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    function GetItems: TList<IRetagInventarioItem>;
    procedure LimparEnt; override;
  public
    property InventarioId: TId read GetInventarioId write SetInventarioId;

    function GetCod(pSeparador: string = '-'): string;

    constructor Create( //
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pDtHDoc: TDateTime; //
      pEstMovCriadoEm: TDateTime; //

      pInventarioId: TId = 0; //

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

{ TInventarioEnt }

constructor TInventarioEnt.Create(pLoja: IAppLoja; pTerminalId: TTerminalId;
  pDtHDoc, pEstMovCriadoEm: TDateTime; pInventarioId: TId; pEstMovId: Int64;
  pEstMovFinalizado, pEstMovCancelado: Boolean;
  pEstMovAlteradoEm, pEstMovFinalizadoEm, pEstMovCanceladoEm: TDateTime);
begin
  inherited Create( //
    pLoja //
    , pTerminalId //
    , TEstMovTipo.emtipoInventario //
    , pDtHDoc //
    , pEstMovCriadoEm //
    , pEstMovId

    , pEstMovFinalizado //
    , pEstMovCancelado //
    , pEstMovAlteradoEm //
    , pEstMovFinalizadoEm //
    , pEstMovCanceladoEm //
    );

  FInventarioId := pInventarioId;
end;

function TInventarioEnt.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(Loja.Id, TerminalId, InventarioId, 'INV',
    pSeparador);
end;

function TInventarioEnt.GetInventarioId: TId;
begin
  Result := FInventarioId;
end;

function TInventarioEnt.GetItems: TList<IRetagInventarioItem>;
begin
  Result := TList<IRetagInventarioItem>(inherited Items);
end;

function TInventarioEnt.GetNomeEnt: string;
begin
  Result := 'Inventário';
end;

function TInventarioEnt.GetNomeEntAbrev: string;
begin
  Result := 'INV';
end;

function TInventarioEnt.GetTitulo: string;
begin
  Result := 'Inventários';
end;

procedure TInventarioEnt.LimparEnt;
begin
  inherited;
  if EditandoItem then
    exit;
  inherited;
  FInventarioId := 0;
end;

procedure TInventarioEnt.SetInventarioId(Value: TId);
begin
  FInventarioId := Value;
end;

end.
