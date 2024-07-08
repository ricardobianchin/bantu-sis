unit App.Pess.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers, App.Pess.DBI,
  App.Pess.Ent, App.Pess.Geral.Factory_u, App.Ent.DBI_u;

type
  TPessDBI = class(TEntDBI, IPessDBI)
  private
    FPessEnt: IPessEnt;
  protected
    procedure SetVarArrayToId(pNovaId: variant); override;
    procedure RegAtualToEnt(Q: TDataSet); virtual;
    function GetFieldNames: string; override;
    function GetFieldValues: string; override;
  public
    function Ler: boolean; override;
    constructor Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
    procedure MunicipioPrepareLista(pUFSigla: string; pSL: TStrings);
  end;

implementation

{ TPessDBI }

uses App.PessEnder, App.Pess.Ent.Factory_u, System.SysUtils, Sis.Types.Dates;

constructor TPessDBI.Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
begin
  inherited Create(pDBConnection, pPessEnt);
  FPessEnt := pPessEnt;
end;

procedure TPessDBI.RegAtualToEnt(Q: TDataSet);
var
  oEnder: IPessEnder;
  iOrdem: integer;
begin
  FPessEnt.LojaId := q.Fields[0 {LOJA_ID}].AsInteger;
  FPessEnt.TerminalId := q.Fields[1 {TERMINAL_ID}].AsInteger;
  FPessEnt.Id := q.Fields[2 {PESSOA_ID}].AsInteger;

  FPessEnt.Apelido := q.Fields[3 {APELIDO}].AsString;
  FPessEnt.Nome := q.Fields[4 {NOME}].AsString;
  FPessEnt.NomeFantasia := q.Fields[5 {NOME_FANTASIA}].AsString;

  FPessEnt.C := q.Fields[6 {C}].AsString;
  FPessEnt.I := q.Fields[7 {I}].AsString;
  FPessEnt.M := q.Fields[8 {M}].AsString;
  FPessEnt.MUF := q.Fields[9 {M_UF}].AsString;

  FPessEnt.EMail := q.Fields[10 {EMAIL}].AsString;
  FPessEnt.DtNasc := q.Fields[11 {DT_NASC}].AsDateTime;

  FPessEnt.CriadoEm := q.Fields[12 {PESS_CRIADO_EM}].AsDateTime;
  FPessEnt.AlteradoEm := q.Fields[13 {PESS_ALTERADO_EM}].AsDateTime;

  iOrdem := q.Fields[14 {ENDER_ORDEM}].AsInteger;

  while FPessEnt.PessEnderList.Count < (iOrdem + 1) do
  begin
    oEnder := PessEnderCreate;
    FPessEnt.PessEnderList.Add(oEnder);
  end;

  FPessEnt.PessEnderList[iOrdem].Ordem := iOrdem;

  FPessEnt.PessEnderList[iOrdem].Logradouro := q.Fields[15 {LOGRADOURO}].AsString;
  FPessEnt.PessEnderList[iOrdem].Numero := q.Fields[16 {NUMERO}].AsString;
  FPessEnt.PessEnderList[iOrdem].Complemento := q.Fields[17 {COMPLEMENTO}].AsString;
  FPessEnt.PessEnderList[iOrdem].Bairro := q.Fields[18 {BAIRRO}].AsString;

  FPessEnt.PessEnderList[iOrdem].UFSigla := q.Fields[19 {UF_SIGLA}].AsString;
  FPessEnt.PessEnderList[iOrdem].CEP := q.Fields[20 {CEP}].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId := q.Fields[21 {MUNICIPIO_IBGE_ID}].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioNome := q.Fields[22 {MUNICIPIO_NOME}].AsString;

  FPessEnt.PessEnderList[iOrdem].DDD := q.Fields[23 {DDD}].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone1 := q.Fields[24 {FONE1}].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone2 := q.Fields[25 {FONE2}].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone3 := q.Fields[26 {FONE3}].AsString;

  FPessEnt.PessEnderList[iOrdem].Contato := q.Fields[27 {CONTATO}].AsString;
  FPessEnt.PessEnderList[iOrdem].Referencia := q.Fields[28 {REFERENCIA}].AsString;

  FPessEnt.PessEnderList[iOrdem].CriadoEm := q.Fields[29 {ENDER_CRIADO_EM}].AsDateTime;
  FPessEnt.PessEnderList[iOrdem].AlteradoEm := q.Fields[30 {ENDER_ALTERADO_EM}].AsDateTime;
end;

function TPessDBI.GetFieldNames: string;
begin
  Result :=
      ' LOJA_ID'#13#10 // 0
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

    + ', PESS_CRIADO_EM'#13#10 // 12
    + ', PESS_ALTERADO_EM'#13#10 // 13

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

function TPessDBI.GetFieldValues: string;
begin
  Result :=
    FPessEnt.LojaId.ToString + #13#10 // LOJA_ID */'
    + ', ' + FPessEnt.TerminalId.ToString + #13#10 // TERMINAL_ID    SMALLINT
    + ', ' + QuotedStr(FPessEnt.Nome) + #13#10 // NOME                VARCHAR(60) CHA+ #13#10 // SET WIN1252
    + ', ' + QuotedStr(FPessEnt.NomeFantasia) + #13#10 // NOME_FANTASIA  VARCHAR(60) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.Apelido) + #13#10 // APELIDO         VARCHAR(20) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.Genero) + #13#10 // GENERO_ID        CHAR(1) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.EstadoCivil) + #13#10 // ESTADO_CIVIL_ID  CHAR(1) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.C) + #13#10 // C       VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.I) + #13#10 // I       VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.M) + #13#10 // M       VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.MUF) + #13#10 // M_UF      CHAR(2) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.EMail) + #13#10 // EMAIL     VARCHAR(50) CHARACTER SET WIN1252
    + ', ' + DataSQLFirebird(FPessEnt.DtNasc) + #13#10 // DT_NASC            DATE
    + ', ' + FPessEnt.Id.ToString + #13#10 // PESSOA_ID          INTEGER
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Logradouro) + #13#10 // LOGRADOURO         VARCHAR(70) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Numero) + #13#10 // NUMERO             (NOME_DOM) VARCHAR(60) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Complemento) + #13#10 // COMPLEMENTO        (NOME_DOM) VARCHAR(60) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Bairro ) + #13#10 // BAIRRO             (NOME_DOM) VARCHAR(60) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].UFSigla ) + #13#10 // UF_SIGLA           CHAR(2) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].CEP ) + #13#10 // CEP                CHAR(8) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].MunicipioIbgeId ) + #13#10 // MUNICIPIO_IBGE_ID  CHAR(5) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].DDD ) + #13#10 // DDD                CHAR(2) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone1 ) + #13#10 // FONE1              (NOME_CURTO_DOM) VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone2 ) + #13#10 // FONE2              (NOME_CURTO_DOM) VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone3 ) + #13#10 // FONE3              (NOME_CURTO_DOM) VARCHAR(15) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Contato ) + #13#10 // CONTATO            (NOME_DOM) VARCHAR(60) CHARACTER SET WIN1252
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Referencia ) + #13#10 // REFERENCIA         (OBS1_DOM) VARCHAR(1000) CHARACTER SET WIN1252
    ;
{

LOJA_ID_RET, TERMINAL_ID_RET, PESSOA_ID_GRAVADA

}
end;

function TPessDBI.Ler: boolean;
var
  sFormat: string;
  sSql: string;
  q: TDataSet;
  Resultado: variant;
  sResultado: string;
  sNome: string;

  aValores: variant;
begin

  Result := False;

  aValores := VarArrayCreate([0, 2], varInteger);
  aValores[0] := FPessEnt.LojaId;
  aValores[1] := FPessEnt.TerminalId;
  aValores[2] := FPessEnt.Id;

  sSql := GetSqlPreencherDataSet(aValores);

  DBConnection.Abrir;
  try
    DBConnection.QueryDataSet(sSql, q);
    Result := not q.isempty;
    if not Result then
      exit;
    while not q.Eof do
    begin
      RegAtualToEnt(q);
      q.Next;
    end;
  finally
    q.Free;
    DBConnection.Fechar;
  end;
end;

procedure TPessDBI.MunicipioPrepareLista(pUFSigla: string; pSL: TStrings);
var
  sSql: string;
  q: TDataSet;
  iId: integer;
  sNome: string;
begin
  sSql := 'SELECT MUNICIPIO_IBGE_ID, NOME' +
    ' FROM ENDERECO_PA.MUNICIPIO_LISTA_GET(' + QuotedStr(pUFSigla) + ');';

  if pSL.Count = 0 then
    pSL.Add('');

  DBConnection.QueryDataSet(sSql, q);
  try
    while not q.Eof do
    begin
      iId := q.Fields[0].AsInteger;
      sNome := Trim(q.Fields[1].AsString);

      pSL.AddObject(sNome, Pointer(iId));
      q.Next;
    end;
  finally
    q.Free;
  end;
end;

procedure TPessDBI.SetVarArrayToId(pNovaId: variant);
begin
//  inherited;
  FPessEnt.LojaId := pNovaId[0];
  FPessEnt.TerminalId := pNovaId[1];
  FPessEnt.Id := pNovaId[2];
end;

end.
