unit btu.lib.db.connection_u;

interface

uses
  btu.lib.db.types
  , btu.lib.db.dbms
  , sis.ui.io.output
  , sis.ui.io.LogProcess
  , Data.DB
  ;

type
  TDBConnection = class(TInterfacedObject, IDBConnection)
  private
    FOutput: IOutput;
    FNVezesConectou:integer;
    FDBConnectionParams: TDBConnectionParams;
    FUltimoErro:string;
    FLogProcess: ILogProcess;
//    FAberto: boolean;

    function GetUltimoErro: string;
    procedure SetUltimoErro(const Value: string);
    function GetAberto: boolean;

    procedure IniciarNVezesConectou;
    procedure IncNVezesConectou;
    procedure DecNVezesConectou;
  protected
    function GetConnectionObject:TObject; virtual; abstract;
    function ConnectionObjectAberto:boolean; virtual; abstract;
    function AbrirConnectionObject:boolean; virtual; abstract;
    procedure FecharConnectionObject; virtual; abstract;

    property LogProcess: ILogProcess read FLogProcess;
    property Output: IOutput read FOutput;
    property DBConnectionParams: TDBConnectionParams read FDBConnectionParams;
  public
    property ConnectionObject:TObject read GetConnectionObject;
    procedure StartTransaction; virtual; abstract;
    procedure Commit; virtual; abstract;
    procedure Rollback; virtual; abstract;

    property UltimoErro: string read GetUltimoErro write SetUltimoErro;

    function Abrir: boolean;
    procedure Fechar;
    property Aberto: boolean read GetAberto;

    function GetValue(pSql: string): Variant; virtual; abstract;
    function ExecuteSQL(pSql: string): LongInt; virtual; abstract;

    constructor Create(pDBConnectionParams: TDBConnectionParams; pLogProcess: ILogProcess; pOutput: IOutput);
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet);
      virtual; abstract;
  end;

implementation

uses
  System.SysUtils
  ;

{ TDBConnection }

function TDBConnection.Abrir: boolean;
var
  s: string;
begin
  result:=false;

  if FNVezesConectou=0 then
  begin
    if Aberto then
    begin
      Result := True;
    end;
    if not result then
    begin
//      try
      s := 'TDBConnection.Abrir,Database=' + FDBConnectionParams.Database +
        ' conectando...';
      FOutput.Exibir(s);
        result:=AbrirConnectionObject;
        if result then
        begin
          IncNVezesConectou;
          if FNVezesConectou = 1 then
          begin
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
    result:=true;
    IncNVezesConectou;
  end;
end;

constructor TDBConnection.Create(pDBConnectionParams: TDBConnectionParams;
  pLogProcess: ILogProcess; pOutput: IOutput);
var
  s: string;
begin
  FUltimoErro := '';
  FOutput := pOutput;
  FLogProcess := pLogProcess;
//  FAberto := false;
  IniciarNVezesConectou;
  s := 'TDBConnection.Create,Database=' + pDBConnectionParams.Database;
  FLogProcess.Exibir(s);
  FDBConnectionParams := pDBConnectionParams;
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
  DecNVezesConectou;
  if FNVezesConectou<1 then
  begin
    IniciarNVezesConectou;//evitar negativos acidentais
    FecharConnectionObject;
    s := 'TDBConnection.Fechar,Database=' + FDBConnectionParams.Database;
    FOutput.Exibir(s);
    //FInterfaceTela.ExibirPausa('desconectou '+inttostr(FNVezesConectou));
  end
  else
  begin
    //FInterfaceTela.ExibirPausa('nao desconectou '+inttostr(FNVezesConectou));
  end;
end;

function TDBConnection.GetAberto: boolean;
begin
  result := ConnectionObjectAberto;
end;

function TDBConnection.GetUltimoErro: string;
begin
  result := FUltimoErro;
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
