unit btu.lib.db.query.firedac_u;

interface

uses
  btu.lib.db.query_u, FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.db,
  btu.lib.db.types, sis.UI.io.LogProcess, sis.UI.io.output;

type
  TDBQueryFireDac = class(TDBQuery)
  private
    FFDQuery: TFDQuery;

  protected
    function GetParams: TFDParams; override;
    procedure SetSQL(Value: string); override;
    function GetSQL: string; override;
    function GetIsEmpty: boolean; override;
    function GetDataSet: TDataSet; override;

    function GetActive: boolean; override;
    procedure SetActive(Value: boolean); override;

    function GetPrepared: boolean; override;
    procedure SetPrepared(Value: boolean); override;
  public
    function Abrir: boolean; override;
    procedure Fechar; override;

    constructor Create(pDBConnection: IDBConnection; pSql: string; pLogProcess: ILogProcess;
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
    if FFDQuery.Active then
    begin
      Result := True;
      UltimoErro := ''
    end;
  except
    on e: exception do
    begin
      UltimoErro := 'TDBQueryFireDac.Abrir Erro' + #13#10 + #13#10 + e.classname + #13#10 + e.message
        + #13#10 + #13#10 + 'ao tentar abrir:'#13#10 + #13#10 +
        FFDQuery.SQL.Text;

      LogProcess.Exibir(UltimoErro);
      output.Exibir(UltimoErro);
      raise exception.Create(UltimoErro);
    end;
  end;
end;

constructor TDBQueryFireDac.Create(pDBConnection: IDBConnection; pSql: string;
  pLogProcess: ILogProcess; pOutput: IOutput);
begin
  inherited Create(pDBConnection, pLogProcess, pOutput);
  FFDQuery := TFDQuery.Create(nil);
  FFDQuery.Connection := TFDConnection(pDBConnection.ConnectionObject);
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
  Result := FFDQuery;
end;

function TDBQueryFireDac.GetIsEmpty: boolean;
begin
  Result := FFDQuery.IsEmpty;
end;

function TDBQueryFireDac.GetParams: TFDParams;
begin
  Result := FFDQuery.Params;
end;

function TDBQueryFireDac.GetPrepared: boolean;
begin
  Result := FFDQuery.Prepared;
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

procedure TDBQueryFireDac.SetPrepared(Value: boolean);
begin
  inherited;
  FFDQuery.Prepared := Value;
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
