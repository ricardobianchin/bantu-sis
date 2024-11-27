unit App.Pess.Funcionario.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, Vcl.CheckLst,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Funcionario.DBI,
  App.Pess.Funcionario.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u,
  Sis.UI.IO.Output;

type
  TPessFuncionarioDBI = class(TPessDBI, IPessFuncionarioDBI)
  private
    FPessFuncionarioEnt: IPessFuncionarioEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    procedure RegAtualToEnt(Q: TDataSet); override;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;

    function GetSqlGaranteRegERetornaId: string; override;

  public
    constructor Create(pDBConnection: IDBConnection;
      pPessFuncionarioEnt: IPessFuncionarioEnt);
    function GravarSenha(pNovaSenha: string; pCryVer: integer;
      out pMens: string): Boolean;
    function PreencherCheckListBox(pCheckListBox: TCheckListBox;
      pErroOutput: IOutput): Boolean;
    function GravarPerfis(pLojaId: smallint; pPessoaId: integer;
      pStrPerfisId: string; pErroOutput: IOutput): Boolean;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats,
  App.Constants, Sis.Usuario.Senha_u;

{ TPessFuncionarioDBI }

constructor TPessFuncionarioDBI.Create(pDBConnection: IDBConnection;
  pPessFuncionarioEnt: IPessFuncionarioEnt);
begin
  inherited Create(pDBConnection, pPessFuncionarioEnt);
  FPessFuncionarioEnt := pPessFuncionarioEnt;
end;

function TPessFuncionarioDBI.GetFieldNamesListaGet: string;
begin
  Result := inherited //
    + ', NOME_DE_USUARIO'#13#10 // 32
    + ', SENHA'#13#10 // 33
    + ', CRY_VER'#13#10 // 34
    + ', PERFIL_DE_USO_DESCRS'#13#10 // 35
    ;
end;

function TPessFuncionarioDBI.GetFieldValuesGravar: string;
var
  e: IPessFuncionarioEnt;
begin
  e := FPessFuncionarioEnt;
  Result := inherited //
    + ', ' + QuotedStr(e.NomeDeUsuario) + ' -- nome_de_usuario' + #13#10 //
    + ', ' + QuotedStr(e.Senha) + ' -- senha' + #13#10 //
    + ', ' + e.CryVer.ToString + ' -- cry_ver' + #13#10 //

    + ', ' + e.LogUsuarioId.ToString + ' -- LOG_PESSOA_ID' + #13#10 //
    + ', ' + e.MachineIdentId.ToString + ' -- MACHINE_ID' + #13#10 //

    ;
end;

function TPessFuncionarioDBI.GetSqlGaranteRegERetornaId: string;
begin
  Result := 'SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET'#13#10 //

    + 'FROM USUARIO_PA.GARANTIR('#13#10 //

    + GetFieldValuesGravar //
    + ');'#13#10 //
    ;
end;

function TPessFuncionarioDBI.GetSqlForEach(pValues: variant): string;
var
  iLojaId: smallint;
  iTerminalId: smallint;
  iPessoaId: integer;
begin
  iLojaId := pValues[0];
  iTerminalId := pValues[1];
  iPessoaId := pValues[2];

  Result := 'SELECT'#13#10 //
    + GetFieldNamesListaGet //
    + 'FROM FUNCIONARIO_USUARIO_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ', ' + iTerminalId.ToString //
    + ', ' + iPessoaId.ToString //
    + ');'#13#10 //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

function TPessFuncionarioDBI.GravarPerfis(pLojaId: smallint; pPessoaId: integer;
  pStrPerfisId: string; pErroOutput: IOutput): Boolean;
var
  sSql: string;
begin
  Result := DBConnection.Abrir;
  if not Result then
  begin
    pErroOutput.Exibir(DBConnection.UltimoErro);
    exit;
  end;
  try

    sSql := 'EXECUTE PROCEDURE USUARIO_PA.TEM_PERFIS_GARANTIR(' +
      pLojaId.ToString // LOJA_ID
      + ', ' + pPessoaId.ToString // USUARIO_PESSOA_ID
      + ', ' + QuotedStr(pStrPerfisId) // STR_PERFIS_ID
      + ', ' + FPessFuncionarioEnt.LogUsuarioId.ToString
      + ', ' + FPessFuncionarioEnt.MachineIdentId.ToString // MACHINE_ID
      + ');';

    try
      DBConnection.ExecuteSQL(sSql);
    except
      on e: Exception do
      begin
        pErroOutput.Exibir(DBConnection.UltimoErro);
        Result := False;
      end;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

function TPessFuncionarioDBI.GravarSenha(pNovaSenha: string; pCryVer: integer;
  out pMens: string): Boolean;
begin
  FPessFuncionarioEnt.Senha := pNovaSenha;
  FPessFuncionarioEnt.CryVer := pCryVer;

  Result := Sis.Usuario.Senha_u.GravarSenha(pNovaSenha, pCryVer,
    FPessFuncionarioEnt.LojaId, FPessFuncionarioEnt.Id,
    FPessFuncionarioEnt.LogUsuarioId, FPessFuncionarioEnt.MachineIdentId, DBConnection, pMens);
end;

function TPessFuncionarioDBI.PreencherCheckListBox(pCheckListBox: TCheckListBox;
  pErroOutput: IOutput): Boolean;
var
  Q: TDataSet;
  sSql: string;
  iPessoaId: integer;
  pPessoaId: Pointer;
  sPerfilNome: string;
  bTem: Boolean;
  iIndex: integer;
begin
  pCheckListBox.Clear;

  sSql := 'select PERFIL_DE_USO_ID, NOME, TEM'#13#10 //
    + 'FROM FUNCIONARIO_USUARIO_MANUT_PA.PERFIL_DE_USO_IDS_GET('#13#10 //
    + FPessFuncionarioEnt.LojaId.ToString + ','#13#10 //
    + FPessFuncionarioEnt.TerminalId.ToString + ','#13#10 //
    + FPessFuncionarioEnt.Id.ToString + #13#10 //
    + ');'; //

  Result := DBConnection.Abrir;
  if not Result then
  begin
    pErroOutput.Exibir(DBConnection.UltimoErro);
    exit;
  end;
  try
    DBConnection.QueryDataSet(sSql, Q);

    Result := Q <> nil;
    if not Result then
    begin
      pErroOutput.Exibir('Erro consultando perfis de uso');
      exit;
    end;
    try
      iIndex := 0;
      while not Q.Eof do
      begin
        iPessoaId := Q.Fields[0].AsInteger;
        sPerfilNome := Q.Fields[1].AsString.Trim;
        bTem := Q.Fields[2].AsBoolean;

        pPessoaId := Pointer(iPessoaId);

        pCheckListBox.Items.AddObject(sPerfilNome, pPessoaId);
        pCheckListBox.Checked[iIndex] := bTem;
        Q.Next;
        inc(iIndex);
      end;
    finally
      Q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TPessFuncionarioDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
  FPessFuncionarioEnt.NomeDeUsuario := Q.Fields[36].AsString;
  FPessFuncionarioEnt.Senha := Q.Fields[37].AsString;
  FPessFuncionarioEnt.CryVer := Q.Fields[38].AsInteger;
end;

end.
