unit App.Est.EstMovEnt_u;

interface

uses App.Est.EstMovEnt, Sis.Entities.Types, App.Est.Types_u, Sis.Sis.Constants,
  System.Classes, App.Loja, System.Generics.Collections, App.Est.EstMovItem, App.Ent.Ed_u;

type
  TEstMovEnt = class(TEntEd, IEstMovEnt<IEstMovItem>)
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
    FItems: TList<IEstMovItem>;
    FLogStr: string;
    FEditandoItem: Boolean;
    FItemIndex: integer;

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

    function GetItems: TList<IEstMovItem>;

    function GetLogStr: string;
    procedure SetLogStr(Value: string);

    function GetEditandoItem: Boolean;
    procedure SetEditandoItem(Value: Boolean);

    function GetItemIndex: integer;
    procedure SetItemIndex(Value: integer);

  protected

  public
    procedure Zerar; virtual;
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
    property Items: TList<IEstMovItem> read GetItems;

    property LogStr: string read GetLogStr write SetLogStr;
    property EditandoItem: Boolean read GetEditandoItem write SetEditandoItem;
    property ItemIndex: integer read GetItemIndex write SetItemIndex;

    procedure LimparEnt; override;

    function GetLastActiveItemIndex: integer;

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

uses Data.DB, Sis.Types;

{ TEstMovEnt }

constructor TEstMovEnt.Create(pLoja: IAppLoja; pTerminalId: TTerminalId;
  pEstMovTipo: TEstMovTipo; pDtHDoc, pCriadoEm: TDateTime; pEstMovId: Int64;
  pFinalizado, pCancelado: Boolean; pAlteradoEm, pFinalizadoEm,
  pCanceladoEm: TDateTime);
begin
  inherited Create(dsBrowse);
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
  FItems := TList<IEstMovItem>.Create;
end;

destructor TEstMovEnt.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TEstMovEnt.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
end;

function TEstMovEnt.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

function TEstMovEnt.GetCanceladoEm: TDateTime;
begin
  Result := FCanceladoEm;
end;

function TEstMovEnt.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TEstMovEnt.GetDtHDoc: TDateTime;
begin
  Result := FDtHDoc;
end;

function TEstMovEnt.GetEstMovTipo: TEstMovTipo;
begin
  Result := FEstMovTipo;
end;

function TEstMovEnt.GetFinalizado: Boolean;
begin
  Result := FFinalizado;
end;

function TEstMovEnt.GetFinalizadoEm: TDateTime;
begin
  Result := FFinalizadoEm;
end;

function TEstMovEnt.GetEditandoItem: Boolean;
begin
  Result := FEditandoItem;
end;

function TEstMovEnt.GetEstMovId: Int64;
begin
  Result := FEstMovId;
end;

function TEstMovEnt.GetLastActiveItemIndex: integer;
begin
{percorre a lista do ultimo para o primeiro, procurando o primeiro item
  que não esteja cancelado ou finalizado, e retorna o índice desse item.}
  Result := -1;
  for var i := FItems.Count - 1 downto 0 do
  begin
    if not FItems[i].Cancelado then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TEstMovEnt.GetLogStr: string;
begin
  Result := FLogStr;
end;

function TEstMovEnt.GetLoja: IAppLoja;
begin
  Result := FLoja;
end;

function TEstMovEnt.GetTerminalId: TTerminalId;
begin
  Result := FTerminalId;
end;

procedure TEstMovEnt.LimparEnt;
begin
  if EditandoItem then
    exit;
  inherited;
  FTerminalId := 0;
  FEstMovId := 0;
  FDtHDoc := DATA_ZERADA;
  FFinalizado := False;
  FCancelado := False;
  FCriadoEm := DATA_ZERADA;
  FAlteradoEm := DATA_ZERADA;
  FFinalizadoEm := DATA_ZERADA;
  FCanceladoEm := DATA_ZERADA;
  FItems.Clear;
end;

function TEstMovEnt.GetItemIndex: integer;
begin
  Result := FItemIndex;
end;

function TEstMovEnt.GetItems: TList<IEstMovItem>;
begin
  Result := FItems;
end;

procedure TEstMovEnt.SetAlteradoEm(Value: TDateTime);
begin
  FAlteradoEm := Value;
end;

procedure TEstMovEnt.SetCancelado(Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TEstMovEnt.SetCanceladoEm(Value: TDateTime);
begin
  FCanceladoEm := Value;
end;

procedure TEstMovEnt.SetCriadoEm(Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TEstMovEnt.SetDtHDoc(Value: TDateTime);
begin
  FDtHDoc := Value;
end;

procedure TEstMovEnt.SetFinalizado(Value: Boolean);
begin
  FFinalizado := Value;
end;

procedure TEstMovEnt.SetFinalizadoEm(Value: TDateTime);
begin
  FFinalizadoEm := Value;
end;

procedure TEstMovEnt.SetItemIndex(Value: integer);
begin
  FItemIndex := Value;
end;

procedure TEstMovEnt.SetLogStr(Value: string);
begin
  FLogStr := Value;
end;

procedure TEstMovEnt.SetTerminalId(Value: TTerminalId);
begin
  FTerminalId := Value;
end;

procedure TEstMovEnt.Zerar;
begin
  LimparEnt;
end;

procedure TEstMovEnt.SetEditandoItem(Value: Boolean);
begin
  FEditandoItem := Value;
end;

procedure TEstMovEnt.SetEstMovId(Value: Int64);
begin
  FEstMovId := Value;
end;

end.
