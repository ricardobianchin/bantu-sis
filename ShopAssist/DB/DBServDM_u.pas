unit DBServDM_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDBServDM = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Connection: TFDConnection;
    FDQuery1: TFDQuery;
    FDCommand1: TFDCommand;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AbirFDQuery1(pAssunto, pSql: string): Boolean;
    function FDCommand1Execute(pAssunto, pSql: string): Boolean;
    function FDCommand1Prepare(pAssunto, pSql: string): Boolean;
    procedure FDCommand1Unprepare;
    procedure FecharFDQuery1;
  end;

var
  DBServDM: TDBServDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Log_u;

{$R *.dfm}

function GetPastaFirebird: string;
begin
  Result := 'C:\Program Files\Firebird\Firebird_5_0\';

  if not FileExists(Result + 'isql.exe') then
    Result := 'C:\Program Files (x86)\Firebird\Firebird_5_0\';
end;

function TDBServDM.AbirFDQuery1(pAssunto, pSql: string): Boolean;
var
  sMens: string;
begin
  FecharFDQuery1;

  FDQuery1.SQL.Text := pSql;
  try
    FDQuery1.Open;
    Result := FDQuery1.Active;
  except
    on e: exception do
    begin
      Result := False;
      sMens := pAssunto + ', AbirFDQuery1: ' + e.Message;
      EscrevaLog(sMens);
    end;
  end;
end;

procedure TDBServDM.DataModuleCreate(Sender: TObject);
var
  s: string;
begin
  s := GetPastaFirebird;
  FDPhysFBDriverLink1.VendorHome := s;
end;

function TDBServDM.FDCommand1Execute(pAssunto, pSql: string): Boolean;
var
  sMens: string;
begin
  FDCommand1.CommandText.Text := pSql;
  try
    FDCommand1.Execute;
    Result := True;
  except
    on e: exception do
    begin
      Result := False;
      sMens := pAssunto + ', FDCommand1Prepare: ' + e.Message;
      EscrevaLog(sMens);
    end;
  end;
end;

function TDBServDM.FDCommand1Prepare(pAssunto, pSql: string): Boolean;
var
  sMens: string;
begin
  FDCommand1.CommandText.Text := pSql;
  try
    FDCommand1.Prepared := True;
    Result := True;
  except
    on e: exception do
    begin
      Result := False;
      sMens := pAssunto + ', FDCommand1Prepare: ' + e.Message;
      EscrevaLog(sMens);
    end;
  end;
end;

procedure TDBServDM.FDCommand1Unprepare;
begin
  FDCommand1.Prepared := False;
end;

procedure TDBServDM.FecharFDQuery1;
begin
  if FDQuery1.Active then
    FDQuery1.Close;
end;

end.
