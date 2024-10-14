unit App.DB.Term.EnviarTabela.Funcionario_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB{, Data.FmtBcd}, Sis.Entities.Types;

type
  TRegistro = record
    LOJA_ID: TLojaId;
    TERMINAL_ID: TTerminalId;
    PESSOA_ID: integer;
    function MesmoCod(pRegistro: TRegistro): boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabFuncionario = class(TEnviarTabela)
  private
    Conn: array [TDBConnectionLocation] of IDBConnection;
    Arr: array [TDBConnectionLocation] of TRegistrosArray;
    FiQtdRegsTerm: integer;
    FTabelaNome: string;
    FInsDBExec: IDBExec;
    //FAltDBExec: IDBExec;
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

{ TEnvTabFuncionario }

function TEnvTabFuncionario.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  {
  FAltDBExec.Params[0].AsString := pReg.APELIDO;
  FAltDBExec.Params[1].AsBoolean := pReg.SELECIONADO;
  FAltDBExec.Params[2].AsSmallInt := pReg.LOJA_ID;
  FAltDBExec.Execute;

    LOJA_ID: TLojaId;
    TERMINAL_ID: TTerminalId;
    PESSOA_ID: integer;
  }
end;

function TEnvTabFuncionario.BusqueRegNoArr(pReg: TRegistro;
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
    if pReg.MesmoCod(RegAtual) then
    begin
      Result := TResultadoBusca.rbTemIgual;
      {
      Iguais := RegAtual.APELIDO = pReg.APELIDO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;
      }

      break;
    end;
  end;
end;

function TEnvTabFuncionario.CompareLocais: Boolean;
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

//  sSql := GetSqlAlt;
////  {$IFDEF DEBUG}
////  CopyTextToClipboard(sSql);
////  {$ENDIF}
//  FAltDBExec := DBExecCreate('env.alt.exec', Conn[loTerm], sSql, nil, nil);
//  FAltDBExec.Prepare;

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
//    FAltDBExec.Unprepare;
  end;
end;

constructor TEnvTabFuncionario.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'FUNCIONARIO';
end;

procedure TEnvTabFuncionario.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].TERMINAL_ID := Q.Fields[1].AsInteger;
  A[i].PESSOA_ID := Q.Fields[2].AsInteger;
end;

function TEnvTabFuncionario.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.TERMINAL_ID := Q.Fields[1].AsInteger;
  Result.PESSOA_ID := Q.Fields[2].AsInteger;
end;

function TEnvTabFuncionario.Execute: Boolean;
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

function TEnvTabFuncionario.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabFuncionario.GetSqlAlt: string;
begin
  Result := '';
end;

function TEnvTabFuncionario.GetSqlIns: string;
begin
  Result :=
    'INSERT INTO FUNCIONARIO ('#13#10 //
    +'LOJA_ID'#13#10 //
    +', TERMINAL_ID'#13#10 //
    +', PESSOA_ID'#13#10 //

    +') VALUES('#13#10 //

    +':LOJA_ID'#13#10 //
    +', :TERMINAL_ID'#13#10 //
    +', :PESSOA_ID'#13#10 //
    +');';
end;

function TEnvTabFuncionario.GetSqlQtdRegs: string;
begin
  RESULT := 'SELECT COUNT(*) FROM FUNCIONARIO'#13#10; //
end;

function TEnvTabFuncionario.GetSqlQtdRegsTerm: string;
begin
  Result := GetSqlQtdRegs;
end;

function TEnvTabFuncionario.GetSqlTodos: string;
begin
  Result := //
    'SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID'#13#10 //
    +'FROM FUNCIONARIO'#13#10 //
    +'ORDER BY LOJA_ID, TERMINAL_ID, PESSOA_ID;'#13#10 //

end;

function TEnvTabFuncionario.GetSqlTodosTerm: string;
begin
  Result := GetSqlTodos;
end;

function TEnvTabFuncionario.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[2].AsInteger := pReg.PESSOA_ID;

  FInsDBExec.Execute;
end;

procedure TEnvTabFuncionario.PreenchaArr(pLocal: TDBConnectionLocation);
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
