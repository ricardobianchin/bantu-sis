unit EstSaldo_u_dbi;

interface

uses EstSaldo_u_ProdSaldoArrayType;

function GetSaldoDtHistUltima: TDateTime;
function GetEstMovDtHMaisAntigo: TDateTime;
function GetQtdProdsSaldo: integer;
procedure InicializeProdSaldoArray(var pProdSaldoArray: TProdSaldoArray; out pQtdProdsSaldo: integer);
procedure ProdSaldoArrayLeiaQtdsHist(var pProdSaldoArray: TProdSaldoArray; pDt: TDateTime);
procedure EstSaldoReconstruaFaixa(pProdSaldoArray: TProdSaldoArray; pDtHFaixaIni, pDtHFaixaFin: TDateTime);


implementation

uses DBServDM_u, System.DateUtils, EstSaldo_u_ProdSaldoRecord, Sis.Types.Dates,
  EstSaldo_u_ProdSaldoArrayUtils;

function GetSaldoDtHistUltima: TDateTime;
var
  sSql: string;
  bResultado: Boolean;
begin
  Result := 0;

  sSql := //
    'SELECT EST_SALDO_RETAG_PA.DT_HIST_ULTIMA_GET() AS ULTIMA_DATA ' + //
    'FROM RDB$DATABASE;'#13#10 //
    ;

  bResultado := DBServDM.AbirFDQuery1('GetSaldoDtHistUltima', sSql);
  if not bResultado then
    exit;
  try
    Result := DateOf(DBServDM.FDQuery1.Fields[0].AsDateTime);
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

function GetEstMovDtHMaisAntigo: TDateTime;
var
  sSql: string;
  bResultado: Boolean;
begin
  Result := 0;

  sSql := //
    'SELECT EST_SALDO_RETAG_PA.EST_MOV_DTH_MIN_GET() AS DATA_MAIS_ANTIGA ' + //
    'FROM RDB$DATABASE;'#13#10 //
    ;

  bResultado := DBServDM.AbirFDQuery1('GetEstMovDtHMaisAntigo', sSql);
  if not bResultado then
    exit;
  try
    Result := DBServDM.FDQuery1.Fields[0].AsDateTime;
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

function GetQtdProdsSaldo: integer;
var
  sSql: string;
  bResultado: Boolean;
begin
  Result := 0;

  sSql := //
    'SELECT EST_SALDO_RETAG_PA.PROD_QTD_GET() AS QTD ' + //
    'FROM RDB$DATABASE;'#13#10 //
    ;

  bResultado := DBServDM.AbirFDQuery1('GetQtdProdsSaldo', sSql);
  if not bResultado then
    exit;
  try
    Result := DBServDM.FDQuery1.Fields[0].AsInteger;
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

procedure InicializeProdSaldoArray(var pProdSaldoArray: TProdSaldoArray; out pQtdProdsSaldo: integer);
var
  I: Integer;

  sSql: string;
  bResultado: Boolean;
begin
  pQtdProdsSaldo := GetQtdProdsSaldo;
  SetLength(pProdSaldoArray, pQtdProdsSaldo);

  if pQtdProdsSaldo = 0 then
    exit;

  sSql := //
    'SELECT PROD_ID'#13#10 + //
    'FROM EST_SALDO_RETAG_PA.PROD_LISTA_GET;'#13#10 //
    ;

  bResultado := DBServDM.AbirFDQuery1('InicializeProdSaldoArray', sSql);
  if not bResultado then
    exit;
  try
    for I := 0 to pQtdProdsSaldo - 1 do
    begin
      pProdSaldoArray[i].Inicializar(DBServDM.FDQuery1.Fields[0].AsInteger);
      DBServDM.FDQuery1.Next;
      if DBServDM.FDQuery1.Eof then
        break;
    end;
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

procedure ProdSaldoArrayLeiaQtdsHist(var pProdSaldoArray: TProdSaldoArray; pDt: TDateTime);
var
  iIndex: integer;
  iProdId: integer;
  uQtd: Currency;
  sSql: string;
  bResultado: Boolean;
begin

  sSql := //
    'SELECT PROD_ID, QTD'#13#10 + //
    'FROM EST_SALDO_HIST'#13#10 + //
    'WHERE DT = '+DataSQLFirebird(pDt)+#13#10 +//
    'ORDER BY PROD_ID;'#13#10 //
    ;

  bResultado := DBServDM.AbirFDQuery1('ProdSaldoArrayLeiaQtdsHist', sSql);
  if not bResultado then
    exit;
  try
    while not DBServDM.FDQuery1.Eof do
    begin
      iProdId := DBServDM.FDQuery1.Fields[0].AsInteger;
      iIndex := ProdIdToIndex(iProdId, pProdSaldoArray);
      if iIndex > -1 then
      begin
        uQtd := DBServDM.FDQuery1.Fields[1].AsCurrency;
        pProdSaldoArray[iIndex].Qtd := uQtd;
      end;
      DBServDM.FDQuery1.Next;
    end;
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

procedure EstSaldoReconstruaFaixa(pProdSaldoArray: TProdSaldoArray; pDtHFaixaIni, pDtHFaixaFin: TDateTime);
var
  iIndex: integer;
  iProdId: integer;
  cTipo: char;
  uQtd: Currency;
  sSql: string;
  bResultado: Boolean;
begin
  sSql := 'SELECT PROD_ID, EST_MOV_TIPO_ID, QTD'#13#10 + //
    'FROM EST_SALDO_RETAG_PA.EST_MOV_ITEM_LISTA_GET(' + //
    DataHoraSQLFirebird(pDtHFaixaIni) + ', ' + //
    DataHoraSQLFirebird(pDtHFaixaFin) + ');' //
    ;

  bResultado := DBServDM.AbirFDQuery1('EstSaldoReconstruaFaixa', sSql);
  if not bResultado then
    exit;
  try
    while not DBServDM.FDQuery1.Eof do
    begin
      iProdId := DBServDM.FDQuery1.Fields[0].AsInteger;
      iIndex := ProdIdToIndex(iProdId, pProdSaldoArray);
      if iIndex > -1 then
      begin
        uQtd := DBServDM.FDQuery1.Fields[2].AsCurrency;
        cTipo := DBServDM.FDQuery1.Fields[1].AsString[1];
        case cTipo of
          #33:pProdSaldoArray[iIndex].Qtd := pProdSaldoArray[iIndex].Qtd + uQtd;
          #34, #38:pProdSaldoArray[iIndex].Qtd := pProdSaldoArray[iIndex].Qtd - uQtd;
          #35:pProdSaldoArray[iIndex].Qtd := uQtd;
        end;

        {
#032;NAO INDICADO
#033;ENTRADA
#034;VENDA
#035;INVENTARIO
#036;DEVOLUCAO DE VENDA
#037;DEVOLUCAO DE COMPRA
#038;SAIDA
#039;SAIDA ESTORNO
        }
      end;
      DBServDM.FDQuery1.Next;
    end;
  finally
    DBServDM.FecharFDQuery1;
  end;
end;

end.
