unit App.Pess.Loja.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Ent.DBI_u, App.Pess.Loja.DBI,
  App.Pess.Loja.Ent, App.Ent.Ed, App.Pess.Geral.Factory_u;

type
  TPessLojaDBI = class(TEntDBI, IPessLojaDBI)
  private
    FPessLojaEnt: IPessLojaEnt;
    procedure DataSetToEnt(Q: TDataSet);
  protected
    function GetSqlPreencherDataSet(pValues: variant): string; override;
    procedure SetNovaId(pId: variant); override;
  public
    function Inserir(out pNovaId: variant): boolean; override;
    function Alterar: boolean; override;
    function Ler: boolean; override;
    constructor Create(pDBConnection: IDBConnection; pPessLojaEnt: IPessLojaEnt);
  end;

implementation

uses System.SysUtils, Sis.Types.strings_u, App.Est.Types_u, Sis.Lists.Types,
  Sis.Win.Utils_u, Vcl.Dialogs, Sis.Types.Bool_u, Sis.Types.Floats;

{ TPessLojaDBI }

function TPessLojaDBI.Alterar: boolean;
begin

end;

constructor TPessLojaDBI.Create(pDBConnection: IDBConnection;
  pPessLojaEnt: IPessLojaEnt);
begin
  inherited Create(pDBConnection, pPessLojaEnt);
end;

procedure TPessLojaDBI.DataSetToEnt(Q: TDataSet);
begin

end;

function TPessLojaDBI.GetSqlPreencherDataSet(pValues: variant): string;
var
  iLojaId: integer;
begin
  iLojaId := VarToInteger(pValues);

  Result := 'Select'#13#10 + 'ATIVO'#13#10 // 0
    + ', LOJA_ID'#13#10 // 1
    + ', PESSOA_ID'#13#10 // 2
    + ', APELIDO'#13#10 // 3
    + ', NOME'#13#10 // 4
    + ', NOME_FANTASIA'#13#10 // 5
    + ', C'#13#10 // 6
    + ', I'#13#10 // 7
    + ', M'#13#10 // 8
    + ', M_UF'#13#10 // 9
    + ', EMAIL'#13#10 // 10
    + ', DT_NASC'#13#10 // 11
    + ', PESS_EDITADO_EM'#13#10 // 12
    + ', PESS_CRIADO_EM'#13#10 // 13
    + ', ENDER_ORDEM'#13#10 // 14
    + ', LOGRADOURO'#13#10 // 15
    + ', NUMERO'#13#10 // 16
    + ', COMPLEMENTO'#13#10 // 17
    + ', BAIRRO'#13#10 // 18
    + ', UF_SIGLA'#13#10 // 19
    + ', CEP'#13#10 // 20
    + ', MUNICIPIO_IBGE_ID'#13#10 // 21
    + ', DDD'#13#10 // 22
    + ', FONE1'#13#10 // 23
    + ', FONE2'#13#10 // 24
    + ', FONE3'#13#10 // 25
    + ', CONTATO'#13#10 // 26
    + ', REFERENCIA'#13#10 // 27
    + ', ENDER_CRIADO_EM'#13#10 // 28
    + ', ENDER_ALTERADO_EM'#13#10 // 29
    + 'FROM LOJA_MANUT_PA.LISTA_GET(' //
    + iLojaId.ToString //
    + ');'#13#10 //
    ;
end;

function TPessLojaDBI.Inserir(out pNovaId: variant): boolean;
begin

end;

function TPessLojaDBI.Ler: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  iId: integer;
  sNome: string;
begin
  Result := False;
  {

  sSql := GetSqlPreencherDataSet(Ent.LojaId);

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    Ent.Descr := q.Fields[1].AsString.Trim;
    Ent.DescrRed := q.Fields[2].AsString.Trim;

    Ent.ProdFabrEnt.Id := q.Fields[3].AsInteger;
    Ent.ProdTipoEnt.Id := q.Fields[4].AsInteger;
    Ent.ProdUnidEnt.Id := q.Fields[5].AsInteger;
    Ent.ProdICMSEnt.Id := q.Fields[6].AsInteger;

    Ent.CustoAtual := q.Fields[8].AsCurrency;
    Ent.PrecoAtual := q.Fields[9].AsCurrency;

    Ent.Ativo := q.Fields[10].AsBoolean;
    Ent.Localiz := q.Fields[11].AsString.Trim;
    Ent.CapacEmb := q.Fields[12].AsCurrency;

    Ent.Ncm := Trim(q.Fields[13].AsString);

    Ent.Margem := q.Fields[14].AsCurrency;

    Ent.ProdBalancaEnt.BalancaUso := TBalancaUso(q.Fields[15].AsInteger);
    Ent.ProdBalancaEnt.DptoCod := q.Fields[16].AsString.Trim;
    Ent.ProdBalancaEnt.ValidadeDias := q.Fields[17].AsInteger;
    Ent.ProdBalancaEnt.TextoEtiq := q.Fields[18].AsString.Trim;

    Ent.ProdBarrasList.Clear;
    while not q.eof do
    begin
      Ent.ProdBarrasList.PegarBarras(q.Fields[7].AsString.Trim, plFim);
      q.next;
    end;
  finally
    q.Free;
    DBConnection.Fechar;
  end;
  }
end;

procedure TPessLojaDBI.SetNovaId(pId: variant);
begin
  inherited;

end;

end.
