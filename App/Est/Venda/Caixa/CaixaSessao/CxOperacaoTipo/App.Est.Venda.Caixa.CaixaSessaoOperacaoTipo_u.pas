unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo_u;

interface

uses App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo, System.Actions, Vcl.ActnList,
  App.Est.Venda.Caixa.CaixaSessao.Utils_u;

type
  TCxOperacaoTipo = class(TInterfacedObject, ICxOperacaoTipo)
  private
    FId: TCxOpTipo;
    FName: string;
    FAbrev: string;
    FCaption: string;
    FHint: string;
    FSinalNumerico: SmallInt;
    FHabilitadoDuranteSessao: Boolean;
    FAction: TAction;

    function GetId: TCxOpTipo;
    procedure SetId(Value: TCxOpTipo);

    function GetName: string;
    procedure SetName(const Value: string);

    function GetAbrev: string;
    procedure SetAbrev(const Value: string);

    function GetCaption: string;
    procedure SetCaption(const Value: string);

    function GetHint: string;
    procedure SetHint(const Value: string);

    procedure SetHabilitadoDuranteSessao(Value: Boolean);
    function GetHabilitadoDuranteSessao: Boolean;

    function GetSinalNumerico: SmallInt;
    procedure SetSinalNumerico(Value: SmallInt);

    function GetAction: TAction;
    procedure SetAction(Value: TAction);

  public
    property Id: TCxOpTipo read GetId write SetId;
    property Name: string read GetName write SetName;
    property Abrev: string read GetAbrev write SetAbrev;
    property Caption: string read GetCaption write SetCaption;
    property Hint: string read GetHint write SetHint;
    property HabilitadoDuranteSessao: Boolean read GetHabilitadoDuranteSessao
      write SetHabilitadoDuranteSessao;
    property SinalNumerico: SmallInt read GetSinalNumerico
      write SetSinalNumerico;
    property Action: TAction read GetAction write SetAction;
    constructor Create(pIdChar: string; pName: string; pAbrev: string;pCaption: string;
      pHint: string; pSinalNumerico: SmallInt;
      pHabilitadoDuranteSessao: Boolean);
  end;

implementation

{ TCxOperacaoTipo }

constructor TCxOperacaoTipo.Create(pIdChar: string; pName: string;pAbrev: string;
  pCaption: string; pHint: string; pSinalNumerico: SmallInt;
  pHabilitadoDuranteSessao: Boolean);
begin
  FId.FromString(pIdChar);
  FName := pName;
  FAbrev := pAbrev;
  FHint := pHint;
  FCaption := pCaption;
  FSinalNumerico := pSinalNumerico;
  FHabilitadoDuranteSessao := pHabilitadoDuranteSessao;
end;

function TCxOperacaoTipo.GetAbrev: string;
begin
  Result := FAbrev;
end;

function TCxOperacaoTipo.GetAction: TAction;
begin
  Result := FAction;
end;

function TCxOperacaoTipo.GetCaption: string;
begin
  Result := FCaption;
end;

function TCxOperacaoTipo.GetHabilitadoDuranteSessao: Boolean;
begin
  Result := FHabilitadoDuranteSessao;
end;

function TCxOperacaoTipo.GetHint: string;
begin
  Result := FHint;
end;

function TCxOperacaoTipo.GetId: TCxOpTipo;
begin
  Result := FId;
end;

function TCxOperacaoTipo.GetName: string;
begin
  Result := FName;
end;

function TCxOperacaoTipo.GetSinalNumerico: SmallInt;
begin
  Result := FSinalNumerico;
end;

procedure TCxOperacaoTipo.SetAbrev(const Value: string);
begin
  FAbrev := Value;
end;

procedure TCxOperacaoTipo.SetAction(Value: TAction);
begin
  FAction := Value;
end;

procedure TCxOperacaoTipo.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TCxOperacaoTipo.SetHabilitadoDuranteSessao(Value: Boolean);
begin
  FHabilitadoDuranteSessao := Value;
end;

procedure TCxOperacaoTipo.SetHint(const Value: string);
begin
  FHint := Value;
end;

procedure TCxOperacaoTipo.SetId(Value: TCxOpTipo);
begin
  FId := Value;
end;

procedure TCxOperacaoTipo.SetName(const Value: string);
begin
  FName := Value;
end;

procedure TCxOperacaoTipo.SetSinalNumerico(Value: SmallInt);
begin
  FSinalNumerico := Value;
end;

end.
