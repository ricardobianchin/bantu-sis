unit App.DB.Term.EnviarTabela.Terminal_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB;

type
  TRegistro = record
    TERMINAL_ID: smallint;
    APELIDO: string;
    NOME_NA_REDE: string;
    IP: string;
    NF_SERIE: smallint;
    LETRA_DO_DRIVE: string;
    GAVETA_TEM: Boolean;
    BALANCA_MODO_ID: smallint;
    BALANCA_ID: smallint;
    BARRAS_COD_INI: smallint;
    BARRAS_COD_TAM: smallint;
    CUPOM_NLINS_FINAL: smallint;
    SEMPRE_OFFLINE: Boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabTerminal = class(TEnviarTabela)
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

{ TEnvTabTerminal }

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u;

function TEnvTabTerminal.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.APELIDO;
  FAltDBExec.Params[1].AsString := pReg.NOME_NA_REDE;
  FAltDBExec.Params[2].AsString := pReg.IP;
  FAltDBExec.Params[3].AsSmallInt := pReg.NF_SERIE;
  FAltDBExec.Params[4].AsString := pReg.LETRA_DO_DRIVE;
  FAltDBExec.Params[5].AsBoolean := pReg.GAVETA_TEM;
  FAltDBExec.Params[6].AsSmallInt := pReg.BALANCA_MODO_ID;
  FAltDBExec.Params[7].AsSmallInt := pReg.BALANCA_ID;
  FAltDBExec.Params[8].AsSmallInt := pReg.BARRAS_COD_INI;
  FAltDBExec.Params[9].AsSmallInt := pReg.BARRAS_COD_TAM;
  FAltDBExec.Params[10].AsSmallInt := pReg.CUPOM_NLINS_FINAL;
  FAltDBExec.Params[11].AsBoolean := pReg.SEMPRE_OFFLINE;
  FAltDBExec.Params[12].AsSmallInt := pReg.TERMINAL_ID;
  FAltDBExec.Execute;
end;

function TEnvTabTerminal.BusqueRegNoArr(pReg: TRegistro;
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
    if RegAtual.TERMINAL_ID = pReg.TERMINAL_ID then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.APELIDO = pReg.APELIDO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.NOME_NA_REDE = pReg.NOME_NA_REDE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.IP = pReg.IP;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.NF_SERIE = pReg.NF_SERIE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.LETRA_DO_DRIVE = pReg.LETRA_DO_DRIVE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.GAVETA_TEM = pReg.GAVETA_TEM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_MODO_ID = pReg.BALANCA_MODO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_ID = pReg.BALANCA_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BARRAS_COD_INI = pReg.BARRAS_COD_INI;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BARRAS_COD_TAM = pReg.BARRAS_COD_TAM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CUPOM_NLINS_FINAL = pReg.CUPOM_NLINS_FINAL;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.SEMPRE_OFFLINE = pReg.SEMPRE_OFFLINE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabTerminal.CompareLocais: Boolean;
var
  Q: TDataSet;
  sSql: string;
  RegServ: TRegistro;
  eResultado: TResultadoBusca;
begin
  Result := True;

  sSql := GetSqlIns;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
  FInsDBExec := DBExecCreate('env.ins.exec', Conn[loTerm], sSql, nil, nil);
  FInsDBExec.Prepare;

  sSql := GetSqlAlt;
//{$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//{$ENDIF}
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

constructor TEnvTabTerminal.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'TERMINAL';
end;

procedure TEnvTabTerminal.DataSetToItemArray
  (pLocal: TDBConnectionLocation; Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].TERMINAL_ID := Q.Fields[0].AsInteger;
  A[i].APELIDO := Trim(Q.Fields[1].AsString);
  A[i].NOME_NA_REDE := Trim(Q.Fields[2].AsString);
  A[i].IP := Trim(Q.Fields[3].AsString);
  A[i].NF_SERIE := Q.Fields[4].AsInteger;
  A[i].LETRA_DO_DRIVE := Trim(Q.Fields[5].AsString);
  A[i].GAVETA_TEM := Q.Fields[6].AsBoolean;
  A[i].BALANCA_MODO_ID := Q.Fields[7].AsInteger;
  A[i].BALANCA_ID := Q.Fields[8].AsInteger;
  A[i].BARRAS_COD_INI := Q.Fields[9].AsInteger;
  A[i].BARRAS_COD_TAM := Q.Fields[10].AsInteger;
  A[i].CUPOM_NLINS_FINAL := Q.Fields[11].AsInteger;
  A[i].SEMPRE_OFFLINE := Q.Fields[12].AsBoolean;
end;

function TEnvTabTerminal.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.TERMINAL_ID := Q.Fields[0].AsInteger;
  Result.APELIDO := Trim(Q.Fields[1].AsString);
  Result.NOME_NA_REDE := Trim(Q.Fields[2].AsString);
  Result.IP := Trim(Q.Fields[3].AsString);
  Result.NF_SERIE := Q.Fields[4].AsInteger;
  Result.LETRA_DO_DRIVE := Trim(Q.Fields[5].AsString);
  Result.GAVETA_TEM := Q.Fields[6].AsBoolean;
  Result.BALANCA_MODO_ID := Q.Fields[7].AsInteger;
  Result.BALANCA_ID := Q.Fields[8].AsInteger;
  Result.BARRAS_COD_INI := Q.Fields[9].AsInteger;
  Result.BARRAS_COD_TAM := Q.Fields[10].AsInteger;
  Result.CUPOM_NLINS_FINAL := Q.Fields[11].AsInteger;
  Result.SEMPRE_OFFLINE := Q.Fields[12].AsBoolean;
end;

function TEnvTabTerminal.Execute: Boolean;
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

function TEnvTabTerminal.GetQtdRegs
  (pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  sSql := GetSqlQtdRegs;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabTerminal.GetSqlAlt: string;
begin
  Result := //
    'UPDATE TERMINAL SET' //

    + ' APELIDO = :APELIDO' //
    + ', NOME_NA_REDE = :NOME_NA_REDE' //
    + ', IP = :IP' //
    + ', NF_SERIE = :NF_SERIE' //
    + ', LETRA_DO_DRIVE = :LETRA_DO_DRIVE' //
    + ', GAVETA_TEM = :GAVETA_TEM' //
    + ', BALANCA_MODO_ID = :BALANCA_MODO_ID' //
    + ', BALANCA_ID = :BALANCA_ID' //
    + ', BARRAS_COD_INI = :BARRAS_COD_INI' //
    + ', BARRAS_COD_TAM = :BARRAS_COD_TAM' //
    + ', CUPOM_NLINS_FINAL = :CUPOM_NLINS_FINAL' //
    + ', SEMPRE_OFFLINE = :SEMPRE_OFFLINE' //

    + ' WHERE TERMINAL_ID = :TERMINAL_ID' //
    + ';';
end;

function TEnvTabTerminal.GetSqlIns: string;
begin
  Result := //
    'INSERT INTO TERMINAL (' //
    + ' TERMINAL_ID' //
    + ', APELIDO' //
    + ', NOME_NA_REDE' //
    + ', IP' //
    + ', NF_SERIE' //
    + ', LETRA_DO_DRIVE' //
    + ', GAVETA_TEM' //
    + ', BALANCA_MODO_ID' //
    + ', BALANCA_ID' //
    + ', BARRAS_COD_INI' //
    + ', BARRAS_COD_TAM' //
    + ', CUPOM_NLINS_FINAL' //
    + ', SEMPRE_OFFLINE' //

    + ') VALUES(' //

    + ':TERMINAL_ID' //
    + ', :APELIDO' //
    + ', :NOME_NA_REDE' //
    + ', :IP' //
    + ', :NF_SERIE' //
    + ', :LETRA_DO_DRIVE' //
    + ', :GAVETA_TEM' //
    + ', :BALANCA_MODO_ID' //
    + ', :BALANCA_ID' //
    + ', :BARRAS_COD_INI' //
    + ', :BARRAS_COD_TAM' //
    + ', :CUPOM_NLINS_FINAL' //
    + ', :SEMPRE_OFFLINE' //

    + ');'; //
end;

function TEnvTabTerminal.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome + ';';
end;

function TEnvTabTerminal.GetSqlTodos: string;
begin
  Result := 'SELECT TERMINAL_ID, APELIDO, NOME_NA_REDE, IP, NF_SERIE,'#13#13 +
    'LETRA_DO_DRIVE, GAVETA_TEM, BALANCA_MODO_ID, BALANCA_ID,'#13#13 +
    'BARRAS_COD_INI, BARRAS_COD_TAM, CUPOM_NLINS_FINAL, SEMPRE_OFFLINE'#13#13 +
    'FROM TERMINAL'#13#13 + //
    'where TERMINAL_ID > 0'#13#13 + //
    'ORDER BY TERMINAL_ID'#13#13;
end;

function TEnvTabTerminal.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[1].AsString := pReg.APELIDO;
  FInsDBExec.Params[2].AsString := pReg.NOME_NA_REDE;
  FInsDBExec.Params[3].AsString := pReg.IP;
  FInsDBExec.Params[4].AsSmallInt := pReg.NF_SERIE;

  FInsDBExec.Params[5].AsString := pReg.LETRA_DO_DRIVE;
  FInsDBExec.Params[6].AsBoolean := pReg.GAVETA_TEM;
  FInsDBExec.Params[7].AsSmallInt := pReg.BALANCA_MODO_ID;
  FInsDBExec.Params[8].AsSmallInt := pReg.BALANCA_ID;
  FInsDBExec.Params[9].AsSmallInt := pReg.BARRAS_COD_INI;

  FInsDBExec.Params[10].AsSmallInt := pReg.BARRAS_COD_TAM;
  FInsDBExec.Params[11].AsSmallInt := pReg.CUPOM_NLINS_FINAL;
  FInsDBExec.Params[12].AsBoolean := pReg.SEMPRE_OFFLINE;
  FInsDBExec.Execute;
end;

procedure TEnvTabTerminal.PreenchaArr(pLocal: TDBConnectionLocation);
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
