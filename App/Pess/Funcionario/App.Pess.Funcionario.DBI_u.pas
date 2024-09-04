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
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessFuncionarioDBI }

constructor TPessFuncionarioDBI.Create(pDBConnection: IDBConnection;
  pPessFuncionarioEnt: IPessFuncionarioEnt);
begin
  inherited Create(pDBConnection, pPessFuncionarioEnt);
  FPessFuncionarioEnt := pPessFuncionarioEnt;
end;

function TPessFuncionarioDBI.GetFieldNamesListaGet: string;
begin
  Result := inherited
    + ', NOME_DE_USUARIO'#13#10 // 32
    + ', SENHA'#13#10 // 33
    + ', CRY_VER'#13#10 // 34
    ;
end;

function TPessFuncionarioDBI.GetFieldValuesGravar: string;
begin
  Result := inherited
    + ', ' + QuotedStr(FPessFuncionarioEnt.NomeDeUsuario) + ' -- nome_de_usuario' + #13#10 //
    + ', ' + QuotedStr(FPessFuncionarioEnt.Senha) + ' -- senha' + #13#10 //
    + ', ' + FPessFuncionarioEnt.CryVer.ToString + ' -- cry_ver' + #13#10 //
    ;
end;

function TPessFuncionarioDBI.GetSqlGaranteRegRetId: string;
begin
  Result :=
    'SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET'#13#10 //
    + 'FROM USUARIO_PA.GARANTIR('#13#10 //
    + GetFieldValuesGravar //
    + ');'#13#10 //
    ;
end;

function TPessFuncionarioDBI.GetSqlPreencherDataSet(pValues: variant): string;
// var
// iLojaId: integer;
begin
  // iLojaId := pValues[0];

  Result := 'SELECT'#13#10 //
    + GetFieldNamesListaGet //
    + 'FROM FUNCIONARIO_USUARIO_MANUT_PA.LISTA_GET' //
    + ';'#13#10 //
    ;

{
  Result := 'SELECT'#13#10
    + GetFieldNamesListaGet
    + 'FROM LOJA_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ');'#13#10 //
    ;
}
end;

procedure TPessFuncionarioDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
  FPessFuncionarioEnt.NomeDeUsuario := q.Fields[32].AsString;
  FPessFuncionarioEnt.Senha := q.Fields[33].AsString;
  FPessFuncionarioEnt.CryVer := q.Fields[34].AsInteger;
end;

end.
