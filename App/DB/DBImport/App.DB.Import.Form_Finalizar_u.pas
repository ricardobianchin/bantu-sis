unit App.DB.Import.Form_Finalizar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection);

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats,
  App.DB.Import.Form_Finalizar_Fabr_u, App.DB.Import.Form_Finalizar_ProdTipo_u, App.DB.Import.Form_Finalizar_Unid_u;

var
  oProdFDMemTable: TFDMemTable;
  oDBConnection: IDBConnection;
  ComandosSL: TStringList;
  iId: integer;
  bAImportar: boolean;
  sDescr: string;
  sDescrRed: string;
  uCusto: Currency;
  aPreco: TArray<Currency>;
  sBarras: string;
  aBarras: TArray<string>;
  sComando: string;

procedure LerCampos;
begin
  exit;
  f
  iId := oProdFDMemTable.Fields[0].AsInteger;
  bAImportar := oProdFDMemTable.Fields[1].AsBoolean;
  sDescr := oProdFDMemTable.Fields[5].AsString;
  sDescrRed := oProdFDMemTable.Fields[6].AsString;
  uCusto := oProdFDMemTable.Fields[10].AsCurrency;
  aPreco[0] := oProdFDMemTable.Fields[12].AsCurrency;;
  sBarras := oProdFDMemTable.Fields[14].AsString;
  aBarras := sBarras.Split([',']);

{

0	import_prod_id
1	vai_importar
2	PROD_ID
3	DESCR
4	DESCR_RED
5	NOVO_DESCR
6	NOVO_DESCR_RED
7	IMPORT_FABR_ID
8	FABR_NOME
9	IMPORT_PROD_TIPO_ID
10	PROD_TIPO_DESCR
11	IMPORT_UNID_ID
12	UNID_SIGLA
13	IMPORT_ICMS_ID
14	ICMS_PERC_DESCR
15	CAPAC_EMB
16	NCM
17	CUSTO
18	novo_CUSTO
19	PRECO
20	novo_PRECO
21	ATIVO
22	LOCALIZ
23	MARGEM
24	BAL_USO
25	BAL_DPTO
26	codbarras
27	novo_codbarras

}
end;

procedure Finalizar(pProdFDMemTable: TFDMemTable; pDBConnection: IDBConnection);
var
  bResultado: boolean;
begin
  oProdFDMemTable := pProdFDMemTable;
  oDBConnection := pDBConnection;

  oProdFDMemTable.DisableControls;

  ComandosSL := TStringList.Create;
  oDBConnection.Abrir;
  try
    SetLength(aPreco, 1);
    oProdFDMemTable.First;

    GarantirFabr(oDBConnection);
    GarantirProdTipo(oDBConnection);
    GarantirUnid(oDBConnection);

    while not oProdFDMemTable.Eof do
    begin
      LerCampos;

      oProdFDMemTable.Next;
    end;
  finally
    pProdFDMemTable.First;
    pProdFDMemTable.EnableControls;
    ComandosSL.Free;
    oDBConnection.Fechar;
  end;
end;

end.
