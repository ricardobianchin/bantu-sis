unit App.Pess.Cliente.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Cliente.DBI,
  App.Pess.Cliente.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u;

type
  TPessClienteDBI = class(TPessDBI, IPessClienteDBI)
  private
    FPessClienteEnt: IPessClienteEnt;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    procedure RegAtualToEnt(Q: TDataSet); override;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;

    function GetSqlGaranteRegERetornaId: string; override;
  public
    constructor Create(pDBConnection: IDBConnection;
      pPessClienteEnt: IPessClienteEnt);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessClienteDBI }

constructor TPessClienteDBI.Create(pDBConnection: IDBConnection;
  pPessClienteEnt: IPessClienteEnt);
begin
  inherited Create(pDBConnection, pPessClienteEnt);
  FPessClienteEnt := pPessClienteEnt;
end;

function TPessClienteDBI.GetFieldNamesListaGet: string;
begin
  Result := inherited
    ;

{  Result := inherited
    + ', NOME_DE_USUARIO'#13#10 // 32
    + ', SENHA'#13#10 // 33
    + ', CRY_VER'#13#10 // 34
    ;
}
end;

function TPessClienteDBI.GetFieldValuesGravar: string;
begin
  Result := inherited
    ;

{  Result := inherited
    + ', ' + QuotedStr(FPessClienteEnt.NomeDeUsuario) + ' -- nome_de_usuario' + #13#10 //
    + ', ' + QuotedStr(FPessClienteEnt.Senha) + ' -- senha' + #13#10 //
    + ', ' + FPessClienteEnt.CryVer.ToString + ' -- cry_ver' + #13#10 //
    ;}
end;

function TPessClienteDBI.GetSqlGaranteRegERetornaId: string;
begin
  Result :=
    'SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET'#13#10 //
    + 'FROM CLIENTE_PA.GARANTIR('#13#10 //
    + GetFieldValuesGravar //
    + ');'#13#10 //
    ;
end;

function TPessClienteDBI.GetSqlForEach(pValues: variant): string;
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
    + 'FROM CLIENTE_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ', ' + iTerminalId.ToString //
    + ', ' + iPessoaId.ToString //
    + ');'#13#10 //
    ;
end;

procedure TPessClienteDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
//  FPessClienteEnt.NomeDeUsuario := q.Fields[32].AsString;
//  FPessClienteEnt.Senha := q.Fields[33].AsString;
//  FPessClienteEnt.CryVer := q.Fields[34].AsInteger;
end;

end.
