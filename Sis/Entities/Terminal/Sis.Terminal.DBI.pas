unit Sis.Terminal.DBI;

interface

uses Sis.DBI, Sis.TerminalList, Sis.Terminal, FireDAC.Comp.Client, Data.DB,
  Sis.Config.SisConfig;

type
  ITerminalDBI = interface(IDBI)
    ['{2BA7728F-79A8-4E38-B885-F9C9D072A392}']
    function DBToList(pTerminalList: ITerminalList;
      pPastaDados, pAtivDescr: string; pSomenteMaquina: string = ''): Boolean;

    procedure ListToDB(pTerminalList: ITerminalList; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DataSetToDB(pDataSet: TDataSet; pLogLojaId: SmallInt;
      pLogUsuarioId: integer; pLogMachineIdentId: SmallInt);

    procedure DBToDMemTable(pDMemTable: TFDMemTable);

    procedure TermDBsParaList(pTerminalList: ITerminalList;
      pSisConfig: ISisConfig; pPastaDados: string);

    procedure ListToDBs(pTerminalList: ITerminalList; pSisConfig: ISisConfig;
      pLogLojaId: SmallInt; pLogUsuarioId: integer);
  end;

implementation

end.
