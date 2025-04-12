unit App.PDV.PDVSessForm.FiltroFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.Filtro_u, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, System.Actions,
  Vcl.ActnList;

type
  TSessFormFiltroFrame = class(TFiltroFrame)
    FundoPanel: TPanel;
    ErroLabel: TLabel;
    TitPanel: TPanel;
    TitLabel: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    ProdSelectAction: TAction;
    ProdLimparAction: TAction;
    VendaCheckBox: TCheckBox;
    CxOperCheckBox: TCheckBox;
    VendasPanel: TPanel;
    PagFormaLabel: TLabel;
    PagFormaComboBox: TComboBox;
    ProdLabeledEdit: TLabeledEdit;
    ProdToolBar: TToolBar;
    ProdSelectToolButton: TToolButton;
    ToolButton2: TToolButton;
    procedure CxOperCheckBoxClick(Sender: TObject);
    procedure VendaCheckBoxClick(Sender: TObject);
    procedure PagFormaComboBoxChange(Sender: TObject);
    procedure ProdSelectActionExecute(Sender: TObject);
    procedure ProdLimparActionExecute(Sender: TObject);
  private
    { Private declarations }
    FProdIdSelecionado: integer;
    FPagFormaIdSelecionado: integer;
  protected
    function GetValues: variant; override;
    procedure SetValues(Value: variant); override;
    function NewArrayCreate: variant; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pOnChange: TNotifyEvent);
      override;
  end;

var
  SessFormFiltroFrame: TSessFormFiltroFrame;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, Sis.UI.Controls.Utils;

{ TSessFormFiltroFrame }

procedure TSessFormFiltroFrame.CxOperCheckBoxClick(Sender: TObject);
begin
  inherited;
  DoChange;
end;

constructor TSessFormFiltroFrame.Create(AOwner: TComponent;
  pOnChange: TNotifyEvent);
begin
  inherited;
  ReadOnlySet(ProdLabeledEdit, True);
  FProdIdSelecionado := 0;
  FPagFormaIdSelecionado := 0;
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

procedure TSessFormFiltroFrame.ProdLimparActionExecute(Sender: TObject);
begin
  inherited;
  DoChange;
end;

procedure TSessFormFiltroFrame.ProdSelectActionExecute(Sender: TObject);
begin
  inherited;
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
