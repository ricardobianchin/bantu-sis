unit App.Retag.Fin.PagForma.Ent;

interface

uses App.Ent.Ed.Id.Descr, App.FIn.PagFormaTipo;

type
  IPagFormaEnt = interface(IEntIdDescr)
    ['{E3652AF8-CC37-4992-892B-BB8C71B9750E}']

    function GetPagFormaTipo: IPagFormaTipo;
    property PagFormaTipo: IPagFormaTipo read GetPagFormaTipo;

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);
    property DescrRed: string read GetDescrRed write SetDescrRed;

    function GetParaVenda: boolean;
    procedure SetParaVenda(Value: boolean);
    property ParaVenda: boolean read GetParaVenda write SetParaVenda;

    function GetAtivo: boolean;
    procedure SetAtivo(Value: boolean);
    property Ativo: boolean read GetAtivo write SetAtivo;

    function GetSis: boolean;
    procedure SetSis(Value: boolean);
    property Sis: boolean read GetSis write SetSis;

    function GetPromocaoPermite: boolean;
    procedure SetPromocaoPermite(Value: boolean);
    property PromocaoPermite: boolean read GetPromocaoPermite write SetPromocaoPermite;

    function GetComicaoPermite: boolean;
    procedure SetComicaoPermite(Value: boolean);
    property ComicaoPermite: boolean read GetComicaoPermite write SetComicaoPermite;

    function GetTaxaAdmPerc: Currency;
    procedure SetTaxaAdmPerc(Value: Currency);
    property TaxaAdmPerc: Currency read GetTaxaAdmPerc write SetTaxaAdmPerc;

    function GetVendaMinima: Currency;
    procedure SetVendaMinima(Value: Currency);
    property VendaMinima: Currency read GetVendaMinima write SetVendaMinima;

    function GetComissaoAbaterPerc: Currency;
    procedure SetComissaoAbaterPerc(Value: Currency);
    property ComissaoAbaterPerc: Currency read GetComissaoAbaterPerc write SetComissaoAbaterPerc;

    function GetReembolsoDias: smallint;
    procedure SetReembolsoDias(Value: smallint);
    property ReembolsoDias: smallint read GetReembolsoDias write SetReembolsoDias;

    function GetTEFUsa: boolean;
    procedure SetTEFUsa(Value: boolean);
    property TEFUsa: boolean read GetTEFUsa write SetTEFUsa;

    function GetAutorizacaoExige: boolean;
    procedure SetAutorizacaoExige(Value: boolean);
    property AutorizacaoExige: boolean read GetAutorizacaoExige write SetAutorizacaoExige;

    function GetPessoaExige: boolean;
    procedure SetPessoaExige(Value: boolean);
    property PessoaExige: boolean read GetPessoaExige write SetPessoaExige;

    function GetAVista: boolean;
    procedure SetAVista(Value: boolean);
    property AVista: boolean read GetAVista write SetAVista;
  end;

implementation

end.
