unit App.DB.Term.EnviarTabela.PagamentoForma_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB, Data.FmtBcd;

type
  TRegistro = record
    PAGAMENTO_FORMA_ID: smallint;
    PAGAMENTO_FORMA_TIPO_ID: string;
    DESCR: string;
    DESCR_RED: string;
    ATIVO: Boolean;
    PARA_VENDA: Boolean;
    Sis: Boolean;
    PROMOCAO_PERMITE: Boolean;
    COMISSAO_PERMITE: Boolean;
    TAXA_ADM_PERC: Currency;
    VALOR_MINIMO: TBcd;
    COMISSAO_ABATER_PERC: Currency;
    REEMBOLSO_DIAS: smallint;
    TEF_USA: Boolean;
    AUTORIZACAO_EXIGE: Boolean;
    PESSOA_EXIGE: Boolean;
    A_VISTA: Boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabPagamentoForma = class(TEnviarTabela)
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
    function GetSqlTodos: string;
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

{ TEnvTabPagamentoForma }

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u;

function TEnvTabPagamentoForma.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.PAGAMENTO_FORMA_TIPO_ID;
  FAltDBExec.Params[1].AsString := pReg.DESCR;
  FAltDBExec.Params[2].AsString := pReg.DESCR_RED;
  FAltDBExec.Params[3].AsBoolean := pReg.ATIVO;
  FAltDBExec.Params[4].AsBoolean := pReg.PARA_VENDA;
  FAltDBExec.Params[5].AsBoolean := pReg.Sis;
  FAltDBExec.Params[6].AsBoolean := pReg.PROMOCAO_PERMITE;
  FAltDBExec.Params[7].AsBoolean := pReg.COMISSAO_PERMITE;
  FAltDBExec.Params[8].AsCurrency := pReg.TAXA_ADM_PERC;
  FAltDBExec.Params[9].AsFMTBCD  := pReg.VALOR_MINIMO;
  FAltDBExec.Params[10].AsCurrency := pReg.COMISSAO_ABATER_PERC;
  FAltDBExec.Params[11].AsSmallInt := pReg.REEMBOLSO_DIAS;
  FAltDBExec.Params[12].AsBoolean := pReg.TEF_USA;
  FAltDBExec.Params[13].AsBoolean := pReg.AUTORIZACAO_EXIGE;
  FAltDBExec.Params[14].AsBoolean := pReg.PESSOA_EXIGE;
  FAltDBExec.Params[15].AsBoolean := pReg.A_VISTA;
  FAltDBExec.Params[16].AsSmallInt := pReg.PAGAMENTO_FORMA_ID;
  FAltDBExec.Execute;
end;

function TEnvTabPagamentoForma.BusqueRegNoArr(pReg: TRegistro;
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
    if RegAtual.PAGAMENTO_FORMA_ID = pReg.PAGAMENTO_FORMA_ID then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.PAGAMENTO_FORMA_TIPO_ID = pReg.PAGAMENTO_FORMA_TIPO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

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

      Iguais := RegAtual.ATIVO = pReg.ATIVO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PARA_VENDA = pReg.PARA_VENDA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.Sis = pReg.Sis;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PROMOCAO_PERMITE = pReg.PROMOCAO_PERMITE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.COMISSAO_PERMITE = pReg.COMISSAO_PERMITE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.TAXA_ADM_PERC = pReg.TAXA_ADM_PERC;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.VALOR_MINIMO = pReg.VALOR_MINIMO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.COMISSAO_ABATER_PERC = pReg.COMISSAO_ABATER_PERC;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.REEMBOLSO_DIAS = pReg.REEMBOLSO_DIAS;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.TEF_USA = pReg.TEF_USA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.AUTORIZACAO_EXIGE = pReg.AUTORIZACAO_EXIGE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PESSOA_EXIGE = pReg.PESSOA_EXIGE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.A_VISTA = pReg.A_VISTA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabPagamentoForma.CompareLocais: Boolean;
var
  Q: TDataSet;
  sSql: string;
  RegServ: TRegistro;
  eResultado: TResultadoBusca;
begin
  Result := True;

  sSql := GetSqlIns;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  FInsDBExec := DBExecCreate('env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := GetSqlAlt;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  FAltDBExec := DBExecCreate('env.alt.exec', Conn[loTerm], sSql, nil, nil);
  FAltDBExec.Prepare;

  sSql := GetSqlTodos;
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

constructor TEnvTabPagamentoForma.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PAGAMENTO_FORMA';
end;

procedure TEnvTabPagamentoForma.DataSetToItemArray
  (pLocal: TDBConnectionLocation; Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].PAGAMENTO_FORMA_ID := Q.Fields[0].AsInteger;
  A[i].PAGAMENTO_FORMA_TIPO_ID := Q.Fields[1].AsString;
  A[i].DESCR := Q.Fields[2].AsString;
  A[i].DESCR_RED := Q.Fields[3].AsString;
  A[i].ATIVO := Q.Fields[4].AsBoolean;
  A[i].PARA_VENDA := Q.Fields[5].AsBoolean;
  A[i].Sis := Q.Fields[6].AsBoolean;
  A[i].PROMOCAO_PERMITE := Q.Fields[7].AsBoolean;
  A[i].COMISSAO_PERMITE := Q.Fields[8].AsBoolean;
  A[i].TAXA_ADM_PERC := Q.Fields[9].AsCurrency;
  A[i].VALOR_MINIMO := Q.Fields[10].AsBCD;
  A[i].COMISSAO_ABATER_PERC := Q.Fields[11].AsCurrency;
  A[i].REEMBOLSO_DIAS := Q.Fields[12].AsInteger;
  A[i].TEF_USA := Q.Fields[13].AsBoolean;
  A[i].AUTORIZACAO_EXIGE := Q.Fields[14].AsBoolean;
  A[i].PESSOA_EXIGE := Q.Fields[15].AsBoolean;
  A[i].A_VISTA := Q.Fields[16].AsBoolean;
end;

function TEnvTabPagamentoForma.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.PAGAMENTO_FORMA_ID := Q.Fields[0].AsInteger;
  Result.PAGAMENTO_FORMA_TIPO_ID := Q.Fields[1].AsString;
  Result.DESCR := Q.Fields[2].AsString;
  Result.DESCR_RED := Q.Fields[3].AsString;
  Result.ATIVO := Q.Fields[4].AsBoolean;
  Result.PARA_VENDA := Q.Fields[5].AsBoolean;
  Result.Sis := Q.Fields[6].AsBoolean;
  Result.PROMOCAO_PERMITE := Q.Fields[7].AsBoolean;
  Result.COMISSAO_PERMITE := Q.Fields[8].AsBoolean;
  Result.TAXA_ADM_PERC := Q.Fields[9].AsCurrency;
  Result.VALOR_MINIMO := Q.Fields[10].AsBCD;
  Result.COMISSAO_ABATER_PERC := Q.Fields[11].AsCurrency;
  Result.REEMBOLSO_DIAS := Q.Fields[12].AsInteger;
  Result.TEF_USA := Q.Fields[13].AsBoolean;
  Result.AUTORIZACAO_EXIGE := Q.Fields[14].AsBoolean;
  Result.PESSOA_EXIGE := Q.Fields[15].AsBoolean;
  Result.A_VISTA := Q.Fields[16].AsBoolean;
end;

function TEnvTabPagamentoForma.Execute: Boolean;
begin
  FiQtdRegsTerm := GetQtdRegs(loTerm);

  SetLength(Arr[loTerm], FiQtdRegsTerm);
  try
  PreenchaArr(loTerm);

  Result := CompareLocais;
  finally
    SetLength(Arr[loTerm], 0);
  end;
end;

function TEnvTabPagamentoForma.GetQtdRegs
  (pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  sSql := GetSqlQtdRegs;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabPagamentoForma.GetSqlAlt: string;
begin
  Result := //
    'UPDATE PAGAMENTO_FORMA SET' //

    + ' PAGAMENTO_FORMA_TIPO_ID = :PAGAMENTO_FORMA_TIPO_ID' //
    + ', DESCR = :DESCR' //
    + ', DESCR_RED = :DESCR_RED' //
    + ', ATIVO = :ATIVO' //
    + ', PARA_VENDA = :PARA_VENDA' //
    + ', SIS = :SIS' //
    + ', PROMOCAO_PERMITE = :PROMOCAO_PERMITE' //
    + ', COMISSAO_PERMITE = :COMISSAO_PERMITE' //
    + ', TAXA_ADM_PERC = :TAXA_ADM_PERC' //
    + ', VALOR_MINIMO = :VALOR_MINIMO' //
    + ', COMISSAO_ABATER_PERC = :COMISSAO_ABATER_PERC' //
    + ', REEMBOLSO_DIAS = :REEMBOLSO_DIAS' //
    + ', TEF_USA = :TEF_USA' //
    + ', AUTORIZACAO_EXIGE = :AUTORIZACAO_EXIGE' //
    + ', PESSOA_EXIGE = :PESSOA_EXIGE' //
    + ', A_VISTA = :A_VISTA' //

    + ' WHERE PAGAMENTO_FORMA_ID = :PAGAMENTO_FORMA_ID' //
    + ';';
end;

function TEnvTabPagamentoForma.GetSqlIns: string;
begin
  Result := //
    'INSERT INTO PAGAMENTO_FORMA (' //

    + 'PAGAMENTO_FORMA_ID' //
    + ', PAGAMENTO_FORMA_TIPO_ID' //
    + ', DESCR' //
    + ', DESCR_RED' //
    + ', ATIVO' //
    + ', PARA_VENDA' //
    + ', SIS' //
    + ', PROMOCAO_PERMITE' //
    + ', COMISSAO_PERMITE' //
    + ', TAXA_ADM_PERC' //
    + ', VALOR_MINIMO' //
    + ', COMISSAO_ABATER_PERC' //
    + ', REEMBOLSO_DIAS' //
    + ', TEF_USA' //
    + ', AUTORIZACAO_EXIGE' //
    + ', PESSOA_EXIGE' //
    + ', A_VISTA' //

    + ') VALUES (' //

    + ':PAGAMENTO_FORMA_ID' //
    + ', :PAGAMENTO_FORMA_TIPO_ID' //
    + ', :DESCR' //
    + ', :DESCR_RED' //
    + ', :ATIVO' //
    + ', :PARA_VENDA' //
    + ', :SIS' //
    + ', :PROMOCAO_PERMITE' //
    + ', :COMISSAO_PERMITE' //
    + ', :TAXA_ADM_PERC' //
    + ', :VALOR_MINIMO' //
    + ', :COMISSAO_ABATER_PERC' //
    + ', :REEMBOLSO_DIAS' //
    + ', :TEF_USA' //
    + ', :AUTORIZACAO_EXIGE' //
    + ', :PESSOA_EXIGE' //
    + ', :A_VISTA' //

    + ');'; //
end;

function TEnvTabPagamentoForma.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome + ';';
end;

function TEnvTabPagamentoForma.GetSqlTodos: string;
begin
  Result := 'SELECT PAGAMENTO_FORMA_ID, PAGAMENTO_FORMA_TIPO_ID, DESCR' //
    + ', DESCR_RED, ATIVO, PARA_VENDA, SIS, PROMOCAO_PERMITE, COMISSAO_PERMITE'
    + ', TAXA_ADM_PERC, VALOR_MINIMO, COMISSAO_ABATER_PERC, REEMBOLSO_DIAS' //
    + ', TEF_USA, AUTORIZACAO_EXIGE, PESSOA_EXIGE, A_VISTA' //
    + ' FROM PAGAMENTO_FORMA' //
    + ' ORDER BY PAGAMENTO_FORMA_ID'; //
end;

function TEnvTabPagamentoForma.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.PAGAMENTO_FORMA_ID;
  FInsDBExec.Params[1].AsString := pReg.PAGAMENTO_FORMA_TIPO_ID;
  FInsDBExec.Params[2].AsString := pReg.DESCR;
  FInsDBExec.Params[3].AsString := pReg.DESCR_RED;
  FInsDBExec.Params[4].AsBoolean := pReg.ATIVO;
  FInsDBExec.Params[5].AsBoolean := pReg.PARA_VENDA;
  FInsDBExec.Params[6].AsBoolean := pReg.Sis;
  FInsDBExec.Params[7].AsBoolean := pReg.PROMOCAO_PERMITE;
  FInsDBExec.Params[8].AsBoolean := pReg.COMISSAO_PERMITE;
  FInsDBExec.Params[9].AsCurrency := pReg.TAXA_ADM_PERC;
  FInsDBExec.Params[10].AsFMTBCD  := pReg.VALOR_MINIMO;
  FInsDBExec.Params[11].AsCurrency := pReg.COMISSAO_ABATER_PERC;
  FInsDBExec.Params[12].AsSmallInt := pReg.REEMBOLSO_DIAS;
  FInsDBExec.Params[13].AsBoolean := pReg.TEF_USA;
  FInsDBExec.Params[14].AsBoolean := pReg.AUTORIZACAO_EXIGE;
  FInsDBExec.Params[15].AsBoolean := pReg.PESSOA_EXIGE;
  FInsDBExec.Params[16].AsBoolean := pReg.A_VISTA;
  FInsDBExec.Execute;
end;

procedure TEnvTabPagamentoForma.PreenchaArr(pLocal: TDBConnectionLocation);
var
  sSql: string;
  i: integer;
  Q: TDataSet;
begin
  sSql := GetSqlTodos;
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
