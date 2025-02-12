unit DBServDM_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB;

type
  TDBServDM = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Connection: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBServDM: TDBServDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function GetPastaFirebird: string;
begin
  Result := 'C:\Program Files\Firebird\Firebird_5_0\';

  if not FileExists(Result+'isql.exe') then
    Result := 'C:\Program Files (x86)\Firebird\Firebird_5_0\';
end;

procedure TDBServDM.DataModuleCreate(Sender: TObject);
var
  s: string;
begin
  s := GetPastaFirebird;
  FDPhysFBDriverLink1.VendorHome := s;
end;

end.
