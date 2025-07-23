unit App.UI.Form.DataSet.Est.Saldo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Bas.TabSheet.DataSet_u,
  Data.DB, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ToolWin,
  Sis.Usuario, Sis.DB.DBTypes, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, App.Ent.Ed, App.Ent.DBI,
  App.UI.TabSheet.DataSet.Types_u, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, App.AppObj, Vcl.StdCtrls, App.Retag.Est.Saldo.DBI,
  App.Retag.Est.Saldo.Ent;

type
  TRetagSaldoDataSetBasForm = class(TTabSheetDataSetBasForm)
    procedure AtuAction_DatasetTabSheetExecute(Sender: TObject);
  private
    { Private declarations }
    FRetagSaldoEnt: IRetagSaldoEnt;
    FRetagSaldoDBI: IRetagSaldoDBI;
  protected
    procedure DoAtualizar(Sender: TObject); override;
    function GetNomeArqTabView: string; override;
    procedure ToolBar1CrieBotoes; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pFormClassNamesSL: TStringList;
      pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
      pProcessLog: IProcessLog; pOutputNotify: IOutput; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm; pIdPos: integer;
      pAppObj: IAppObj); override;
  end;

var
  RetagSaldoDataSetBasForm: TRetagSaldoDataSetBasForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.IO.Files, Sis.UI.Controls.TToolBar,
  Sis.DB.Factory, App.DB.Utils, Sis.UI.Controls.TDBGrid,
  App.Acesso.PerfilDeUso.UI.Factory_u, Sis.UI.ImgDM;

{ TRetagSaldoDataSetBasForm }

procedure TRetagSaldoDataSetBasForm.AtuAction_DatasetTabSheetExecute(
  Sender: TObject);
begin
  inherited;
//
end;

constructor TRetagSaldoDataSetBasForm.Create(AOwner: TComponent;
  pFormClassNamesSL: TStringList; pUsuarioLog: IUsuario; pDBMS: IDBMS;
  pOutput: IOutput; pProcessLog: IProcessLog; pOutputNotify: IOutput;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pModoDataSetForm: TModoDataSetForm;
  pIdPos: integer; pAppObj: IAppObj);
begin
  inherited Create(AOwner, pFormClassNamesSL, pUsuarioLog, pDBMS, pOutput,
    pProcessLog, pOutputNotify, pEntEd, pEntDBI, pModoDataSetForm,
    pIdPos, pAppObj);

  FRetagSaldoEnt := EntEdCastToRetagSaldoEnt(pEntEd);
end;

procedure TRetagSaldoDataSetBasForm.DoAtualizar(Sender: TObject);
begin
  FDMemTable.DisableControls;
  FDMemTable.BeginBatch;
  FDMemTable.EmptyDataSet;

  try
    EntDBI.ForEach(0{EstFiltroFrame.Values}, LeRegEInsere);

  finally
    FDMemTable.First;
    FDMemTable.EndBatch;
    FDMemTable.EnableControls;
    DBGridPosicioneColumnVisible(DBGrid1);
//    DetailCarregar;
  end;
end;

function TRetagSaldoDataSetBasForm.GetNomeArqTabView: string;
var
  sNomeArq: string;
begin
  sNomeArq := AppObj.AppInfo.PastaConsTabViews +
    'App\Retag\Est\Saldo\tabview.est.saldo.csv';
  Result := sNomeArq;
end;

procedure TRetagSaldoDataSetBasForm.ToolBar1CrieBotoes;
begin
  inherited;
  ToolBarAddButton(AtuAction_DatasetTabSheet, TitToolBar1_BasTabSheet);
end;

end.
