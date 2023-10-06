unit btu.lib.db.updater.comando.fb.createdomains_u;

interface

uses btu.lib.db.updater.comando, System.Classes, btu.lib.db.updater.campo.list,
  btu.lib.db.types, btu.lib.db.updater.comando.fb_u, btu.lib.db.updater.operations,
  btu.sis.ui.io.log, btu.sis.ui.io.output;

type
  TComandoFBCreateDomains = class(TComandoFB)
  private
    FDomainsDefSL: TStringList;
    FDomainNamesSL: TStringList;

  protected
    procedure PegarObjeto(pNome: string); override;
    function GetAsText: string;  override;
  public
    procedure PegarLinhas(var piLin: integer; pSL: TStrings); override;
    function GetAsSql: string; override;
    constructor Create(pDBConnection: IDBConnection;
      pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
    function Funcionou: boolean; override;
    destructor Destroy; override;
  end;

implementation

uses btu.lib.db.updater.constants_u, btu.lib.db.updater.campo, System.SysUtils,
  btu.lib.db.updater.factory, btn.lib.types.strings, btu.sis.db.updater.utils
  , System.StrUtils, btu.lib.db.factory, btu.lib.db.updater.firebird.GetSql_u;

{ TComandoFBCreateDomains }

constructor TComandoFBCreateDomains.Create(pDBConnection: IDBConnection;
  pUpdaterOperations: IDBUpdaterOperations; pLog: ILog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pUpdaterOperations, pLog, pOutput);
  FDomainsDefSL := TStringList.Create;
  FDomainNamesSL := TStringList.Create;
end;

destructor TComandoFBCreateDomains.Destroy;
begin
  FDomainsDefSL.Free;
  FDomainNamesSL.Free;
  inherited;
end;

function TComandoFBCreateDomains.Funcionou: boolean;
var
  sSql: string;
  sDomainName: string;
  oDBQuery: IDBQuery;
  I: integer;
begin
  sSql := GetSQLDomainExisteParams;
  oDBQuery := btu.lib.db.factory.DBQueryCreate(DBConnection, sSql, Log, Output);
  oDBQuery.Prepare;
  try
    for I := 0 to FDomainNamesSL.Count - 1 do
    begin
      sDomainName := FDomainNamesSL[I];
      oDBQuery.Params[0].AsString := sDomainName;
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
begin
  Result := FDomainsDefSL.Text;

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
//  FDomainsDefSL.Delimiter := ',';

  Result := DBATUALIZ_TIPO_COMANDO_CREATE_DOMAINS + ' ' + FDomainNamesSL.DelimitedText;
end;

procedure TComandoFBCreateDomains.PegarLinhas(var piLin: integer;
  pSL: TStrings);
var
  sLinha: string;
  sDomainName: string;
  sLinAtual: string;
  bPegandoCodigo: boolean;
  aPalavras: TArray<string>;
begin
  bPegandoCodigo := False;

  FDomainsDefSL.Clear;
  FDomainNamesSL.Clear;

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

      sLinAtual := StrSemEspacoDuplo(sLinha);
      if LeftStr(sLinAtual, 13) = 'CREATE DOMAIN' then
      begin
        aPalavras := sLinha.Split([' ']);
        sDomainName := aPalavras[2];
        FDomainNamesSL.Add(sDomainName);
      end;
    end
    else if sLinha = SYNTAX_FIREBIRD_INI then
    begin
      bPegandoCodigo := True;
    end;
  end;
end;

procedure TComandoFBCreateDomains.PegarObjeto(pNome: string);
begin
//  inherited;
// este tipo nao tem object name
end;

end.
