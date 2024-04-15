unit App.Retag.Fin.PagForma.DBI_u;

interface

uses Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Variants,
  Sis.Types.Integers, App.Ent.DBI_u, App.Retag.Fin.PagForma.Ent;

type
  TPagFormaDBI = class(TEntDBI)
  private
    function GetPagFormaEnt: IPagFormaEnt;
    property Ent: IPagFormaEnt read GetPagFormaEnt;
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    function GetSqlGetExistente(pValues: variant): string; override;
    function GetSqlGarantirRegId: string; override;
    procedure SetNovaId(pId: variant); override;
    function GetPackageName: string; override;
  public
    function Inserir(out pNovaId: Variant): boolean; override;
    function Alterar: boolean; override;
    function Ler: boolean; override;

  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Retag.Fin.Factory,
  Sis.Types.Bool_u, Sis.Types.Floats, Sis.Win.Utils_u;

{ TPagFormaDBI }

function TPagFormaDBI.Alterar: boolean;
var
  sSql: string;
  sMens: string;
  bResultado: boolean;
begin
  Result := False;

  sSql := 'EXECUTE PROCEDURE PAGAMENTO_FORMA_PA.ALTERAR_DO('
    + Ent.Id.ToString
    + ',' + QuotedStr(Ent.FormaTipo)

    + ',' + QuotedStr(Ent.Descr)
    + ',' + QuotedStr(Ent.DescrRed)

    + ',' + BooleanToStrSQL(Ent.Ativo)
    + ',' + BooleanToStrSQL(Ent.ParaVenda)
    + ', FALSE'//SIS
    + ',' + BooleanToStrSQL(Ent.PromocaoPermite)
    + ',' + BooleanToStrSQL(Ent.ComicaoPermite)
    + ',' + CurrencyToStrPonto(Ent.TaxaAdmPerc) //
    + ',' + CurrencyToStrPonto(Ent.ValorMinimo) //

    + ',' + CurrencyToStrPonto(Ent.ComissaoAbaterPerc) //
    + ',' + Ent.ReembolsoDias.ToString
    + ',' + BooleanToStrSQL(Ent.TEFUsa)

    + ',' + BooleanToStrSQL(Ent.AutorizacaoExige)
    + ',' + BooleanToStrSQL(Ent.PessoaExige)
    + ',' + BooleanToStrSQL(Ent.AVista)
    + ');';

  bResultado := DBConnection.Abrir;
  if not bResultado then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;
  try
    DBConnection.ExecuteSQL(sSql);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TPagFormaDBI.GetPackageName: string;
begin
  Result := 'PAGAMENTO_FORMA_PA';
end;

function TPagFormaDBI.GetPagFormaEnt: IPagFormaEnt;
begin
  Result := EntEdCastToPagFormaEnt(EntEd);
end;

function TPagFormaDBI.GetSqlGarantirRegId: string;
begin

end;

function TPagFormaDBI.GetSqlGetExistente(pValues: variant): string;
begin

end;

function TPagFormaDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result := 'SELECT'
    +' FORMA_ID' //ID_SHORT_DOM
    +', FORMA_TIPO_DESCR' //NOME_INTERM_DOM
    +', DESCR' //NOME_INTERM_DOM
    +', DESCR_RED' //CHAR(8)
    +', PARA_VENDA' //BOOLEAN
    +', ATIVO' //BOOLEAN
    +' FROM PAGAMENTO_FORMA_PA.LISTA_GET;'
    ;
end;

function TPagFormaDBI.Inserir(out pNovaId: Variant): boolean;
var
  sSql: string;
  sMens: string;
  bResultado: boolean;
begin
  Result := False;

  sSql := 'SELECT PAGAMENTO_FORMA_ID FROM PAGAMENTO_FORMA_PA.INSERIR_DO('
    + QuotedStr(Ent.FormaTipo)
    + ',' + QuotedStr(Ent.Descr)
    + ',' + QuotedStr(Ent.DescrRed)
    + ',' + BooleanToStrSQL(Ent.Ativo)
    + ',' + BooleanToStrSQL(Ent.ParaVenda)
    + ', FALSE'//SIS
    + ',' + BooleanToStrSQL(Ent.PromocaoPermite)
    + ',' + BooleanToStrSQL(Ent.ComicaoPermite)
    + ',' + CurrencyToStrPonto(Ent.TaxaAdmPerc) //
    + ',' + CurrencyToStrPonto(Ent.ValorMinimo) //
    + ',' + CurrencyToStrPonto(Ent.ComissaoAbaterPerc) //
    + ',' + Ent.ReembolsoDias.ToString
    + ',' + BooleanToStrSQL(Ent.TEFUsa)
    + ',' + BooleanToStrSQL(Ent.AutorizacaoExige)
    + ',' + BooleanToStrSQL(Ent.PessoaExige)
    + ',' + BooleanToStrSQL(Ent.AVista)
    + ');';

  bResultado := DBConnection.Abrir;
  if not bResultado then
  begin
    sMens := DBConnection.UltimoErro;
    exit;
  end;
  try
    pNovaId := DBConnection.GetValueInteger(sSql);
  finally
    DBConnection.Fechar;
    Result := True;
  end;
end;

function TPagFormaDBI.Ler: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  iId: integer;
  sFormaTipo: string;
  sNome: string;
begin
  Result := False;

  sSql := 'SELECT ' +
      'TIPO_ID' + //0
      ', TIPO_DESCR' + //1
      ', TIPO_DESCR_RED' + //2
      ', TIPO_ATIVO' + //3
      ', DESCR' + //4
      ', DESCR_RED' + //5
      ', ATIVO' + //6
      ', PARA_VENDA' + //7
      ', SIS' + //8
      ', PROMOCAO_PERMITE' + //9
      ', COMISSAO_PERMITE' + //10
      ', TAXA_ADM_PERC' + //11
      ', VALOR_MINIMO' + //12
      ', COMISSAO_ABATER_PERC' + //13
      ', REEMBOLSO_DIAS' + //14
      ', TEF_USA' + //15
      ', AUTORIZACAO_EXIGE' + //16
      ', PESSOA_EXIGE' + //17
      ', A_VISTA' + //18

    ' FROM PAGAMENTO_FORMA_PA.BYID_GET(' + Ent.Id.ToString + ');';

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    sFormaTipo := q.Fields[0].AsString.Trim;
    if sFormaTipo = '' then
      sFormaTipo := #32;

    Ent.FormaTipo := sFormaTipo[1];
    Ent.PagFormaTipo.Descr := q.Fields[1].AsString.Trim;
    Ent.PagFormaTipo.DescrRed := q.Fields[2].AsString.Trim;
    Ent.PagFormaTipo.Ativo := q.Fields[3].AsBoolean;

    Ent.Descr := q.Fields[4].AsString.Trim;
    Ent.DescrRed := q.Fields[5].AsString.Trim;

    Ent.Ativo := q.Fields[6].AsBoolean;
    Ent.ParaVenda := q.Fields[7].AsBoolean;
    //sis [8]
    Ent.PromocaoPermite := q.Fields[9].AsBoolean;
    Ent.ComicaoPermite := q.Fields[10].AsBoolean;
    Ent.TaxaAdmPerc := q.Fields[11].AsCurrency;
    Ent.ValorMinimo := q.Fields[12].AsCurrency;
    Ent.ComissaoAbaterPerc := q.Fields[13].AsCurrency;
    Ent.ReembolsoDias := q.Fields[14].AsInteger;
    Ent.TEFUsa := q.Fields[15].AsBoolean;
    Ent.AutorizacaoExige := q.Fields[16].AsBoolean;
    Ent.PessoaExige := q.Fields[17].AsBoolean;
    Ent.AVista := q.Fields[18].AsBoolean;

  finally
    q.free;
    DBConnection.Fechar;
  end;
end;

procedure TPagFormaDBI.SetNovaId(pId: variant);
begin
  inherited;
  Ent.Id := pId;
end;

end.
