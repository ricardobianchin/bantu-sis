unit btu.lib.db.updater.comando.fb.createdomains_u;

interface

uses btu.lib.db.updater.comando, System.Classes, btu.lib.db.updater.campo.list,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u, btu.lib.db.updater.operations,
  sis.ui.io.LogProcess, sis.ui.io.output, btu.lib.lists.TextoList;

type
  TComandoFBCreateDomains = class(TComandoFB)
  private
    FDomainsDefSL: TStringList;
    //FDomainNamesSL: TStringList;
    FComandosTextoList: ITextoList;
    procedure ForcarUmComandoPorLinha;
  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLogProcess: ILogProcess; pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses btu.lib.db.updater.constants_u, btu.lib.db.updater.campo, System.SysUtils,
  btu.lib.db.updater.factory, sis.types.strings, btu.sis.db.updater.utils
  , System.StrUtils, btu.lib.db.factory, btu.lib.db.updater.firebird.GetSql_u
  , btu.lib.lists.factory, btu.lib.lists.TextoItem;

{ TComandoFBCreateDomains }

constructor TComandoFBCreateDomains.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLogProcess: ILogProcess; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLogProcess, pOutput);
  FDomainsDefSL := TStringList.Create;
  //FDomainNamesSL := TStringList.Create;
  FComandosTextoList := TextoListCreate;
end;

destructor TComandoFBCreateDomains.Destroy;
begin
  FDomainsDefSL.Free;
  //FDomainNamesSL.Free;
  inherited;
end;

procedure TComandoFBCreateDomains.ForcarUmComandoPorLinha;
var
  s: string;
  I: integer;
  FaComandos: TArray<string>;
  sTit, sTex: string;
  aPalavras: TArray<string>;
begin
  s := StrSemAcento( FDomainsDefSL.text);
  s := StringReplace(s, #13#10, #32, [rfReplaceAll, rfIgnoreCase]);
  FaComandos := s.Split([';']);
  for I := 0 to Length(FaComandos) - 1 do
  begin
    s := StrSemCharRepetido(FaComandos[i]);

    if LeftStr(s, 13) = 'CREATE DOMAIN' then
    begin
      aPalavras := s.Split([' ']);
      sTit := aPalavras[2];
      sTex := StrGarantirTermino(s, ';');
      FComandosTextoList.PegarTextoItem(TextoItemCreate(sTit, sTex));
    end;
  end;
end;

function TComandoFBCreateDomains.Funcionou: boolean;
var
  sSql: string;
  sDomainName: string;
  oDBQuery: IDBQuery;
  I: integer;
begin
  Result := true;
//  EXIT;

//  oDBQuery.Prepare;
  try
    for I := 0 to FComandosTextoList.Count - 1 do
    begin
      sDomainName := FComandosTextoList[I].Titulo;
      sSql := GetSQLDomainExiste{Params}(sDomainName);
      oDBQuery := DBQueryCreate(DBConnection, sSql, LogProcess, Output);
    //  oDBQuery.Params[0].AsString := sDomainName;
      try
        oDBQuery.Open;
        Result := oDBQuery.DataSet.Fields[0].AsInteger = 1;
      finally
        oDBQuery.Close;
      end;

      if not Result then
      begin
        UltimoErro := 'TComandoFBCreateDomains, Erro ao criar o DOMAIN ' + sDomainName;
        break;
      end;
    end;
  finally
    oDBQuery.Unprepare;
  end;
end;

function TComandoFBCreateDomains.GetAsSql: string;
var
  sSql: string;
  sDomainName: string;
  oDBQuery: IDBQuery;
  I: integer;
  bResultado: boolean;
  oItemTexto: ITextoItem;
begin
  Result := '';
  sSql := GetSQLDomainExisteParams;
  oDBQuery := btu.lib.db.factory.DBQueryCreate(DBConnection, sSql, LogProcess, Output);
  oDBQuery.Prepare;
  try
    for I := 0 to FComandosTextoList.Count - 1 do
    begin
      oItemTexto := FComandosTextoList[I];

      sDomainName := oItemTexto.Titulo;
      oDBQuery.Params[0].AsString := sDomainName;
      try
        oDBQuery.Open;
        bResultado := oDBQuery.DataSet.Fields[0].AsInteger = 1;
      finally
        oDBQuery.Close;
      end;

      if not bResultado then
      begin
        Result := Result + oItemTexto.Texto + #13#10;
      end;
    end;
  finally
    oDBQuery.Unprepare;
  end;

  if Result = '' then
    Exit;

  Result :=
    #13#10
    + '/*******'#13#10
    + '*'#13#10
    + '* ' + GetAsText + #13#10
    + '*'#13#10
    + '*******/'#13#10
    + Result
    ;
end;

function TComandoFBCreateDomains.GetAsText: string;
begin

  Result := DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS + ' ' + FComandosTextoList.TitulosComVirgulas;
end;

procedure TComandoFBCreateDomains.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  sDomainName: string;
  sLinAtual: string;
  bPegandoCodigo: boolean;
//  aPalavras: TArray<string>;
begin
  bPegandoCodigo := False;

  FDomainsDefSL.Clear;
  //FDomainNamesSL.Clear;

  while piLin < pSL.Count do
  begin
    inc(piLin);
    sLinha := pSL[piLin];

    if bPegandoCodigo then
    begin
      if sLinha = SYNTAX_FIM then
      begin
        bPegandoCodigo := False;
        break;
      end;
      FDomainsDefSL.Add(sLinha);
    end
    else if sLinha = SYNTAX_FIREBIRD_INI then
    begin
      bPegandoCodigo := True;
    end;
  end;


  (*      sLinAtual := StrSemEspacoDuplo(sLinha);
      if LeftStr(sLinAtual, 13) = 'CREATE DOMAIN' then
      begin
        aPalavras := sLinha.Split([' ']);
        sDomainName := aPalavras[2];
        FDomainNamesSL.Add(sDomainName);
      end;
*)

  ForcarUmComandoPorLinha;
end;

procedure TComandoFBCreateDomains.PegarObjeto(pNome: string);
begin
//  inherited;
// este tipo nao tem object name
end;

end.
