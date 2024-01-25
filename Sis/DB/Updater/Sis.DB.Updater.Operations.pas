unit Sis.DB.Updater.Operations;

interface

uses System.Classes;

type
  IDBUpdaterOperations = interface(IInterface)
    ['{31B6E0D8-9051-473A-BFCE-B16FF6D867F4}']
    function TabelaExiste(pNomeTabela: string): boolean;
    function GetIndexFieldNames(pIndexName: string): string;
    function ProcedureExiste(pProcedureName: string): boolean;

    procedure PackagePegarCodigo(pPackageName: string; out pCabec: string;
      out pBody: string);

    function VersaoGet: integer;
    procedure HistIns(pNum: integer; pAssunto, pObjetivo, pObs: string);

    procedure PreparePrincipais;
    procedure PrepareVersoes;
    procedure Unprepare;

    function NomeTabelaToPKName(pNomeTabela: string): string;

    function SequenceExiste(pNomeSequence: string): boolean;
    function GetForeignKeyInfo(pFKName: string; out pTabelaFK: string;
      out pCamposFK: string; out pTabelaPK: string; out pCamposPK: string
      ): boolean;
  end;

implementation

end.
