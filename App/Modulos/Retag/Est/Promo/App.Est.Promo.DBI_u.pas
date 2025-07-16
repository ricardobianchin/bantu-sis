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

    function InserirItem: Boolean;
    function AlterarPromo: Boolean;

    constructor Create(pDBConnection: IDBConnection; pEstPromoEnt: IEstPromoEnt;
      pAppObj: IAppObj; pUsuarioId: TId);
  end;

implementation

uses Sis.DB.DataSet.Utils, Sis.DB.Factory, System.SysUtils, Sis.Types.Floats,
  Sis.DB.Firebird.GetSQL_u, Data.FmtBcd, Sis.Types.Bool_u, Sis.Types.Dates,
  Sis.Win.Utils_u;

{ TEstPromoDBI }

function TEstPromoDBI.AlterarPromo: Boolean;
begin
  Result := not FEstPromoEnt.GravaCabec;
  if Result then
    exit;

  Result := Alterar;
end;

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
var
  q: TDataSet;
  e: IEstPromoEnt;
begin
  e := FEstPromoEnt;

  if e.EditandoItem then
  begin
    Result := GetSqlInserirDoERetornaId;
    exit;
  end;

  Result := 'EXECUTE PROCEDURE PROMO_PA.ALTERAR_DO('#13#10 +
    e.Loja.Id.ToString + ', -- LOJA_ID'#13#10 + //
    e.PromoId.ToString + ', -- PROMO_ID'#13#10 + //
    QuotedStr(e.Nome) + ', -- NOME'#13#10 + //
    BooleanToStrSQL(e.Ativo) + ', -- PROMO_ATIVO'#13#10 + //
    DataHoraSQLFirebird(e.IniciaEm) + ', -- INICIA_EM'#13#10 + //
    DataHoraSQLFirebird(e.TerminaEm) + ', -- TERMINA_EM'#13#10 + //

    QuotedStr(e.AcaoSisId) + ', -- ACAO_SIS_ID'#13#10 + //

    UsuarioId.ToString + ', -- LOG_PESSOA_ID'#13#10 + //
    sMachId + ' -- MACHINE_ID'#13#10 //
    + ');' //
    ;

//   {$IFDEF DEBUG}
//   CopyTextToClipboard(Result);
//   {$ENDIF}
end;

function TEstPromoDBI.GetSqlForEach(pValues: variant): string;
begin
  Result := //
    'SELECT'#13#10 + //
    '  LOJA_ID,'#13#10 + // 0
    '  PROMO_ID,'#13#10 + // 1
    '  COD,'#13#10 + // 2
    '  NOME,'#13#10 + // 3
    '  ATIVO,'#13#10 + // 4
    '  INICIA_EM,'#13#10 + // 5
    '  TERMINA_EM'#13#10 + // 6
    'FROM PROMO_PA.LISTA_GET'#13#10 //
  // (' + pValues + ')'
    ;
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}
end;

function TEstPromoDBI.GetSqlInserirDoERetornaId: string;
var
  i: integer;
  iProdId: TId;
  uPrecoPromo: Currency;
  e: IEstPromoEnt;
//  bItemAtivo: Boolean;
begin
  e := FEstPromoEnt;
  if e.EditandoItem and (e.State = dsEdit) then
  begin
    i := e.ItemIndex;
  end
  else
  begin
    i := e.Items.Count - 1;
  end;

  iProdId := e.Items[i].Prod.Id;
  Bcdtocurr(e.Items[i].PrecoPromo, uPrecoPromo);
//  bItemAtivo := e.Items[i].Ativo;

  Result := //
    'SELECT'#13#10 + 'PROMO_ID_RET'#13#10 //

    + 'FROM PROMO_PA.PROMO_ITEM_INS('#13#10 + //

    e.Loja.Id.ToString + ', -- LOJA_ID'#13#10 + //
    e.PromoId.ToString + ', -- PROMO_ID'#13#10 + //
    QuotedStr(e.Nome) + ', -- NOME'#13#10 + //
    BooleanToStrSQL(e.Ativo) + ', -- PROMO_ATIVO'#13#10 + //
    DataHoraSQLFirebird(e.IniciaEm) + ', -- INICIA_EM'#13#10 + //
    DataHoraSQLFirebird(e.TerminaEm) + ', -- TERMINA_EM'#13#10 + //
    BooleanToStrSQL(e.GravaCabec) + ', -- GRAVA_CABEC'#13#10 + //
    iProdId.ToString + ', -- PROD_ID'#13#10 + //
    CurrencyToStrPonto(uPrecoPromo) + ', -- PRECO_PROMO'#13#10 + //
//    BooleanToStrSQL(bItemAtivo) + ', -- PROMO_ITEM_ATIVO'#13#10 + //
    QuotedStr(e.AcaoSisId) + ', -- ACAO_SIS_ID'#13#10 + //

    UsuarioId.ToString + ', -- LOG_PESSOA_ID'#13#10 + //
    sMachId + ' -- MACHINE_ID'#13#10 //
    + ');' //
    ;

// {$IFDEF DEBUG}
// CopyTextToClipboard(Result);
// {$ENDIF}
end;

function TEstPromoDBI.InserirItem: Boolean;
var
  aNovaId: variant;
begin
  Result := Inserir(aNovaId);
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
    + 'AND LOJA_ID = ' + IntToStr(FEstPromoEnt.Loja.Id) + #13#10;;

  if pPromoIdExceto > 0 then
  begin
    sSql := sSql + 'AND PROMO_ID <> ' + IntToStr(pPromoIdExceto) + #13#10
  end;

  sSql := GetSQLExists(sSql);

  DBConnection.Abrir;
  try
    oDBQuery := DBQueryCreate('promo.exist.q', DBConnection, sSql, nil, nil);
    oDBQuery.Abrir;
    try
      Result := oDBQuery.Fields[0].AsInteger = 1;
      // pMensagem := 'Este nome de promoção já existe.';

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
  if FEstPromoEnt.EditandoItem then
    exit;
  FEstPromoEnt.PromoId := pNovaId[0];
end;

end.
