unit App.Est.Venda.Caixa.CaixaSessaoOperacao.DBI;

interface

uses App.Ent.DBI, System.Classes;

type
  ICxOperacaoDBI = interface(IEntDBI)
    ['{6742C994-0B43-4BBC-B2F1-46DE0D0353F2}']
    procedure FecharPodeGet(out pPode: Boolean; pMensagem: string);
  end;

implementation

end.
