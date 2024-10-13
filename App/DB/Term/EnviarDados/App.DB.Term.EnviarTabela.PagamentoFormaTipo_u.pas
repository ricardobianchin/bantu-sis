unit App.DB.Term.EnviarTabela.PagamentoFormaTipo_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB{, Data.FmtBcd};

type
  TRegistro = record
    PAGAMENTO_FORMA_TIPO_ID: string;
    DESCR: string;
    DESCR_RED: string;
    ATIVO: Boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabPagamentoFormaTipo = class(TEnviarTabela)
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

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u;

{ TEnvTabPagamentoFormaTipo }

function TEnvTabPagamentoFormaTipo.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.DESCR;
  FAltDBExec.Params[1].AsString := pReg.DESCR_RED;
  FAltDBExec.Params[2].AsBoolean := pReg.ATIVO;
  FAltDBExec.Params[3].AsString := pReg.PAGAMENTO_FORMA_TIPO_ID;
  FAltDBExec.Execute;
end;

function TEnvTabPagamentoFormaTipo.BusqueRegNoArr(pReg: TRegistro;
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
    if RegAtual.PAGAMENTO_FORMA_TIPO_ID = pReg.PAGAMENTO_FORMA_TIPO_ID then
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

      Iguais := RegAtual.ATIVO = pReg.ATIVO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabPagamentoFormaTipo.CompareLocais: Boolean;
var
  Q: TDataSet;
  sSql: string;
  RegServ: TRegistro;
  eResultado: TResultadoBusca;
begin
  Result := True;

  sSql := GetSqlIns;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//  {$ENDIF}
  FInsDBExec := DBExecCreate('env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := GetSqlAlt;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//  {$ENDIF}
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

constructor TEnvTabPagamentoFormaTipo.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PAGAMENTO_FORMA_TIPO';
end;

procedure TEnvTabPagamentoFormaTipo.DataSetToItemArray(
  pLocal: TDBConnectionLocation; Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].PAGAMENTO_FORMA_TIPO_ID := Q.Fields[0].AsString;
  A[i].DESCR := Q.Fields[1].AsString;
  A[i].DESCR_RED := Q.Fields[2].AsString;
  A[i].ATIVO := Q.Fields[3].AsBoolean;
end;

function TEnvTabPagamentoFormaTipo.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.PAGAMENTO_FORMA_TIPO_ID := Q.Fields[0].AsString;
  Result.DESCR := Q.Fields[1].AsString;
  Result.DESCR_RED := Q.Fields[2].AsString;
  Result.ATIVO := Q.Fields[3].AsBoolean;
end;

function TEnvTabPagamentoFormaTipo.Execute: Boolean;
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

function TEnvTabPagamentoFormaTipo.GetQtdRegs(
  pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  sSql := GetSqlQtdRegs;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabPagamentoFormaTipo.GetSqlAlt: string;
begin
  Result := //
    'UPDATE PAGAMENTO_FORMA_TIPO SET' //

    + ' DESCR = :DESCR' //
    + ', DESCR_RED = :DESCR_RED' //
    + ', ATIVO = :ATIVO' //

    + ' WHERE PAGAMENTO_FORMA_TIPO_ID = :PAGAMENTO_FORMA_TIPO_ID' //
    + ';';

end;

function TEnvTabPagamentoFormaTipo.GetSqlIns: string;
begin
  Result := //
    'INSERT INTO PAGAMENTO_FORMA_TIPO (' //

    + 'PAGAMENTO_FORMA_TIPO_ID' //
    + ', DESCR' //
    + ', DESCR_RED' //
    + ', ATIVO' //

    + ') VALUES (' //

    + ':PAGAMENTO_FORMA_TIPO_ID' //
    + ', :DESCR' //
    + ', :DESCR_RED' //
    + ', :ATIVO' //

    + ');'; //

end;

function TEnvTabPagamentoFormaTipo.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome + ';';
end;

function TEnvTabPagamentoFormaTipo.GetSqlTodos: string;
begin
  Result := 'SELECT PAGAMENTO_FORMA_TIPO_ID, DESCR, DESCR_RED, ATIVO' //
    + ' FROM PAGAMENTO_FORMA_TIPO' //
    + ' ORDER BY PAGAMENTO_FORMA_TIPO_ID'; //
end;

function TEnvTabPagamentoFormaTipo.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsString := pReg.PAGAMENTO_FORMA_TIPO_ID;
  FInsDBExec.Params[1].AsString := pReg.DESCR;
  FInsDBExec.Params[2].AsString := pReg.DESCR_RED;
  FInsDBExec.Params[3].AsBoolean := pReg.ATIVO;
  FInsDBExec.Execute;
end;

procedure TEnvTabPagamentoFormaTipo.PreenchaArr(pLocal: TDBConnectionLocation);
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
