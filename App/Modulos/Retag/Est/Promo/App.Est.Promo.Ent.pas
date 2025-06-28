unit App.Est.Promo.Ent;

interface

uses Sis.Types, App.Ent.Ed, System.Generics.Collections, Sis.Entities.Types,
  App.Est.PromoItem, App.Loja;

type
  IEstPromoEnt = interface(IEntEd)
    ['{16A78AC6-43B2-426D-9AF9-E7DC115BF9B7}']
    function GetLoja: IAppLoja;
    property Loja: IAppLoja read GetLoja;

    function GetPromoId: integer;
    procedure SetPromoId(Value: integer);
    property PromoId: integer read GetPromoId write SetPromoId;

    function GetCod(pSeparador: string = '-'): string;

    function GetNome: string;
    procedure SetNome(Value: string);
    property Nome: string read GetNome write SetNome;

    function GetAtivo: Boolean;
    procedure SetAtivo(Value: Boolean);
    property Ativo: Boolean read GetAtivo write SetAtivo;

    function GetIniciaEm: TDateTime;
    procedure SetIniciaEm(Value: TDateTime);
    property IniciaEm: TDateTime read GetIniciaEm write SetIniciaEm;

    function GetTerminaEm: TDateTime;
    procedure SetTerminaEm(Value: TDateTime);
    property TerminaEm: TDateTime read GetTerminaEm write SetTerminaEm;

    function GetItems: TList<IEstPromoItem>;
    property Items: TList<IEstPromoItem> read GetItems;

    function GetEditandoItem: Boolean;
    procedure SetEditandoItem(Value: Boolean);
    property EditandoItem: Boolean read GetEditandoItem write SetEditandoItem;

    function GetItemIndex: integer;
    procedure SetItemIndex(Value: integer);
    property ItemIndex: integer read GetItemIndex write SetItemIndex;

  end;

implementation

end.
