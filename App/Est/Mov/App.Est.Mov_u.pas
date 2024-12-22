unit App.Est.Mov_u;

interface

uses App.Est.Mov, Sis.Entities.Types, App.Est.Types_u, Sis.Sis.Constants;

type
  TEstMov = class(TInterfacedObject, IEstMov)
  private
    FLojaId: TLojaId;
    FTerminalId: TTerminalId;
    FId: Int64;
    FEstMovTipo: TEstMovTipo;
    FDtHDoc: TDateTime;
    FFinalizado: Boolean;
    FCancelado: Boolean;
    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;
    FFinalizadoEm: TDateTime;
    FCanceladoEm: TDateTime;

    function GetLojaId: TLojaId;
    function GetTerminalId: TTerminalId;

    function GetId: Int64;
    procedure SetId(Value: Int64);

    function GetEstMovTipo: TEstMovTipo;

    function GetDtHDoc: TDateTime;
    procedure SetDtHDoc(Value: TDateTime);

    function GetFinalizado: Boolean;
    procedure SetFinalizado(Value: Boolean);

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTime);

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);

    function GetFinalizadoEm: TDateTime;
    procedure SetFinalizadoEm(Value: TDateTime);

    function GetCanceladoEm: TDateTime;
    procedure SetCanceladoEm(Value: TDateTime);

  public
    property LojaId: TLojaId read GetLojaId;
    property TerminalId: TTerminalId read GetTerminalId;
    property Id: Int64 read GetId write SetId;
    property EstMovTipo: TEstMovTipo read GetEstMovTipo;
    property DtHDoc: TDateTime read GetDtHDoc write SetDtHDoc;
    property Finalizado: Boolean read GetFinalizado write SetFinalizado;
    property Cancelado: Boolean read GetCancelado write SetCancelado;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;
    property FinalizadoEm: TDateTime read GetFinalizadoEm write SetFinalizadoEm;
    property CanceladoEm: TDateTime read GetCanceladoEm write SetCanceladoEm;

    constructor Create(
      pLojaId: TLojaId; //
      pTerminalId: TTerminalId; //
      pEstMovTipo: TEstMovTipo; //
      pDtHDoc: TDateTime; //
      pCriadoEm: TDateTime; //

      pId: Int64 = 0; //
      pFinalizado: Boolean = False; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pFinalizadoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;


implementation

{ TEstMov }

constructor TEstMov.Create(pLojaId: TLojaId; pTerminalId: TTerminalId;
  pEstMovTipo: TEstMovTipo; pDtHDoc, pCriadoEm: TDateTime; pId: Int64;
  pFinalizado, pCancelado: Boolean; pAlteradoEm, pFinalizadoEm,
  pCanceladoEm: TDateTime);
begin
  FLojaId := pLojaId;
  FTerminalId := pTerminalId;
  FEstMovTipo := pEstMovTipo;
  FDtHDoc := pDtHDoc;
  FCriadoEm := pCriadoEm;
  FId := pId;

  FFinalizado := pFinalizado;
  FCancelado := pCancelado;
  FAlteradoEm := pAlteradoEm;
  FFinalizadoEm := pFinalizadoEm;
  FCanceladoEm := pCanceladoEm;
end;

function TEstMov.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
end;

function TEstMov.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

function TEstMov.GetCanceladoEm: TDateTime;
begin
  Result := FCanceladoEm;
end;

function TEstMov.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TEstMov.GetDtHDoc: TDateTime;
begin
  Result := FDtHDoc;
end;

function TEstMov.GetEstMovTipo: TEstMovTipo;
begin
  Result := FEstMovTipo;
end;

function TEstMov.GetFinalizado: Boolean;
begin
  Result := FFinalizado;
end;

function TEstMov.GetFinalizadoEm: TDateTime;
begin
  Result := FFinalizadoEm;
end;

function TEstMov.GetId: Int64;
begin
  Result := FId;
end;

function TEstMov.GetLojaId: TLojaId;
begin
  Result := FLojaId;
end;

function TEstMov.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TEstMov.SetAlteradoEm(Value: TDateTime);
begin
  FAlteradoEm := Value;
end;

procedure TEstMov.SetCancelado(Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TEstMov.SetCanceladoEm(Value: TDateTime);
begin
  FCanceladoEm := Value;
end;

procedure TEstMov.SetCriadoEm(Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TEstMov.SetDtHDoc(Value: TDateTime);
begin
  FDtHDoc := Value;
end;

procedure TEstMov.SetFinalizado(Value: Boolean);
begin
  FFinalizado := Value;
end;

procedure TEstMov.SetFinalizadoEm(Value: TDateTime);
begin
  FFinalizadoEm := Value;
end;

procedure TEstMov.SetId(Value: Int64);
begin
  FId := Value;
end;

end.
