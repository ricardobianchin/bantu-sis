unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI;

interface

uses App.Ent.DBI, System.Classes, FireDAC.Comp.Client;

type
  ICxOperacaoDBI = interface(IEntDBI)
    ['{6742C994-0B43-4BBC-B2F1-46DE0D0353F2}']
    procedure FecharPodeGet(out pPode: Boolean; out pMensagem: string);
    procedure PreencherPagamentoFormaDataSet(pDMemTable1: TFDMemTable);
    procedure PDVCarregarDataSet(pDMemTable1: TFDMemTable);
    procedure PreencherDespTipoSL(pSL: TStrings);
  end;

implementation

end.
