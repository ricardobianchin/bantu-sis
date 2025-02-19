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
  App.AppObj,App.Est.Venda.Caixa.CxValor.DBI, App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent,
  Vcl.Grids, Vcl.DBGrids;

type
  TCxOperValoresEdForm = class(TCxOperacaoEdForm)
    FDMemTable1: TFDMemTable;
    FDMemTable1Id: TIntegerField;
    FDMemTable1Descr: TStringField;
    FDMemTable1Valor: TCurrencyField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    procedure FDMemTable1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    procedure PreencherFDMemTable1;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI); reintroduce; virtual;
  end;

var
  CxOperValoresEdForm: TCxOperValoresEdForm;

implementation

{$R *.dfm}
{ TCxOperValoresEdForm }

constructor TCxOperValoresEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FDMemTable1.OnNewRecord := nil;
  PreencherFDMemTable1;
  FDMemTable1.OnNewRecord := FDMemTable1NewRecord;
end;

procedure TCxOperValoresEdForm.FDMemTable1NewRecord(DataSet: TDataSet);
begin
  inherited;
  Abort
end;

procedure TCxOperValoresEdForm.PreencherFDMemTable1;
begin
  CxOperacaoDBI.PreencherPagamentoFormaDataSet(FDMemTable1);
end;

end.
