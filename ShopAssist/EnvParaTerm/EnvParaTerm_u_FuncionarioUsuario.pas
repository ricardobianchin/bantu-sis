unit EnvParaTerm_u_FuncionarioUsuario;

interface

uses DBTermDM_u, ExecScript_u;

procedure EnvFuncionarioUsuario(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);

implementation

uses DBServDM_u, Data.DB, FireDAC.Comp.Client, Sis.Types.Integers,
  System.SysUtils, DB_u, Sis.DB.SqlUtils_u, Sis.Win.Utils_u;

function GetSqlServLogs(pLogIdIni, pLogIdFin: Int64): string;
begin
  Result := //
    'SELECT'#13#10 //

    + 'LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', PESSOA_ID'#13#10 // 2

    + ', NOME'#13#10 // 3
    + ', NOME_FANTASIA'#13#10 // 4
    + ', APELIDO'#13#10 // 5
    + ', GENERO_ID'#13#10 // 6
    + ', ESTADO_CIVIL_ID'#13#10 // 7
    + ', C'#13#10 // 8
    + ', I'#13#10 // 9
    + ', M'#13#10 // 10
    + ', M_UF'#13#10 // 11
    + ', EMAIL'#13#10 // 12
    + ', DT_NASC'#13#10 // 13
    + ', ATIVO'#13#10 // 14
    + ', CRIADO_EM'#13#10 // 15
    + ', ALTERADO_EM'#13#10 // 16

    + ', 0 ORDEM'#13#10 // 17
    + ', LOGRADOURO'#13#10 // 18
    + ', NUMERO'#13#10 // 19
    + ', COMPLEMENTO'#13#10 // 20
    + ', BAIRRO'#13#10 // 21
    + ', UF_SIGLA'#13#10 // 22
    + ', CEP'#13#10 // 23
    + ', MUNICIPIO_IBGE_ID'#13#10 // 24
    + ', DDD'#13#10 // 25
    + ', FONE1'#13#10 // 26
    + ', FONE2'#13#10 // 27
    + ', FONE3'#13#10 // 28
    + ', CONTATO'#13#10 // 29
    + ', REFERENCIA'#13#10 // 30

    + ', NOME_DE_USUARIO'#13#10 // 31
    + ', SENHA'#13#10 // 32
    + ', CRY_VER'#13#10 // 33
    + ', DE_SISTEMA'#13#10 // 34

    + 'FROM LOG_HIST_PA.TEVE_FUNCIONARIO_USUARIO('#13#10 //

    + pLogIdIni.ToString //
    + ', ' + pLogIdFin.ToString //

    + ');' //
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

procedure EnvFuncionarioUsuario(pTermDM: TDBTermDM; oExecScript: TExecScript;
  pLogIdIni, pLogIdFin: Int64);
var
  sSql: string;
  q: TDataSet;
  NomeDeUsuarioField: TField;
begin
  sSql := GetSqlServLogs(pLogIdIni, pLogIdFin);
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
  DBServDM.Connection.ExecSQL(sSql, q);

  if not Assigned(q) then
    exit;

  try
    NomeDeUsuarioField := q.Fields[31];

    while not q.Eof do
    begin
      sSql := DataSetToSqlGarantir(q, 'PESSOA',
        'LOJA_ID, TERMINAL_ID, PESSOA_ID', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
        11, 12, 13, 14, 15, 16]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'ENDERECO',
        'LOJA_ID, TERMINAL_ID, PESSOA_ID, ORDEM', [0, 1, 2, 17, 18, 19, 20, 21,
        22, 23, 24, 25, 26, 27, 28, 29, 30]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}
      oExecScript.PegueComando(sSql);

      sSql := DataSetToSqlGarantir(q, 'FUNCIONARIO',
        'LOJA_ID, TERMINAL_ID, PESSOA_ID', [0, 1, 2]);
      // {$IFDEF DEBUG}
      // CopyTextToClipboard(sSql);
      // {$ENDIF}
      oExecScript.PegueComando(sSql);

      if not NomeDeUsuarioField.IsNull then
      begin
        sSql := DataSetToSqlGarantir(q, 'USUARIO',
          'LOJA_ID, TERMINAL_ID, PESSOA_ID', [0, 1, 2, 31, 32, 33, 34]);
        // {$IFDEF DEBUG}
        // CopyTextToClipboard(sSql);
        // {$ENDIF}
        oExecScript.PegueComando(sSql);
      end;
      q.Next;
    end;
  finally
    q.Free
  end;
end;

end.
