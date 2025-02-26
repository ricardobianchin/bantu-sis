unit App.Est.Venda.CaixaSessao.DBI;

interface

uses Sis.DBI, App.Est.Venda.CaixaSessaoRecord_u, FireDAC.Comp.Client;

type
  ICaixaSessaoDBI = interface(IDBI)
    ['{1821EE74-8193-444D-B2C1-098DA1ABAD66}']
    function CaixaSessaoAbertoGet(var pCaixaSessaoRec: TCaixaSessaoRec): Boolean;

    function GetMensagem: string;
    property Mensagem: string read GetMensagem;
    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable);
  end;

implementation

end.
