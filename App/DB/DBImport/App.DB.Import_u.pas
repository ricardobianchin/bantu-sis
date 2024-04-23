unit App.DB.Import_u;

interface

uses Sis.Sis.Executavel_u, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  App.DB.Import, Sis.DB.DBTypes, App.DB.Import.Origem;

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
  Output.Exibir('');
  Output.Exibir('-------------');
  Output.Exibir('Início');
  Output.Exibir('-------------');
  Result := DestinoDBConnection.Abrir;
  if not Result then
  begin
    Output.Exibir('Erro ao Conectar no Banco de Dados');
    Output.Exibir('Terminando sem importar');
    exit;
  end;
  try
    Output.Exibir('Vai importar');

    Result := FDBImportOrigem.PodeImportar;
    if not Result then
    begin
      Output.Exibir('Terminando sem importar');
      exit;
    end;

  finally
    DestinoDBConnection.Fechar;
  Output.Exibir('-------------');
  Output.Exibir('Fim');
  Output.Exibir('-------------');
  end;
end;

end.
