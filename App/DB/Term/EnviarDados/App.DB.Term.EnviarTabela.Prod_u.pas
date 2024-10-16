unit App.DB.Term.EnviarTabela.Prod_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB, Data.FmtBcd;

type
  TRegistro = record
    PROD_ID: integer;
    DESCR: string;
    DESCR_RED: string;
    FABR_ID: SmallInt;
    PROD_TIPO_ID: SmallInt;
    UNID_ID: SmallInt;
    ICMS_ID: SmallInt;
    CAPAC_EMB: Currency;
    NCM: string;
    DE_SISTEMA: Boolean;
    FABR_NOME: string;
    PROD_TIPO_DESCR: string;
    UNID_DESCR: string;
    UNID_SIGLA: string;
    ICMS_SIGLA: string;
    ICMS_DESCR: string;
    ICMS_PERC: Currency;
    ATIVO: Boolean;
    LOCALIZ: string;
    BAL_USO: SmallInt;
    CUSTO: Currency;
    PRECO: Currency;
    //CUSTO: TBcd;
    //PRECO: TBcd;
    CRIADO_EM: TDateTime;
    ALTERADO_EM: TDateTime;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabProd = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    Arr: array [TDBConnectionLocation] of TRegistrosArray;
    FiQtdRegsTerm: integer;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    FAltDBExec: IDBExec;
    function DataSetToRecord(Q: TDataSet): TRegistro;
    function Inserir(pLocal: TDBConnectionLocation; pReg: TRegistro): Boolean;
    function Atualizar(pLocal: TDBConnectionLocation; pReg: TRegistro): Boolean;

  protected
    function GetQtdRegs(pLocal: TDBConnectionLocation): integer;
    procedure PreenchaArr(pLocal: TDBConnectionLocation);
    procedure DataSetToItemArray(pLocal: TDBConnectionLocation; Q: TDataSet;
      i: integer);
    function GetSqlQtdRegs: string;
    function GetSqlQtdRegsTerm: string;

    function GetSqlTodos: string;
    function GetSqlTodosTerm: string;
    function GetSqlIns: string;
    function GetSqlAlt: string;

    function CompareLocais: Boolean;
    function BusqueRegNoArr(pReg: TRegistro; pLocal: TDBConnectionLocation)
      : TResultadoBusca;
  public
    function Execute: Boolean; override;
    constructor Create(pServ, pTerm: IDBConnection);
  end;

implementation

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u;

{ TEnvTabProd }

function TEnvTabProd.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.DESCR;
  FAltDBExec.Params[1].AsString := pReg.DESCR_RED;
  FAltDBExec.Params[2].AsSmallInt := pReg.FABR_ID;
  FAltDBExec.Params[3].AsSmallInt := pReg.PROD_TIPO_ID;
  FAltDBExec.Params[4].AsSmallInt := pReg.UNID_ID;
  FAltDBExec.Params[5].AsSmallInt := pReg.ICMS_ID;
  FAltDBExec.Params[6].AsCurrency := pReg.CAPAC_EMB;
  FAltDBExec.Params[7].AsString := pReg.NCM;
  FAltDBExec.Params[8].AsBoolean := pReg.DE_SISTEMA;
  FAltDBExec.Params[9].AsString := pReg.FABR_NOME;
  FAltDBExec.Params[10].AsString := pReg.PROD_TIPO_DESCR;
  FAltDBExec.Params[11].AsString := pReg.UNID_DESCR;
  FAltDBExec.Params[12].AsString := pReg.UNID_SIGLA;
  FAltDBExec.Params[13].AsString := pReg.ICMS_SIGLA;
  FAltDBExec.Params[14].AsString := pReg.ICMS_DESCR;
  FAltDBExec.Params[15].AsCurrency := pReg.ICMS_PERC;
  FAltDBExec.Params[16].AsBoolean := pReg.ATIVO;
  FAltDBExec.Params[17].AsString := pReg.LOCALIZ;
  FAltDBExec.Params[18].AsSmallInt := pReg.BAL_USO;

  SetParamCurrency(FInsDBExec.Params[19], pReg.CUSTO);
  SetParamCurrency(FInsDBExec.Params[20], pReg.PRECO);

  SetParamDateTime(FAltDBExec.Params[21], pReg.CRIADO_EM);
  SetParamDateTime(FAltDBExec.Params[22], pReg.ALTERADO_EM);

  FAltDBExec.Params[23].AsInteger := pReg.PROD_ID;

  FAltDBExec.Execute;
end;

function TEnvTabProd.BusqueRegNoArr(pReg: TRegistro;
  pLocal: TDBConnectionLocation): TResultadoBusca;
var
  i: integer;
  RegAtual: TRegistro;
  Iguais: Boolean;
begin
  Result := TResultadoBusca.rbNaoTem;
  for i := 0 to Length(Arr[pLocal]) - 1 do
  begin
    RegAtual := Arr[pLocal][i];
    if pReg.PROD_ID = RegAtual.PROD_ID then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.DESCR = pReg.DESCR;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.DESCR_RED = pReg.DESCR_RED;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.FABR_ID = pReg.FABR_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PROD_TIPO_ID = pReg.PROD_TIPO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.NCM = pReg.NCM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ICMS_ID = pReg.ICMS_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CAPAC_EMB = pReg.CAPAC_EMB;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.DE_SISTEMA = pReg.DE_SISTEMA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.FABR_NOME = pReg.FABR_NOME;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PROD_TIPO_DESCR = pReg.PROD_TIPO_DESCR;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.UNID_DESCR = pReg.UNID_DESCR;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.UNID_SIGLA = pReg.UNID_SIGLA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ICMS_DESCR = pReg.ICMS_DESCR;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ICMS_PERC = pReg.ICMS_PERC;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ATIVO = pReg.ATIVO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.LOCALIZ = pReg.LOCALIZ;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BAL_USO = pReg.BAL_USO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CUSTO = pReg.CUSTO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PRECO = pReg.PRECO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CRIADO_EM = pReg.CRIADO_EM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ALTERADO_EM = pReg.ALTERADO_EM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabProd.CompareLocais: Boolean;
var
  Q: TDataSet;
  sSql: string;
  RegServ: TRegistro;
  eResultado: TResultadoBusca;
begin
  Result := True;

  sSql := GetSqlIns;
//   {$IFDEF DEBUG}
//   CopyTextToClipboard(sSql);
//   {$ENDIF}
  FInsDBExec := DBExecCreate('env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := GetSqlAlt;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  FAltDBExec := DBExecCreate('env.alt.exec', Conn[loTerm], sSql, nil, nil);
  FAltDBExec.Prepare;

  sSql := GetSqlTodos;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}

  Conn[loServ].QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      RegServ := DataSetToRecord(Q);
      eResultado := BusqueRegNoArr(RegServ, loTerm);
      case eResultado of
        rbNaoTem:
          Inserir(loTerm, RegServ);
        rbTemDiferente:
          Atualizar(loTerm, RegServ);
        rbTemIgual:
          ;
      end;
      Q.Next;
    end;
  finally
    Q.Free;
    FInsDBExec.Unprepare;
    FAltDBExec.Unprepare;
  end;
end;

constructor TEnvTabProd.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PROD';
end;

procedure TEnvTabProd.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];

  A[i].PROD_ID := Q.Fields[0].AsInteger;
  A[i].DESCR := Q.Fields[1].AsString;
  A[i].DESCR_RED := Q.Fields[2].AsString;
  A[i].FABR_ID := Q.Fields[3].AsInteger;
  A[i].PROD_TIPO_ID := Q.Fields[4].AsInteger;
  A[i].UNID_ID := Q.Fields[5].AsInteger;
  A[i].ICMS_ID := Q.Fields[6].AsInteger;
  A[i].CAPAC_EMB := Q.Fields[7].AsCurrency;
  A[i].NCM := Q.Fields[8].AsString;
  A[i].DE_SISTEMA := Q.Fields[9].AsBoolean;
  A[i].FABR_NOME := Q.Fields[10].AsString;
  A[i].PROD_TIPO_DESCR := Q.Fields[11].AsString;
  A[i].UNID_DESCR := Q.Fields[12].AsString;
  A[i].UNID_SIGLA := Q.Fields[13].AsString;
  A[i].ICMS_SIGLA := Q.Fields[14].AsString;
  A[i].ICMS_DESCR := Q.Fields[15].AsString;
  A[i].ICMS_PERC := Q.Fields[16].AsCurrency;
  A[i].ATIVO := Q.Fields[17].AsBoolean;
  A[i].LOCALIZ := Q.Fields[18].AsString;
  A[i].BAL_USO := Q.Fields[19].AsInteger;
  A[i].CUSTO := Q.Fields[20].AsCurrency;
  A[i].PRECO := Q.Fields[21].AsCurrency;
  A[i].CRIADO_EM := Q.Fields[22].AsDateTime;
  A[i].ALTERADO_EM := Q.Fields[23].AsDateTime;
end;

function TEnvTabProd.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.PROD_ID := Q.Fields[0].AsInteger;
  Result.DESCR := Q.Fields[1].AsString;
  Result.DESCR_RED := Q.Fields[2].AsString;
  Result.FABR_ID := Q.Fields[3].AsInteger;
  Result.PROD_TIPO_ID := Q.Fields[4].AsInteger;
  Result.UNID_ID := Q.Fields[5].AsInteger;
  Result.ICMS_ID := Q.Fields[6].AsInteger;
  Result.CAPAC_EMB := Q.Fields[7].AsCurrency;
  Result.NCM := Q.Fields[8].AsString;
  Result.DE_SISTEMA := Q.Fields[9].AsBoolean;
  Result.FABR_NOME := Q.Fields[10].AsString;
  Result.PROD_TIPO_DESCR := Q.Fields[11].AsString;
  Result.UNID_DESCR := Q.Fields[12].AsString;
  Result.UNID_SIGLA := Q.Fields[13].AsString;
  Result.ICMS_SIGLA := Q.Fields[14].AsString;
  Result.ICMS_DESCR := Q.Fields[15].AsString;
  Result.ICMS_PERC := Q.Fields[16].AsCurrency;
  Result.ATIVO := Q.Fields[17].AsBoolean;
  Result.LOCALIZ := Q.Fields[18].AsString;
  Result.BAL_USO := Q.Fields[19].AsInteger;
  Result.CUSTO := Q.Fields[20].AsCurrency;
  Result.PRECO := Q.Fields[21].AsCurrency;
  Result.CRIADO_EM := Q.Fields[22].AsDateTime;
  Result.ALTERADO_EM := Q.Fields[23].AsDateTime;
end;

function TEnvTabProd.Execute: Boolean;
begin
  FiQtdRegsTerm := GetQtdRegs(loTerm);

  SetLength(Arr[loTerm], FiQtdRegsTerm);
  try
    if FiQtdRegsTerm > 0 then
      PreenchaArr(loTerm);

    Result := CompareLocais;
  finally
    SetLength(Arr[loTerm], 0);
  end;
end;

function TEnvTabProd.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabProd.GetSqlAlt: string;
begin
  Result := //
    'UPDATE prod SET'#13#10 //

    + 'DESCR = :DESCR'#13#10 //
    + ', DESCR_RED = :DESCR_RED'#13#10 //
    + ', FABR_ID = :FABR_ID'#13#10 //
    + ', PROD_TIPO_ID = :PROD_TIPO_ID'#13#10 //
    + ', UNID_ID = :UNID_ID'#13#10 //
    + ', ICMS_ID = :ICMS_ID'#13#10 //
    + ', CAPAC_EMB = :CAPAC_EMB'#13#10 //
    + ', NCM = :NCM'#13#10 //
    + ', DE_SISTEMA = :DE_SISTEMA'#13#10 //
    + ', FABR_NOME = :FABR_NOME'#13#10 //
    + ', PROD_TIPO_DESCR = :PROD_TIPO_DESCR'#13#10 //
    + ', UNID_DESCR = :UNID_DESCR'#13#10 //
    + ', UNID_SIGLA = :UNID_SIGLA'#13#10 //
    + ', ICMS_SIGLA = :ICMS_SIGLA'#13#10 //
    + ', ICMS_DESCR = :ICMS_DESCR'#13#10 //
    + ', ICMS_PERC = :ICMS_PERC'#13#10 //
    + ', ATIVO = :ATIVO'#13#10 //
    + ', LOCALIZ = :LOCALIZ'#13#10 //
    + ', BAL_USO = :BAL_USO'#13#10 //
    + ', CUSTO = :CUSTO'#13#10 //
    + ', PRECO = :PRECO'#13#10 //
    + ', CRIADO_EM = :CRIADO_EM'#13#10 //
    + ', ALTERADO_EM = :ALTERADO_EM'#13#10 //

    + 'WHERE PROD_ID = :PROD_ID'#13#10 //

    + ';';
end;

function TEnvTabProd.GetSqlIns: string;
begin
  Result := 'INSERT INTO PROD ('#13#10 //
    + 'PROD_ID'#13#10 //
    + ', DESCR'#13#10 //
    + ', DESCR_RED'#13#10 //
    + ', FABR_ID'#13#10 //
    + ', PROD_TIPO_ID'#13#10 //
    + ', UNID_ID'#13#10 //
    + ', ICMS_ID'#13#10 //
    + ', CAPAC_EMB'#13#10 //
    + ', NCM'#13#10 //
    + ', DE_SISTEMA'#13#10 //
    + ', FABR_NOME'#13#10 //
    + ', PROD_TIPO_DESCR'#13#10 //
    + ', UNID_DESCR'#13#10 //
    + ', UNID_SIGLA'#13#10 //
    + ', ICMS_SIGLA'#13#10 //
    + ', ICMS_DESCR'#13#10 //
    + ', ICMS_PERC'#13#10 //
    + ', ATIVO'#13#10 //
    + ', LOCALIZ'#13#10 //
    + ', BAL_USO'#13#10 //
    + ', CUSTO'#13#10 //
    + ', PRECO'#13#10 //
    + ', CRIADO_EM'#13#10 //
    + ', ALTERADO_EM'#13#10 //

    + ') VALUES('#13#10 //

    + ':PROD_ID'#13#10 //
    + ', :DESCR'#13#10 //
    + ', :DESCR_RED'#13#10 //
    + ', :FABR_ID'#13#10 //
    + ', :PROD_TIPO_ID'#13#10 //
    + ', :UNID_ID'#13#10 //
    + ', :ICMS_ID'#13#10 //
    + ', :CAPAC_EMB'#13#10 //
    + ', :NCM'#13#10 //
    + ', :DE_SISTEMA'#13#10 //
    + ', :FABR_NOME'#13#10 //
    + ', :PROD_TIPO_DESCR'#13#10 //
    + ', :UNID_DESCR'#13#10 //
    + ', :UNID_SIGLA'#13#10 //
    + ', :ICMS_SIGLA'#13#10 //
    + ', :ICMS_DESCR'#13#10 //
    + ', :ICMS_PERC'#13#10 //
    + ', :ATIVO'#13#10 //
    + ', :LOCALIZ'#13#10 //
    + ', :BAL_USO'#13#10 //
    + ', :CUSTO'#13#10 //
    + ', :PRECO'#13#10 //
    + ', :CRIADO_EM'#13#10 //
    + ', :ALTERADO_EM'#13#10 //

    + ');';
end;

function TEnvTabProd.GetSqlQtdRegs: string;
begin
  Result := 'SELECT COUNT(*) FROM PROD'#13#10; //
end;

function TEnvTabProd.GetSqlQtdRegsTerm: string;
begin
  rESULT := GetSqlQtdRegs;
end;

function TEnvTabProd.GetSqlTodos: string;
begin
  Result := //
    'SELECT'#13#10 //
    + 'PROD.PROD_ID'#13#10 //
    + ', PROD.DESCR'#13#10 //
    + ', PROD.DESCR_RED'#13#10 //
    + ', FABR.FABR_ID'#13#10 //
    + ', PROD_TIPO.PROD_TIPO_ID'#13#10 //
    + ', UNID.UNID_ID'#13#10 //
    + ', ICMS.ICMS_ID'#13#10 //
    + ', PROD.CAPAC_EMB'#13#10 //
    + ', PROD.NCM'#13#10 //
    + ', PROD.DE_SISTEMA'#13#10 //
    + ', FABR.NOME FABR_NOME'#13#10 //
    + ', PROD_TIPO.DESCR PROD_TIPO_DESCR'#13#10 //
    + ', UNID.DESCR UNID_DESCR'#13#10 //
    + ', UNID.SIGLA UNID_SIGLA'#13#10 //
    + ', ICMS.SIGLA ICMS_SIGLA'#13#10 //
    + ', ICMS.DESCR ICMS_DESCR'#13#10 //
    + ', ICMS.PERC ICMS_PERC'#13#10 //
    + ', PROD_COMPL.ATIVO'#13#10 //
    + ', PROD_COMPL.LOCALIZ'#13#10 //
    + ', PROD_COMPL.BAL_USO'#13#10 //
    + ', PROD_CUSTO.CUSTO CUSTO'#13#10 //
    + ', PROD_PRECO.PRECO PRECO'#13#10 //
    + ', PROD.CRIADO_EM'#13#10 //
    + ', PROD.ALTERADO_EM'#13#10 //

    + 'FROM PROD'#13#10 //

    + 'JOIN PROD_COMPL ON'#13#10 //
    + 'PROD.PROD_ID = PROD_COMPL.PROD_ID'#13#10 //

    + 'JOIN LOJA ON'#13#10 //
    + 'LOJA.LOJA_ID = PROD_COMPL.LOJA_ID'#13#10 //
    + 'AND LOJA.SELECIONADO'#13#10 //

    + 'JOIN FABR ON'#13#10 //
    + 'PROD.FABR_ID = FABR.FABR_ID'#13#10 //

    + 'JOIN PROD_TIPO ON'#13#10 //
    + 'PROD.PROD_TIPO_ID = PROD_TIPO.PROD_TIPO_ID'#13#10 //

    + 'JOIN UNID ON'#13#10 //
    + 'PROD.UNID_ID = UNID.UNID_ID'#13#10 //

    + 'JOIN ICMS ON'#13#10 //
    + 'PROD.ICMS_ID = ICMS.ICMS_ID'#13#10 //

    + 'JOIN PROD_CUSTO ON'#13#10 //
    + 'PROD.PROD_ID = PROD_CUSTO.PROD_ID'#13#10 //
    +' AND LOJA.LOJA_ID = PROD_CUSTO.LOJA_ID'#13#10 //
    + 'AND LOJA.SELECIONADO'#13#10 //

    + 'JOIN PROD_PRECO ON'#13#10 //
    + 'PROD.PROD_ID = PROD_PRECO.PROD_ID'#13#10 //
    +' AND LOJA.LOJA_ID = PROD_PRECO.LOJA_ID'#13#10 //
    + 'AND LOJA.SELECIONADO'#13#10 //

    + 'ORDER BY PROD.PROD_ID;'#13#10 //
    ;
end;

function TEnvTabProd.GetSqlTodosTerm: string;
begin
  Result := //
    'SELECT'#13#10 //
    + 'PROD_ID'#13#10 //
    + ', DESCR'#13#10 //
    + ', DESCR_RED'#13#10 //
    + ', FABR_ID'#13#10 //
    + ', PROD_TIPO_ID'#13#10 //
    + ', UNID_ID'#13#10 //
    + ', ICMS_ID'#13#10 //
    + ', CAPAC_EMB'#13#10 //
    + ', NCM'#13#10 //
    + ', DE_SISTEMA'#13#10 //
    + ', FABR_NOME'#13#10 //
    + ', PROD_TIPO_DESCR'#13#10 //
    + ', UNID_DESCR'#13#10 //
    + ', UNID_SIGLA'#13#10 //
    + ', ICMS_SIGLA'#13#10 //
    + ', ICMS_DESCR'#13#10 //
    + ', ICMS_PERC'#13#10 //
    + ', ATIVO'#13#10 //
    + ', LOCALIZ'#13#10 //
    + ', BAL_USO'#13#10 //
    + ', CUSTO'#13#10 //
    + ', PRECO'#13#10 //
    + ', CRIADO_EM'#13#10 //
    + ', ALTERADO_EM'#13#10 //
    + 'FROM PROD'#13#10 //
    + 'ORDER BY PROD_ID;'#13#10 //
    ;
end;

function TEnvTabProd.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FInsDBExec.Params[0].AsInteger := pReg.PROD_ID;
  FInsDBExec.Params[1].AsString := pReg.DESCR;
  FInsDBExec.Params[2].AsString := pReg.DESCR_RED;
  FInsDBExec.Params[3].AsSmallInt := pReg.FABR_ID;
  FInsDBExec.Params[4].AsSmallInt := pReg.PROD_TIPO_ID;
  FInsDBExec.Params[5].AsSmallInt := pReg.UNID_ID;
  FInsDBExec.Params[6].AsSmallInt := pReg.ICMS_ID;
  FInsDBExec.Params[7].AsCurrency := pReg.CAPAC_EMB;
  FInsDBExec.Params[8].AsString := pReg.NCM;
  FInsDBExec.Params[9].AsBoolean := pReg.DE_SISTEMA;
  FInsDBExec.Params[10].AsString := pReg.FABR_NOME;
  FInsDBExec.Params[11].AsString := pReg.PROD_TIPO_DESCR;
  FInsDBExec.Params[12].AsString := pReg.UNID_DESCR;
  FInsDBExec.Params[13].AsString := pReg.UNID_SIGLA;
  FInsDBExec.Params[14].AsString := pReg.ICMS_SIGLA;
  FInsDBExec.Params[15].AsString := pReg.ICMS_DESCR;
  FInsDBExec.Params[16].AsCurrency := pReg.ICMS_PERC;
  FInsDBExec.Params[17].AsBoolean := pReg.ATIVO;
  FInsDBExec.Params[18].AsString := pReg.LOCALIZ;
  FInsDBExec.Params[19].AsSmallInt := pReg.BAL_USO;

  SetParamCurrency(FInsDBExec.Params[20], pReg.CUSTO);
  SetParamCurrency(FInsDBExec.Params[21], pReg.PRECO);

//  FInsDBExec.Params[20].AsBCD := pReg.CUSTO;
//  FInsDBExec.Params[21].AsFMTBCD := pReg.PRECO;

  SetParamDateTime(FInsDBExec.Params[22], pReg.CRIADO_EM);
  SetParamDateTime(FInsDBExec.Params[23], pReg.ALTERADO_EM);

  FInsDBExec.Execute;
end;

procedure TEnvTabProd.PreenchaArr(pLocal: TDBConnectionLocation);
var
  sSql: string;
  i: integer;
  Q: TDataSet;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlTodos
  else
    sSql := GetSqlTodosTerm;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//  {$ENDIF}

  Conn[pLocal].QueryDataSet(sSql, Q);

  i := 0;
  while not Q.Eof do
  begin
    DataSetToItemArray(pLocal, Q, i);
    Q.Next;
    inc(i);
  end;
  Q.Free;
end;

end.
