unit App.DB.Term.EnviarTabela.Usuario_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types;

type
  TRegistro = record
    LOJA_ID: TLojaId;
    TERMINAL_ID: TTerminalId;
    PESSOA_ID: integer;
    NOME_DE_USUARIO: string;
    SENHA: string;
    CRY_VER: SmallInt;
    function MesmoCod(pRegistro: TRegistro): boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabUsuario = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    Arr: array [TDBConnectionLocation] of TRegistrosArray;
    FiQtdRegsTerm: integer;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    FAltDBExec: IDBExec;
    function DataSetToRecord(Q: TDataSet): TRegistro;
    function Inserir(pLocal: TDBConnectionLocation; pReg: TRegistro): boolean;
    function Atualizar(pLocal: TDBConnectionLocation; pReg: TRegistro): boolean;

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

    function CompareLocais: boolean;
    function BusqueRegNoArr(pReg: TRegistro; pLocal: TDBConnectionLocation)
      : TResultadoBusca;
  public
    function Execute: boolean; override;
    constructor Create(pServ, pTerm: IDBConnection);
  end;

implementation

uses System.SysUtils, Sis.DB.Factory, Sis.Win.Utils_u;

{ TEnvTabUsuario }

function TEnvTabUsuario.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): boolean;
begin
  Result := True;

  FAltDBExec.Params[0].AsString := pReg.NOME_DE_USUARIO;
  FAltDBExec.Params[1].AsString := pReg.SENHA;
  FAltDBExec.Params[2].AsSmallInt := pReg.CRY_VER;
  FAltDBExec.Params[3].AsSmallInt := pReg.LOJA_ID;
  FAltDBExec.Params[4].AsSmallInt := pReg.TERMINAL_ID;
  FAltDBExec.Params[5].AsInteger := pReg.PESSOA_ID;

  FAltDBExec.Execute;
end;

function TEnvTabUsuario.BusqueRegNoArr(pReg: TRegistro;
  pLocal: TDBConnectionLocation): TResultadoBusca;
var
  i: integer;
  RegAtual: TRegistro;
  Iguais: boolean;
begin
  Result := TResultadoBusca.rbNaoTem;
  for i := 0 to Length(Arr[pLocal]) - 1 do
  begin
    RegAtual := Arr[pLocal][i];
    if pReg.MesmoCod(RegAtual) then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.NOME_DE_USUARIO = pReg.NOME_DE_USUARIO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.SENHA = pReg.SENHA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CRY_VER = pReg.CRY_VER;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabUsuario.CompareLocais: boolean;
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

constructor TEnvTabUsuario.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'USUARIO';
end;

procedure TEnvTabUsuario.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].TERMINAL_ID := Q.Fields[1].AsInteger;
  A[i].PESSOA_ID := Q.Fields[2].AsInteger;
  A[i].NOME_DE_USUARIO := Q.Fields[3].AsString;
  A[i].SENHA := Q.Fields[4].AsString;
  A[i].CRY_VER := Q.Fields[5].AsInteger;
end;

function TEnvTabUsuario.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.TERMINAL_ID := Q.Fields[1].AsInteger;
  Result.PESSOA_ID := Q.Fields[2].AsInteger;
  Result.NOME_DE_USUARIO := Q.Fields[3].AsString;
  Result.SENHA := Q.Fields[4].AsString;
  Result.CRY_VER := Q.Fields[5].AsInteger;
end;

function TEnvTabUsuario.Execute: boolean;
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

function TEnvTabUsuario.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabUsuario.GetSqlAlt: string;
begin
  Result := //
    'UPDATE USUARIO SET'#13#10 //

    + 'NOME_DE_USUARIO = :NOME_DE_USUARIO'#13#10 //
    + ', SENHA = :SENHA'#13#10 //
    + ', CRY_VER = :CRY_VER'#13#10 //

    + 'WHERE LOJA_ID = :LOJA_ID'#13#10 //
    + 'AND TERMINAL_ID = :TERMINAL_ID'#13#10 //
    + 'AND PESSOA_ID = :PESSOA_ID'#13#10 //

    + ';';
end;

function TEnvTabUsuario.GetSqlIns: string;
begin
  Result := 'INSERT INTO USUARIO ('#13#10 //
    + 'LOJA_ID'#13#10 //
    + ', TERMINAL_ID'#13#10 //
    + ', PESSOA_ID'#13#10 //
    + ', NOME_DE_USUARIO'#13#10 //
    + ', SENHA'#13#10 //
    + ', CRY_VER'#13#10 //

    + ') VALUES('#13#10 //

    + ':LOJA_ID'#13#10 //
    + ', :TERMINAL_ID'#13#10 //
    + ', :PESSOA_ID'#13#10 //
    + ', :NOME_DE_USUARIO'#13#10 //
    + ', :SENHA'#13#10 //
    + ', :CRY_VER'#13#10 //

    + ');';
end;

function TEnvTabUsuario.GetSqlQtdRegs: string;
begin
  Result := 'SELECT COUNT(*) FROM USUARIO'#13#10; //
end;

function TEnvTabUsuario.GetSqlQtdRegsTerm: string;
begin
  Result := GetSqlQtdRegs;
end;

function TEnvTabUsuario.GetSqlTodos: string;
begin
  Result := //
    'SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME_DE_USUARIO, SENHA'
    + ', CRY_VER'#13#10 //
    + 'FROM USUARIO'#13#10 //
    + 'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID;'#13#10 //
    ;
end;

function TEnvTabUsuario.GetSqlTodosTerm: string;
begin
  Result := GetSqlTodos;
end;

function TEnvTabUsuario.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): boolean;
begin
  Result := True;

  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[2].AsInteger := pReg.PESSOA_ID;
  FInsDBExec.Params[3].AsString := pReg.NOME_DE_USUARIO;
  FInsDBExec.Params[4].AsString := pReg.SENHA;
  FInsDBExec.Params[5].AsSmallInt := pReg.CRY_VER;

  FInsDBExec.Execute;
end;

procedure TEnvTabUsuario.PreenchaArr(pLocal: TDBConnectionLocation);
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

{ TRegistro }

function TRegistro.MesmoCod(pRegistro: TRegistro): boolean;
begin
  Result := PESSOA_ID = pRegistro.PESSOA_ID;
  if not Result then
    exit;

  Result := TERMINAL_ID = pRegistro.TERMINAL_ID;
  if not Result then
    exit;

  Result := LOJA_ID = pRegistro.LOJA_ID;
end;

end.
