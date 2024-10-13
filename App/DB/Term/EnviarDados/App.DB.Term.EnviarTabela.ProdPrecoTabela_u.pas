unit App.DB.Term.EnviarTabela.ProdPrecoTabela_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, Data.SqlTimSt;

type
  TRegistro = record
    PROD_PRECO_TABELA_ID: smallint;
    NOME: string;
    PERC: currency;
    ATIVO: Boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabProdPrecoTabela = class(TEnviarTabela)
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

{ TEnvTabProdPrecoTabela }

function TEnvTabProdPrecoTabela.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FAltDBExec.Params[0].AsString := pReg.NOME;
  FAltDBExec.Params[1].AsCurrency := pReg.PERC;
  FAltDBExec.Params[2].AsBoolean := pReg.ATIVO;
  FAltDBExec.Params[3].AsSmallInt := pReg.PROD_PRECO_TABELA_ID;

  FAltDBExec.Execute;
end;

function TEnvTabProdPrecoTabela.BusqueRegNoArr(pReg: TRegistro;
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
    if pReg.PROD_PRECO_TABELA_ID = RegAtual.PROD_PRECO_TABELA_ID then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.NOME = pReg.NOME;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.PERC = pReg.PERC;
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

function TEnvTabProdPrecoTabela.CompareLocais: Boolean;
var
  Q: TDataSet;
  sSql: string;
  RegServ: TRegistro;
  eResultado: TResultadoBusca;
begin
  Result := True;

  sSql := GetSqlIns;
  {$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
  {$ENDIF}
  FInsDBExec := DBExecCreate('env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := GetSqlAlt;
  {$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
  {$ENDIF}
  FAltDBExec := DBExecCreate('env.alt.exec', Conn[loTerm], sSql, nil, nil);
  FAltDBExec.Prepare;

  sSql := GetSqlTodos;
  {$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
  {$ENDIF}

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

constructor TEnvTabProdPrecoTabela.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PROD_PRECO_TABELA';
end;

procedure TEnvTabProdPrecoTabela.DataSetToItemArray(
  pLocal: TDBConnectionLocation; Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].PROD_PRECO_TABELA_ID := Q.Fields[0].AsInteger;
  A[i].NOME := Q.Fields[1].AsString;
  A[i].PERC := Q.Fields[2].AsCurrency;
  A[i].ATIVO := Q.Fields[3].AsBoolean;
end;

function TEnvTabProdPrecoTabela.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.PROD_PRECO_TABELA_ID := Q.Fields[0].AsInteger;
  Result.NOME := Q.Fields[1].AsString;
  Result.PERC := Q.Fields[2].AsCurrency;
  Result.ATIVO := Q.Fields[3].AsBoolean;
end;

function TEnvTabProdPrecoTabela.Execute: Boolean;
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

function TEnvTabProdPrecoTabela.GetQtdRegs(
  pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabProdPrecoTabela.GetSqlAlt: string;
begin
  Result := //
    'UPDATE PROD_PRECO_TABELA SET'#13#10 //

    + 'NOME = :NOME'#13#10 //
    + ', PERC = :PERC'#13#10 //
    + ', ATIVO = :ATIVO'#13#10 //

    + 'WHERE PROD_PRECO_TABELA_ID = :PROD_PRECO_TABELA_ID'#13#10 //

    + ';';
end;

function TEnvTabProdPrecoTabela.GetSqlIns: string;
begin
  Result := 'INSERT INTO PROD_PRECO_TABELA ('#13#10 //
    + 'PROD_PRECO_TABELA_ID'#13#10 //
    + ', NOME'#13#10 //
    + ', PERC'#13#10 //
    + ', ATIVO'#13#10 //

    + ') VALUES('#13#10 //

    + ':PROD_PRECO_TABELA_ID'#13#10 //
    + ', :NOME'#13#10 //
    + ', :PERC'#13#10 //
    + ', :ATIVO'#13#10 //

    + ');';
end;

function TEnvTabProdPrecoTabela.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome + ';';
end;

function TEnvTabProdPrecoTabela.GetSqlQtdRegsTerm: string;
begin
  Result := GetSqlQtdRegs;
end;

function TEnvTabProdPrecoTabela.GetSqlTodos: string;
begin
  Result := //
    'SELECT PROD_PRECO_TABELA_ID, NOME, PERC, ATIVO'#13#10 //
    +'FROM PROD_PRECO_TABELA'#13#10 //
    +'ORDER BY PROD_PRECO_TABELA_ID'#13#10 //
    ;
end;

function TEnvTabProdPrecoTabela.GetSqlTodosTerm: string;
begin
  Result := GetSqlTodos;
end;

function TEnvTabProdPrecoTabela.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.PROD_PRECO_TABELA_ID;
  FInsDBExec.Params[1].AsString := pReg.NOME;
  FInsDBExec.Params[2].AsCurrency := pReg.PERC;
  FInsDBExec.Params[3].AsBoolean := pReg.ATIVO;

  FInsDBExec.Execute;
end;

procedure TEnvTabProdPrecoTabela.PreenchaArr(pLocal: TDBConnectionLocation);
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
