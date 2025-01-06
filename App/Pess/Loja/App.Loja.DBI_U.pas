unit App.Loja.DBI_U;

interface

uses App.Loja, App.Loja.DBI, Sis.Loja.DBI_u, Sis.DB.DBTypes;

type
  TAppLojaDBI = class(TSisLojaDBI, IAppLojaDBI)
  private
    FAppLoja: IAppLoja;
    function GetSqlLerPessoa: string;
  public
    function Ler(out pMens: string): boolean; override;
    constructor Create(pLoja: IAppLoja; pDBConnection: IDBConnection); reintroduce;
  end;

implementation

uses Data.DB;

{ TAppLojaDBI }

constructor TAppLojaDBI.Create(pLoja: IAppLoja; pDBConnection: IDBConnection);
begin
  inherited Create(pLoja, pDBConnection);
  FAppLoja := pLoja;
end;

function TAppLojaDBI.GetSqlLerPessoa: string;
begin
    Result := //
      'WITH LOJ AS'#13#10 //
      +'('#13#10 //
      +'  SELECT LOJA_ID, APELIDO'#13#10 //
      +'  FROM LOJA'#13#10 //
      +'  WHERE SELECIONADO'#13#10 //
      +'), LOJPES AS'#13#10 //
      +'('#13#10 //
      +'  SELECT'#13#10 //
      +'    LOJA_ID, TERMINAL_ID, PESSOA_ID'#13#10 //
      +'  FROM'#13#10 //
      +'    LOJA_EH_PESSOA'#13#10 //
      +'), PES AS'#13#10 //
      +'('#13#10 //
      +'  SELECT'#13#10 //
      +'    LOJA_ID'#13#10 //
      +'    , TERMINAL_ID'#13#10 //
      +'    , PESSOA_ID'#13#10 //
      +'    , NOME'#13#10 //
      +'    , NOME_FANTASIA'#13#10 //
      +'    , APELIDO'#13#10 //
      +'    , C'#13#10 //
      +'    , I'#13#10 //
      +'    , M'#13#10 //
      +'    , M_UF'#13#10 //
      +'    , EMAIL'#13#10 //
      +'  FROM'#13#10 //
      +'    PESSOA'#13#10 //
      +'), ENDER AS'#13#10 //
      +'('#13#10 //
      +'  SELECT'#13#10 //
      +'    LOJA_ID'#13#10 //
      +'    , TERMINAL_ID'#13#10 //
      +'    , PESSOA_ID'#13#10 //
      +'    , LOGRADOURO'#13#10 //
      +'    , NUMERO'#13#10 //
      +'    , COMPLEMENTO'#13#10 //
      +'    , BAIRRO'#13#10 //
      +'    , UF_SIGLA'#13#10 //
      +'    , CEP'#13#10 //
      +'    , MUNICIPIO_IBGE_ID'#13#10 //
      +'    , DDD'#13#10 //
      +'    , FONE1'#13#10 //
      +'    , FONE2'#13#10 //
      +'    , FONE3'#13#10 //
      +'    , CONTATO'#13#10 //
      +'    , REFERENCIA'#13#10 //
      +'  FROM'#13#10 //
      +'    ENDERECO'#13#10 //
      +'  WHERE ORDEM = 0'#13#10 //
      +'), MUN AS'#13#10 //
      +'('#13#10 //
      +'  SELECT MUNICIPIO_IBGE_ID, NOME'#13#10 //
      +'  FROM MUNICIPIO'#13#10 //
      +')'#13#10 //
      +'SELECT'#13#10 //
      +'  LOJ.LOJA_ID'#13#10 // 0
      +'  , LOJ.APELIDO'#13#10 // 1

      +'  , PES.TERMINAL_ID'#13#10 // 2
      +'  , PES.PESSOA_ID'#13#10 // 3

      +'  , PES.NOME'#13#10 // 4
      +'  , PES.NOME_FANTASIA'#13#10 // 5

      +'  , PES.C'#13#10 // 6
      +'  , PES.I'#13#10 // 7
      +'  , PES.M'#13#10 // 8
      +'  , PES.M_UF'#13#10 // 9

      +'  , PES.EMAIL'#13#10 // 10

      +'  , ENDER.LOGRADOURO'#13#10 // 11
      +'  , ENDER.NUMERO'#13#10 // 12
      +'  , ENDER.COMPLEMENTO'#13#10 // 13
      +'  , ENDER.BAIRRO'#13#10 // 14
      +'  , ENDER.UF_SIGLA'#13#10 // 15
      +'  , ENDER.CEP'#13#10 // 16

      +'  , MUN.MUNICIPIO_IBGE_ID'#13#10 // 17
      +'  , MUN.NOME MUN_NOME'#13#10 // 18

      +'  , ENDER.DDD'#13#10 // 19
      +'  , ENDER.FONE1'#13#10 // 20
      +'  , ENDER.FONE2'#13#10 // 21
      +'  , ENDER.FONE3'#13#10 // 22

      +'  , ENDER.CONTATO'#13#10 // 23
      +'  , ENDER.REFERENCIA'#13#10 // 24
      +''#13#10 //

      +'FROM LOJ'#13#10 //
      +''#13#10 //

      +'LEFT JOIN LOJPES ON'#13#10 //
      +'LOJ.LOJA_ID = LOJPES.LOJA_ID'#13#10 //
      +''#13#10 //

      +'LEFT JOIN PES ON'#13#10 //
      +'LOJPES.LOJA_ID = PES.LOJA_ID'#13#10 //
      +'AND LOJPES.TERMINAL_ID = PES.TERMINAL_ID'#13#10 //
      +'AND LOJPES.PESSOA_ID = PES.PESSOA_ID'#13#10 //
      +''#13#10 //

      +'LEFT JOIN ENDER ON'#13#10 //
      +'PES.LOJA_ID = ENDER.LOJA_ID'#13#10 //
      +'AND PES.TERMINAL_ID = ENDER.TERMINAL_ID'#13#10 //
      +'AND PES.PESSOA_ID = ENDER.PESSOA_ID'#13#10 //
      +''#13#10 //

      +'LEFT JOIN MUN ON'#13#10 //
      +'ENDER.MUNICIPIO_IBGE_ID = MUN.MUNICIPIO_IBGE_ID'#13#10 //
      ;
end;

function TAppLojaDBI.Ler(out pMens: string): boolean;
var
  sSql: string;
  q: TDataSet;
begin
  sSql := GetSqlLerPessoa;

  Result := DBConnection.Abrir;
  if not Result then
  begin
    pMens := DBConnection.UltimoErro;
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, q);
    try
      FAppLoja.Id := q.Fields[0 {LOJA_ID}].AsInteger;
      FAppLoja.Descr := q.Fields[1 {APELIDO}].AsString;
      FAppLoja.Apelido := q.Fields[1 {APELIDO}].AsString;

      FAppLoja.Nome := q.Fields[4 {NOME}].AsString;
      FAppLoja.NomeFantasia := q.Fields[5 {NOME_FANTASIA}].AsString;
      FAppLoja.C := q.Fields[6 {c}].AsString;
      FAppLoja.I := q.Fields[7 {I}].AsString;
      FAppLoja.M := q.Fields[8 {M}].AsString;
      FAppLoja.MUF := q.Fields[9 {M_UF}].AsString;
      FAppLoja.EMail := q.Fields[10 {EMAIL}].AsString;

      FAppLoja.Ender.Ordem := 0;
      FAppLoja.Ender.Logradouro := q.Fields[11 {LOGRADOURO}].AsString;
      FAppLoja.Ender.Numero := q.Fields[12 {NUMERO}].AsString;
      FAppLoja.Ender.Complemento := q.Fields[13 {COMPLEMENTO}].AsString;
      FAppLoja.Ender.Bairro := q.Fields[14 {BAIRRO}].AsString;
      FAppLoja.Ender.MunicipioIbgeId := q.Fields[17 {MUNICIPIO_IBGE_ID}].AsString;
      FAppLoja.Ender.MunicipioNome := q.Fields[18 {MUN_NOME}].AsString;
      FAppLoja.Ender.UFSigla := q.Fields[15 {UF_SIGLA}].AsString;
      FAppLoja.Ender.CEP := q.Fields[16 {CEP}].AsString;

      FAppLoja.Ender.DDD := q.Fields[19 {DDD}].AsString;
      FAppLoja.Ender.Fone1 := q.Fields[20 {FONE1}].AsString;
      FAppLoja.Ender.Fone2 := q.Fields[21 {FONE2}].AsString;
      FAppLoja.Ender.Fone3 := q.Fields[22 {FONE3}].AsString;
      FAppLoja.Ender.Contato := q.Fields[23 {CONTATO}].AsString;
      FAppLoja.Ender.Referencia := q.Fields[24 {REFERENCIA}].AsString;
    finally
      q.Free;
    end;
  finally
    DBConnection.Fechar;
  end;
end;

end.
