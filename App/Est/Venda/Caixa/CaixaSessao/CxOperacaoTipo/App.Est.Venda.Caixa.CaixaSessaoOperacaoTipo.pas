unit App.Est.Venda.Caixa.CaixaSessaoOperacaoTipo;

interface

uses App.Est.Venda.Caixa.CaixaSessao.Utils_u, Vcl.ActnList;

type
  ICxOperacaoTipo = interface(IInterface)
    ['{70A99376-ED84-40CC-AB88-F4F00680B915}']
    function GetId: TCxOpTipo;
    procedure SetId(Value: TCxOpTipo);
    property Id: TCxOpTipo read GetId write SetId;

    function GetName: string;
    procedure SetName(const Value: string);
    property Name: string read GetName write SetName;

    function GetAbrev: string;
    procedure SetAbrev(const Value: string);
    property Abrev: string read GetAbrev write SetAbrev;

    function GetCaption: string;
    procedure SetCaption(const Value: string);
    property Caption: string read GetCaption write SetCaption;

    function GetHint: string;
    procedure SetHint(const Value: string);
    property Hint: string read GetHint write SetHint;

    function GetHabilitadoDuranteSessao: Boolean;
    procedure SetHabilitadoDuranteSessao(Value: Boolean);
    property HabilitadoDuranteSessao: Boolean read GetHabilitadoDuranteSessao
      write SetHabilitadoDuranteSessao;

    function GetSinalNumerico: SmallInt;
    procedure SetSinalNumerico(Value: SmallInt);
    property SinalNumerico: SmallInt read GetSinalNumerico
      write SetSinalNumerico;

    function GetAction: TAction;
    procedure SetAction(Value: TAction);
    property Action: TAction read GetAction write SetAction;
  end;

implementation

end.
