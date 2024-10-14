unit App.DB.Term.EnviarTabela.Pessoa_u;

interface

uses Sis.DB.DBTypes, App.DB.Term.EnviarTabela_u, Data.DB {, Data.FmtBcd} ,
  Sis.Entities.Types, App.DB.Term.EnviarTabela.PessoaReg_u;

type
  TDBConnectionLocation = (loServ, loTerm);
  TRegistrosArray = Array of TRegistro;
  TResultadoBusca = (rbNaoTem, rbTemDiferente, rbTemIgual);

  TEnvTabPessoa = class(TEnviarTabela)
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

{ TEnvTabPessoa }

function TEnvTabPessoa.Atualizar(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FAltDBExec.Params[0].AsString := pReg.NOME;
  FAltDBExec.Params[1].AsString := pReg.NOME_FANTASIA;
  FAltDBExec.Params[2].AsString := pReg.APELIDO;
  FAltDBExec.Params[3].AsString := pReg.GENERO_ID;
  FAltDBExec.Params[4].AsString := pReg.ESTADO_CIVIL_ID;
  FAltDBExec.Params[5].AsString := pReg.C;
  FAltDBExec.Params[6].AsString := pReg.i;
  FAltDBExec.Params[7].AsString := pReg.M;
  FAltDBExec.Params[8].AsString := pReg.M_UF;
  FAltDBExec.Params[9].AsString := pReg.EMAIL;

  SetParamDateTime(FInsDBExec.Params[10], pReg.DT_NASC);

  FAltDBExec.Params[11].AsBoolean := pReg.ATIVO;

  SetParamDateTime(FAltDBExec.Params[12], pReg.CRIADO_EM);
  SetParamDateTime(FAltDBExec.Params[13], pReg.ALTERADO_EM);

  FAltDBExec.Params[14].AsSmallInt := pReg.LOJA_ID;
  FAltDBExec.Params[15].AsSmallInt := pReg.TERMINAL_ID;
  FAltDBExec.Params[16].AsInteger := pReg.PESSOA_ID;
  FAltDBExec.Execute;
end;

function TEnvTabPessoa.BusqueRegNoArr(pReg: TRegistro;
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

      Iguais := RegAtual.NOME = pReg.NOME;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.NOME_FANTASIA = pReg.NOME_FANTASIA;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.APELIDO = pReg.APELIDO;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.GENERO_ID = pReg.GENERO_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.ESTADO_CIVIL_ID = pReg.ESTADO_CIVIL_ID;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.C = pReg.C;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.I = pReg.I;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.M = pReg.M;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.M_UF = pReg.M_UF;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.EMAIL = pReg.EMAIL;
      if not Iguais then
      begin
        Result := TResultadoBusca.rbTemDiferente;
        break;
      end;

      Iguais := RegAtual.DT_NASC = pReg.DT_NASC;
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

function TEnvTabPessoa.CompareLocais: Boolean;
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
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(sSql);
//  {$ENDIF}

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

constructor TEnvTabPessoa.Create(pServ, pTerm: IDBConnection);
begin
  Conn[loServ] := pServ;
  Conn[loTerm] := pTerm;

  FTabelaNome := 'PESSOA';
end;

procedure TEnvTabPessoa.DataSetToItemArray(pLocal: TDBConnectionLocation;
  Q: TDataSet; i: integer);
var
  A: TRegistrosArray;
begin
  A := Arr[pLocal];
  A[i].LOJA_ID := Q.Fields[0].AsInteger;
  A[i].TERMINAL_ID := Q.Fields[1].AsInteger;
  A[i].PESSOA_ID := Q.Fields[2].AsInteger;
  A[i].NOME := Q.Fields[3].AsString;
  A[i].NOME_FANTASIA := Q.Fields[4].AsString;
  A[i].APELIDO := Q.Fields[5].AsString;
  A[i].GENERO_ID := Q.Fields[6].AsString;
  A[i].ESTADO_CIVIL_ID := Q.Fields[7].AsString;
  A[i].C := Q.Fields[8].AsString;
  A[i].I := Q.Fields[9].AsString;
  A[i].M := Q.Fields[10].AsString;
  A[i].M_UF := Q.Fields[11].AsString;
  A[i].EMAIL := Q.Fields[12].AsString;
  A[i].DT_NASC := Trunc(Q.Fields[13].AsDateTime);
  A[i].ATIVO := Q.Fields[14].AsBoolean;
  A[i].CRIADO_EM := Q.Fields[15].AsDateTime;
  A[i].ALTERADO_EM := Q.Fields[16].AsDateTime;
end;

function TEnvTabPessoa.DataSetToRecord(Q: TDataSet): TRegistro;
begin
  Result.LOJA_ID := Q.Fields[0].AsInteger;
  Result.TERMINAL_ID := Q.Fields[1].AsInteger;
  Result.PESSOA_ID := Q.Fields[2].AsInteger;
  Result.NOME := Q.Fields[3].AsString;
  Result.NOME_FANTASIA := Q.Fields[4].AsString;
  Result.APELIDO := Q.Fields[5].AsString;
  Result.GENERO_ID := Q.Fields[6].AsString;
  Result.ESTADO_CIVIL_ID := Q.Fields[7].AsString;
  Result.C := Q.Fields[8].AsString;
  Result.I := Q.Fields[9].AsString;
  Result.M := Q.Fields[10].AsString;
  Result.M_UF := Q.Fields[11].AsString;
  Result.EMAIL := Q.Fields[12].AsString;
  Result.DT_NASC := Trunc(Q.Fields[13].AsDateTime);
  Result.ATIVO := Q.Fields[14].AsBoolean;
  Result.CRIADO_EM := Q.Fields[15].AsDateTime;
  Result.ALTERADO_EM := Q.Fields[16].AsDateTime;
end;

function TEnvTabPessoa.Execute: Boolean;
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

function TEnvTabPessoa.GetQtdRegs(pLocal: TDBConnectionLocation): integer;
var
  sSql: string;
begin
  if pLocal = TDBConnectionLocation.loServ then
    sSql := GetSqlQtdRegs
  else
    sSql := GetSqlQtdRegsTerm;

  Result := Conn[pLocal].GetValueInteger(sSql);
end;

function TEnvTabPessoa.GetSqlAlt: string;
begin
  Result := //
    'UPDATE PESSOA SET'#13#10 //

    +'NOME = :NOME'#13#10 //
    +', NOME_FANTASIA = :NOME_FANTASIA'#13#10 //
    +', APELIDO = :APELIDO'#13#10 //
    +', GENERO_ID = :GENERO_ID'#13#10 //
    +', ESTADO_CIVIL_ID = :ESTADO_CIVIL_ID'#13#10 //
    +', C = :C'#13#10 //
    +', I = :I'#13#10 //
    +', M = :M'#13#10 //
    +', M_UF = :M_UF'#13#10 //
    +', EMAIL = :EMAIL'#13#10 //
    +', DT_NASC = :DT_NASC'#13#10 //
    +', ATIVO = :ATIVO'#13#10 //
    +', CRIADO_EM = :CRIADO_EM'#13#10 //
    +', ALTERADO_EM = :ALTERADO_EM'#13#10 //

    +'WHERE LOJA_ID = :LOJA_ID'#13#10 //
    +'AND TERMINAL_ID = :TERMINAL_ID'#13#10 //
    +'AND PESSOA_ID = :PESSOA_ID'#13#10 //

    + ';';
end;

function TEnvTabPessoa.GetSqlIns: string;
begin
  Result :=
    'INSERT INTO PESSOA ('#13#10 //
    +'LOJA_ID'#13#10 //
    +', TERMINAL_ID'#13#10 //
    +', PESSOA_ID'#13#10 //
    +', NOME'#13#10 //
    +', NOME_FANTASIA'#13#10 //
    +', APELIDO'#13#10 //
    +', GENERO_ID'#13#10 //
    +', ESTADO_CIVIL_ID'#13#10 //
    +', C'#13#10 //
    +', I'#13#10 //
    +', M'#13#10 //
    +', M_UF'#13#10 //
    +', EMAIL'#13#10 //
    +', DT_NASC'#13#10 //
    +', ATIVO'#13#10 //
    +', CRIADO_EM'#13#10 //
    +', ALTERADO_EM'#13#10 //

    +') VALUES('#13#10 //

    +':LOJA_ID'#13#10 //
    +', :TERMINAL_ID'#13#10 //
    +', :PESSOA_ID'#13#10 //
    +', :NOME'#13#10 //
    +', :NOME_FANTASIA'#13#10 //
    +', :APELIDO'#13#10 //
    +', :GENERO_ID'#13#10 //
    +', :ESTADO_CIVIL_ID'#13#10 //
    +', :C'#13#10 //
    +', :I'#13#10 //
    +', :M'#13#10 //
    +', :M_UF'#13#10 //
    +', :EMAIL'#13#10 //
    +', :DT_NASC'#13#10 //
    +', :ATIVO'#13#10 //
    +', :CRIADO_EM'#13#10 //
    +', :ALTERADO_EM'#13#10 //
    +');';
end;

function TEnvTabPessoa.GetSqlQtdRegs: string;
begin
  Result :=
    'select count(*) from ('#13#10 //
    +'  SELECT'#13#10 //
    +'    pu.LOJA_ID,'#13#10 //
    +'    pu.TERMINAL_ID,'#13#10 //
    +'    pu.PESSOA_ID'#13#10 //
    +'  FROM PESSOA pu'#13#10 //
    +'  INNER JOIN USUARIO u ON'#13#10 //
    +'    pu.LOJA_ID = u.LOJA_ID'#13#10 //
    +'    AND pu.TERMINAL_ID = u.TERMINAL_ID'#13#10 //
    +'    AND pu.PESSOA_ID = u.PESSOA_ID'#13#10 //
    +#13#10 //
    +'UNION'#13#10 //
    +#13#10 //
    +'  SELECT'#13#10 //
    +'    pf.LOJA_ID,'#13#10 //
    +'    pf.TERMINAL_ID,'#13#10 //
    +'    pf.PESSOA_ID'#13#10 //
    +'  FROM PESSOA pf'#13#10 //
    +'  INNER JOIN FUNCIONARIO f ON'#13#10 //
    +'  pf.LOJA_ID = f.LOJA_ID'#13#10 //
    +'  AND pf.TERMINAL_ID = f.TERMINAL_ID'#13#10 //
    +'  AND pf.PESSOA_ID = f.PESSOA_ID'#13#10 //
    +#13#10 //
    +'UNION'#13#10 //
    +#13#10 //
    +'  SELECT'#13#10 //
    +'    pl.LOJA_ID,'#13#10 //
    +'    pl.TERMINAL_ID,'#13#10 //
    +'    pl.PESSOA_ID'#13#10 //
    +'  FROM PESSOA pl'#13#10 //
    +'  INNER JOIN LOJA_EH_PESSOA l ON'#13#10 //
    +'  pl.LOJA_ID = l.LOJA_ID'#13#10 //
    +'  AND pl.TERMINAL_ID = l.TERMINAL_ID'#13#10 //
    +'  AND pl.PESSOA_ID = l.PESSOA_ID'#13#10 //
    +'  INNER JOIN LOJA PE ON'#13#10 //
    +'  pE.LOJA_ID = Pl.LOJA_ID'#13#10 //
    +'  AND PE.SELECIONADO'#13#10 //
    +') tab_pessoa;'#13#10 //
    ;
end;

function TEnvTabPessoa.GetSqlQtdRegsTerm: string;
begin
  RESULT := 'SELECT COUNT(*) FROM PESSOA'#13#10; //
end;

function TEnvTabPessoa.GetSqlTodos: string;
begin
   Result := //
    '  SELECT'#13#10 //
    +'    pu.LOJA_ID,'#13#10 //
    +'    pu.TERMINAL_ID,'#13#10 //
    +'    pu.PESSOA_ID,'#13#10 //
    +'    pu.NOME,'#13#10 //
    +'    pu.NOME_FANTASIA,'#13#10 //
    +'    pu.APELIDO,'#13#10 //
    +'    pu.GENERO_ID,'#13#10 //
    +'    pu.ESTADO_CIVIL_ID,'#13#10 //
    +'    pu.C,'#13#10 //
    +'    pu.I,'#13#10 //
    +'    pu.M,'#13#10 //
    +'    pu.M_UF,'#13#10 //
    +'    pu.EMAIL,'#13#10 //
    +'    pu.DT_NASC,'#13#10 //
    +'    pu.ATIVO,'#13#10 //
    +'    pu.CRIADO_EM,'#13#10 //
    +'    pu.ALTERADO_EM'#13#10 //
    +'  FROM PESSOA pu'#13#10 //
    +'  INNER JOIN USUARIO u ON'#13#10 //
    +'    pu.LOJA_ID = u.LOJA_ID'#13#10 //
    +'    AND pu.TERMINAL_ID = u.TERMINAL_ID'#13#10 //
    +'    AND pu.PESSOA_ID = u.PESSOA_ID'#13#10 //
    +#13#10 //
    +'UNION'#13#10 //
    +#13#10 //
    +'  SELECT'#13#10 //
    +'    pf.LOJA_ID,'#13#10 //
    +'    pf.TERMINAL_ID,'#13#10 //
    +'    pf.PESSOA_ID,'#13#10 //
    +'    pf.NOME,'#13#10 //
    +'    pf.NOME_FANTASIA,'#13#10 //
    +'    pf.APELIDO,'#13#10 //
    +'    pf.GENERO_ID,'#13#10 //
    +'    pf.ESTADO_CIVIL_ID,'#13#10 //
    +'    pf.C,'#13#10 //
    +'    pf.I,'#13#10 //
    +'    pf.M,'#13#10 //
    +'    pf.M_UF,'#13#10 //
    +'    pf.EMAIL,'#13#10 //
    +'    pf.DT_NASC,'#13#10 //
    +'    pf.ATIVO,'#13#10 //
    +'    pf.CRIADO_EM,'#13#10 //
    +'    pf.ALTERADO_EM'#13#10 //
    +'  FROM PESSOA pf'#13#10 //
    +'  INNER JOIN FUNCIONARIO f ON'#13#10 //
    +'  pf.LOJA_ID = f.LOJA_ID'#13#10 //
    +'  AND pf.TERMINAL_ID = f.TERMINAL_ID'#13#10 //
    +'  AND pf.PESSOA_ID = f.PESSOA_ID'#13#10 //
    +#13#10 //
    +'UNION'#13#10 //
    +#13#10 //
    +'  SELECT'#13#10 //
    +'    pl.LOJA_ID,'#13#10 //
    +'    pl.TERMINAL_ID,'#13#10 //
    +'    pl.PESSOA_ID,'#13#10 //
    +'    pl.NOME,'#13#10 //
    +'    pl.NOME_FANTASIA,'#13#10 //
    +'    pl.APELIDO,'#13#10 //
    +'    pl.GENERO_ID,'#13#10 //
    +'    pl.ESTADO_CIVIL_ID,'#13#10 //
    +'    pl.C,'#13#10 //
    +'    pl.I,'#13#10 //
    +'    pl.M,'#13#10 //
    +'    pl.M_UF,'#13#10 //
    +'    pl.EMAIL,'#13#10 //
    +'    pl.DT_NASC,'#13#10 //
    +'    pl.ATIVO,'#13#10 //
    +'    pl.CRIADO_EM,'#13#10 //
    +'    pl.ALTERADO_EM'#13#10 //

    +'  FROM PESSOA pl'#13#10 //

    +'  INNER JOIN LOJA_EH_PESSOA l ON'#13#10 //
    +'  pl.LOJA_ID = l.LOJA_ID'#13#10 //
    +'  AND pl.TERMINAL_ID = l.TERMINAL_ID'#13#10 //
    +'  AND pl.PESSOA_ID = l.PESSOA_ID'#13#10 //

    +'  INNER JOIN LOJA PE ON'#13#10 //
    +'  pE.LOJA_ID = Pl.LOJA_ID'#13#10 //
    +'  AND PE.SELECIONADO'#13#10 //

    ;
end;

function TEnvTabPessoa.GetSqlTodosTerm: string;
begin
   Result := //
    '  SELECT'#13#10 //
    +'    LOJA_ID,'#13#10 //
    +'    TERMINAL_ID,'#13#10 //
    +'    PESSOA_ID,'#13#10 //
    +'    NOME,'#13#10 //
    +'    NOME_FANTASIA,'#13#10 //
    +'    APELIDO,'#13#10 //
    +'    GENERO_ID,'#13#10 //
    +'    ESTADO_CIVIL_ID,'#13#10 //
    +'    C,'#13#10 //
    +'    I,'#13#10 //
    +'    M,'#13#10 //
    +'    M_UF,'#13#10 //
    +'    EMAIL,'#13#10 //
    +'    DT_NASC,'#13#10 //
    +'    ATIVO,'#13#10 //
    +'    CRIADO_EM,'#13#10 //
    +'    ALTERADO_EM'#13#10 //
    +'  FROM PESSOA'#13#10 //
    ;
end;

function TEnvTabPessoa.Inserir(pLocal: TDBConnectionLocation;
  pReg: TRegistro): Boolean;
begin
  Result := True;
  FInsDBExec.Params[0].AsSmallInt := pReg.LOJA_ID;
  FInsDBExec.Params[1].AsSmallInt := pReg.TERMINAL_ID;
  FInsDBExec.Params[2].AsInteger := pReg.PESSOA_ID;
  FInsDBExec.Params[3].AsString := pReg.NOME;
  FInsDBExec.Params[4].AsString := pReg.NOME_FANTASIA;
  FInsDBExec.Params[5].AsString := pReg.APELIDO;
  FInsDBExec.Params[6].AsString := pReg.GENERO_ID;
  FInsDBExec.Params[7].AsString := pReg.ESTADO_CIVIL_ID;
  FInsDBExec.Params[8].AsString := pReg.C;
  FInsDBExec.Params[9].AsString := pReg.i;
  FInsDBExec.Params[10].AsString := pReg.M;
  FInsDBExec.Params[11].AsString := pReg.M_UF;
  FInsDBExec.Params[12].AsString := pReg.EMAIL;

  SetParamDateTime(FInsDBExec.Params[13], pReg.DT_NASC);

  FInsDBExec.Params[14].AsBoolean := pReg.ATIVO;

  SetParamDateTime(FInsDBExec.Params[15], pReg.CRIADO_EM);
  SetParamDateTime(FInsDBExec.Params[16], pReg.ALTERADO_EM);

  FInsDBExec.Execute;
end;

procedure TEnvTabPessoa.PreenchaArr(pLocal: TDBConnectionLocation);
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

end.
