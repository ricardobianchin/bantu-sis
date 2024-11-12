unit App.DB.Import.Form_Finalizar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes,
  App.AppObj, Sis.Usuario, Vcl.ComCtrls;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection;
  pAppObj: IAppObj; pUsuario: IUsuario; pProgressBar1: TProgressBar);

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats,
  App.DB.Import.Form_Finalizar_Fabr_u, App.DB.Import.Form_Finalizar_ProdTipo_u,
  App.DB.Import.Form_Finalizar_Unid_u, App.DB.Import.Form_Finalizar_Prod_u,
  Sis.DB.Factory;

var
  oProdFDMemTable: TFDMemTable;
  oDBConnection: IDBConnection;
  ComandosSL: TStringList;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection;
  pAppObj: IAppObj; pUsuario: IUsuario; pProgressBar1: TProgressBar);
var
  bResultado: boolean;
  sSql: string;
  oDBQuery: IDBQuery;
begin
  oProdFDMemTable := pProdFDMemTable;
  oDBConnection := pDBConnection;

  oProdFDMemTable.DisableControls;

  ComandosSL := TStringList.Create;
  oDBConnection.Abrir;
  try
    oProdFDMemTable.First;

    GarantirFabr(oDBConnection);
    GarantirProdTipo(oDBConnection);
    GarantirUnid(oDBConnection);
    // nao fiz ainda GarantirICMS. ate unit existe mas nao inserida no projec
    GarantirProd(oDBConnection, pAppObj, pUsuario, pProgressBar1);

    sSql := //
      'SELECT LOG_ID_RET'#13#10 //
      + 'FROM LOG_PA.LOG_NOVO_GET'#13#10 //
      + '('#13#10 //
      + '  :LOJA_ID,'#13#10 // 0
      + '  :RETAGUARDA_TERMINAL_ID,'#13#10 // 1
      + '  :PESSOA_ID,'#13#10 // 2
      + '  :RETAGUARDA_MODULO_SIS_ID,'#13#10 // 3
      + '  :ACAO_SIS_ID,'#13#10 // 4
      + '  :FEATURE_SIS_ID,'#13#10 // 5
      + '  :MACHINE_ID'#13#10 // 6
      + ');'#13#10 //
      ;

    oDBQuery := DBQueryCreate('import.finalizar.crialog.q', oDBConnection,
      sSql, nil, nil);

    oDBQuery.Prepare;
    try
      oDBQuery.Params[0].AsSmallInt := pAppObj.Loja.Id;
      oDBQuery.Params[1].AsSmallInt := 0;
      oDBQuery.Params[2].AsInteger := pUsuario.Id;
      oDBQuery.Params[3].AsString := '!';
      oDBQuery.Params[4].AsString := '''';
      oDBQuery.Params[5].AsSmallInt := 8;
      oDBQuery.Params[6].AsSmallInt := pAppObj.SisConfig.ServerMachineId.IdentId;

      oDBQuery.Open;
      oDBQuery.Close;
    finally
      oDBQuery.Unprepare;
    end;

  finally
    pProdFDMemTable.First;
    pProdFDMemTable.EnableControls;
    ComandosSL.Free;
    oDBConnection.Fechar;
  end;
end;

end.
