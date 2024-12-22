unit App.Est.MoviItem;

interface

uses Sis.Types;

type
  IEstMovItem = interface(IInterface)
    ['{E19547F3-74A8-4CDD-ABCB-D9B7231AAA43}']
    function GetOrdem: SmallInt;
    property Ordem: SmallInt read GetOrdem;

    function GetProdId: TId;
    property ProdId: TId read GetProdId;

    function GetQtd: Currency;
    procedure SetQtd(Value: Currency);
    property Qtd: Currency read GetQtd write SetQtd;

    function GetCancelado: Boolean;
    procedure SetCancelado(Value: Boolean);
    property Cancelado: Boolean read GetCancelado write SetCancelado;

    function GetCriadoEm: TDateTime;
    procedure SetCriadoEm(Value: TDateTime);
    property CriadoEm: TDateTime read GetCriadoEm write SetCriadoEm;

    function GetAlteradoEm: TDateTime;
    procedure SetAlteradoEm(Value: TDateTime);
    property AlteradoEm: TDateTime read GetAlteradoEm write SetAlteradoEm;

    function GetCanceladoEm: TDateTime;
    procedure SetCanceladoEm(Value: TDateTime);
    property CanceladoEm: TDateTime read GetCanceladoEm write SetCanceladoEm;
  end;

implementation

end.
