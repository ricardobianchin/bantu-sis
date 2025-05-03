unit App.Retag.Est.EstSaida.Ent_u;

interface

uses App.Retag.Est.EstSaida.Ent, Sis.Types, App.Est.EstMovEnt_u, App.Loja,
  App.Retag.Est.EstSaidaItem, System.Generics.Collections, Sis.Sis.Constants,
  Sis.Entities.Types;

type
  TEstSaidaEnt = class(TEstMovEnt, IEstSaidaEnt)
  private
    FEstSaidaId: TId;
    FSaidaMotivoId: TId;

    function GetEstSaidaId: TId;
    procedure SetEstSaidaId(Value: TId);

    function GetSaidaMotivoId: TId;
    procedure SetSaidaMotivoId(Value: TId);
  protected
    function GetItems: TList<IRetagEstSaidaItem>;
  public
    property EstSaidaId: TId read GetEstSaidaId write SetEstSaidaId;
    property SaidaMotivoId: TId read GetSaidaMotivoId write SetSaidaMotivoId;

    function GetCod(pSeparador: string = '-'): string;

    constructor Create( //
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pDtHDoc: TDateTime; //
      pEstMovCriadoEm: TDateTime; //

      pEstSaidaId: TId = 0; //
      pSaidaMotivoId: TId = 0; //

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

{ TEstSaidaEnt }

constructor TEstSaidaEnt.Create(pLoja: IAppLoja; pTerminalId: TTerminalId;
  pDtHDoc, pEstMovCriadoEm: TDateTime; pEstSaidaId, pSaidaMotivoId: TId;
  pEstMovId: Int64; pEstMovFinalizado, pEstMovCancelado: Boolean;
  pEstMovAlteradoEm, pEstMovFinalizadoEm, pEstMovCanceladoEm: TDateTime);
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

  FEstSaidaId := pEstSaidaId;
  FSaidaMotivoId := pSaidaMotivoId;
end;

function TEstSaidaEnt.GetCod(pSeparador: string): string;
begin
  Result := Sis.Entities.Types.GetCod(Loja.Id, TerminalId, EstSaidaId, 'SAI',
    pSeparador);
end;

function TEstSaidaEnt.GetEstSaidaId: TId;
begin
  Result := FEstSaidaId;
end;

function TEstSaidaEnt.GetItems: TList<IRetagEstSaidaItem>;
begin
  Result := TList<IRetagEstSaidaItem>(inherited Items);
end;

function TEstSaidaEnt.GetSaidaMotivoId: TId;
begin
  Result := FSaidaMotivoId;
end;

procedure TEstSaidaEnt.SetEstSaidaId(Value: TId);
begin
  FEstSaidaId := Value;
end;

procedure TEstSaidaEnt.SetSaidaMotivoId(Value: TId);
begin
  FSaidaMotivoId := Value;
end;

end.
