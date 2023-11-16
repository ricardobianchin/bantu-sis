unit btu.lib.db.dbms;

interface

uses sis.ui.io.ProcessLog, sis.ui.io.output, btu.lib.db.types, System.Classes;
// sugestoes
// DBMS (Database Management System)
// IDBMS
// IDBMSInterface
// IDBMSEnvironment
// IDBMSControler
type
  IDBMS = interface(IInterface)
    ['{538EDEC7-A17C-4F0B-80C0-F55CE89435AB}']
    function LocalDoDBToConnectionParams(pLocalDoDB: TLocalDoDB): TDBConnectionParams;
    function LocalDoDBToNomeBanco(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToNomeArq(pLocalDoDB: TLocalDoDB): string;
    function LocalDoDBToDatabase(pLocalDoDB: TLocalDoDB): string;

    procedure GarantirDBMSInstalado(pProcessLog: IProcessLog; pOutput: IOutput);
    function GarantirDBServCriadoEAtualizado(pProcessLog: IProcessLog; pOutput: IOutput): boolean;

//    procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pProcessLog: IProcessLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string; pLocalDoDB: TLocalDoDB; pProcessLog: IProcessLog; pOutput: IOutput); overload;
  end;

implementation

end.
