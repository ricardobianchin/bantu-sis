unit App.Pess.Factory_u;

interface

uses App.Loja, App.Loja.DBI, Sis.DB.DBTypes;

function AppLojaCreate: IAppLoja;
function AppLojaDBICreate(pLoja: IAppLoja; pDBConnection: IDBConnection): IAppLojaDBI;

implementation

uses App.Loja_u, App.Loja.DBI_u;

function AppLojaCreate: IAppLoja;
begin
  Result := TAppLoja.Create;
end;

function AppLojaDBICreate(pLoja: IAppLoja; pDBConnection: IDBConnection): IAppLojaDBI;
begin
  Result := TAppLojaDBI.Create(pLoja, pDBConnection);
end;

end.
