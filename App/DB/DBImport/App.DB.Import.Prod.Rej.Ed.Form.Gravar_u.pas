unit App.DB.Import.Prod.Rej.Ed.Form.Gravar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes;

function Gravou(pProdFDMemTable: TFDMemTable; pFDMemTable: TFDMemTable;
  pDBConnection: IDBConnection): boolean;

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats;

var
  oProdFDMemTable: TFDMemTable;
  oFDMemTable: TFDMemTable;
  oDBConnection: IDBConnection;

function Gravou(pProdFDMemTable: TFDMemTable; pFDMemTable: TFDMemTable;
  pDBConnection: IDBConnection): boolean;
var
  i: integer;
  b: TBookmark;
  bResultado: boolean;
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
begin
  Result := True;
  oProdFDMemTable := pProdFDMemTable;
  oFDMemTable := pFDMemTable;
  oDBConnection := pDBConnection;

  pProdFDMemTable.DisableControls;
  pFDMemTable.DisableControls;

  b := pProdFDMemTable.GetBookmark;
  ComandosSL := TStringList.Create;
  oDBConnection.Abrir;
  try
    pFDMemTable.First;
    SetLength(aPreco, 1);
    while not pFDMemTable.Eof do
    begin
      iId := pFDMemTable.Fields[0].AsInteger;
      bResultado := pProdFDMemTable.FindKey([iId]);

      bAImportar := pFDMemTable.Fields[1].AsBoolean;
      sDescr := pFDMemTable.Fields[5].AsString;
      sDescrRed := pFDMemTable.Fields[6].AsString;
      uCusto := pFDMemTable.Fields[10].AsCurrency;
      aPreco[0] := pFDMemTable.Fields[12].AsCurrency;;
      sBarras := pFDMemTable.Fields[14].AsString;
      aBarras := sBarras.Split([',']);

      pProdFDMemTable.Edit;
      pProdFDMemTable.Fields[1].AsBoolean := bAImportar;
      pProdFDMemTable.Fields[5].AsString := sDescr;
      pProdFDMemTable.Fields[6].AsString := sDescrRed;
      pProdFDMemTable.Fields[10].AsCurrency := uCusto;
      pProdFDMemTable.Fields[12].AsCurrency := aPreco[0];
      pProdFDMemTable.Fields[14].AsString := sBarras;
      pProdFDMemTable.Post;

      sComando := 'UPDATE IMPORT_PROD SET' + ' VAI_IMPORTAR=' +
        BooleanToStrSQL(bAImportar) + ', NOVO_DESCR=' + QuotedStr(sDescr) +
        ', NOVO_DESCR_RED=' + QuotedStr(sDescrRed) + ', NOVO_CUSTO=' +
        CurrencyToStrPonto(uCusto) + ' WHERE IMPORT_PROD_ID=' + iId.ToString;
      oDBConnection.ExecuteSQL(sComando);
      // ComandosSL.Add(sComando);

      sComando := 'DELETE FROM IMPORT_PROD_PRECO_NOVO' +
        ' WHERE IMPORT_PROD_ID=' + iId.ToString + ';';
      oDBConnection.ExecuteSQL(sComando);
      // ComandosSL.Add(sComando);

      sComando := 'INSERT INTO IMPORT_PROD_PRECO_NOVO (IMPORT_PROD_ID' +
        ', PROD_PRECO_TABELA_ID, PRECO) VALUES(' + iId.ToString + ', 1, ' +
        CurrencyToStrPonto(aPreco[0]) + ');';
      oDBConnection.ExecuteSQL(sComando);
      // ComandosSL.Add(sComando);

      sComando := 'DELETE FROM IMPORT_PROD_BARRAS_NOVO' +
        ' WHERE IMPORT_PROD_ID=' + iId.ToString + ';';
      oDBConnection.ExecuteSQL(sComando);
      // ComandosSL.Add(sComando);

      for i := 0 to Length(aBarras) - 1 do
      begin
        sComando := 'INSERT INTO IMPORT_PROD_BARRAS_NOVO (IMPORT_PROD_ID' +
          ', ORDEM, COD_BARRAS) VALUES(' + iId.ToString + ', ' + (i + 1)
          .ToString + ', ' + QuotedStr(aBarras[i]) + ');';
        oDBConnection.ExecuteSQL(sComando);
        // ComandosSL.Add(sComando);
      end;

      pFDMemTable.Next;
    end;
  finally
    pProdFDMemTable.GotoBookmark(b);
    pProdFDMemTable.FreeBookmark(b);
    pProdFDMemTable.EnableControls;
    pFDMemTable.First;
    pFDMemTable.EnableControls;
    ComandosSL.Free;
    oDBConnection.Fechar;
  end;
end;

end.
