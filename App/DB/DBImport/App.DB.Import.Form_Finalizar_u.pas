unit App.DB.Import.Form_Finalizar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes,
  App.AppObj, Sis.Usuario, Vcl.ComCtrls;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection;
  pAppObj: IAppObj; pUsuario: IUsuario; pProgressBar1: TProgressBar);

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats,
  App.DB.Import.Form_Finalizar_Fabr_u, App.DB.Import.Form_Finalizar_ProdTipo_u,
  App.DB.Import.Form_Finalizar_Unid_u, App.DB.Import.Form_Finalizar_Prod_u;

var
  oProdFDMemTable: TFDMemTable;
  oDBConnection: IDBConnection;
  ComandosSL: TStringList;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection;
  pAppObj: IAppObj; pUsuario: IUsuario; pProgressBar1: TProgressBar);
var
  bResultado: boolean;
begin
  oProdFDMemTable := pProdFDMemTable;
  oDBConnection := pDBConnection;

  oProdFDMemTable.DisableControls;

  ComandosSL := TStringList.Create;
  oDBConnection.Abrir;
  try
    oProdFDMemTable.First;

    // GarantirFabr(oDBConnection);
    // GarantirProdTipo(oDBConnection);
    // GarantirUnid(oDBConnection);
    // nao fiz ainda GarantirICMS. ate unit existe mas nao inserida no projec
    GarantirProd(oDBConnection, pAppObj, pUsuario, pProgressBar1);

//    while not oProdFDMemTable.Eof do
//    begin
//
//      oProdFDMemTable.Next;
//    end;
  finally
    pProdFDMemTable.First;
    pProdFDMemTable.EnableControls;
    ComandosSL.Free;
    oDBConnection.Fechar;
  end;
end;

end.
