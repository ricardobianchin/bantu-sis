unit App.UI.Form.TabSheet.Retag.Est.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo, Vcl.StdCtrls;

  na classe mae usar estes pra carregar
  classe filha define DBConnectionParams se serv ou term
  oDBConnection: IDBConnection;
  DBConnectionParams: TDBConnectionParams;

type
  TRetagEstProdFabrTabSheetDataSetForm = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
  protected
    function GetNomeArqTabView: string; override;
    function GetTitulo: string; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdFabrTabSheetDataSetForm: TRetagEstProdFabrTabSheetDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files;

{ TFabricanteTabSheetDataSetForm }

function TRetagEstProdFabrTabSheetDataSetForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppInfo.PastaConsTabViews + 'Est\tabview.est.prod.fabr.csv';

  Result := sNomeArq;
end;

function TRetagEstProdFabrTabSheetDataSetForm.GetTitulo: string;
begin
  Result := 'Fabricantes';
end;

end.
