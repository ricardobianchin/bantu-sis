unit Sis.DB.DBConfigDBI_u;

interface

uses Sis.DBI_u, Sis.DB.DBConfigDBI, Sis.DB.DBTypes;

type
  TDBConfigDBI = class(TDBI, IDBConfigDBI)
  private
  public
    constructor Create(pDBConnection: IDBConnection);
    procedure Gravar(pChave, pValor: string); overload;
    procedure Gravar(pChave: string; pValor: Boolean); overload;
  end;

implementation

{ TDBConfigDBI }

uses Sis.DB.Factory, Sis.Types.Bool_u;

constructor TDBConfigDBI.Create(pDBConnection: IDBConnection);
begin
  inherited;
end;

procedure TDBConfigDBI.Gravar(pChave, pValor: string);
var
  rDBConnectionParams: TDBConnectionParams;
  oDBConnection: IDBConnection;
  sSql: string;
  sFormat: string;
  oDBExec: IDBExec;
begin
  if not oDBConnection.Abrir then
    exit;
  try
    sSql := 'EXECUTE PROCEDURE CONFIG_SIS_PA.GARANTIR(:CHAVE, :VALOR);';

    oDBExec := DBExecCreate('TDBConfigDBI.Gravar.Exec', oDBConnection, sSql,
      nil, nil);
    oDBExec.Prepare;
    try
      oDBExec.Params[0].AsString := pChave;
      oDBExec.Params[1].AsString := pValor;

      oDBExec.Execute;
    finally
      oDBExec.Unprepare;
    end;
  finally
    oDBConnection.Fechar;
  end;
end;

procedure TDBConfigDBI.Gravar(pChave: string; pValor: Boolean);
begin
  Gravar(pChave, IIF(pValor, 'S', 'NULL'));
end;

end.
