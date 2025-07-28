unit App.Retag.Est.ProdSelectDBI_u;

interface

uses Sis.DBI_u, App.Retag.Est.ProdSelectDBI, Sis.DB.DBTypes, App.AppObj,
  System.Variants, Sis.Entities.Types;

type
  TProdSelectDBI = class(TDBI, IProdSelectDBI)
  private
    FAppObj: IAppObj;
    FTerminalId: TTerminalId;
  protected
    function GetSqlForEach(pValues: variant): string; override;
  public
    function GetNomeArqTabView(pValues: variant): string; override;

    procedure PegarProd(pProdId: integer; var pValues: variant;
      out pErroDeu: boolean; out pErroMens: string);

    constructor Create(pDBConnection: IDBConnection; pAppObj: IAppObj;
      pTerminalId: TTerminalId); reintroduce;
  end;

implementation

uses App.Prod.BuscaTipo_u, Sis.Types.strings_u, System.SysUtils, Sis.Win.Utils_u,
  Sis.DB.Factory, Sis.DB.DataSet.Utils;

{ TProdSelectDBI }

constructor TProdSelectDBI.Create(pDBConnection: IDBConnection;
  pAppObj: IAppObj;
      pTerminalId: TTerminalId);
begin
  inherited Create(pDBConnection);
  FAppObj := pAppObj;
  FTerminalId := pTerminalId;
end;

function TProdSelectDBI.GetNomeArqTabView(pValues: variant): string;
var
  sNomeArq: string;
begin
  sNomeArq := FAppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\tabview.est.prod.prodselect.csv';

  Result := sNomeArq;
end;

function TProdSelectDBI.GetSqlForEach(pValues: variant): string;
var
  sBusca: string;
  eBuscaTipo: TProdBuscaTipo;
  sWhere: string;
begin
  sBusca := VarToString(pValues[0]);
  eBuscaTipo := StrToProdBuscaTipo(sBusca);

  case eBuscaTipo of
    prodbusProdId:
      sWhere := 'P.PROD_ID = ' + sBusca;
    prodbusBarras:
      sWhere := 'B.COD_BARRAS = ' + QuotedStr(sBusca);
    prodbusDescr:
      sWhere := 'P.DESCR_RED LIKE ' + QuotedStr('%' + sBusca + '%');
  Else
    sWhere := '1 = 1'; // Nenhum registro será retornado
  end;

  // TABELA Ambiente_Sis TEM SEMPRE SOMENTE UM REGISTRO
  Result := 'SELECT'#13#10 //

    + 'P.PROD_ID,'#13#10 // 0
    + 'P.DESCR_RED,'#13#10 // 1
    + 'F.NOME AS FABR,'#13#10 // 2
    + 'C.BALANCA_EXIGE,'#13#10 // 3
    + 'PC.CUSTO,'#13#10 // 4
    + 'C.MARGEM,'#13#10 // 5
    + 'PR.PRECO,'#13#10 // 6
    + 'LIST(B.COD_BARRAS) BARRAS'#13#10 // 7

    + 'FROM AMBIENTE_SIS A'#13#10 //

    + 'JOIN PROD_COMPL C ON'#13#10 //
    + 'A.LOJA_ID = C.LOJA_ID'#13#10 //

    + 'JOIN PROD P ON'#13#10 //
    + 'P.PROD_ID = C.PROD_ID'#13#10 //

    + 'JOIN FABR F ON'#13#10 //
    + 'F.FABR_ID = P.FABR_ID'#13#10 //

    + 'LEFT JOIN PROD_BARRAS B ON'#13#10 //
    + 'P.PROD_ID = B.PROD_ID'#13#10 //

    + 'LEFT JOIN PROD_PRECO PR ON'#13#10 //
    + 'P.PROD_ID = PR.PROD_ID'#13#10 //
    + 'AND A.LOJA_ID = PR.LOJA_ID'#13#10 //
    + 'AND A.TERMINAL_ID = PR.TERMINAL_ID'#13#10 //

    + 'LEFT JOIN PROD_CUSTO PC ON'#13#10 //
    + 'P.PROD_ID = PC.PROD_ID'#13#10 //
    + 'AND A.LOJA_ID = PC.LOJA_ID'#13#10 //
    + 'AND A.TERMINAL_ID = PC.TERMINAL_ID'#13#10 //

    + 'WHERE ' + sWhere + #13#10 //
    + 'GROUP BY P.PROD_ID, P.DESCR_RED, F.NOME, C.BALANCA_EXIGE'#13#10 //
    + ', PC.CUSTO, C.MARGEM, PR.PRECO'#13#10 //
    + 'ORDER BY P.DESCR_RED'#13#10 //
    ;

//   {$IFDEF DEBUG}
//   CopyTextToClipboard(Result);
//   {$ENDIF}
end;

procedure TProdSelectDBI.PegarProd(pProdId: integer; var pValues: variant;
  out pErroDeu: boolean; out pErroMens: string);
var
  sSql: string;
  vParametros: variant;
  Q: IDBQuery;
  DataSetWasEmpty: boolean;
begin
  pErroDeu := False;
  pErroMens := '';

  vParametros := VarArrayCreate([0, 0], varVariant);
  vParametros[0] := pProdId;

  sSql := GetSqlForEach(vParametros);

  Q := DBQueryCreate('prod.select.q', DBConnection, sSql, nil, nil);
  try
    Q.Open;
    if not Q.DataSet.Eof then
    begin
      RecordToVarArray(pValues, Q.DataSet, DataSetWasEmpty);
      if DataSetWasEmpty then
      begin
        pErroDeu := True;
        pErroMens := 'Produto não encontrado ou inválido.';
      end;
    end
    else
    begin
      pErroDeu := True;
      pErroMens := 'Produto não encontrado ou inválido.';
    end;
  except
    on E: Exception do
    begin
      pErroDeu := True;
      pErroMens := 'Erro ao buscar produto: ' + E.Message;
    end;
  end;

//  pValues[0] := pProdId;
//  pValues[1] := 'PROD TESTE';
end;

end.
