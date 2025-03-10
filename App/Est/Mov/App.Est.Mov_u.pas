unit App.Est.Mov_u;

interface

uses App.Est.Mov, Sis.Entities.Types, App.Est.Types_u, Sis.Sis.Constants,
  System.Classes, App.Loja, System.Generics.Collections;

type
  TEstMov = class(TInterfacedObject, IEstMov<IInterface>)
  private
    FLoja: IAppLoja;
    FTerminalId: TTerminalId;
    FEstMovId: Int64;
    FEstMovTipo: TEstMovTipo;
    FDtHDoc: TDateTime;
    FFinalizado: Boolean;
    FCancelado: Boolean;
    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;
    FFinalizadoEm: TDateTime;
    FCanceladoEm: TDateTime;
    FItems: TList<IInterface>;

    function GetLoja: IAppLoja;

    procedure SetTerminalId(Value: TTerminalId);
    function GetTerminalId: TTerminalId;

    function GetEstMovId: Int64;
    procedure SetEstMovId(Value: Int64);

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

    function GetItems: TList<IInterface>;

  public
    property Loja: IAppLoja read GetLoja;
    property TerminalId: TTerminalId read GetTerminalId write SetTerminalId;
    property EstMovId: Int64 read GetEstMovId write SetEstMovId;
    property EstMovTipo: TEstMovTipo read GetEstMovTipo;
    property DtHDoc: TDateTime read GetDtHDoc write SetDtHDoc;
    property Finalizado: Boolean read GetFinalizado write SetFinalizado;
    property Cancelado: Boolean read GetCancelado write SetCancelado;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;
    property FinalizadoEm: TDateTime read GetFinalizadoEm write SetFinalizadoEm;
    property CanceladoEm: TDateTime read GetCanceladoEm write SetCanceladoEm;
    property Items: TList<IInterface> read GetItems;

    procedure Zerar; virtual;

    constructor Create(
      pLoja: IAppLoja; //
      pTerminalId: TTerminalId; //
      pEstMovTipo: TEstMovTipo; //
      pDtHDoc: TDateTime; //
      pCriadoEm: TDateTime; //

      pEstMovId: Int64 = 0; //
      pFinalizado: Boolean = False; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pFinalizadoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
    destructor Destroy; override;
  end;


implementation

{ TEstMov }

constructor TEstMov.Create(pLoja: IAppLoja; pTerminalId: TTerminalId;
  pEstMovTipo: TEstMovTipo; pDtHDoc, pCriadoEm: TDateTime; pEstMovId: Int64;
  pFinalizado, pCancelado: Boolean; pAlteradoEm, pFinalizadoEm,
  pCanceladoEm: TDateTime);
begin
  inherited Create;
  FLoja := pLoja;
  FTerminalId := pTerminalId;
  FEstMovTipo := pEstMovTipo;
  FDtHDoc := pDtHDoc;
  FCriadoEm := pCriadoEm;
  FEstMovId := pEstMovId;

  FFinalizado := pFinalizado;
  FCancelado := pCancelado;
  FAlteradoEm := pAlteradoEm;
  FFinalizadoEm := pFinalizadoEm;
  FCanceladoEm := pCanceladoEm;
  FItems := TList<IInterface>.Create;
end;

destructor TEstMov.Destroy;
begin
  FItems.Free;
  inherited;
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

function TEstMov.GetEstMovId: Int64;
begin
  Result := FEstMovId;
end;

function TEstMov.GetLoja: IAppLoja;
begin
  Result := FLoja;
end;

function TEstMov.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

function TEstMov.GetItems: TList<IInterface>;
begin
  Result := FItems;
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

procedure TEstMov.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

procedure TEstMov.Zerar;
begin
  FTerminalId := 0;
  FEstMovId := 0;
  FDtHDoc := DATA_ZERADA;
  FFinalizado := False;
  FCancelado := False;
  FCriadoEm := DATA_ZERADA;
  FAlteradoEm := DATA_ZERADA;
  FFinalizadoEm := DATA_ZERADA;
  FCanceladoEm := DATA_ZERADA;
end;

procedure TEstMov.SetEstMovId(Value: Int64);
begin
  FEstMovId := Value;
end;

end.
