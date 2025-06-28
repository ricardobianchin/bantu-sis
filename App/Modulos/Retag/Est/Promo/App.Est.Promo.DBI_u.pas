unit App.Est.Promo.DBI_u;

interface

uses App.Ent.DBI_u, App.Est.Promo.DBI, Sis.Entities.Types, Sis.Types,
  Sis.DB.DBTypes, App.Ent.Ed, App.AppObj, App.Est.EstMovItem, Data.DB,
  App.Est.Promo.Ent;

type
  TEstPromoDBI = class(TEntDBI, IEstPromoDBI)
  private
    FAppObj: IAppObj;
    FUsuarioId: TId;
    FMachId: string;
    FEstPromoEnt: IEstPromoEnt;
    property UsuarioId: TId read FUsuarioId;
    property AppObj: IAppObj read FAppObj;
    property sMachId: string read FMachId;

  protected
    function GetSqlForEach(pValues: variant): string; override;

    procedure SetVarArrayToId(pNovaId: variant); override;
    function GetSqlInserirDoERetornaId: string; override;
    function GetSqlAlterarDo: string; override;

  public
    {
      procedure EstMovCancele(out pCanceladoEm: TDateTime; out pErroDeu: Boolean;
      out pErroMens: string; pLojaId: TLojaId; pEstMovId: Int64;
      pTerminalId: TTerminalId = 0; pModuloSisId: Char = '"');
    }
    function NomeJaExistente(pNome: string;
      pPromoIdExceto: integer = 0): Boolean;

    constructor Create(pDBConnection: IDBConnection; pEstPromoEnt: IEstPromoEnt;
      pAppObj: IAppObj; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats,
  Sis.DB.Firebird.GetSQL_u;

{ TEstPromoDBI }

constructor TEstPromoDBI.Create(pDBConnection: IDBConnection;
  pEstPromoEnt: IEstPromoEnt; pAppObj: IAppObj; pUsuarioId: TId);
begin
  inherited Create(pDBConnection, pEstPromoEnt);
  FUsuarioId := pUsuarioId;
  FAppObj := pAppObj;
  FMachId := AppObj.SisConfig.LocalMachineId.IdentId.ToString;
  FEstPromoEnt := pEstPromoEnt;
end;

function TEstPromoDBI.GetSqlAlterarDo: string;
begin

end;

function TEstPromoDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := //
    'SELECT'#13#10 + //
    '  LOJA_ID,'#13#10 + //
    '  PROMO_ID,'#13#10 + //
    '  COD,'#13#10 + //
    '  NOME,'#13#10 + //
    '  ATIVO,'#13#10 + //
    '  INICIA_EM,'#13#10 + //
    '  TERMINA_EM'#13#10 + //
    'FROM PROMO_PA.LISTA_GET'#13#10 //
  // (' + pValues + ')'
    ;
end;

function TEstPromoDBI.GetSqlInserirDoERetornaId: string;
begin

end;

function TEstPromoDBI.NomeJaExistente(pNome: string;
  pPromoIdExceto: integer): Boolean;
var
  sSql: string;
  oDBQuery: IDBQuery;
begin
  Result := False;

  sSql := //
  'SELECT PROMO_ID'#13#10 //
    + 'FROM PROMO'#13#10 //
    + 'WHERE NOME = ' + QuotedStr(pNome) + #13#10 //
    + 'AND LOJA_ID = ' + IntToStr(FEstPromoEnt.Loja.Id) + #13#10;
    ;

  if pPromoIdExceto > 0 then
  begin
    sSql := sSql + 'AND PROMO_ID <> ' + IntToStr(pPromoIdExceto) + #13#10
  end;

  sSql := GetSQLExists(sSql);

  DBConnection.Abrir;
  try
    oDBQuery := DBQueryCreate('promo.exist.q', DBConnection, sSql,
      nil, nil);
    oDBQuery.Abrir;
    try
      Result := oDBQuery.Fields[0].AsInteger = 1;
      //pMensagem := 'Este nome de promoção já existe.';

    finally
      oDBQuery.Fechar;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

procedure TEstPromoDBI.SetVarArrayToId(pNovaId: variant);
begin
  inherited;

end;

end.
