unit Sis.DB.DBConnection_u;

interface

uses
  Data.DB, Sis.DB.DBTypes, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Output.ProcessLog.Registrador;

type
  TDBConnection = class(TInterfacedObject, IDBConnection)
  private
    FOutput: IOutput;
    FNVezesConectou: integer;
    FDBConnectionParams: TDBConnectionParams;
    FUltimoErro: string;
    FProcessLog: IProcessLog;
    // FAberto: boolean;
    FDBLog: IProcessLogRegistrador;
    FNome: string;

    function GetUltimoErro: string;
    procedure SetUltimoErro(const Value: string);
    function GetAberto: boolean;

    procedure IniciarNVezesConectou;
    procedure IncNVezesConectou;
    procedure DecNVezesConectou;

    function GetNome: string;

  protected
    function GetConnectionObject: TObject; virtual; abstract;
    function ConnectionObjectAberto: boolean; virtual; abstract;
    function AbrirConnectionObject: boolean; virtual; abstract;
    procedure FecharConnectionObject; virtual; abstract;

    property Nome: string read GetNome;
    property Output: IOutput read FOutput;
    property ProcessLog: IProcessLog read FProcessLog;
    property DBLog: IProcessLogRegistrador read FDBLog;
    property DBConnectionParams: TDBConnectionParams read FDBConnectionParams;

  public
    property ConnectionObject: TObject read GetConnectionObject;
    procedure StartTransaction; virtual; abstract;
    procedure Commit; virtual; abstract;
    procedure Rollback; virtual; abstract;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function Abrir: boolean;
    procedure Fechar;
    property Aberto: boolean read GetAberto;

    function GetValue(pSql: string): Variant; virtual; abstract;
    function GetValueInteger(pSql: string): integer;
    function ExecuteSQL(pSql: string): LongInt; virtual; abstract;

    constructor Create(pNomeComponente: string;
      pDBConnectionParams: TDBConnectionParams; pProcessLog: IProcessLog;
      pOutput: IOutput);
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet);
      virtual; abstract;
  end;

implementation

uses System.SysUtils, Sis.Types.Bool_u, Sis.UI.IO.Output.ProcessLog.Factory,
  Sis.Types.Integers;

{ TDBConnection }

function TDBConnection.Abrir: boolean;
var
  s: string;
begin
  result := false;
  FProcessLog.PegueLocal('TDBConnection.Abrir');
  DBLog.Registre('FNVezesConectou=' + FNVezesConectou.ToString);
  try
    if FNVezesConectou = 0 then
    begin
      DBLog.Registre('Aberto=' + BooleanToStr(Aberto));
      if Aberto then
      begin
        result := True;
      end;
      if not result then
      begin
        // try
        s := 'TDBConnection.Abrir,Database=' + FDBConnectionParams.Database +
          ' conectando...';
        FOutput.Exibir(s);
        DBLog.Registre('Vai AbrirConnectionObject');
        result := AbrirConnectionObject;
        DBLog.Registre('Result=' + BooleanToStr(result));
        if result then
        begin
          IncNVezesConectou;
          if FNVezesConectou = 1 then
          begin
            DBLog.Registre('FNVezesConectou = 1, conectou ok');
            s := 'TDBConnection.Abrir,Database=' + FDBConnectionParams.Database
              + ',conectou ok';
            FOutput.Exibir(s);
          end;
        end;
        FUltimoErro := '';
      end;
    end
    else
    begin
      result := True;
      IncNVezesConectou;
      DBLog.Registre('ja conectado, incrementou FNVezesConectou para ' +
        FNVezesConectou.ToString);
    end;
  finally
    DBLog.Registre('FUltimoErro=[' + FUltimoErro + '],Fim');
    FProcessLog.RetorneLocal;
  end;
end;

constructor TDBConnection.Create(pNomeComponente: string;
  pDBConnectionParams: TDBConnectionParams; pProcessLog: IProcessLog;
  pOutput: IOutput);
var
  s: string;
begin
  pProcessLog.PegueLocal('TDBConnection.Create');
  try
    FNome := pNomeComponente;
    FUltimoErro := '';
    FOutput := pOutput;
    FProcessLog := pProcessLog;

    FDBLog := ProcessLogRegistradorCreate(FProcessLog,
      TProcessLogTipo.lptDB, FNome);
    s := 'FDBConnectionParams.Database=[' + FDBConnectionParams.Database + ']';
    FDBLog.Registre(s);

    IniciarNVezesConectou;
    FDBConnectionParams := pDBConnectionParams;
  finally
    DBLog.Registre('Fim');
    FProcessLog.RetorneLocal;
  end;
end;

procedure TDBConnection.DecNVezesConectou;
begin
  if FNVezesConectou = 0 then
    exit;

  dec(FNVezesConectou);
end;

procedure TDBConnection.Fechar;
var
  s: string;
begin
  FProcessLog.PegueLocal('TDBConnection.Fechar');
  try
    DecNVezesConectou;
    if FNVezesConectou < 1 then
    begin
      IniciarNVezesConectou; // evitar negativos acidentais
      DBLog.Registre('vai FecharConnectionObject');
      FecharConnectionObject;
      s := 'TDBConnection.Fechar,Database=' + FDBConnectionParams.Database;
      FOutput.Exibir(s);
      // FInterfaceTela.ExibirPausa('desconectou '+inttostr(FNVezesConectou));
    end
    else
    begin
      // FInterfaceTela.ExibirPausa('nao desconectou '+inttostr(FNVezesConectou));
    end;
  finally
    DBLog.Registre('Fim');
    FProcessLog.RetorneLocal;
  end;
end;

function TDBConnection.GetAberto: boolean;
begin
  result := ConnectionObjectAberto;
end;

function TDBConnection.GetNome: string;
begin
  result := FNome;
end;

function TDBConnection.GetUltimoErro: string;
begin
  result := FUltimoErro;
end;

function TDBConnection.GetValueInteger(pSql: string): integer;
var
  Resultado: Variant;
begin
  Resultado := GetValue(pSql);
  result := VarToInteger(Resultado);
end;

procedure TDBConnection.IncNVezesConectou;
begin
  inc(FNVezesConectou)
end;

procedure TDBConnection.IniciarNVezesConectou;
begin
  FNVezesConectou := 0;
end;

procedure TDBConnection.SetUltimoErro(const Value: string);
begin
  FUltimoErro := Value;
end;

end.
