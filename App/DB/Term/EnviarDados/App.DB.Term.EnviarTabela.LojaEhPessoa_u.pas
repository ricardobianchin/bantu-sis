unit App.DB.Term.EnviarTabela.LojaEhPessoa_u;

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

  TEnvTabLojaEhPessoa = class(TEnviarTabela)
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

{ TEnvTabLojaEhPessoa }

function TEnvTabLojaEhPessoa.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
end;

function TEnvTabLojaEhPessoa.BusqueRegNoArr(pReg: TRegistro;
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

      break;
    end;
  end;
end;

function TEnvTabLojaEhPessoa.CompareLocais: Boolean;
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
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//  {$ENDIF}
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
  end;
end;

constructor TEnvTabLojaEhPessoa.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'LOJA_EH_PESSOA';
end;

procedure TEnvTabLojaEhPessoa.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].TERMINAL_ID := Q.Fields[1].AsInteger;
  A[i].PESSOA_ID := Q.Fields[2].AsInteger;
end;

function TEnvTabLojaEhPessoa.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.TERMINAL_ID := Q.Fields[1].AsInteger;
  Result.PESSOA_ID := Q.Fields[2].AsInteger;
end;

function TEnvTabLojaEhPessoa.Execute: Boolean;
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

function TEnvTabLojaEhPessoa.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabLojaEhPessoa.GetSqlAlt: string;
begin
  Result := '';
end;

function TEnvTabLojaEhPessoa.GetSqlIns: string;
begin
  Result :=
    'INSERT INTO LOJA_EH_PESSOA ('#13#10 //
    +'LOJA_ID'#13#10 //
    +', TERMINAL_ID'#13#10 //
    +', PESSOA_ID'#13#10 //

    +') VALUES('#13#10 //

    +':LOJA_ID'#13#10 //
    +', :TERMINAL_ID'#13#10 //
    +', :PESSOA_ID'#13#10 //
    +');';
end;

function TEnvTabLojaEhPessoa.GetSqlQtdRegs: string;
begin
  Result := //
    'SELECT COUNT(*)'#13#10 //

    +'FROM LOJA_EH_PESSOA'#13#10 //

    +'JOIN LOJA ON'#13#10 //
    +'LOJA_EH_PESSOA.LOJA_ID = LOJA.LOJA_ID'#13#10 //
    +'AND LOJA.SELECIONADO'#13#10 //

    +'ORDER BY'#13#10 //
    +'  LOJA_EH_PESSOA.LOJA_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.TERMINAL_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.PESSOA_ID;'#13#10 //
    ;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//  {$ENDIF}
end;

function TEnvTabLojaEhPessoa.GetSqlQtdRegsTerm: string;
begin
  RESULT := 'SELECT COUNT(*) FROM LOJA_EH_PESSOA'#13#10; //
end;

function TEnvTabLojaEhPessoa.GetSqlTodos: string;
begin
  Result := //
    'SELECT'#13#10 //
    +'  LOJA_EH_PESSOA.LOJA_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.TERMINAL_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.PESSOA_ID'#13#10 //

    +'FROM LOJA_EH_PESSOA'#13#10 //

    +'JOIN LOJA ON'#13#10 //
    +'LOJA_EH_PESSOA.LOJA_ID = LOJA.LOJA_ID'#13#10 //
    +'AND LOJA.SELECIONADO'#13#10 //

    +'ORDER BY'#13#10 //
    +'  LOJA_EH_PESSOA.LOJA_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.TERMINAL_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.PESSOA_ID;'#13#10 //
    ;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//  {$ENDIF}
end;

function TEnvTabLojaEhPessoa.GetSqlTodosTerm: string;
begin
  Result :=
    'SELECT'#13#10 //
    +'  LOJA_EH_PESSOA.LOJA_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.TERMINAL_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.PESSOA_ID'#13#10 //

    +'FROM LOJA_EH_PESSOA'#13#10 //

    +'ORDER BY'#13#10 //
    +'  LOJA_EH_PESSOA.LOJA_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.TERMINAL_ID'#13#10 //
    +'  , LOJA_EH_PESSOA.PESSOA_ID;'#13#10 //
    ;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//  {$ENDIF}
end;

function TEnvTabLojaEhPessoa.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[2].AsInteger := pReg.PESSOA_ID;

  FInsDBExec.Execute;
end;

procedure TEnvTabLojaEhPessoa.PreenchaArr(pLocal: TDBConnectionLocation);
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
