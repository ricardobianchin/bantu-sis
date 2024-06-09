unit App.Pess.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB,
  System.Variants, Sis.Types.Integers, App.Pess.DBI,
  App.Pess.Ent, App.Pess.Geral.Factory_u, App.Ent.DBI_u;

type
  TPessDBI = class(TEntDBI, IPessDBI)
  private
    FPessEnt: IPessEnt;
  protected
    procedure SetNovaId(pId: variant); override;
    procedure DataSetToEnt(Q: TDataSet); virtual;
  public
    function Inserir(out pNovaId: variant): boolean; override;
    function Alterar: boolean; override;
    function Ler: boolean; override;
    constructor Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
  end;

implementation

{ TPessDBI }

function TPessDBI.Alterar: boolean;
begin

end;

constructor TPessDBI.Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
begin
  inherited Create(pDBConnection, pPessEnt;
  FPessEnt := pPessEnt;
end;

procedure TPessDBI.DataSetToEnt(Q: TDataSet);
begin
  FPessEnt.LojaId := q.Fields[ 0 {LOJA_ID}].As;
  FPessEnt.TerminalId := q.Fields[ 1 {PESSOA_ID}].As;
  FPessEnt.Apelido := q.Fields[ 2 {APELIDO}].As;
  FPessEnt.Nome := q.Fields[ 3 {NOME}].As;
  FPessEnt.NomeFantasia := q.Fields[ 4 {NOME_FANTASIA}].As;
  FPessEnt.C := q.Fields[ 5 {C}].As;
  FPessEnt.I := q.Fields[ 6 {I}].As;
  FPessEnt.M := q.Fields[ 7 {M}].As;
  FPessEnt.MUF := q.Fields[ 8 {M_UF}].As;
  FPessEnt. := q.Fields[ 9 {EMAIL}].As;
  FPessEnt. := q.Fields[10 {DT_NASC}].As;
  FPessEnt. := q.Fields[11 {PESS_EDITADO_EM}].As;
  FPessEnt. := q.Fields[12 {PESS_CRIADO_EM}].As;
  FPessEnt. := q.Fields[13 {ENDER_ORDEM}].As;
  FPessEnt. := q.Fields[14 {LOGRADOURO}].As;
  FPessEnt. := q.Fields[15 {NUMERO}].As;
  FPessEnt. := q.Fields[16 {COMPLEMENTO}].As;
  FPessEnt. := q.Fields[17 {BAIRRO}].As;
  FPessEnt. := q.Fields[18 {UF_SIGLA}].As;
  FPessEnt. := q.Fields[19 {CEP}].As;
  FPessEnt. := q.Fields[20 {MUNICIPIO_IBGE_ID}].As;
  FPessEnt. := q.Fields[21 {DDD}].As;
  FPessEnt. := q.Fields[22 {FONE1}].As;
  FPessEnt. := q.Fields[23 {FONE2}].As;
  FPessEnt. := q.Fields[24 {FONE3}].As;
  FPessEnt. := q.Fields[25 {CONTATO}].As;
  FPessEnt. := q.Fields[26 {REFERENCIA}].As;
  FPessEnt. := q.Fields[27 {ENDER_CRIADO_EM}].As;
  FPessEnt. := q.Fields[28 {ENDER_ALTERADO_EM}].As;

    property Nome: string read GetNome write SetNome;
    property NomeFantasia: string read GetNomeFantasia write SetNomeFantasia;
    property Apelido: string read GetApelido write SetApelido;
    property EstadoCivil: char read GetEstadoCivil write SetEstadoCivil;
    property Genero: char read GetGenero write SetGenero;
    property C: string read GetC write SetC;
    property I: string read GetI write SetI;
    property M: string read GetM write SetM;
    property MUF: string read GetMUF write SetMUF;
    property DtNasc: TDateTime read GetDtNasc write SetDtNasc;
    property PessEnderList: IPessEnderList read GetPessEnderList;

end;

function TPessDBI.Inserir(out pNovaId: variant): boolean;
begin

end;

function TPessDBI.Ler: boolean;
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

  sSql := GetSqlPreencherDataSet(FPessEnt);

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;

    DataSetToEnt(q);

  finally
    q.Free;
    DBConnection.Fechar;
  end;
end;

procedure TPessDBI.SetNovaId(pId: variant);
begin
//  inherited;
//  LojaId := pId[0];
//  TerminalId := pId[1];
//  Id := pId[2];

end;

end.
