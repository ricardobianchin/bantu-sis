unit App.Est.Venda.CaixaSessao.DBI;

interface

uses Sis.DBI, FireDAC.Comp.Client, System.Classes,
  App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.CaixaSessaoRecord_u,
  Sis.DB.DBTypes;

type
  ICaixaSessaoDBI = interface(IDBI)
    ['{1821EE74-8193-444D-B2C1-098DA1ABAD66}']
    function CaixaSessaoAbertoGet(var pCaixaSessaoRec: TCaixaSessaoRec)
      : Boolean;

    function CaixaSessaoPreencheComUltimo(pCaixaSessao: ICaixaSessao): Boolean;
    procedure PegDados(pCaixaSessao: ICaixaSessao);
    function GetMensagem: string;
    property Mensagem: string read GetMensagem;

    procedure PDVSessFormCarregarDataSet(pDMemTableMaster, pDMemTableItem,
      pDMemTablePag: TFDMemTable; pCaixaSessao: ICaixaSessao; pValues: variant;
      pCarregaDetail: Boolean = True);

    procedure PDVSessFormCarregarDataSetDetail(pDMemTableMaster, pDMemTableItem,
      pDMemTablePag: TFDMemTable; pDBConnection: IDBConnection = nil);

    procedure PreenchaCxSessRelatorio(pLinhas: TStrings;
      pCaixaSessao: ICaixaSessao);

    procedure PreencherPagamentoFormaFiltroSL(pSL: TStrings);
    procedure PreencherSessFiltroSL(pSL: TStrings);
  end;

implementation

end.
