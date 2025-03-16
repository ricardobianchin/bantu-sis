unit App.UI.FormEd.CxOperacao.Despesa_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, App.UI.Form.Ed.CxOperacao.UmValor_u,
  System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.Mask, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Sis.UI.Controls.ComboBoxManager,
  App.AppObj, App.Ent.Ed, App.Ent.DBI, App.Est.Venda.Caixa.CxValor.DBI;

type
  TCxOperDespesaEdForm = class(TCxOperUmValorEdForm)
    DespTIpoLabel: TLabel;
    DespTipoComboBox: TComboBox;
    FornecNomeLabeledEdit: TLabeledEdit;
    procedure FornecNomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure DespTipoComboBoxKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDespTipoComboBoxManager: IComboBoxManager;
  protected
    function GetSqlGarantir: string; override;
    function ControlesOk: boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj;
      pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI); override;
  end;

var
  CxOperDespesaEdForm: TCxOperDespesaEdForm;

implementation

{$R *.dfm}

uses App.Est.Venda.Caixa.CaixaSessaoOperacao.Ent, Sis.Types.Floats,
  Sis.Entities.Types, App.Est.Venda.Caixa.CaixaSessao.Utils_u,
  Sis.UI.Controls.Factory;

{ TCxOperDespesaEdForm }

function TCxOperDespesaEdForm.ControlesOk: boolean;
begin
  Result := inherited ControlesOk;
  if not Result then
    exit;

  if TrabPageControl.ActivePage = ValorTabSheet then
  begin
    Result := FDespTipoComboBoxManager.Id > 0;
    if not Result then
    begin
      ErroOutput.Exibir('Tipo de Despesa é obrigatório');
      FDespTipoComboBoxManager.SetFocus;
    end;
    exit;
  end;

end;

constructor TCxOperDespesaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pUsuarioId: integer; pUsuarioNomeExib: string; pEntEd: IEntEd;
  pEntDBI: IEntDBI; pCxValorDBI: ICxValorDBI);
begin
  inherited;
  FDespTipoComboBoxManager := ComboBoxManagerCreate(DespTipoComboBox);
  FDespTipoComboBoxManager.Clear;
  CxOperacaoDBI.PreencherDespTipoSL(DespTipoComboBox.Items);
  DespTipoComboBox.ItemIndex := -1;
end;

procedure TCxOperDespesaEdForm.DespTipoComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    SelectNext(TWinControl(Sender), True, True);
end;

procedure TCxOperDespesaEdForm.FornecNomeLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    SelectNext(TWinControl(Sender), True, True)
  else
    EditKeyPress(Sender, Key);
end;

function TCxOperDespesaEdForm.GetSqlGarantir: string;
var
  Ent: ICxOperacaoEnt;
  sProcName: string;
  sValores: string;
begin
  Ent := CxOperacaoEnt;

  if Ent.CxOperacaoTipo.Id <> cxopDespesa then
  begin
    raise Exception.Create('Form de despesas recebeu operação de outro tipo');
    exit;
  end;

  Result := 'SELECT'#13#10

    + 'SESS_ID_RET'#13#10 // 0
    + ', OPER_ORDEM_RET'#13#10 // 1
    + ', OPER_LOG_ID_RET'#13#10 // 2
    + ', OPER_TIPO_ORDEM_RET'#13#10 // 3
    + ', LOG_DTH'#13#10 // 4

    + 'FROM CAIXA_SESSAO_MANUT_PA.CAIXA_SESSAO_OPERACAO_DESPESA_INSERIR_DO'#13#10

    + '('#13#10 //

    + '  ' + Ent.CaixaSessao.LojaId.ToString + ' -- loja_id'#13#10 //
    + '  , ' + Ent.CaixaSessao.TerminalId.ToString + ' -- terminal_id'#13#10 //
    + '  , ' + Ent.CaixaSessao.Id.ToString + ' -- sess id'#13#10 //
    + '  , null' + ' -- oper ordem'#13#10 // + Ent.OperOrdem.ToString //
    + '  , ' + Ent.CxOperacaoTipo.Id.ToSqlConstant + ' -- oper tipo'#13#10 //
    + '  , ' + Ent.LogId.ToString + ' -- log id'#13#10 //
    + '  , null' + ' -- tipo ordem'#13#10 // + Ent.OperTipoOrdem.ToString //
    + '  , ' + CurrencyToStrPonto(Ent.Valor) + ' -- valor'#13#10 //
    + '  , ' + QuotedStr(Ent.obs) + ' -- obs'#13#10 //

    + '  , ' + UsuarioId.ToString + ' -- usu id'#13#10 //
    + '  , ' + Ent.CaixaSessao.MachineIdentId.ToString + ' -- machine id'#13#10
  //
    + '  , ' + QuotedStr(Ent.CxValorList.AsList) + ' -- valor list'#13#10 //
    + '  , ' + QuotedStr(Ent.CxValorList.NumerarioAsList) +
    ' -- numerario list'#13#10 //
    + '  , ' + FDespTipoComboBoxManager.Id.ToString //
    + '  , ' + QuotedStr(Trim(FornecNomeLabeledEdit.Text)) + ' -- numerario list'#13#10 //
    + ', FORNEC_NOME'#13#10 //
    + ', NUMDOC'#13#10 //

    + ');' //
    ;

  // {$IFDEF DEBUG}
  // CopyTextToClipboard(Result);
  // {$ENDIF}

end;

end.
