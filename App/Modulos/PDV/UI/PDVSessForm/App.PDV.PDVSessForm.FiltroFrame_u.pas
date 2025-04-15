unit App.PDV.PDVSessForm.FiltroFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, System.Actions,
  Vcl.ActnList, App.Est.Venda.CaixaSessao.DBI, Sis.UI.Controls.ComboBoxManager,
  Sis.UI.Select;

type
  TSessFormFiltroFrame = class(TFiltroFrame)
    FundoPanel: TPanel;
    ErroLabel: TLabel;
    TitPanel: TPanel;
    TitLabel: TLabel;
    TitToolBar: TToolBar;
    TitFecharToolButton: TToolButton;
    ActionList1: TActionList;

    CxOperCheckBox: TCheckBox;
    VendaCheckBox: TCheckBox;
    PagFormaComboBox: TComboBox;
    ProdLabeledEdit: TLabeledEdit;

    ProdSelectAction: TAction;
    ProdLimparAction: TAction;
    ProdToolBar: TToolBar;
    ProdSelectToolButton: TToolButton;
    ProdLimparToolButton: TToolButton;
    LimparFiltroToolButton: TToolButton;

    VendasPanel: TPanel;
    PagFormaLabel: TLabel;
    FiltroToolBar: TToolBar;
    FiltroLimparAction: TAction;
    procedure CxOperCheckBoxClick(Sender: TObject);
    procedure VendaCheckBoxClick(Sender: TObject);
    procedure PagFormaComboBoxChange(Sender: TObject);
    procedure ProdSelectActionExecute(Sender: TObject);
    procedure ProdLimparActionExecute(Sender: TObject);
    procedure FiltroLimparActionExecute(Sender: TObject);
    procedure ProdLabeledEditClick(Sender: TObject);
  private
    { Private declarations }
    FProdIdSelecionado: integer;
    FCaixaSessaoDBI: ICaixaSessaoDBI;
    FPagFormaComboBoxManager: IComboBoxManager;
    FProdSelect: ISelect;
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent;
      pCaixaSessaoDBI: ICaixaSessaoDBI; pProdSelect: ISelect); reintroduce;
  end;

var
  SessFormFiltroFrame: TSessFormFiltroFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Controls.Utils, Sis.UI.Controls.Factory, Sis.Types.strings_u, System.Generics.Collections;

{ TSessFormFiltroFrame }

procedure TSessFormFiltroFrame.CxOperCheckBoxClick(Sender: TObject);
begin
  inherited;
  DoChange;
end;

procedure TSessFormFiltroFrame.FiltroLimparActionExecute(Sender: TObject);
begin
  inherited;
  ProcessaFiltro := False;
  try
    CxOperCheckBox.Checked := True;
    VendaCheckBox.Checked := True;
    PagFormaComboBox.ItemIndex := 0;
    ProdLimparAction.Execute;
  finally
    ProcessaFiltro := True;
    DoChange;
  end;
end;

constructor TSessFormFiltroFrame.Create(AOwner: TComponent;
  pOnChange: TNotifyEvent; pCaixaSessaoDBI: ICaixaSessaoDBI;
  pProdSelect: ISelect);
begin
  inherited Create(AOwner, pOnChange);
  FCaixaSessaoDBI := pCaixaSessaoDBI;
  ReadOnlySet(ProdLabeledEdit, True);
  FPagFormaComboBoxManager := ComboBoxManagerCreate(PagFormaComboBox);
  FProdIdSelecionado := 0;
  FCaixaSessaoDBI.PreencherPagamentoFormaFiltroSL(PagFormaComboBox.Items);
  PagFormaComboBox.ItemIndex := 0;
  FProdSelect := pProdSelect;
  FiltroLimparAction.Execute;
  ProcessaFiltro := True;
end;

{
  bExibeCxOper  pValues[0]
  bExibeVendas  pValues[1]
  iPagFormaId   pValues[2]
  iProdCod      pValues[3]
}

function TSessFormFiltroFrame.GetValues: variant;
begin
  Result := inherited;
  Result[0] := CxOperCheckBox.Checked;
  Result[1] := VendaCheckBox.Checked;
  Result[2] := FPagFormaComboBoxManager.Id;
  Result[3] := FProdIdSelecionado;
end;

function TSessFormFiltroFrame.NewArrayCreate: variant;
begin
  Result := VarArrayCreate([0, 3], varVariant);
end;

procedure TSessFormFiltroFrame.PagFormaComboBoxChange(Sender: TObject);
begin
  inherited;
  DoChange;

end;

procedure TSessFormFiltroFrame.ProdLabeledEditClick(Sender: TObject);
begin
  inherited;
  ProdSelectAction.Execute
end;

procedure TSessFormFiltroFrame.ProdLimparActionExecute(Sender: TObject);
begin
  inherited;
  FProdIdSelecionado := 0;
  ProdLabeledEdit.Text := '<TODOS OS PRODUTOS>';
  DoChange;
end;

procedure TSessFormFiltroFrame.ProdSelectActionExecute(Sender: TObject);
var
  s: string;
  aStrings: TArray<string>;
begin
  inherited;
  if not FProdSelect.Execute() then
    exit;

  s := FProdSelect.LastSelected;

  aStrings := s.Split([';']);

  FProdIdSelecionado := StrToInt(aStrings[0]);

  ProdLabeledEdit.Text := aStrings[0] + ' - ' + aStrings[1];

  DoChange;
end;

procedure TSessFormFiltroFrame.SetValues(Value: variant);
begin
  inherited;
  CxOperCheckBox.Checked := Value[0];
  VendaCheckBox.Checked := Value[0];
end;

procedure TSessFormFiltroFrame.VendaCheckBoxClick(Sender: TObject);
begin
  inherited;
  DoChange;
end;

end.
