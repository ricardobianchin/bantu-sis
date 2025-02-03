unit App.DB.Term.EnviarTabela.Terminal_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB, Sis.Entities.Types;

type
  TRegistro = record
    TERMINAL_ID: SmallInt;

    APELIDO: string;
    NOME_NA_REDE: string;
    IP: string;
    LETRA_DO_DRIVE: string;

    NF_SERIE: SmallInt;

    GAVETA_TEM: Boolean;
    GAVETA_COMANDO: string;
    GAVETA_IMPR_NOME: string;

    BALANCA_MODO_USO_ID: SmallInt;
    BALANCA_ID: SmallInt;

    BARRAS_COD_INI: SmallInt;
    BARRAS_COD_TAM: SmallInt;

    IMPRESSORA_MODO_ENVIO_ID: SmallInt;
    IMPRESSORA_MODELO_ID: SmallInt;
    IMPRESSORA_NOME: string;
    IMPRESSORA_COLS_QTD: SmallInt;

    CUPOM_QTD_LINS_FINAL: SmallInt;
    SEMPRE_OFFLINE: Boolean;
    ATIVO: Boolean;

    BALANCA_PORTA: SmallInt;
    BALANCA_BAUDRATE: SmallInt;
    BALANCA_DATABITS: SmallInt;
    BALANCA_PARIDADE: SmallInt;
    BALANCA_STOPBITS: SmallInt;
    BALANCA_HANDSHAKING: SMALLINT

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
    FTerminalId: TTerminalId;
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
    constructor Create(pServ, pTerm: IDBConnection;
  pTerminalId: TTerminalId);
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
  FAltDBExec.Params[3].AsString := pReg.LETRA_DO_DRIVE;

  FAltDBExec.Params[4].AsSmallInt := pReg.NF_SERIE;

  FAltDBExec.Params[5].AsBoolean := pReg.GAVETA_TEM;
  FAltDBExec.Params[6].AsString := pReg.GAVETA_COMANDO;
  FAltDBExec.Params[7].AsString := pReg.GAVETA_IMPR_NOME;

  FAltDBExec.Params[8].AsSmallInt := pReg.BALANCA_MODO_USO_ID;
  FAltDBExec.Params[9].AsSmallInt := pReg.BALANCA_ID;

  FAltDBExec.Params[10].AsSmallInt := pReg.BARRAS_COD_INI;
  FAltDBExec.Params[11].AsSmallInt := pReg.BARRAS_COD_TAM;

  FAltDBExec.Params[12].AsSmallInt := pReg.IMPRESSORA_MODO_ENVIO_ID;
  FAltDBExec.Params[13].AsSmallInt := pReg.IMPRESSORA_MODELO_ID;
  FAltDBExec.Params[14].AsString := pReg.IMPRESSORA_NOME;
  FAltDBExec.Params[15].AsSmallInt := pReg.IMPRESSORA_COLS_QTD;

  FAltDBExec.Params[16].AsSmallInt := pReg.CUPOM_QTD_LINS_FINAL;

  FAltDBExec.Params[17].AsBoolean := pReg.SEMPRE_OFFLINE;
  FAltDBExec.Params[18].AsBoolean := pReg.ATIVO;

  FAltDBExec.Params[19].AsSmallInt := pReg.BALANCA_PORTA;
  FAltDBExec.Params[20].AsSmallInt := pReg.BALANCA_BAUDRATE;
  FAltDBExec.Params[21].AsSmallInt := pReg.BALANCA_DATABITS;
  FAltDBExec.Params[22].AsSmallInt := pReg.BALANCA_PARIDADE;
  FAltDBExec.Params[23].AsSmallInt := pReg.BALANCA_STOPBITS;
  FAltDBExec.Params[24].AsSmallInt := pReg.BALANCA_HANDSHAKING;

  FAltDBExec.Params[25].AsSmallInt := pReg.TERMINAL_ID;
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

      Iguais := RegAtual.LETRA_DO_DRIVE = pReg.LETRA_DO_DRIVE;
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

      Iguais := RegAtual.GAVETA_TEM = pReg.GAVETA_TEM;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.GAVETA_COMANDO = pReg.GAVETA_COMANDO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.GAVETA_IMPR_NOME = pReg.GAVETA_IMPR_NOME;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_MODO_USO_ID = pReg.BALANCA_MODO_USO_ID;
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

      Iguais := RegAtual.IMPRESSORA_MODO_ENVIO_ID = pReg.IMPRESSORA_MODO_ENVIO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.IMPRESSORA_MODELO_ID = pReg.IMPRESSORA_MODELO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.IMPRESSORA_NOME = pReg.IMPRESSORA_NOME;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.IMPRESSORA_COLS_QTD = pReg.IMPRESSORA_COLS_QTD;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CUPOM_QTD_LINS_FINAL = pReg.CUPOM_QTD_LINS_FINAL;
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

      Iguais := RegAtual.ATIVO = pReg.ATIVO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_PORTA = pReg.BALANCA_PORTA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_BAUDRATE = pReg.BALANCA_BAUDRATE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_DATABITS = pReg.BALANCA_DATABITS;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_PARIDADE = pReg.BALANCA_PARIDADE;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_STOPBITS = pReg.BALANCA_STOPBITS;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BALANCA_HANDSHAKING = pReg.BALANCA_HANDSHAKING;
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

constructor TEnvTabTerminal.Create(pServ, pTerm: IDBConnection;
  pTerminalId: TTerminalId);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;
  FTerminalId := pTerminalId;
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
  A[i].LETRA_DO_DRIVE := Trim(Q.Fields[4].AsString);

  A[i].NF_SERIE := Q.Fields[5].AsInteger;

  A[i].GAVETA_TEM := Q.Fields[6].AsBoolean;
  A[i].GAVETA_COMANDO := Trim(Q.Fields[7].AsString);
  A[i].GAVETA_IMPR_NOME := Trim(Q.Fields[8].AsString);

  A[i].BALANCA_MODO_USO_ID := Q.Fields[9].AsInteger;
  A[i].BALANCA_ID := Q.Fields[10].AsInteger;

  A[i].BARRAS_COD_INI := Q.Fields[11].AsInteger;
  A[i].BARRAS_COD_TAM := Q.Fields[12].AsInteger;

  A[i].IMPRESSORA_MODO_ENVIO_ID := Q.Fields[13].AsInteger;
  A[i].IMPRESSORA_MODELO_ID := Q.Fields[14].AsInteger;
  A[i].IMPRESSORA_NOME := Trim(Q.Fields[15].AsString);
  A[i].IMPRESSORA_COLS_QTD := Q.Fields[16].AsInteger;

  A[i].CUPOM_QTD_LINS_FINAL := Q.Fields[17].AsInteger;

  A[i].SEMPRE_OFFLINE := Q.Fields[18].AsBoolean;
  A[i].ATIVO := Q.Fields[19].AsBoolean;

  A[i].BALANCA_PORTA := Q.Fields[20].AsInteger;
  A[i].BALANCA_BAUDRATE := Q.Fields[21].AsInteger;
  A[i].BALANCA_DATABITS := Q.Fields[22].AsInteger;
  A[i].BALANCA_PARIDADE := Q.Fields[23].AsInteger;
  A[i].BALANCA_STOPBITS := Q.Fields[24].AsInteger;
  A[i].BALANCA_HANDSHAKING := Q.Fields[25].AsInteger;
end;

function TEnvTabTerminal.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.TERMINAL_ID := Q.Fields[0].AsInteger;

  Result.APELIDO := Trim(Q.Fields[1].AsString);
  Result.NOME_NA_REDE := Trim(Q.Fields[2].AsString);
  Result.IP := Trim(Q.Fields[3].AsString);
  Result.LETRA_DO_DRIVE := Trim(Q.Fields[4].AsString);

  Result.NF_SERIE := Q.Fields[5].AsInteger;

  Result.GAVETA_TEM := Q.Fields[6].AsBoolean;
  Result.GAVETA_COMANDO := Trim(Q.Fields[7].AsString);
  Result.GAVETA_IMPR_NOME := Trim(Q.Fields[8].AsString);

  Result.BALANCA_MODO_USO_ID := Q.Fields[9].AsInteger;
  Result.BALANCA_ID := Q.Fields[10].AsInteger;

  Result.BARRAS_COD_INI := Q.Fields[11].AsInteger;
  Result.BARRAS_COD_TAM := Q.Fields[12].AsInteger;

  Result.IMPRESSORA_MODO_ENVIO_ID := Q.Fields[13].AsInteger;
  Result.IMPRESSORA_MODELO_ID := Q.Fields[14].AsInteger;
  Result.IMPRESSORA_NOME := Trim(Q.Fields[15].AsString);
  Result.IMPRESSORA_COLS_QTD := Q.Fields[16].AsInteger;

  Result.CUPOM_QTD_LINS_FINAL := Q.Fields[17].AsInteger;

  Result.SEMPRE_OFFLINE := Q.Fields[18].AsBoolean;
  Result.ATIVO := Q.Fields[19].AsBoolean;

  Result.BALANCA_PORTA := Q.Fields[20].AsInteger;
  Result.BALANCA_BAUDRATE := Q.Fields[21].AsInteger;
  Result.BALANCA_DATABITS := Q.Fields[22].AsInteger;
  Result.BALANCA_PARIDADE := Q.Fields[23].AsInteger;
  Result.BALANCA_STOPBITS := Q.Fields[24].AsInteger;
  Result.BALANCA_HANDSHAKING := Q.Fields[25].AsInteger;
end;

function TEnvTabTerminal.Execute: Boolean;
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

    + ' APELIDO = :APELIDO' // 0
    + ', NOME_NA_REDE = :NOME_NA_REDE' // 1
    + ', IP = :IP' // 2
    + ', LETRA_DO_DRIVE = :LETRA_DO_DRIVE' // 3

    + ', NF_SERIE = :NF_SERIE' // 4

    + ', GAVETA_TEM = :GAVETA_TEM' // 5
    + ', GAVETA_COMANDO = :GAVETA_COMANDO' // 6
    + ', GAVETA_IMPR_NOME = :GAVETA_IMPR_NOME' // 7

    + ', BALANCA_MODO_USO_ID = :BALANCA_MODO_USO_ID' // 8
    + ', BALANCA_ID = :BALANCA_ID' // 9

    + ', BARRAS_COD_INI = :BARRAS_COD_INI' // 10
    + ', BARRAS_COD_TAM = :BARRAS_COD_TAM' // 11

    + ', IMPRESSORA_MODO_ENVIO_ID = :IMPRESSORA_MODO_ENVIO_ID' // 12
    + ', IMPRESSORA_MODELO_ID = :IMPRESSORA_MODELO_ID' // 13
    + ', IMPRESSORA_NOME = :IMPRESSORA_NOME' // 14
    + ', IMPRESSORA_COLS_QTD = :IMPRESSORA_COLS_QTD' // 15

    + ', CUPOM_QTD_LINS_FINAL = :CUPOM_QTD_LINS_FINAL' // 16

    + ', SEMPRE_OFFLINE = :SEMPRE_OFFLINE' // 17
    + ', ATIVO = :ATIVO' // 18

    + ', BALANCA_PORTA = :BALANCA_PORTA' // 19
    + ', BALANCA_BAUDRATE = :BALANCA_BAUDRATE' // 20
    + ', BALANCA_DATABITS = :BALANCA_DATABITS' // 21
    + ', BALANCA_PARIDADE = :BALANCA_PARIDADE' // 22
    + ', BALANCA_STOPBITS = :BALANCA_STOPBITS' // 23
    + ', BALANCA_HANDSHAKING = :BALANCA_HANDSHAKING' // 24

    + ' WHERE TERMINAL_ID = :TERMINAL_ID' // 25
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
    + ', LETRA_DO_DRIVE' //
    + ', NF_SERIE' //
    + ', GAVETA_TEM' //
    + ', GAVETA_COMANDO' //
    + ', GAVETA_IMPR_NOME' //
    + ', BALANCA_MODO_USO_ID' //
    + ', BALANCA_ID' //
    + ', BARRAS_COD_INI' //
    + ', BARRAS_COD_TAM' //
    + ', IMPRESSORA_MODO_ENVIO_ID' //
    + ', IMPRESSORA_MODELO_ID' //
    + ', IMPRESSORA_NOME' //
    + ', IMPRESSORA_COLS_QTD' //
    + ', CUPOM_QTD_LINS_FINAL' //
    + ', SEMPRE_OFFLINE' //
    + ', ATIVO' //

    + ', BALANCA_PORTA' //
    + ', BALANCA_BAUDRATE' //
    + ', BALANCA_DATABITS' //
    + ', BALANCA_PARIDADE' //
    + ', BALANCA_STOPBITS' //
    + ', BALANCA_HANDSHAKING' //

    + ') VALUES(' //

    + ':TERMINAL_ID' // 0

    + ', :APELIDO' // 1
    + ', :NOME_NA_REDE' // 2
    + ', :IP' // 3
    + ', :LETRA_DO_DRIVE' // 4

    + ', :NF_SERIE' // 5

    + ', :GAVETA_TEM' // 6
    + ', :GAVETA_COMANDO' // 7
    + ', :GAVETA_IMPR_NOME' // 8
    
    + ', :BALANCA_MODO_USO_ID' // 9
    + ', :BALANCA_ID' // 10
    
    + ', :BARRAS_COD_INI' // 11
    + ', :BARRAS_COD_TAM' // 12
    
    + ', :IMPRESSORA_MODO_ENVIO_ID' // 13
    + ', :IMPRESSORA_MODELO_ID' // 14
    + ', :IMPRESSORA_NOME' // 15
    + ', :IMPRESSORA_COLS_QTD' // 16
    
    + ', :CUPOM_QTD_LINS_FINAL' // 17
    
    + ', :SEMPRE_OFFLINE' // 18
    + ', :ATIVO' // 19

    + ', :BALANCA_PORTA' // 20
    + ', :BALANCA_BAUDRATE' // 21
    + ', :BALANCA_DATABITS' // 22
    + ', :BALANCA_PARIDADE' // 23
    + ', :BALANCA_STOPBITS' // 24
    + ', :BALANCA_HANDSHAKING' // 25

    + ');'; //
end;

function TEnvTabTerminal.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome +' where terminal_id = '+FTerminalId.ToString+ ';';
end;

function TEnvTabTerminal.GetSqlTodos: string;
begin
  Result := 'SELECT TERMINAL_ID, APELIDO, NOME_NA_REDE, IP, LETRA_DO_DRIVE,'#13#10 +
    'NF_SERIE, GAVETA_TEM, GAVETA_COMANDO, GAVETA_IMPR_NOME,'#13#10 +
    'BALANCA_MODO_USO_ID, BALANCA_ID, BARRAS_COD_INI, BARRAS_COD_TAM,'#13#10 +
    'IMPRESSORA_MODO_ENVIO_ID, IMPRESSORA_MODELO_ID, IMPRESSORA_NOME,'#13#10 +
    'IMPRESSORA_COLS_QTD, CUPOM_QTD_LINS_FINAL, SEMPRE_OFFLINE, ATIVO,'#13#10 +
    'BALANCA_PORTA, BALANCA_BAUDRATE, BALANCA_DATABITS, BALANCA_PARIDADE,'#13#10 +
    'BALANCA_STOPBITS, BALANCA_HANDSHAKING'#13#10 +

    'FROM TERMINAL'#13#10 +

    'WHERE TERMINAL_ID = ' + FTerminalId.ToString + #13#10 +
    'ORDER BY TERMINAL_ID'#13#10;
end;

function TEnvTabTerminal.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.TERMINAL_ID;

  FInsDBExec.Params[1].AsString := pReg.APELIDO;
  FInsDBExec.Params[2].AsString := pReg.NOME_NA_REDE;
  FInsDBExec.Params[3].AsString := pReg.IP;
  FInsDBExec.Params[4].AsString := pReg.LETRA_DO_DRIVE;

  FInsDBExec.Params[5].AsSmallInt := pReg.NF_SERIE;

  FInsDBExec.Params[6].AsBoolean := pReg.GAVETA_TEM;
  FInsDBExec.Params[7].AsString := pReg.GAVETA_COMANDO;
  FInsDBExec.Params[8].AsString := pReg.GAVETA_IMPR_NOME;

  FInsDBExec.Params[9].AsSmallInt := pReg.BALANCA_MODO_USO_ID;
  FInsDBExec.Params[10].AsSmallInt := pReg.BALANCA_ID;

  FInsDBExec.Params[11].AsSmallInt := pReg.BARRAS_COD_INI;
  FInsDBExec.Params[12].AsSmallInt := pReg.BARRAS_COD_TAM;

  FInsDBExec.Params[13].AsSmallInt := pReg.IMPRESSORA_MODO_ENVIO_ID;
  FInsDBExec.Params[14].AsSmallInt := pReg.IMPRESSORA_MODELO_ID;
  FInsDBExec.Params[15].AsString := pReg.IMPRESSORA_NOME;
  FInsDBExec.Params[16].AsSmallInt := pReg.IMPRESSORA_COLS_QTD;

  FInsDBExec.Params[17].AsSmallInt := pReg.CUPOM_QTD_LINS_FINAL;

  FInsDBExec.Params[18].AsBoolean := pReg.SEMPRE_OFFLINE;
  FInsDBExec.Params[19].AsBoolean := pReg.ATIVO;

  FInsDBExec.Params[20].AsSmallInt := pReg.BALANCA_PORTA;
  FInsDBExec.Params[21].AsSmallInt := pReg.BALANCA_BAUDRATE;
  FInsDBExec.Params[22].AsSmallInt := pReg.BALANCA_DATABITS;
  FInsDBExec.Params[23].AsSmallInt := pReg.BALANCA_PARIDADE;
  FInsDBExec.Params[24].AsSmallInt := pReg.BALANCA_STOPBITS;
  FInsDBExec.Params[25].AsSmallInt := pReg.BALANCA_HANDSHAKING;

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
