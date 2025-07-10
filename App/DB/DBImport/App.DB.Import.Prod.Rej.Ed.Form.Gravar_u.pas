unit App.DB.Import.Prod.Rej.Ed.Form.Gravar_u;

interface

uses Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Sis.DB.DBTypes;

function Gravou(pProdFDMemTable: TFDMemTable; pFDMemTable: TFDMemTable;
  pDBConnection: IDBConnection): boolean;

implementation

uses System.Classes, System.SysUtils, Sis.Types.Bool_u, Sis.Types.Floats,
  Sis.Win.Utils_u;

var
  oProdFDMemTable: TFDMemTable;
  oFDMemTable: TFDMemTable;
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
  bAImportar := oFDMemTable.Fields[1].AsBoolean;
  sDescr := oFDMemTable.Fields[5].AsString;
  sDescrRed := oFDMemTable.Fields[6].AsString;
  uCusto := oFDMemTable.Fields[10].AsCurrency;
  aPreco[0] := oFDMemTable.Fields[12].AsCurrency;
  sBarras := oFDMemTable.Fields[14].AsString;
  aBarras := sBarras.Split([',']);
end;

procedure EditReg;
begin
  oProdFDMemTable.Edit;
  oProdFDMemTable.Fields[1].AsBoolean := bAImportar;
  oProdFDMemTable.Fields[5].AsString := sDescr;
  oProdFDMemTable.Fields[6].AsString := sDescrRed;
  if uCusto = 0 then
    oProdFDMemTable.Fields[18].Clear
  else
    oProdFDMemTable.Fields[18].AsCurrency := uCusto;
  if aPreco[0] > 0 then
    oProdFDMemTable.Fields[20].AsCurrency := aPreco[0];
  oProdFDMemTable.Fields[26].AsString := sBarras;
  oProdFDMemTable.Post;
end;

procedure GravarImportProd;
begin
  sComando := 'UPDATE IMPORT_PROD SET' + //
    ' VAI_IMPORTAR=' + BooleanToStrSQL(bAImportar) + //
    ', NOVO_DESCR=' + QuotedStr(sDescr) + //
    ', NOVO_DESCR_RED=' + QuotedStr(sDescrRed);

  if uCusto > 0 then
    sComando := sComando + ', NOVO_CUSTO=' + CurrencyToStrPonto(uCusto);

  sComando := sComando + ' WHERE IMPORT_PROD_ID=' + iId.ToString;

  oDBConnection.ExecuteSQL(sComando);
  // ComandosSL.Add(sComando);
end;

procedure GravarImportProdPreco;
begin
  sComando := 'DELETE FROM IMPORT_PROD_PRECO_NOVO' + //
    ' WHERE IMPORT_PROD_ID=' + //
    iId.ToString + //
    ';';

  oDBConnection.ExecuteSQL(sComando);
  // ComandosSL.Add(sComando);

  sComando := 'INSERT INTO IMPORT_PROD_PRECO_NOVO (IMPORT_PROD_ID'
  // ', PROD_PRECO_TABELA_ID
    + ', PRECO) VALUES(' //
    + iId.ToString //
    + ', ' //
  // ', 1, ' +
    + CurrencyToStrPonto(aPreco[0]) //
    + ');';

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sComando);
  // {$ENDIF}

  oDBConnection.ExecuteSQL(sComando);
  // ComandosSL.Add(sComando);

end;

procedure GravarImportProdBarras;
var
  i: integer;
begin
  sComando := 'DELETE FROM IMPORT_PROD_BARRAS_NOVO' + ' WHERE IMPORT_PROD_ID=' +
    iId.ToString + ';';
  oDBConnection.ExecuteSQL(sComando);
  // ComandosSL.Add(sComando);

  for i := 0 to Length(aBarras) - 1 do
  begin
    sComando := 'INSERT INTO IMPORT_PROD_BARRAS_NOVO (IMPORT_PROD_ID' +
      ', ORDEM, COD_BARRAS) VALUES(' + iId.ToString + ', ' + (i + 1).ToString +
      ', ' + QuotedStr(aBarras[i]) + ');';
    oDBConnection.ExecuteSQL(sComando);
    // ComandosSL.Add(sComando);
  end;
end;

function Gravou(pProdFDMemTable: TFDMemTable; pFDMemTable: TFDMemTable;
  pDBConnection: IDBConnection): boolean;
var
  b: TBookmark;
  bResultado: boolean;
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

      LerCampos;
      EditReg;

      GravarImportProd;
      GravarImportProdPreco;
      GravarImportProdBarras;

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
