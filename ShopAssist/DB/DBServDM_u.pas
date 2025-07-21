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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function AbirFDQuery1(pAssunto, pSql: string): Boolean;
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
      sMens := pAssunto + ': ' + e.Message;
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

procedure TDBServDM.FecharFDQuery1;
begin
  if FDQuery1.Active then
    FDQuery1.Close;
end;

end.
