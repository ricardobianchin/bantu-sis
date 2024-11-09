unit Sis.DB.DBQuery.FireDAC_u;

interface

uses
  FireDAC.Stan.Param, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Comp.Client, System.Classes, Data.DB,
  Sis.DB.DBQuery_u, Sis.DB.DBTypes, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog;

type
  TDBQueryFireDac = class(TDBQuery)
  private
    FFDQuery: TFDQuery;

  protected
    function GetParams: TFDParams; override;
    function GetSQL: TStrings; override;
    function GetIsEmpty: boolean; override;
    function GetDataSet: TDataSet; override;

    function GetActive: boolean; override;
    procedure SetActive(Value: boolean); override;

    function GetPrepared: boolean; override;
    procedure SetPrepared(Value: boolean); override;
  public
    function Abrir: boolean; override;
    procedure Fechar; override;

    constructor Create(pNomeComponente: string; pDBConnection: IDBConnection;
      pSql: string; pProcessLog: IProcessLog; pOutput: IOutput);
    destructor Destroy; override;

    procedure Prepare; override;
    procedure Unprepare; override;
  end;

implementation

uses System.SysUtils;

{ TDBQueryFireDac }

function TDBQueryFireDac.Abrir: boolean;
var
  sLog: string;
begin
  Result := False;
  ProcessLog.PegueLocal('TDBQueryFireDac.Abrir');
  try
    try
      sLog := SQL.Text + ',' + GetParamsAsStr + ', vai FFDQuery.Open';
      FFDQuery.Open;
      if FFDQuery.Active then
      begin
        Result := True;
        sLog := sLog + 'Abriu';
        UltimoErro := ''
      end;
    except
      on e: exception do
      begin
        UltimoErro := 'TDBQueryFireDac.Abrir Erro'#13#10#13#10 + e.classname +
          #13#10 + e.message + #13#10 + #13#10 + 'ao tentar abrir:'#13#10#13#10
          + FFDQuery.SQL.Text;
        sLog := sLog + ',' + UltimoErro;
        DBLog.Registre(sLog);
        Output.Exibir(UltimoErro);
        raise exception.Create(UltimoErro);
      end;
    end;
  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal;
  end;
end;

constructor TDBQueryFireDac.Create(pNomeComponente: string;
  pDBConnection: IDBConnection; pSql: string; pProcessLog: IProcessLog;
  pOutput: IOutput);
var
  sLog: string;
begin
  pProcessLog.PegueLocal('TDBQueryFireDac.Create');
  try
    inherited Create(pNomeComponente, pDBConnection, pProcessLog, pOutput);

    sLog := 'retornou de inherited Create' +
      ',vai FFDQuery := TFDQuery.Create(nil)';

    FFDQuery := TFDQuery.Create(nil);

    FFDQuery.Connection := TFDConnection(pDBConnection.ConnectionObject);

    sLog := sLog + #13#10'pSql='#13#10 + pSql + #13#10;
    SQL.Text := pSql;

  finally
    DBLog.Registre(sLog);
    ProcessLog.RetorneLocal
  end;
end;

destructor TDBQueryFireDac.Destroy;
begin
  ProcessLog.PegueLocal('TDBQueryFireDac.Destroy');
  try
    DBLog.Registre('vai FreeAndNil(FFDQuery)');
    FreeAndNil(FFDQuery);
    inherited;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

procedure TDBQueryFireDac.Fechar;
begin
  ProcessLog.PegueLocal('TDBQueryFireDac.Fechar');
  try
    DBLog.Registre('vai FFDQuery.Close');
    FFDQuery.Close;
  finally
    ProcessLog.RetorneLocal;
  end;
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

function TDBQueryFireDac.GetSQL: TStrings;
begin
  Result := FFDQuery.SQL;
end;

procedure TDBQueryFireDac.Prepare;
begin
  inherited;
  ProcessLog.PegueLocal('TDBQueryFireDac.Prepare');
  try
    if not FFDQuery.Prepared then
    begin
      DBLog.Registre('vai FFDQuery.Prepare');
      FFDQuery.Prepare;
    end;
  finally
    ProcessLog.RetorneLocal;
  end;
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

procedure TDBQueryFireDac.Unprepare;
begin
  inherited;
  ProcessLog.PegueLocal('TDBQueryFireDac.Prepare');
  try
    if FFDQuery.Prepared then
    begin
      DBLog.Registre('vai FFDQuery.Unprepare');
      FFDQuery.Unprepare;
    end;
  finally
    ProcessLog.RetorneLocal;
  end;
end;

end.
