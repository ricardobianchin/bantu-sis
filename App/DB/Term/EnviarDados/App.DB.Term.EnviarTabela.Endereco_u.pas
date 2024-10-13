unit App.DB.Term.EnviarTabela.Endereco_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, App.DB.Term.EnviarTabela.EnderecoReg_u, Data.SqlTimSt;

type
  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabEndereco = class(TEnviarTabela)
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

{ TEnvTabEndereco }

function TEnvTabEndereco.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FAltDBExec.Params[0].AsString := pReg.LOGRADOURO;
  FAltDBExec.Params[1].AsString := pReg.NUMERO;
  FAltDBExec.Params[2].AsString := pReg.COMPLEMENTO;
  FAltDBExec.Params[3].AsString := pReg.BAIRRO;
  FAltDBExec.Params[4].AsString := pReg.UF_SIGLA;
  FAltDBExec.Params[5].AsString := pReg.CEP;
  FAltDBExec.Params[6].AsString := pReg.MUNICIPIO_IBGE_ID;
  FAltDBExec.Params[7].AsString := pReg.DDD;
  FAltDBExec.Params[8].AsString := pReg.FONE1;
  FAltDBExec.Params[9].AsString := pReg.FONE2;
  FAltDBExec.Params[10].AsString := pReg.FONE3;
  FAltDBExec.Params[11].AsString := pReg.CONTATO;
  FAltDBExec.Params[12].AsString := pReg.REFERENCIA;

  SetParamDateTime(FAltDBExec.Params[13], pReg.CRIADO_EM);
  SetParamDateTime(FAltDBExec.Params[14], pReg.ALTERADO_EM);

  FAltDBExec.Params[15].AsSmallInt := pReg.LOJA_ID;
  FAltDBExec.Params[16].AsSmallInt := pReg.TERMINAL_ID;
  FAltDBExec.Params[17].AsInteger := pReg.PESSOA_ID;
  FAltDBExec.Params[18].AsSmallInt := pReg.ORDEM;

  FAltDBExec.Execute;
end;

function TEnvTabEndereco.BusqueRegNoArr(pReg: TRegistro;
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

      Iguais := RegAtual.LOGRADOURO = pReg.LOGRADOURO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.NUMERO = pReg.NUMERO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.COMPLEMENTO = pReg.COMPLEMENTO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.BAIRRO = pReg.BAIRRO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.UF_SIGLA = pReg.UF_SIGLA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CEP = pReg.CEP;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.MUNICIPIO_IBGE_ID = pReg.MUNICIPIO_IBGE_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.DDD = pReg.DDD;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.FONE1 = pReg.FONE1;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.FONE2 = pReg.FONE2;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.FONE3 = pReg.FONE3;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.CONTATO = pReg.CONTATO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.REFERENCIA = pReg.REFERENCIA;
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

function TEnvTabEndereco.CompareLocais: Boolean;
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

constructor TEnvTabEndereco.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'ENDERECO';
end;

procedure TEnvTabEndereco.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].TERMINAL_ID := Q.Fields[1].AsInteger;
  A[i].PESSOA_ID := Q.Fields[2].AsInteger;
  A[i].ORDEM := Q.Fields[3].AsInteger;
  A[i].LOGRADOURO := Q.Fields[4].AsString;
  A[i].NUMERO := Q.Fields[5].AsString;
  A[i].COMPLEMENTO := Q.Fields[6].AsString;
  A[i].BAIRRO := Q.Fields[7].AsString;
  A[i].UF_SIGLA := Q.Fields[8].AsString;
  A[i].CEP := Q.Fields[9].AsString;
  A[i].MUNICIPIO_IBGE_ID := Q.Fields[10].AsString;
  A[i].DDD := Q.Fields[11].AsString;
  A[i].FONE1 := Q.Fields[12].AsString;
  A[i].FONE2 := Q.Fields[13].AsString;
  A[i].FONE3 := Q.Fields[14].AsString;
  A[i].CONTATO := Q.Fields[15].AsString;
  A[i].REFERENCIA := Q.Fields[16].AsString;
  A[i].CRIADO_EM := Q.Fields[17].AsDateTime;
  A[i].ALTERADO_EM := Q.Fields[18].AsDateTime;
end;

function TEnvTabEndereco.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.TERMINAL_ID := Q.Fields[1].AsInteger;
  Result.PESSOA_ID := Q.Fields[2].AsInteger;
  Result.ORDEM := Q.Fields[3].AsInteger;
  Result.LOGRADOURO := Q.Fields[4].AsString;
  Result.NUMERO := Q.Fields[5].AsString;
  Result.COMPLEMENTO := Q.Fields[6].AsString;
  Result.BAIRRO := Q.Fields[7].AsString;
  Result.UF_SIGLA := Q.Fields[8].AsString;
  Result.CEP := Q.Fields[9].AsString;
  Result.MUNICIPIO_IBGE_ID := Q.Fields[10].AsString;
  Result.DDD := Q.Fields[11].AsString;
  Result.FONE1 := Q.Fields[12].AsString;
  Result.FONE2 := Q.Fields[13].AsString;
  Result.FONE3 := Q.Fields[14].AsString;
  Result.CONTATO := Q.Fields[15].AsString;
  Result.REFERENCIA := Q.Fields[16].AsString;
  Result.CRIADO_EM := Q.Fields[17].AsDateTime;
  Result.ALTERADO_EM := Q.Fields[18].AsDateTime;
end;

function TEnvTabEndereco.Execute: Boolean;
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

function TEnvTabEndereco.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabEndereco.GetSqlAlt: string;
begin
  Result := //
    'UPDATE ENDERECO SET'#13#10 //

    + 'LOGRADOURO = :LOGRADOURO'#13#10 //
    + ', NUMERO = :NUMERO'#13#10 //
    + ', COMPLEMENTO = :COMPLEMENTO'#13#10 //
    + ', BAIRRO = :BAIRRO'#13#10 //
    + ', UF_SIGLA = :UF_SIGLA'#13#10 //
    + ', CEP = :CEP'#13#10 //
    + ', MUNICIPIO_IBGE_ID = :MUNICIPIO_IBGE_ID'#13#10 //
    + ', DDD = :DDD'#13#10 //
    + ', FONE1 = :FONE1'#13#10 //
    + ', FONE2 = :FONE2'#13#10 //
    + ', FONE3 = :FONE3'#13#10 //
    + ', CONTATO = :CONTATO'#13#10 //
    + ', REFERENCIA = :REFERENCIA'#13#10 //
    + ', CRIADO_EM = :CRIADO_EM'#13#10 //
    + ', ALTERADO_EM = :ALTERADO_EM'#13#10 //

    + 'WHERE LOJA_ID = :LOJA_ID'#13#10 //
    + 'AND TERMINAL_ID = :TERMINAL_ID'#13#10 //
    + 'AND PESSOA_ID = :PESSOA_ID'#13#10 //
    + 'AND ORDEM = :ORDEM'#13#10 //

    + ';';
end;

function TEnvTabEndereco.GetSqlIns: string;
begin
  Result := 'INSERT INTO ENDERECO ('#13#10 //
    + 'LOJA_ID'#13#10 //
    + ', TERMINAL_ID'#13#10 //
    + ', PESSOA_ID'#13#10 //

    + ', ORDEM'#13#10 //
    + ', LOGRADOURO'#13#10 //
    + ', NUMERO'#13#10 //
    + ', COMPLEMENTO'#13#10 //
    + ', BAIRRO'#13#10 //
    + ', UF_SIGLA'#13#10 //
    + ', CEP'#13#10 //
    + ', MUNICIPIO_IBGE_ID'#13#10 //
    + ', DDD'#13#10 //
    + ', FONE1'#13#10 //
    + ', FONE2'#13#10 //
    + ', FONE3'#13#10 //
    + ', CONTATO'#13#10 //
    + ', REFERENCIA'#13#10 //

    + ', CRIADO_EM'#13#10 //
    + ', ALTERADO_EM'#13#10 //

    + ') VALUES('#13#10 //

    + ':LOJA_ID'#13#10 //
    + ', :TERMINAL_ID'#13#10 //
    + ', :PESSOA_ID'#13#10 //
    + ', :ORDEM'#13#10 //
    + ', :LOGRADOURO'#13#10 //
    + ', :NUMERO'#13#10 //
    + ', :COMPLEMENTO'#13#10 //
    + ', :BAIRRO'#13#10 //
    + ', :UF_SIGLA'#13#10 //
    + ', :CEP'#13#10 //
    + ', :MUNICIPIO_IBGE_ID'#13#10 //
    + ', :DDD'#13#10 //
    + ', :FONE1'#13#10 //
    + ', :FONE2'#13#10 //
    + ', :FONE3'#13#10 //
    + ', :CONTATO'#13#10 //
    + ', :REFERENCIA'#13#10 //
    + ', :CRIADO_EM'#13#10 //
    + ', :ALTERADO_EM'#13#10 //
    + ');';
end;

function TEnvTabEndereco.GetSqlQtdRegs: string;
begin
  Result := //
    'SELECT COUNT(*) FROM'#13#10 //
    + '('#13#10 //
    + '  SELECT E.LOJA_ID, E.TERMINAL_ID, E.PESSOA_ID, E.ORDEM'#13#10 //
    + '  FROM ENDERECO E'#13#10 //
    + '  JOIN ('#13#10 //
    + #13#10 //

    + '    SELECT pu.LOJA_ID, pu.TERMINAL_ID, pu.PESSOA_ID'#13#10 //
    + '    FROM PESSOA pu'#13#10 //
    + '    JOIN USUARIO u ON'#13#10 //
    + '      pu.LOJA_ID = u.LOJA_ID'#13#10 //
    + '      AND pu.TERMINAL_ID = u.TERMINAL_ID'#13#10 //
    + '      AND pu.PESSOA_ID = u.PESSOA_ID'#13#10 //
    + #13#10 //

    + '  UNION'#13#10 //
    + #13#10 //

    + '    SELECT pf.LOJA_ID, pf.TERMINAL_ID, pf.PESSOA_ID'#13#10 //
    + '    FROM PESSOA pf'#13#10 //
    + '    JOIN FUNCIONARIO f ON'#13#10 //
    + '      pf.LOJA_ID = f.LOJA_ID'#13#10 //
    + '      AND pf.TERMINAL_ID = f.TERMINAL_ID'#13#10 //
    + '      AND pf.PESSOA_ID = f.PESSOA_ID'#13#10 //
    + #13#10 //

    + '  UNION'#13#10 //
    + #13#10 //

    + '    SELECT pl.LOJA_ID, pl.TERMINAL_ID, pl.PESSOA_ID'#13#10 //
    + '    FROM PESSOA pl'#13#10 //
    + '    JOIN LOJA_EH_PESSOA l ON'#13#10 //
    + '      pl.LOJA_ID = l.LOJA_ID'#13#10 //
    + '      AND pl.TERMINAL_ID = l.TERMINAL_ID'#13#10 //
    + '      AND pl.PESSOA_ID = l.PESSOA_ID'#13#10 //
    + '    JOIN LOJA PE ON'#13#10 //
    + '      pE.LOJA_ID = Pl.LOJA_ID'#13#10 //
    + '      AND PE.SELECIONADO'#13#10 //
    + #13#10 //

    + ') TAB_PESSOA ON'#13#10 //
    + '    E.LOJA_ID = TAB_PESSOA.LOJA_ID'#13#10 //
    + '    AND E.TERMINAL_ID = TAB_PESSOA.TERMINAL_ID'#13#10 //
    + '    AND E.PESSOA_ID = TAB_PESSOA.PESSOA_ID'#13#10 //
    + ') TAB_ENDERECOS;'#13#10 //
    ;
end;

function TEnvTabEndereco.GetSqlQtdRegsTerm: string;
begin
  Result := //
    'SELECT COUNT(*) FROM ENDERECO'#13#10 //
    ;

end;

function TEnvTabEndereco.GetSqlTodos: string;
begin
  Result := //
    'SELECT'#13#10 //
    + 'E.LOJA_ID'#13#10 //
    + ', E.TERMINAL_ID'#13#10 //
    + ', E.PESSOA_ID'#13#10 //
    + ', E.ORDEM'#13#10 //
    + ', E.LOGRADOURO'#13#10 //
    + ', E.NUMERO'#13#10 //
    + ', E.COMPLEMENTO'#13#10 //
    + ', E.BAIRRO'#13#10 //
    + ', E.UF_SIGLA'#13#10 //
    + ', E.CEP'#13#10 //
    + ', E.MUNICIPIO_IBGE_ID'#13#10 //
    + ', E.DDD'#13#10 //
    + ', E.FONE1'#13#10 //
    + ', E.FONE2'#13#10 //
    + ', E.FONE3'#13#10 //
    + ', E.CONTATO'#13#10 //
    + ', E.REFERENCIA'#13#10 //
    + ', E.CRIADO_EM'#13#10 //
    + ', E.ALTERADO_EM'#13#10 //
    + 'FROM ENDERECO E'#13#10 //
    + #13#10 //
    + 'JOIN ('#13#10 //
    + 'SELECT pu.LOJA_ID, pu.TERMINAL_ID, pu.PESSOA_ID'#13#10 //
    + 'FROM PESSOA pu'#13#10 //
    + 'JOIN USUARIO u ON'#13#10 //
    + 'pu.LOJA_ID = u.LOJA_ID'#13#10 //
    + 'AND pu.TERMINAL_ID = u.TERMINAL_ID'#13#10 //
    + 'AND pu.PESSOA_ID = u.PESSOA_ID'#13#10 //
    + ''#13#10 //
    + 'UNION'#13#10 //
    + ''#13#10 //
    + 'SELECT pf.LOJA_ID, pf.TERMINAL_ID, pf.PESSOA_ID'#13#10 //
    + 'FROM PESSOA pf'#13#10 //
    + 'JOIN FUNCIONARIO f ON'#13#10 //
    + 'pf.LOJA_ID = f.LOJA_ID'#13#10 //
    + 'AND pf.TERMINAL_ID = f.TERMINAL_ID'#13#10 //
    + 'AND pf.PESSOA_ID = f.PESSOA_ID'#13#10 //
    + ''#13#10 //
    + 'UNION'#13#10 //
    + ''#13#10 //
    + 'SELECT pl.LOJA_ID, pl.TERMINAL_ID, pl.PESSOA_ID'#13#10 //
    + 'FROM PESSOA pl'#13#10 //
    + 'JOIN LOJA_EH_PESSOA l ON'#13#10 //
    + 'pl.LOJA_ID = l.LOJA_ID'#13#10 //
    + 'AND pl.TERMINAL_ID = l.TERMINAL_ID'#13#10 //
    + 'AND pl.PESSOA_ID = l.PESSOA_ID'#13#10 //
    + 'JOIN LOJA PE ON'#13#10 //
    + 'pE.LOJA_ID = Pl.LOJA_ID'#13#10 //
    + 'AND PE.SELECIONADO'#13#10 //
    + ''#13#10 //
    + ') TAB_PESSOA ON'#13#10 //
    + 'E.LOJA_ID = TAB_PESSOA.LOJA_ID'#13#10 //
    + 'AND E.TERMINAL_ID = TAB_PESSOA.TERMINAL_ID'#13#10 //
    + 'AND E.PESSOA_ID = TAB_PESSOA.PESSOA_ID;'#13#10 //
    ;
end;

function TEnvTabEndereco.GetSqlTodosTerm: string;
begin
  Result := //
    'SELECT'#13#10 //
    + 'E.LOJA_ID'#13#10 //
    + ', E.TERMINAL_ID'#13#10 //
    + ', E.PESSOA_ID'#13#10 //
    + ', E.ORDEM'#13#10 //
    + ', E.LOGRADOURO'#13#10 //
    + ', E.NUMERO'#13#10 //
    + ', E.COMPLEMENTO'#13#10 //
    + ', E.BAIRRO'#13#10 //
    + ', E.UF_SIGLA'#13#10 //
    + ', E.CEP'#13#10 //
    + ', E.MUNICIPIO_IBGE_ID'#13#10 //
    + ', E.DDD'#13#10 //
    + ', E.FONE1'#13#10 //
    + ', E.FONE2'#13#10 //
    + ', E.FONE3'#13#10 //
    + ', E.CONTATO'#13#10 //
    + ', E.REFERENCIA'#13#10 //
    + ', E.CRIADO_EM'#13#10 //
    + ', E.ALTERADO_EM'#13#10 //
    + 'FROM ENDERECO E'#13#10 //
    ;
end;

function TEnvTabEndereco.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;

  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[2].AsInteger := pReg.PESSOA_ID;
  FInsDBExec.Params[3].AsSmallInt := pReg.ORDEM;
  FInsDBExec.Params[4].AsString := pReg.LOGRADOURO;
  FInsDBExec.Params[5].AsString := pReg.NUMERO;
  FInsDBExec.Params[6].AsString := pReg.COMPLEMENTO;
  FInsDBExec.Params[7].AsString := pReg.BAIRRO;
  FInsDBExec.Params[8].AsString := pReg.UF_SIGLA;
  FInsDBExec.Params[9].AsString := pReg.CEP;
  FInsDBExec.Params[10].AsString := pReg.MUNICIPIO_IBGE_ID;
  FInsDBExec.Params[11].AsString := pReg.DDD;
  FInsDBExec.Params[12].AsString := pReg.FONE1;
  FInsDBExec.Params[13].AsString := pReg.FONE2;
  FInsDBExec.Params[14].AsString := pReg.FONE3;
  FInsDBExec.Params[15].AsString := pReg.CONTATO;
  FInsDBExec.Params[16].AsString := pReg.REFERENCIA;

  SetParamDateTime(FInsDBExec.Params[17], pReg.CRIADO_EM);
  SetParamDateTime(FInsDBExec.Params[18], pReg.ALTERADO_EM);

  FInsDBExec.Execute;
end;

procedure TEnvTabEndereco.PreenchaArr(pLocal: TDBConnectionLocation);
var
  sSql: string;
  i: integer;
  Q: TDataSet;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlTodos
  else
    sSql := GetSqlTodosTerm;
  {$IFDEF DEBUG}
  CopyTextToClipboard(sSql);
  {$ENDIF}

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
