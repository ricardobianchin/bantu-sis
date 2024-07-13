unit App.Pess.Geral.Factory_u;

interface

uses App.Generos, Sis.DB.DBTypes, App.Ent.Ed, App.Pess.Loja.Ent, Data.DB,
  Vcl.StdCtrls, Sis.UI.IO.Output.ProcessLog, Sis.UI.IO.Output, System.Classes,
  Sis.Entidade, Sis.Loja, Sis.Usuario, App.UI.Form.Bas.Ed_u, App.Ent.DBI,
  Sis.UI.Controls.ComboBoxManager, App.AppInfo, Sis.Config.SisConfig,
  Sis.UI.FormCreator
  ;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;

implementation

uses App.Generos_u, App.Pess.Ent_u//, Vcl.Controls, App.UI.FormCreator.DataSet_u

{$REGION 'uses loja'}
  , App.PessEnder.List_u
  , App.Pess.Loja.Ent_u // loja ent
  , App.Pess.Loja.DBI_u // loja dbi
//  , App.UI.Form.Ed.Prod.Fabr_u // fabr ed form
//  , App.UI.Form.DataSet.Retag.Est.Prod.Fabr_u
{$ENDREGION}
  ;

function GenerosCreate(pDBConnection: IDBConnection): IGeneros;
var
  s: string;
begin
  Result := TGeneros.Create;
end;

end.
