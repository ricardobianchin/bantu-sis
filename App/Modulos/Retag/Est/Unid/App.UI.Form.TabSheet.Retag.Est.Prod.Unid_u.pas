unit App.UI.Form.TabSheet.Retag.Est.Prod.Unid_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.TabSheet.DataSet_u, Data.DB, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ToolWin, App.AppInfo,
  Vcl.StdCtrls, Sis.UI.Frame.Bas.FiltroParams.BuscaString_u,
  App.Ent.DBI, Sis.DB.DBTypes, App.UI.Decorator.Form.Excl,
  App.UI.Form.Ed.Unid_u;

type
  TRetagEstProdUnidTabSheetDataSetForm = class(TTabSheetDataSetBasForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FFiltroParamsStringFrame: TFiltroParamsStringFrame;
    procedure CrieFiltroFrame;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function DoInserir: boolean; override;
    procedure DoAlterar; override;

    function GetNomeArqTabView: string; override;
    function GetTitulo: string; override;
    procedure ToolBar1CrieBotoes; override;
    function GetNome: string; override;
    function GetNomeAbrev: string; override;
  public
    { Public declarations }
  end;

var
  RetagEstProdUnidTabSheetDataSetForm: TRetagEstProdUnidTabSheetDataSetForm;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, Sis.UI.Controls.TToolBar, App.Retag.Est.Factory,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.IO.Input.Perg, App.UI.Form.Retag.Excl_u,
  Sis.UI.Controls.TDBGrid;

procedure TRetagEstProdUnidTabSheetDataSetForm.CrieFiltroFrame;
var
  iIndexUltimoBotao: integer;
  l, w: integer;
  oToolB: TToolBar;
begin
  if Assigned(FFiltroParamsStringFrame) then
    exit;

  // FFiltroParamsStringFrame
  oToolB := TitToolBar1_BasTabSheet;
  FFiltroParamsStringFrame := TFiltroParamsStringFrame.Create(oToolB,
    DoAtualizar);
  FFiltroParamsStringFrame.Parent := oToolB;

  iIndexUltimoBotao := oToolB.ButtonCount - 1;

  if iIndexUltimoBotao > -1 then
  begin
    l := oToolB.ControlCount;
    l := oToolB.Buttons[iIndexUltimoBotao].Left;
    w := oToolB.Buttons[iIndexUltimoBotao].Width;
    FFiltroParamsStringFrame.Left := l + w;
  end
  else
    FFiltroParamsStringFrame.Left := 0;
end;

procedure TRetagEstProdUnidTabSheetDataSetForm.DoAlterar;
var
  oUnid: IEntIdDescr;
  oUnidDBI: IEntDBI;
  oDBConnectionParams: TDBConnectionParams;
  oConn: IDBConnection;
  sBusca: string;
  Resultado: boolean;
begin
  oUnid := RetagEstProdUnidCreate(State, FDMemTable.Fields[0].AsInteger, FDMemTable.Fields[1].AsString);

  oDBConnectionParams := LocalDoDBToDBConnectionParams(TLocalDoDB.ldbServidor,
    AppInfo, SisConfig);

  oConn := DBConnectionCreate('Retag.Unid.Ed.Atu.Conn', SisConfig, DBMS,
    oDBConnectionParams, ProcessLog, Output);

  oUnidDBI := RetagEstProdUnidDBICreate(oConn, oUnid);

  Resultado := ProdUnidPerg(Self, Titulo, dsEdit, oUnid, oUnidDBI);
  if not Resultado then
    exit;

  FDMemTable.Edit;
  FDMemTable.Fields[1].AsString := oUnid.Descr;
  FDMemTable.Post;
end;

procedure TRetagEstProdUnidTabSheetDataSetForm.DoAtualizar(Sender: TObject);
begin
  inherited;

end;

function TRetagEstProdUnidTabSheetDataSetForm.DoInserir: boolean;
begin

end;

procedure TRetagEstProdUnidTabSheetDataSetForm.FormCreate(Sender: TObject);
begin
  inherited;
  FFiltroParamsStringFrame := nil;
end;

function TRetagEstProdUnidTabSheetDataSetForm.GetNome: string;
begin

end;

function TRetagEstProdUnidTabSheetDataSetForm.GetNomeAbrev: string;
begin

end;

function TRetagEstProdUnidTabSheetDataSetForm.GetNomeArqTabView: string;
begin

end;

function TRetagEstProdUnidTabSheetDataSetForm.GetTitulo: string;
begin

end;

procedure TRetagEstProdUnidTabSheetDataSetForm.ToolBar1CrieBotoes;
begin
  inherited;

end;

end.
