unit btu.lib.db.query.firedac_u;

interface

uses
  btu.lib.db.query_u, FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.db,
  btu.lib.db.types, btu.sis.UI.io.log, btu.sis.UI.io.output;

type
  TDBQueryFireDac = class(TDBQuery)
  private
    FFDQuery: TFDQuery;

  protected
    function GetParams: TFDParams; override;
    procedure SetSql(Value: string); override;
    function GetSQL: string; override;
    function GetIsEmpty: boolean;  override;
    function GetDataSet: TDataSet;  override;

    function GetActive: boolean; override;
    procedure SetActive(Value: boolean); override;
  public
    function Abrir: boolean; override;
    procedure Fechar; override;

    constructor Create(pDBConnection: IDBConnection; pSql: string; pLog: ILog;
      pOutput: IOutput);
    destructor Destroy; override;

    procedure Prepare; override;
    procedure Unprepare; override;
  end;

implementation

uses System.SysUtils;

{ TDBQueryFireDac }

function TDBQueryFireDac.Abrir: boolean;
begin
  Result := False;
  try
    FFDQuery.Open;
    result := FFDQuery.Active;
    UltimoErro := '';
  except
    on e: exception do
    begin
      UltimoErro := 'Erro' + #13#10 + #13#10 + e.classname + #13#10 + e.message
        + #13#10 + #13#10 + 'ao tentar abrir:'#13#10 + #13#10 +
        FFDQuery.SQL.Text;

      Result := False;

      Log.Exibir(UltimoErro);
      Output.Exibir(UltimoErro);
      raise exception.Create(UltimoErro);
    end;
  end;
end;

constructor TDBQueryFireDac.Create(pDBConnection: IDBConnection; pSql: string;
  pLog: ILog; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pLog, pOutput);
  FFDQuery:=TFDQuery.Create(nil);
  FFDQuery.Connection := TFDConnection( pDBConnection.ConnectionObject);
  SetSql(pSql);
end;

destructor TDBQueryFireDac.Destroy;
begin
  FreeAndNil(FFDQuery);

  inherited;
end;

procedure TDBQueryFireDac.Fechar;
begin
  FFDQuery.Close;
end;

function TDBQueryFireDac.GetActive: boolean;
begin
  Result := FFDQuery.Active;
end;

function TDBQueryFireDac.GetDataSet: TDataSet;
begin
  result := FFDQuery;
end;

function TDBQueryFireDac.GetIsEmpty: boolean;
begin
  Result := FFDQuery.IsEmpty;
end;

function TDBQueryFireDac.GetParams: TFDParams;
begin
  Result := FFDQuery.Params;
end;

function TDBQueryFireDac.GetSQL: string;
begin
  Result := FFDQuery.SQL.Text;
end;

procedure TDBQueryFireDac.Prepare;
begin
  inherited;
  if not FFDQuery.Prepared then
    FFDQuery.Prepare;
end;

procedure TDBQueryFireDac.SetActive(Value: boolean);
begin
  inherited;
  if FFDQuery.Active <> Value then
    FFDQuery.Active := Value;
end;

procedure TDBQueryFireDac.SetSql(Value: string);
begin
  FFDQuery.SQL.Text := Value;
end;

procedure TDBQueryFireDac.Unprepare;
begin
  inherited;
  if FFDQuery.Prepared then
    FFDQuery.Unprepare;
end;

end.
