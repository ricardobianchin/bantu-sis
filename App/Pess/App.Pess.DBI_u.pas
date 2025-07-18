unit App.Pess.DBI_u;

interface

uses App.Ent.DBI, Sis.DBI, Sis.DBI_u, Sis.DB.DBTypes, Data.DB, System.Classes,
  System.Variants, Sis.Types.Integers, App.Pess.DBI, App.PessEnder.List,
  App.Pess.Ent, App.Pess.Geral.Factory_u, App.Ent.DBI_u, Sis.Entities.Types;

type
  TPessDBI = class(TEntDBI, IPessDBI)
  private
    FPessEnt: IPessEnt;
  protected
    procedure SetVarArrayToId(pNovaId: variant); override;
    procedure RegAtualToEnt(Q: TDataSet); virtual;
    function GetFieldNamesListaGet: string; override;
    function GetFieldValuesGravar: string; override;

    function GetSqlCToPess(pC: string; pExcetoLojaId: smallint;
      pExcetoTerminalId: smallint; pExcetoPessoaId: integer): string;
      virtual; abstract;

  public
    function Ler: Boolean; override;

    procedure MunicipioPrepareLista(pUFSigla: string; pSL: TStrings);

    procedure CToPess( //
      const pC: string; //
      out pEncontrado: Boolean; //

      out pEncontradoLojaId: smallint; //
      out pEncontradoTerminalId: smallint; //
      out pEncontradoPessoaId: integer; //
      out pEncontradoNome: string; //

      pExcetoLojaId: smallint; //
      pExcetoTerminalId: smallint; //
      pExcetoPessoaId: integer //
      );

    constructor Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
  end;

implementation

{ TPessDBI }

uses App.PessEnder, App.Pess.Loja.Ent.Factory_u, System.SysUtils,
  Sis.Types.Dates, Sis.Types.Bool_u, App.Pess.Ent.Factory_u,
  Sis.Win.Utils_u;

constructor TPessDBI.Create(pDBConnection: IDBConnection; pPessEnt: IPessEnt);
begin
  inherited Create(pDBConnection, pPessEnt);
  FPessEnt := pPessEnt;
end;

procedure TPessDBI.RegAtualToEnt(Q: TDataSet);
var
  oEnder: IPessEnder;
  iOrdem: integer;
  sIdChar: string;
begin
  FPessEnt.LojaId := Q.Fields[0 { LOJA_ID } ].AsInteger;
  FPessEnt.TerminalId := Q.Fields[1 { TERMINAL_ID } ].AsInteger;
  FPessEnt.Id := Q.Fields[2 { PESSOA_ID } ].AsInteger;

  FPessEnt.Apelido := Q.Fields[3 { APELIDO } ].AsString;
  FPessEnt.Nome := Q.Fields[4 { NOME } ].AsString;
  FPessEnt.NomeFantasia := Q.Fields[5 { NOME_FANTASIA } ].AsString;

  // genero id
  sIdChar := Trim(Q.Fields[6 { genero_id } ].AsString);
  if sIdChar = '' then
    sIdChar := ' ';

  FPessEnt.GeneroId := sIdChar[1];

  // estado_civil id
  sIdChar := Trim(Q.Fields[8 { estado_civil } ].AsString);
  if sIdChar = '' then
    sIdChar := ' ';

  FPessEnt.EstadoCivilId := sIdChar[1];

  FPessEnt.GeneroDescr := Q.Fields[7 { genero_descr } ].AsString;
  FPessEnt.EstadoCivilDescr := Q.Fields[9 { estado_civil_descrF } ].AsString;

  FPessEnt.C := Q.Fields[10 { C } ].AsString;
  FPessEnt.I := Q.Fields[11 { I } ].AsString;
  FPessEnt.M := Q.Fields[12 { M } ].AsString;
  FPessEnt.MUF := Q.Fields[13 { M_UF } ].AsString;

  FPessEnt.EMail := Q.Fields[14 { EMAIL } ].AsString;
  FPessEnt.DtNasc := Q.Fields[15 { DT_NASC } ].AsDateTime;
  FPessEnt.Ativo := iif(FPessEnt.Id = 0, True,
    Q.Fields[16 { ATIVO } ].AsBoolean);

  FPessEnt.CriadoEm := Q.Fields[17 { PESS_CRIADO_EM } ].AsDateTime;
  FPessEnt.AlteradoEm := Q.Fields[18 { PESS_ALTERADO_EM } ].AsDateTime;

  iOrdem := Q.Fields[19 { ENDER_ORDEM } ].AsInteger;

  while FPessEnt.PessEnderList.Count < (iOrdem + 1) do
  begin
    oEnder := PessEnderCreate;
    FPessEnt.PessEnderList.Add(oEnder);
  end;

  oEnder := FPessEnt.PessEnderList[iOrdem];

  oEnder.Ordem := iOrdem;

  oEnder.Logradouro := Q.Fields[20 { LOGRADOURO } ].AsString;
  oEnder.Numero := Q.Fields[21 { NUMERO } ].AsString;
  oEnder.Complemento := Q.Fields[22 { COMPLEMENTO } ].AsString;
  oEnder.Bairro := Q.Fields[23 { BAIRRO } ].AsString;

  oEnder.UFSigla := Q.Fields[24 { UF_SIGLA } ].AsString;
  oEnder.CEP := Q.Fields[25 { CEP } ].AsString;
  oEnder.MunicipioIbgeId := Q.Fields[26 { MUNICIPIO_IBGE_ID } ].AsString;
  oEnder.MunicipioNome := Q.Fields[27 { MUNICIPIO_NOME } ].AsString;

  if oEnder.MunicipioIbgeId = '' then
    oEnder.MunicipioIbgeId := '       ';

  oEnder.DDD := Q.Fields[28 { DDD } ].AsString;
  oEnder.Fone1 := Q.Fields[29 { FONE1 } ].AsString;
  oEnder.Fone2 := Q.Fields[30 { FONE2 } ].AsString;
  oEnder.Fone3 := Q.Fields[31 { FONE3 } ].AsString;

  oEnder.Contato := Q.Fields[32 { CONTATO } ].AsString;
  oEnder.Referencia := Q.Fields[33 { REFERENCIA } ].AsString;

  oEnder.CriadoEm := Q.Fields[34 { ENDER_CRIADO_EM } ].AsDateTime;
  oEnder.AlteradoEm := Q.Fields[35 { ENDER_ALTERADO_EM } ].AsDateTime;
end;

procedure TPessDBI.CToPess( //
  const pC: string; //
  out pEncontrado: Boolean; //

  out pEncontradoLojaId: smallint; //
  out pEncontradoTerminalId: smallint; //
  out pEncontradoPessoaId: integer; //
  out pEncontradoNome: string; //

  pExcetoLojaId: smallint; //
  pExcetoTerminalId: smallint; //
  pExcetoPessoaId: integer //
  );
var
  sSql: string;
  Q: TDataSet;
  Resultado: variant;
  sResultado: string;
  sNome: string;
begin
  sSql := GetSqlCToPess(pC, pExcetoLojaId, pExcetoTerminalId, pExcetoPessoaId);

  pEncontrado := DBConnection.Abrir;
  if not pEncontrado then
  begin
    exit;
  end;

  try
    DBConnection.QueryDataSet(sSql, Q);
    pEncontrado := not Q.isempty;
    if not pEncontrado then
      exit;

    pEncontradoLojaId := Q.Fields[0].AsInteger;
    pEncontradoTerminalId := Q.Fields[1].AsInteger;
    pEncontradoPessoaId := Q.Fields[2].AsInteger;
    pEncontradoNome := Trim(Q.Fields[3].AsString);
  finally
    Q.Free;
    DBConnection.Fechar;
  end;
end;

function TPessDBI.GetFieldNamesListaGet: string;
begin
  Result := ' LOJA_ID'#13#10 // 0
    + ', TERMINAL_ID'#13#10 // 1
    + ', PESSOA_ID'#13#10 // 2

    + ', APELIDO'#13#10 // 3
    + ', NOME'#13#10 // 4
    + ', NOME_FANTASIA'#13#10 // 5

    + ', GENERO_ID' // 6
    + ', GENERO_DESCR' // 7

    + ', ESTADO_CIVIL_ID' // 8
    + ', ESTADO_CIVIL_DESCR' // 9

    + ', C'#13#10 // 10
    + ', I'#13#10 // 11
    + ', M'#13#10 // 12
    + ', M_UF'#13#10 // 13

    + ', EMAIL'#13#10 // 14
    + ', DT_NASC'#13#10 // 15
    + ', ATIVO'#13#10 // 16

    + ', PESS_CRIADO_EM'#13#10 // 17
    + ', PESS_ALTERADO_EM'#13#10 // 18

    + ', ENDER_ORDEM'#13#10 // 19
    + ', LOGRADOURO'#13#10 // 20
    + ', NUMERO'#13#10 // 21
    + ', COMPLEMENTO'#13#10 // 22

    + ', BAIRRO'#13#10 // 23
    + ', UF_SIGLA'#13#10 // 24
    + ', CEP'#13#10 // 25

    + ', MUNICIPIO_IBGE_ID'#13#10 // 26
    + ', MUNICIPIO_NOME'#13#10 // 27

    + ', DDD'#13#10 // 28
    + ', FONE1'#13#10 // 29
    + ', FONE2'#13#10 // 30
    + ', FONE3'#13#10 // 31

    + ', CONTATO'#13#10 // 32
    + ', REFERENCIA'#13#10 // 33

    + ', ENDER_CRIADO_EM'#13#10 // 34
    + ', ENDER_ALTERADO_EM'#13#10 // 35
    ;
end;

function TPessDBI.GetFieldValuesGravar: string;
var
  p: IPessEnt;
  el: IPessEnderList;
begin
  p := FPessEnt;
  el := p.PessEnderList;

  Result := //
    p.LojaId.ToString + ' -- LOJA_ID'#13#10 //

    + ', ' + p.TerminalId.ToString + ' -- TERMINAL_ID '#13#10 //
    + ', ' + QuotedStr(p.Nome) + ' -- NOME'#13#10 //
    + ', ' + QuotedStr(p.NomeFantasia) + ' -- NOME_FANTASIA'#13#10 //
    + ', ' + QuotedStr(p.Apelido) + ' -- APELIDO'#13#10 //

    + ', ' + QuotedStr(p.GeneroId) + ' -- GENERO_ID'#13#10 //
    + ', ' + QuotedStr(p.EstadoCivilId) + ' -- ESTADO_CIVIL_ID'#13#10 //

    + ', ' + QuotedStr(p.C) + ' -- C'#13#10 //
    + ', ' + QuotedStr(p.I) + ' -- I'#13#10 //
    + ', ' + QuotedStr(p.M) + ' -- M'#13#10 //
    + ', ' + QuotedStr(p.MUF) + ' -- M_UF'#13#10 //

    + ', ' + QuotedStr(p.EMail) + ' -- EMAIL'#13#10 //
    + ', ' + DataSQLFirebird(p.DtNasc) + ' -- DT_NASC'#13#10 //
    + ', ' + BooleanToStrSQL(p.Ativo) + ' -- ATIVO' + #13#10 //

    + ', ' + p.Id.ToString + ' -- PESSOA_ID'#13#10 //

    + ', ' + QuotedStr(el[0].Logradouro) + ' -- LOGRADOURO'#13#10 //
    + ', ' + QuotedStr(el[0].Numero) + ' -- NUMERO'#13#10 //
    + ', ' + QuotedStr(el[0].Complemento) + ' -- COMPLEMENTO'#13#10 //
    + ', ' + QuotedStr(el[0].Bairro) + ' -- BAIRRO'#13#10 //

    + ', ' + QuotedStr(el[0].UFSigla) + ' -- UF_SIGLA'#13#10 //
    + ', ' + QuotedStr(el[0].CEP) + ' -- CEP'#13#10 //
    + ', ' + QuotedStr(el[0].MunicipioIbgeId) + ' -- MUNICIPIO_IBGE_ID'#13#10
  //

    + ', ' + QuotedStr(el[0].DDD) + ' -- DDD'#13#10 //
    + ', ' + QuotedStr(el[0].Fone1) + ' -- FONE1'#13#10 //
    + ', ' + QuotedStr(el[0].Fone2) + ' -- FONE2'#13#10 //
    + ', ' + QuotedStr(el[0].Fone3) + ' -- FONE3'#13#10 //

    + ', ' + QuotedStr(el[0].Contato) + ' -- CONTATO'#13#10 //
    + ', ' + QuotedStr(el[0].Referencia) + ' -- REFERENCIA'#13#10 //
    ; //
end;

function TPessDBI.Ler: Boolean;
var
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

  sSql := GetSqlForEach(aValores);
  // {$IFDEF DEBUG}
  // CopyTextToClipboard(sSql);
  // {$ENDIF}
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
  sSql := 'SELECT MUNICIPIO_IBGE_ID, NOME' //
    + ' FROM ENDERECO_PA.MUNICIPIO_LISTA_GET(' //
    + QuotedStr(pUFSigla) //
    + ');' //
    ;

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
