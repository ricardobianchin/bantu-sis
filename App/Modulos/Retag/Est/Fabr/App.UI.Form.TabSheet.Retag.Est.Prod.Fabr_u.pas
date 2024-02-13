unit App.UI.Form.TabSheet.Retag.Est.Prod.Fabr_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Retag.Est.Prod.Fabr;

type
  TRetagEstProdFabrTabSheetDataSetForm = class(TTabSheetDataSetBasForm)
    procedure FormCreate(Sender: TObject);
    procedure InsAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FFiltroParamsStringFrame: TFiltroParamsStringFrame;
    procedure CrieFiltroFrame;
  protected
    function GetNomeArqTabView: string; override;
    function GetTitulo: string; override;
    procedure ToolBar1CrieBotoes; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdFabrTabSheetDataSetForm: TRetagEstProdFabrTabSheetDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory;

{ TFabricanteTabSheetDataSetForm }

procedure TRetagEstProdFabrTabSheetDataSetForm.CrieFiltroFrame;
var
  iIndexUltimoBotao: integer;
  l, w: integer;
  oFr: TFiltroParamsStringFrame;
  oToolB: TToolBar;
begin
  if Assigned(FFiltroParamsStringFrame) then
    exit;

  //FFiltroParamsStringFrame
  oToolB := TitToolBar1_BasTabSheet;
  oFr := TFiltroParamsStringFrame.Create(oToolB);
  oFr.Parent := oToolB;

  iIndexUltimoBotao := oToolB.ButtonCount - 1;

  if iIndexUltimoBotao > -1 then
  begin
    L := oToolB.ControlCount;
    L := oToolB.Buttons[iIndexUltimoBotao].Left;
    W := oToolB.Buttons[iIndexUltimoBotao].Width;
    oFr.Left := L + W;
  end
  else
    oFr.Left := 0;

end;

procedure TRetagEstProdFabrTabSheetDataSetForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFiltroParamsStringFrame := nil;
end;

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

procedure TRetagEstProdFabrTabSheetDataSetForm.InsAction_DatasetTabSheetExecute(
  Sender: TObject);
var
  oFabr: IProdFabr;
  Resultado: boolean;
begin
  inherited;
  oFabr := RetagEstProdFabrCreate(dsInsert);

  Resultado := ProdFabrPerg(Self,  Titulo, dsInsert, oFabr);
  if not Resultado then
    exit;

end;

procedure TRetagEstProdFabrTabSheetDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;
  CrieFiltroFrame;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);

  ToolBarAddButton(InsAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(AltAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
  ToolBarAddButton(ExclAction_DatasetTabSheetAction1, TitToolBar1_BasTabSheet);
end;

end.
