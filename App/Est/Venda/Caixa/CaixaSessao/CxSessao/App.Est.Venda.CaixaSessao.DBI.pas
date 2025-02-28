unit App.Est.Venda.CaixaSessao.DBI;

interface

uses Sis.DBI, FireDAC.Comp.Client, System.Classes,
  App.Est.Venda.Caixa.CaixaSessao, App.Est.Venda.CaixaSessaoRecord_u;

type
  ICaixaSessaoDBI = interface(IDBI)
    ['{1821EE74-8193-444D-B2C1-098DA1ABAD66}']
    function CaixaSessaoAbertoGet(pCaixaSessaoRec: TCaixaSessaoRec)
      : Boolean;

    function CaixaSessaoUltimoGet(pCaixaSessao: ICaixaSessao)
      : Boolean;

    function GetMensagem: string;
    property Mensagem: string read GetMensagem;

    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable;
      pCaixaSessao: ICaixaSessao);

    procedure PreenchaCxSessRelatorio(pLinhas: TStrings;
      pCaixaSessao: ICaixaSessao);
  end;

implementation

end.
