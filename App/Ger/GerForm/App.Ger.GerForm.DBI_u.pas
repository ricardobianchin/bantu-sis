unit App.Ger.GerForm.DBI_u;

interface

uses Sis.DBI_u, App.Ger.GerForm.DBI, Sis.DB.DBConfigDBI, Sis.DB.DBTypes;

type
  TGerFormDBI = class(TDBI, IGerFormDBI)
  private
    FDBConfigDBI: IDBConfigDBI;
  public
    constructor Create(pDBConnection: IDBConnection; pDBConfigDBI: IDBConfigDBI);
    procedure PegarConfigs(out pSempreVisivel: boolean; out pAutoOpen: boolean);
    procedure SempreVisivelGravar(pValor: Boolean);
    procedure AutoOpenGravar(pValor: Boolean);
  end;

implementation

uses Data.DB, App.Ger.GerForm.Constants_u;

{ TGerFormDBI }

procedure TGerFormDBI.AutoOpenGravar(pValor: Boolean);
begin
  FDBConfigDBI.Gravar(GER_FORM_AUTO_OPEN_CONFIG_CHAVE, pValor);
end;

constructor TGerFormDBI.Create(pDBConnection: IDBConnection;
  pDBConfigDBI: IDBConfigDBI);
begin
  inherited Create(pDBConnection);
  FDBConfigDBI := pDBConfigDBI;
end;

procedure TGerFormDBI.PegarConfigs(out pSempreVisivel, pAutoOpen: boolean);
var
  sSql: string;
  q: TDataSet;
begin
  if not DBConnection.Abrir then
    exit;
  try
    sSql := 'SELECT SEMPRE_VISIVEL, AUTO_OPEN'#13#10 //
      + 'FROM GER_FORM_PA.CONFIGS_GET;'#13#10 //
      ;

    DBConnection.QueryDataSet(sSql, q);
    if not Assigned(q) then
      exit;

    try
      pSempreVisivel := q.fields[0].AsBoolean;
      pAutoOpen := q.fields[1].AsBoolean;
    finally
      q.free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TGerFormDBI.SempreVisivelGravar(pValor: Boolean);
begin
  FDBConfigDBI.Gravar(GER_FORM_SEMPRE_VISIVEL_CONFIG_CHAVE, pValor);
end;

end.
