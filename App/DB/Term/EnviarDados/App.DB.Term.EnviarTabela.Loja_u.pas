unit App.DB.Term.EnviarTabela.Loja_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB{, Data.FmtBcd}, Sis.Entities.Types;

type
  TRegistro = record
    LOJA_ID: TLojaId;
    APELIDO: string;
    SELECIONADO: Boolean;
  end;

  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabLoja = class(TEnviarTabela)
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

{ TEnvTabLoja }

function TEnvTabLoja.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.APELIDO;
  FAltDBExec.Params[1].AsBoolean := pReg.SELECIONADO;
  FAltDBExec.Params[2].AsSmallInt := pReg.LOJA_ID;
  FAltDBExec.Execute;
end;

function TEnvTabLoja.BusqueRegNoArr(pReg: TRegistro;
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
    if RegAtual.LOJA_ID = pReg.LOJA_ID then
    begin
      Result := TResultadoBusca.rbTemIgual;

      Iguais := RegAtual.APELIDO = pReg.APELIDO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.SELECIONADO = pReg.SELECIONADO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      break;
    end;
  end;
end;

function TEnvTabLoja.CompareLocais: Boolean;
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

constructor TEnvTabLoja.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'LOJA';
end;

procedure TEnvTabLoja.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].APELIDO := Q.Fields[1].AsString;
  A[i].SELECIONADO := Q.Fields[2].AsBoolean;
end;

function TEnvTabLoja.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.APELIDO := Q.Fields[1].AsString;
  Result.SELECIONADO := Q.Fields[2].AsBoolean;
end;

function TEnvTabLoja.Execute: Boolean;
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

function TEnvTabLoja.GetQtdRegs(
  pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  sSql := GetSqlQtdRegs;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabLoja.GetSqlAlt: string;
begin
  Result := //
    'UPDATE LOJA SET' //
    + ' APELIDO = APELIDO' //
    + ', SELECIONADO = :SELECIONADO' //
    + ' WHERE LOJA_ID = :LOJA_ID' //
    + ';';
end;

function TEnvTabLoja.GetSqlIns: string;
begin
  Result := //
    'INSERT INTO LOJA (' //

    + 'LOJA_ID' //
    + ', APELIDO' //
    + ', SELECIONADO' //

    + ') VALUES (' //

    + ':LOJA_ID' //
    + ', :APELIDO' //
    + ', :SELECIONADO' //

    + ');'; //
end;

function TEnvTabLoja.GetSqlQtdRegs: string;
begin
  Result := 'select count(*) from ' + FTabelaNome + ';';
end;

function TEnvTabLoja.GetSqlTodos: string;
begin
  Result := 'SELECT LOJA_ID, APELIDO, SELECIONADO' //
    + ' FROM LOJA' //
    + ' WHERE SELECIONADO' //
    + ' ORDER BY LOJA_ID' //
    + ';'; //
end;

function TEnvTabLoja.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsString := pReg.APELIDO;
  FInsDBExec.Params[2].AsBoolean := pReg.SELECIONADO;
  FInsDBExec.Execute;
end;

procedure TEnvTabLoja.PreenchaArr(pLocal: TDBConnectionLocation);
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
