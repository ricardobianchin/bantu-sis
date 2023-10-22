unit btu.lib.db.connection_u;

interface

uses
  btu.lib.db.types
  , btu.lib.db.dbms
  , sis.ui.io.output
  , sis.ui.io.log
  , Data.DB
  ;

type
  TDBConnection = class(TInterfacedObject, IDBConnection)
  private
    FOutput: IOutput;
    FNVezesConectou:integer;
    FDBConnectionParams: TDBConnectionParams;
    FUltimoErro:string;
    FLog: ILog;
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

    property Log: ILog read FLog;
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

    constructor Create(pDBConnectionParams: TDBConnectionParams; pLog: ILog; pOutput: IOutput);
    procedure QueryDataSet(pSql: string; var pDataSet: TDataSet);
      virtual; abstract;
  end;

implementation

uses
  System.SysUtils
  ;

{ TDBConnection }

function TDBConnection.Abrir: boolean;
begin
  result:=false;

  if FNVezesConectou=0 then
  begin
    result:=Aberto;
    if not result then
    begin
//      try
        FOutput.Exibir(FDBConnectionParams.Database+' conectando...');
        result:=AbrirConnectionObject;
        if result then
        begin
          IncNVezesConectou;
          if FNVezesConectou = 1 then
          begin
            FOutput.Exibir(FDBConnectionParams.Database+' conectou ok');
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

constructor TDBConnection.Create(pDBConnectionParams: TDBConnectionParams; pLog: ILog; pOutput: IOutput);
begin
  FUltimoErro := '';
  FOutput := pOutput;
  FLog := pLog;
//  FAberto := false;
  IniciarNVezesConectou;
  FDBConnectionParams := pDBConnectionParams;
end;

procedure TDBConnection.DecNVezesConectou;
begin
  if FNVezesConectou = 0 then
    exit;

  dec(FNVezesConectou);
end;

procedure TDBConnection.Fechar;
begin
  DecNVezesConectou;
  if FNVezesConectou<1 then
  begin
    IniciarNVezesConectou;//evitar negativos acidentais
    FecharConnectionObject;
    FOutput.Exibir('Desconectou ' + FDBConnectionParams.Database);
    FOutput.Exibir('');
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
