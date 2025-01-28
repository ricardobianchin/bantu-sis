unit App.Config.Ambi.Terminal.DBI;

interface

uses Sis.DBI, FireDAC.Comp.Client;

type
  IConfigAmbiTerminalDBI = interface(IDBI)
    ['{D1F8EB5E-6855-407F-A0F5-F841C9CAE2E4}']
    procedure PreenchaDataSet(pDMemTable: TFDMemTable);
    procedure Inserir(pDMemTable: TFDMemTable);
    procedure Alterar(pDMemTable: TFDMemTable);
  end;

implementation

end.
