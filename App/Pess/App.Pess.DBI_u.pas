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
    //usado no atualizar
    function GetSqlPreencherDataSet(pValues: variant): string; override;

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
  inherited Create(pDBConnection, pPessEnt);
  FPessEnt := pPessEnt;
end;

procedure TPessDBI.DataSetToEnt(Q: TDataSet);
begin
//  FPessEnt.LojaId := q.Fields[ 0 {LOJA_ID}].As;
//  FPessEnt.TerminalId := q.Fields[ 1 {PESSOA_ID}].As;
//  FPessEnt.Apelido := q.Fields[ 2 {APELIDO}].As;
//  FPessEnt.Nome := q.Fields[ 3 {NOME}].As;
//  FPessEnt.NomeFantasia := q.Fields[ 4 {NOME_FANTASIA}].As;
//  FPessEnt.C := q.Fields[ 5 {C}].As;
//  FPessEnt.I := q.Fields[ 6 {I}].As;
//  FPessEnt.M := q.Fields[ 7 {M}].As;
//  FPessEnt.MUF := q.Fields[ 8 {M_UF}].As;
//  FPessEnt.EMail := q.Fields[ 9 {EMAIL}].As;
//  FPessEnt.DtNasc := q.Fields[10 {DT_NASC}].As;
//  FPessEnt.CriadoEm := q.Fields[12 {PESS_CRIADO_EM}].As;
//  FPessEnt.EditadoEm := q.Fields[11 {PESS_EDITADO_EM}].As;
//  FPessEnt.PessEnderList. := q.Fields[13 {ENDER_ORDEM}].As;
//  FPessEnt.PessEnderList. := q.Fields[14 {LOGRADOURO}].As;
//  FPessEnt.PessEnderList. := q.Fields[15 {NUMERO}].As;
//  FPessEnt.PessEnderList. := q.Fields[16 {COMPLEMENTO}].As;
//  FPessEnt.PessEnderList. := q.Fields[17 {BAIRRO}].As;
//  FPessEnt.PessEnderList. := q.Fields[18 {UF_SIGLA}].As;
//  FPessEnt.PessEnderList. := q.Fields[19 {CEP}].As;
//  FPessEnt.PessEnderList. := q.Fields[20 {MUNICIPIO_IBGE_ID}].As;
//  FPessEnt.PessEnderList. := q.Fields[20 {MUNICIPIO_IBGE_ID}].As;
//  FPessEnt.PessEnderList. := q.Fields[21 {DDD}].As;
//  FPessEnt.PessEnderList. := q.Fields[22 {FONE1}].As;
//  FPessEnt.PessEnderList. := q.Fields[23 {FONE2}].As;
//  FPessEnt.PessEnderList. := q.Fields[24 {FONE3}].As;
//  FPessEnt.PessEnderList. := q.Fields[25 {CONTATO}].As;
//  FPessEnt.PessEnderList. := q.Fields[26 {REFERENCIA}].As;
//  FPessEnt.PessEnderList. := q.Fields[27 {ENDER_CRIADO_EM}].As;
//  FPessEnt.PessEnderList. := q.Fields[28 {ENDER_ALTERADO_EM}].As;
//
//Ordem
//Logradouro
//Numero
//Complemento
//Bairro
//Municipio
//UFSigla
//CEP
//MunicipioIbgeId
//DDD
//Fone1
//Fone2
//Fone3
//Contato
//Referencia
//CriadoEm
//EditadoEm
end;

function TPessDBI.GetSqlPreencherDataSet(pValues: variant): string;
begin
  Result :=//
      'Select'#13#10//
    + ' LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
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
    + ', MUNICIPIO_NOME'#13#10 // 22
    + ', DDD'#13#10 // 23
    + ', FONE1'#13#10 // 24
    + ', FONE2'#13#10 // 25
    + ', FONE3'#13#10 // 26
    + ', CONTATO'#13#10 // 27
    + ', REFERENCIA'#13#10 // 28
    + ', ENDER_CRIADO_EM'#13#10 // 29
    + ', ENDER_ALTERADO_EM'#13#10 // 30
    ;
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
