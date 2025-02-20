unit App.UI.Form.Ed.CxOperacao.Valores_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Ed.CxOperacao_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.Ent.Ed, App.Ent.DBI,
  App.AppObj, App.Est.Venda.Caixa.CxValor.DBI,
  App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Sis.Usuario,
  Vcl.Grids, Vcl.DBGrids, Vcl.Mask, CustomEditBtu, CustomNumEditBtu, NumEditBtu;

type
  TCxOperValoresEdForm = class(TCxOperacaoEdForm)
    FDMemTable1: TFDMemTable;
    FDMemTable1Id: TIntegerField;
    FDMemTable1Descr: TStringField;
    FDMemTable1Valor: TCurrencyField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    TotPanel: TPanel;
    TotNumEditBtu: TNumEditBtu;
    procedure FDMemTable1NewRecord(DataSet: TDataSet);
    procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure DBGrid1ColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1ColEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure ParaTodosRegs(pCode: TProc);
    procedure PreencherFDMemTable1;
    procedure AjusteTotal;
  protected
    procedure AjusteControles; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;
    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pUsuario: IUsuario;
      pEntEd: IEntEd; pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
      reintroduce; virtual;
  end;

var
  CxOperValoresEdForm: TCxOperValoresEdForm;

implementation

{$R *.dfm}
{ TCxOperValoresEdForm }

procedure TCxOperValoresEdForm.AjusteControles;
begin
  inherited;
  DBGrid1.SetFocus;
  DBGrid1.SelectedIndex := 2;
end;

procedure TCxOperValoresEdForm.AjusteTotal;
var
  Tot: Currency;
begin
  Tot := 0;
  ParaTodosRegs(
    procedure
    begin
      Tot := Tot + FDMemTable1.Fields[2].AsCurrency;
    end);
  TotNumEditBtu.Valor := Tot;
end;

function TCxOperValoresEdForm.ControlesOk: boolean;
begin
  result := inherited;
end;

procedure TCxOperValoresEdForm.ControlesToEnt;
var
  i: Integer;
  v: Currency;
begin
  inherited;
  CxOperacaoEnt.Valor := TotNumEditBtu.AsCurrency;
  CxOperacaoEnt.CxValorList.Clear;
  ParaTodosRegs(
    procedure
    begin
      v := FDMemTable1.Fields[2].AsCurrency;
      if v >= 0.01 then
      begin
        i := FDMemTable1.Fields[0].AsInteger;
        CxOperacaoEnt.CxValorList.PegueCxValor(i, v);
      end;
    end);
end;

constructor TCxOperValoresEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
pUsuario: IUsuario; pEntEd: IEntEd; pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner, pAppObj, pUsuario, pEntEd, pEntDBI);
  PreencherFDMemTable1;
end;

function TCxOperValoresEdForm.DadosOk: boolean;
begin
  result := inherited;
  if not result then
    exit;

end;

procedure TCxOperValoresEdForm.DBGrid1ColEnter(Sender: TObject);
begin
  inherited;
  if DBGrid1.SelectedIndex <> 2 then
    DBGrid1.SelectedIndex := 2;
end;

procedure TCxOperValoresEdForm.DBGrid1ColumnMoved(Sender: TObject;
FromIndex, ToIndex: Integer);
begin
  inherited;
  // DBGrid1.SelectedIndex := 2;
  // DBGrid1.Columns[ToIndex].Index := FromIndex; // impede de mover
end;

procedure TCxOperValoresEdForm.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if FDMemTable1.State <> TDataSetState.dsBrowse then
      FDMemTable1.Post;
  end;
end;

procedure TCxOperValoresEdForm.EntToControles;
begin
  inherited;

end;

procedure TCxOperValoresEdForm.FDMemTable1AfterPost(DataSet: TDataSet);
begin
  inherited;
  AjusteTotal;
end;

procedure TCxOperValoresEdForm.FDMemTable1NewRecord(DataSet: TDataSet);
begin
  inherited;
  Abort
end;

procedure TCxOperValoresEdForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if FDMemTable1.State <> TDataSetState.dsBrowse then
    begin
      FDMemTable1.Cancel;
      exit;
    end;
  end;
  inherited;

end;

procedure TCxOperValoresEdForm.ParaTodosRegs(pCode: TProc);
var
  bm: TBookmark;
begin
  inherited;
  FDMemTable1.OnNewRecord := nil;
  FDMemTable1.AfterPost := nil;
  FDMemTable1.BeginBatch;
  FDMemTable1.DisableControls;

  bm := FDMemTable1.GetBookmark;
  try
    FDMemTable1.First;
    while not FDMemTable1.Eof do
    begin
      pCode;
      FDMemTable1.Next;
    end;
  finally
    FDMemTable1.GotoBookmark(bm);
    FDMemTable1.FreeBookmark(bm);
    FDMemTable1.EndBatch;
    FDMemTable1.EnableControls;
    FDMemTable1.OnNewRecord := FDMemTable1NewRecord;
    FDMemTable1.AfterPost := FDMemTable1AfterPost;
  end;
end;

procedure TCxOperValoresEdForm.PreencherFDMemTable1;
begin
  FDMemTable1.OnNewRecord := nil;
  FDMemTable1.AfterPost := nil;
  CxOperacaoDBI.PreencherPagamentoFormaDataSet(FDMemTable1);
  FDMemTable1.OnNewRecord := FDMemTable1NewRecord;
  FDMemTable1.AfterPost := FDMemTable1AfterPost;
end;

end.
