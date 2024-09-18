unit App.Pess.Funcionario.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Funcionario.DBI,
  App.Pess.Funcionario.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u;

type
  TPessFuncionarioDBI = class(TPessDBI, IPessFuncionarioDBI)
  private
    FPessFuncionarioEnt: IPessFuncionarioEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure RegAtualToEnt(Q: TDataSet); override;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;

    function GetSqlGaranteRegRetId: string; override;

  public
    constructor Create(pDBConnection: IDBConnection;
      pPessFuncionarioEnt: IPessFuncionarioEnt);
    function GravarSenha(pNovaSenha: string; pCryVer: integer;
      out pMens: string): Boolean;
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
    ;
end;

function TPessFuncionarioDBI.GetSqlGaranteRegRetId: string;
begin
  Result := 'SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET'#13#10 //
    + 'FROM USUARIO_PA.GARANTIR('#13#10 //
    + GetFieldValuesGravar //
    + ');'#13#10 //
    ;
end;

function TPessFuncionarioDBI.GetSqlPreencherDataSet(pValues: variant): string;
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

function TPessFuncionarioDBI.GravarSenha(pNovaSenha: string; pCryVer: integer;
  out pMens: string): Boolean;
begin
  FPessFuncionarioEnt.Senha := pNovaSenha;
  FPessFuncionarioEnt.CryVer := pCryVer;

  Result := Sis.Usuario.Senha_u.GravarSenha(pNovaSenha, pCryVer,
    FPessFuncionarioEnt.LojaId, FPessFuncionarioEnt.TerminalId,
    FPessFuncionarioEnt.Id, DBConnection, pMens);
end;

procedure TPessFuncionarioDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
  FPessFuncionarioEnt.NomeDeUsuario := Q.Fields[36].AsString;
  FPessFuncionarioEnt.Senha := Q.Fields[37].AsString;
  FPessFuncionarioEnt.CryVer := Q.Fields[38].AsInteger;
end;

end.
