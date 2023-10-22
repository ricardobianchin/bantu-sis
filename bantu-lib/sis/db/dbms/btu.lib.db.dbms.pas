unit btu.lib.db.dbms;

interface

uses sis.ui.io.log, sis.ui.io.output, btu.lib.db.types, System.Classes;
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

    procedure GarantirDBMSInstalado(pLog: iLog; pOutput: IOutput);
    procedure GarantirDBServCriadoEAtualizado(pLog: iLog; pOutput: IOutput);

//    procedure ExecInterative(pNomeArqSQL: string; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;
    procedure ExecInterative(pAssunto: string; pSql: string; pLocalDoDB: TLocalDoDB; pLog: iLog; pOutput: IOutput); overload;
  end;

implementation

end.
