unit Sis.DB.Import_u;

interface

uses Sis.Sis.Executavel_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.DB.Import, Sis.DB.DBTypes, Sis.DB.Import.Origem;

type
  TDBImport = class(TExecutavel, IDBImport)
  private
    FDestinoDBConnection: IDBConnection;
    FDBImportOrigem: IDBImportOrigem;
  protected
    property DestinoDBConnection: IDBConnection read FDestinoDBConnection;
    property DBImportOrigem: IDBImportOrigem read FDBImportOrigem;
  public
    function Execute: Boolean; override;

    constructor Create(pDestinoDBConnection: IDBConnection; pDBImportOrigem: IDBImportOrigem;
      pOutput: IOutput = nil; pProcessLog: IProcessLog = nil);

  end;

implementation

{ TDBImport }

constructor TDBImport.Create(pDestinoDBConnection: IDBConnection; pDBImportOrigem: IDBImportOrigem;
  pOutput: IOutput; pProcessLog: IProcessLog);
begin
  inherited Create(pOutput, pProcessLog);
  FDestinoDBConnection := pDestinoDBConnection;
  FDBImportOrigem := pDBImportOrigem;
end;

function TDBImport.Execute: Boolean;
begin
  Result := DestinoDBConnection.Abrir;
  if not Result then
    exit;

end;

end.
