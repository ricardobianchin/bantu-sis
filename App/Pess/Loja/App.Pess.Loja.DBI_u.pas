unit App.Pess.Loja.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.Pess.Geral.Factory_u, App.Pess.DBI_u;

type
  TPessLojaDBI = class(TPessDBI, IPessLojaDBI)
  private
    FPessLojaEnt: IPessLojaEnt;
    FSelecionadoFieldIndex: integer;
  protected
    function GetSqlForEach(pValues: variant): string; override;
    procedure RegAtualToEnt(Q: TDataSet); override;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;

    function GetSqlGaranteRegERetornaId: string; override;

    function GetSqlCToPess(pC: string; pExcetoLojaId: smallint;
      pExcetoTerminalId: smallint; pExcetoPessoaId: integer): string;
      override;
  public
    constructor Create(pDBConnection: IDBConnection; pPessLojaEnt: IPessLojaEnt);
    function LojaIdExiste(pLojaId: SmallInt; out pApelido: string): boolean;
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessLojaDBI }

constructor TPessLojaDBI.Create(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt);
begin
  inherited Create(pDBConnection, pPessLojaEnt);
  FPessLojaEnt := pPessLojaEnt;
end;

procedure TPessLojaDBI.RegAtualToEnt(Q: TDataSet);
begin
  inherited;
  FPessLojaEnt.Selecionado := q.FieldByName('SELECIONADO').AsBoolean;
end;

function TPessLojaDBI.GetFieldNamesListaGet: string;
begin
  Result := inherited
    +', Selecionado'#13#10//32
    ;
end;

function TPessLojaDBI.GetFieldValuesGravar: string;
begin
  Result := inherited
    + ', ' + BooleanToStrSQL(FPessLojaEnt.Selecionado) +' -- Selecionado'+ #13#10

    + ', ' + FPessLojaEnt.LogLojaId.ToString +' -- LOG_LOJA_ID'+ #13#10
    + ', ' + FPessLojaEnt.LogUsuarioId.ToString +' -- LOG_PESSOA_ID'+ #13#10
    + ', ' + FPessLojaEnt.MachineIdentId.ToString +' -- MACHINE_ID'+ #13#10

    ;
end;

function TPessLojaDBI.GetSqlGaranteRegERetornaId: string;
begin
  Result := 'SELECT LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_RET'#13#10
    + 'FROM LOJA_MANUT_PA.GARANTIR('#13#10
    + GetFieldValuesGravar
    + ');'#13#10
    ;
//  {$IFDEF DEBUG}
//  CopyTextToClipboard(Result);
//  {$ENDIF}

end;

function TPessLojaDBI.GetSqlCToPess(pC: string; pExcetoLojaId,
  pExcetoTerminalId: smallint; pExcetoPessoaId: integer): string;
begin
  Result := 'SELECT P.LOJA_ID, P.TERMINAL_ID, P.PESSOA_ID, P.NOME'#13#10 + //
    'FROM PESSOA P'#13#10 + //
    'JOIN LOJA_EH_PESSOA F ON'#13#10 + //
    'P.LOJA_ID  = F.LOJA_ID'#13#10 + //
    'AND P.TERMINAL_ID = F.TERMINAL_ID'#13#10 + //
    'AND P.PESSOA_ID = F.PESSOA_ID'#13#10 + //
    'WHERE P.C = ' + QuotedStr(pC) + #13#10;

  if (pExcetoLojaId <> 0) and (pExcetoPessoaId <> 0) then
  begin
    Result := Result + 'AND NOT (P.LOJA_ID = ' + pExcetoLojaId.ToString +
      ' AND P.PESSOA_ID = ' + pExcetoPessoaId.ToString + ')'#13#10;
  end;
end;

function TPessLojaDBI.GetSqlForEach(pValues: variant): string;
var
  iLojaId: integer;
begin
  iLojaId := pValues[0];

  Result := 'SELECT'#13#10
    + GetFieldNamesListaGet
    + 'FROM LOJA_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ');'#13#10 //
    ;
end;

function TPessLojaDBI.LojaIdExiste(pLojaId: SmallInt; out pApelido: string): boolean;
var
  sFormat: string;
  sSql: string;
  vResult: Variant;
begin
  Result := False;
  sFormat := 'SELECT APELIDO FROM LOJA_INICIAL_PA.BYID_GET(%d);';
  sSql := Format(sFormat, [pLojaId]);

  DBConnection.Abrir;
  try
    vResult := DBConnection.GetValue(sSql);
    if VarIsNull(vResult) then
      pApelido := ''
    else
      pApelido := Trim(vResult);

    Result := pApelido <> '';
  finally
    DBConnection.Fechar;
  end;
end;

end.
