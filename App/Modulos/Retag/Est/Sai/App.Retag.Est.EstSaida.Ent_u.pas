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
    FSaidaMotivoDescr: string;

    function GetEstSaidaId: TId;
    procedure SetEstSaidaId(Value: TId);

    function GetEstSaidaMotivoDescr: string;
    procedure SetEstSaidaMotivoDescr(Value: string);

    function GetSaidaMotivoId: TId;
    procedure SetSaidaMotivoId(Value: TId);
  protected
    function GetNomeEnt: string; override;
    function GetNomeEntAbrev: string; override;
    function GetTitulo: string; override;

    function GetItems: TList<IRetagEstSaidaItem>;
    procedure LimparEnt; override;
  public
    property EstSaidaId: TId read GetEstSaidaId write SetEstSaidaId;
    property SaidaMotivoId: TId read GetSaidaMotivoId write SetSaidaMotivoId;
    property SaidaMotivoDescr: string read GetEstSaidaMotivoDescr
      write SetEstSaidaMotivoDescr;

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

function TEstSaidaEnt.GetEstSaidaMotivoDescr: string;
begin
  Result := FSaidaMotivoDescr;
end;

function TEstSaidaEnt.GetEstSaidaId: TId;
begin
  Result := FEstSaidaId;
end;

function TEstSaidaEnt.GetItems: TList<IRetagEstSaidaItem>;
begin
  Result := TList<IRetagEstSaidaItem>(inherited Items);
end;

function TEstSaidaEnt.GetNomeEnt: string;
begin
  Result := 'Saída';
end;

function TEstSaidaEnt.GetNomeEntAbrev: string;
begin
  Result := 'EstSai';
end;

function TEstSaidaEnt.GetSaidaMotivoId: TId;
begin
  Result := FSaidaMotivoId;
end;

function TEstSaidaEnt.GetTitulo: string;
begin
  Result := 'Saídas';
end;

procedure TEstSaidaEnt.SetEstSaidaMotivoDescr(Value: string);
begin
  FSaidaMotivoDescr := Value;
end;

procedure TEstSaidaEnt.SetEstSaidaId(Value: TId);
begin
  FEstSaidaId := Value;
end;

procedure TEstSaidaEnt.SetSaidaMotivoId(Value: TId);
begin
  FSaidaMotivoId := Value;
end;

procedure TEstSaidaEnt.LimparEnt;
begin
  if EditandoItem then
    exit;
  inherited;
  FEstSaidaId := 0;
  FSaidaMotivoId := 0;
  FSaidaMotivoDescr := 'NAO INDICADO';
end;

end.
