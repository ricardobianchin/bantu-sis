unit App.UI.Form.DataSet.Retag.Fin.PagForma_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.Ent.Ed.Id.Descr, App.Retag.Fin.PagForma.Ent;

type
  TTabSheetDataSetBasForm1 = class(TTabSheetDataSetBasForm)
  private
    { Private declarations }
    function GetProdFabrEnt: IPagFormaEnt;
    property ProdFabrEnt: IPagFormaEnt read GetProdFabrEnt;

  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
    procedure RecordToEnt; override;

  public
    { Public declarations }
  end;

var
  TabSheetDataSetBasForm1: TTabSheetDataSetBasForm1;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Fin.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, Sis.UI.Controls.TDBGrid;

{ TTabSheetDataSetBasForm1 }

function TTabSheetDataSetBasForm1.GetProdFabrEnt: IPagFormaEnt;
begin
  Result := EntEdCastToProdEnt(EntEd);
end;

end.
