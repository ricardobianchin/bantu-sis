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
    function CToIdLojaTermRecord(const C: string; out pLojaId: smallint;
      out pTerminalId: smallint; out pPessoaId: integer;
      out pNome: string): boolean;
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
  FPessEnt.LojaId := Q.Fields[0 { LOJA_ID } ].AsInteger;
  FPessEnt.TerminalId := Q.Fields[1 { TERMINAL_ID } ].AsInteger;
  FPessEnt.Id := Q.Fields[2 { PESSOA_ID } ].AsInteger;

  FPessEnt.Apelido := Q.Fields[3 { APELIDO } ].AsString;
  FPessEnt.Nome := Q.Fields[4 { NOME } ].AsString;
  FPessEnt.NomeFantasia := Q.Fields[5 { NOME_FANTASIA } ].AsString;

  FPessEnt.C := Q.Fields[6 { C } ].AsString;
  FPessEnt.I := Q.Fields[7 { I } ].AsString;
  FPessEnt.M := Q.Fields[8 { M } ].AsString;
  FPessEnt.MUF := Q.Fields[9 { M_UF } ].AsString;

  FPessEnt.EMail := Q.Fields[10 { EMAIL } ].AsString;
  FPessEnt.DtNasc := Q.Fields[11 { DT_NASC } ].AsDateTime;

  FPessEnt.CriadoEm := Q.Fields[12 { PESS_CRIADO_EM } ].AsDateTime;
  FPessEnt.AlteradoEm := Q.Fields[13 { PESS_ALTERADO_EM } ].AsDateTime;

  iOrdem := Q.Fields[14 { ENDER_ORDEM } ].AsInteger;

  while FPessEnt.PessEnderList.Count < (iOrdem + 1) do
  begin
    oEnder := PessEnderCreate;
    FPessEnt.PessEnderList.Add(oEnder);
  end;

  FPessEnt.PessEnderList[iOrdem].Ordem := iOrdem;

  FPessEnt.PessEnderList[iOrdem].Logradouro :=
    Q.Fields[15 { LOGRADOURO } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Numero := Q.Fields[16 { NUMERO } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Complemento :=
    Q.Fields[17 { COMPLEMENTO } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Bairro := Q.Fields[18 { BAIRRO } ].AsString;

  FPessEnt.PessEnderList[iOrdem].UFSigla := Q.Fields[19 { UF_SIGLA } ].AsString;
  FPessEnt.PessEnderList[iOrdem].CEP := Q.Fields[20 { CEP } ].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId :=
    Q.Fields[21 { MUNICIPIO_IBGE_ID } ].AsString;
  FPessEnt.PessEnderList[iOrdem].MunicipioNome :=
    Q.Fields[22 { MUNICIPIO_NOME } ].AsString;

  if FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId = '' then
    FPessEnt.PessEnderList[iOrdem].MunicipioIbgeId := '     ';

  FPessEnt.PessEnderList[iOrdem].DDD := Q.Fields[23 { DDD } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone1 := Q.Fields[24 { FONE1 } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone2 := Q.Fields[25 { FONE2 } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Fone3 := Q.Fields[26 { FONE3 } ].AsString;

  FPessEnt.PessEnderList[iOrdem].Contato := Q.Fields[27 { CONTATO } ].AsString;
  FPessEnt.PessEnderList[iOrdem].Referencia :=
    Q.Fields[28 { REFERENCIA } ].AsString;

  FPessEnt.PessEnderList[iOrdem].CriadoEm := Q.Fields[29 { ENDER_CRIADO_EM } ]
    .AsDateTime;
  FPessEnt.PessEnderList[iOrdem].AlteradoEm :=
    Q.Fields[30 { ENDER_ALTERADO_EM } ].AsDateTime;
end;

function TPessDBI.CToIdLojaTermRecord(const C: string; out pLojaId: smallint;
  out pTerminalId: smallint; out pPessoaId: integer; out pNome: string)
  : boolean;
var
  sFormat: string;
  sSql: string;
  Q: TDataSet;
  Resultado: variant;
  sResultado: string;
  sNome: string;
begin
  sSql := 'SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME FROM ID_BY_C(' +
    QuotedStr(C) + ');';

  Result := DBConnection.Abrir;
  if not Result then
    exit;

  try
    DBConnection.QueryDataSet(sSql, Q);
    Result := not Q.isempty;
    if not Result then
      exit;

    pLojaId := Q.Fields[0].AsInteger;
    pTerminalId := Q.Fields[1].AsInteger;
    pPessoaId := Q.Fields[2].AsInteger;
    pNome := Trim(Q.Fields[3].AsString);
  finally
    Q.Free;
    DBConnection.Fechar;
  end;
end;

function TPessDBI.GetFieldNames: string;
begin
  Result := ' LOJA_ID'#13#10 // 0
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
  Result := FPessEnt.LojaId.ToString + '-- LOJA_ID'#13#10
    + ', ' + FPessEnt.TerminalId.ToString + ' -- TERMINAL_ID '#13#10
    + ', ' + QuotedStr(FPessEnt.Nome) + ' -- NOME'#13#10
    + ', ' + QuotedStr(FPessEnt.NomeFantasia) + ' -- NOME_FANTASIA'#13#10
    + ', ' + QuotedStr(FPessEnt.Apelido) + ' -- APELIDO'#13#10
    + ', ' + QuotedStr(FPessEnt.Genero) + ' -- GENERO_ID'#13#10
    + ', ' + QuotedStr(FPessEnt.EstadoCivil) + ' -- ESTADO_CIVIL_ID'#13#10
    + ', ' + QuotedStr(FPessEnt.C) + ' -- C'#13#10
    + ', ' + QuotedStr(FPessEnt.I) + ' -- I'#13#10
    + ', ' + QuotedStr(FPessEnt.M) + ' -- M'#13#10
    + ', ' + QuotedStr(FPessEnt.MUF) + ' -- M_UF'#13#10
    + ', ' + QuotedStr(FPessEnt.EMail) + ' -- EMAIL'#13#10
    + ', ' + DataSQLFirebird(FPessEnt.DtNasc) + ' -- DT_NASC'#13#10
    + ', ' + FPessEnt.Id.ToString + ' -- PESSOA_ID'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Logradouro) + ' -- LOGRADOURO'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Numero) + ' -- NUMERO'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Complemento) + ' -- COMPLEMENTO'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Bairro) + ' -- BAIRRO'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].UFSigla) + ' -- UF_SIGLA'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].CEP) + ' -- CEP'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].MunicipioIbgeId) + ' -- MUNICIPIO_IBGE_ID'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].DDD) + ' -- DDD'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone1) + ' -- FONE1'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone2) + ' -- FONE2'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Fone3) + ' -- FONE3'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Contato) + ' -- CONTATO'#13#10
    + ', ' + QuotedStr(FPessEnt.PessEnderList[0].Referencia) + ' -- REFERENCIA'#13#10
    ;
end;

function TPessDBI.Ler: boolean;
var
  sFormat: string;
  sSql: string;
  Q: TDataSet;
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
    DBConnection.QueryDataSet(sSql, Q);
    Result := not Q.isempty;
    if not Result then
      exit;
    while not Q.Eof do
    begin
      RegAtualToEnt(Q);
      Q.Next;
    end;
  finally
    Q.Free;
    DBConnection.Fechar;
  end;
end;

procedure TPessDBI.MunicipioPrepareLista(pUFSigla: string; pSL: TStrings);
var
  sSql: string;
  Q: TDataSet;
  iId: integer;
  sNome: string;
begin
  sSql := 'SELECT MUNICIPIO_IBGE_ID, NOME' +
    ' FROM ENDERECO_PA.MUNICIPIO_LISTA_GET(' + QuotedStr(pUFSigla) + ');';

  if pSL.Count = 0 then
    pSL.Add('NAO INDICADO');

  DBConnection.QueryDataSet(sSql, Q);
  try
    while not Q.Eof do
    begin
      iId := Q.Fields[0].AsInteger;
      sNome := Trim(Q.Fields[1].AsString);

      pSL.AddObject(sNome, Pointer(iId));
      Q.Next;
    end;
  finally
    Q.Free;
  end;
end;

procedure TPessDBI.SetVarArrayToId(pNovaId: variant);
begin
  // inherited;
  FPessEnt.LojaId := pNovaId[0];
  FPessEnt.TerminalId := pNovaId[1];
  FPessEnt.Id := pNovaId[2];
end;

end.
