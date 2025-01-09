unit App.UI.PDV.PagPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, App.PDV.DBI, App.PDV.Venda,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TPagPergForm = class(TDiagBasForm)
    CancelarStatusLabel: TLabel;
    FaltaLabel: TLabel;
    PagFormaFDMemTable: TFDMemTable;
    PagFormaFDMemTablePAGAMENTO_FORMA_ID: TIntegerField;
    PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID: TStringField;
    PagFormaFDMemTableTIPO_DESCR_RED: TStringField;
    PagFormaFDMemTableFORMA_DESCR: TStringField;
    PagFormaFDMemTableVALOR_MINIMO: TCurrencyField;
    PagFormaFDMemTablePROMOCAO_PERMITE: TBooleanField;
    PagFormaFDMemTableTEF_USA: TBooleanField;
    PagFormaFDMemTableAUTORIZACAO_EXIGE: TBooleanField;
    PagFormaFDMemTablePESSOA_EXIGE: TBooleanField;
    PagFormaDataSource: TDataSource;
    PagFormaDBGrid: TDBGrid;
    Label1: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    FormaPagObsLabel: TLabel;
  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
    FPDVDBI: IAppPDVDBI;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
      pPDVDBI: IAppPDVDBI); reintroduce;
  end;

var
  PagPergForm: TPagPergForm;

implementation

{$R *.dfm}

constructor TPagPergForm.Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
  pPDVDBI: IAppPDVDBI);
begin
  inherited Create(AOwner);
  Caption := 'Inserir Forma de Pagamento...';
  FPDVVenda := pPDVVenda;
  FPDVDBI := pPDVDBI;
  FPDVDBI.PagamentoFormaPreencheDataSet(PagFormaFDMemTable);
end;

end.
