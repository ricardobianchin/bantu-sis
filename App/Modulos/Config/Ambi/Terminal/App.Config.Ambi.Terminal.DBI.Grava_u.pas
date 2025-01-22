unit App.Config.Ambi.Terminal.DBI.Grava_u;

interface

uses Sis.DBI_u, App.Config.Ambi.Terminal.DBI, FireDAC.Comp.Client, Data.DB,
  Sis.Usuario, App.AppObj, Sis.DB.DBTypes, Sis.Terminal.DBI;

type
  TConfigAmbiTerminalDBIGrava = class(TDBI, IConfigAmbiTerminalDBI)
  private
    FDMemTable: TFDMemTable;
    FUsuarioAdmin: IUsuario;
    FAppObj: IAppObj;
    FTerminalDBI: ITerminalDBI;
  protected

  public
    procedure PreenchaDataSet(pDMemTable: TFDMemTable);
    procedure Inserir(pDMemTable: TFDMemTable);
    procedure Alterar(pDMemTable: TFDMemTable);

    constructor Create(pDBConnection: IDBConnection; pUsuarioAdmin: IUsuario;
      pAppObj: IAppObj; pTerminalDBI: ITerminalDBI);
  end;

implementation

uses Sis.DB.DataSet.Utils, System.SysUtils, Sis.DB.SqlUtils_u,
  Sis.Win.Utils_u, Sis.Types.Bool_u;

{ TConfigAmbiTerminalDBIGrava }

procedure TConfigAmbiTerminalDBIGrava.Alterar(pDMemTable: TFDMemTable);
begin
  FTerminalDBI.DataSetToDB(pDMemTable, FAppObj.Loja.Id, FUsuarioAdmin.Id,
    FAppObj.SisConfig.ServerMachineId.IdentId);
end;

constructor TConfigAmbiTerminalDBIGrava.Create(pDBConnection: IDBConnection;
  pUsuarioAdmin: IUsuario; pAppObj: IAppObj; pTerminalDBI: ITerminalDBI);
begin
  inherited Create(pDBConnection);
  FUsuarioAdmin := pUsuarioAdmin;
  FAppObj := pAppObj;
  FTerminalDBI := pTerminalDBI;
end;

procedure TConfigAmbiTerminalDBIGrava.Inserir(pDMemTable: TFDMemTable);
begin
  FTerminalDBI.DataSetToDB(pDMemTable, FAppObj.Loja.Id, FUsuarioAdmin.Id,
    FAppObj.SisConfig.ServerMachineId.IdentId);
end;

procedure TConfigAmbiTerminalDBIGrava.PreenchaDataSet(pDMemTable: TFDMemTable);
begin
  FDMemTable := pDMemTable;
  FTerminalDBI.DBToDMemTable(pDMemTable);
end;

end.
