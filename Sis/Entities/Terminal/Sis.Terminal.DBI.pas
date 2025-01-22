unit Sis.Terminal.DBI;

interface

uses Sis.DBI, Sis.TerminalList, Sis.Terminal, FireDAC.Comp.Client, Data.DB;

type
  ITerminalDBI = interface(IDBI)
    ['{2BA7728F-79A8-4E38-B885-F9C9D072A392}']
    procedure DataSetToTerminal(Q: TDataSet; pTerminal: ITerminal;
      pPastaDados, pAtivDescr: string);

    procedure DBToList(pTerminalList: ITerminalList;
      pPastaDados, pAtivDescr: string; pSomenteMaquina: string = '');

    procedure ListToDB(pTerminalList: ITerminalList; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DataSetToDB(pDataSet: TDataSet; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DBToDMemTable(pDMemTable: TFDMemTable);
  end;

implementation

end.
