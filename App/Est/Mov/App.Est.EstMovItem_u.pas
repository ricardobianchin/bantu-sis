unit App.Est.EstMovItem_u;

interface

uses App.Est.EstMovItem, Sis.Types, Sis.Sis.Constants, App.Est.Prod;

type
  TEstMovItem = class(TInterfacedObject, IEstMovItem)
  private
    FOrdem: SmallInt;
    FProd: IProd;
    FQtd: Currency;
    FCancelado: Boolean;
    FCriadoEm: TDateTime;
    FAlteradoEm: TDateTime;
    FCanceladoEm: TDateTime;

    function GetOrdem: SmallInt;

    function GetProd: IProd;

    function GetQtd: Currency;
    procedure SetQtd(Value: Currency);

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTime);

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);

    function GetCanceladoEm: TDateTime;
    procedure SetCanceladoEm(Value: TDateTime);
  public
    property Ordem: SmallInt read GetOrdem;
    property Prod: IProd read GetProd;
    property Qtd: Currency read GetQtd write SetQtd;
    property Cancelado: Boolean read GetCancelado write SetCancelado;
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;
    property CanceladoEm: TDateTime read GetCanceladoEm write SetCanceladoEm;

    constructor Create( //
      pOrdem: SmallInt; //
      pProd: IProd; //
      pQtd: Currency; //
      pCriadoEm: TDateTime; //
      pCancelado: Boolean = False; //
      pAlteradoEm: TDateTime = DATA_ZERADA; //
      pCanceladoEm: TDateTime = DATA_ZERADA //
      );
  end;

implementation

{ TEstMovItem }

constructor TEstMovItem.Create( //
  pOrdem: SmallInt; //
  pProd: IProd; //
  pQtd: Currency; //
  pCriadoEm: TDateTime; //
  pCancelado: Boolean; //
  pAlteradoEm: TDateTime; //
  pCanceladoEm: TDateTime //
  );
begin
  FOrdem := pOrdem;
  FProd := pProd;
  FQtd := pQtd;
  FCancelado := pCancelado;
  FCriadoEm := pCriadoEm;
  FAlteradoEm := pAlteradoEm;
  FCanceladoEm := pCanceladoEm;
end;

function TEstMovItem.GetAlteradoEm: TDateTime;
begin
  Result := FAlteradoEm;
end;

function TEstMovItem.GetCancelado: Boolean;
begin
  Result := FCancelado;
end;

function TEstMovItem.GetCanceladoEm: TDateTime;
begin
  Result := FCanceladoEm;
end;

function TEstMovItem.GetCriadoEm: TDateTime;
begin
  Result := FCriadoEm;
end;

function TEstMovItem.GetOrdem: SmallInt;
begin
  Result := FOrdem;
end;

function TEstMovItem.GetProd: IProd;
begin
  Result := FProd;
end;

function TEstMovItem.GetQtd: Currency;
begin
  Result := FQtd;
end;

procedure TEstMovItem.SetAlteradoEm(Value: TDateTime);
begin
  FAlteradoEm := Value;
end;

procedure TEstMovItem.SetCancelado(Value: Boolean);
begin
  FCancelado := Value;
end;

procedure TEstMovItem.SetCanceladoEm(Value: TDateTime);
begin
  FCanceladoEm := Value;
end;

procedure TEstMovItem.SetCriadoEm(Value: TDateTime);
begin
  FCriadoEm := Value;
end;

procedure TEstMovItem.SetQtd(Value: Currency);
begin
  FQtd := Value;
end;

end.
