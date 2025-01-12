unit App.UI.PDV.PagPergForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Sis.Types,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, App.PDV.DBI, App.PDV.Venda,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, NumEditBtu,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, FireDAC.Stan.StorageBin,
  App.PDV.Factory_u, App.PDV.VendaPag;

type
  TPagPergForm = class(TDiagBasForm)
    FaltaLabel: TLabel;
    PagFormaDataSource: TDataSource;
    PagFormaDBGrid: TDBGrid;
    ToolBar1: TToolBar;
    ValorFaltaToolButton: TToolButton;
    CancelarToolButton: TToolButton;
    FormaPagObsLabel: TLabel;
    OkToolButton: TToolButton;
    MoldeValorLabeledEdit: TLabeledEdit;
    EntreguePanel: TPanel;
    Label1: TLabel;
    MoldeTrocoLabeledEdit: TLabeledEdit;
    MoldeEntregueLabeledEdit: TLabeledEdit;
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
    PagFormaFDMemTableACEITA_TROCO: TBooleanField;

    procedure PagFormaFDMemTableAfterScroll(DataSet: TDataSet);
    procedure PagFormaDBGridColEnter(Sender: TObject);

    procedure MoldeValorLabeledEditChange(Sender: TObject);
    procedure MoldeValorLabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure MoldeEntregueLabeledEditChange(Sender: TObject);
    procedure MoldeEntregueLabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure ValorFaltaToolButtonClick(Sender: TObject);
    procedure CancelarToolButtonClick(Sender: TObject);

  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
    FPDVDBI: IAppPDVDBI;
    FValorEdit: TNumEditBtu;
    FEntregueEdit: TNumEditBtu;
    FTrocoEdit: TNumEditBtu;
    FFalta: Currency;
    FRecebitoTestar: Boolean;

    FProcedurePagAppend: TVendaPagProcedure;
    FPagFormaTem: TVendaPagTesteForma;

    procedure PegueValor;
    procedure AtualizeTroco;
    procedure FaltaColar;

    function ValorOk: Boolean;
    function EntregueOk(pVal, pRec: Currency): Boolean;

    procedure ValorLabeledEditExit(Sender: TObject);
    procedure EntregueLabeledEditExit(Sender: TObject);
    procedure DecidaRecebidoVisivel;
    function PagFormaPodeInserir(pPagFormaId: TId): Boolean;
    function NovoPagCreate: IVendaPag;
  protected
    procedure AjusteControles; override;
    function Voltou: Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
      pPDVDBI: IAppPDVDBI;
      pProcedurePagAppend: TVendaPagProcedure;
      pPagFormaTem: TVendaPagTesteForma); reintroduce;
  end;

var
  PagPergForm: TPagPergForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.Floats;

procedure TPagPergForm.AjusteControles;
begin
  inherited;
  TrySetFocus(FValorEdit);
end;

procedure TPagPergForm.AtualizeTroco;
var
  r, v, t: Currency;
begin
  inherited;
  r := FEntregueEdit.AsCurrency;
  v := FValorEdit.AsCurrency;

  if (r = 0) or (r < v) then
    t := 0
  else
    t := r - v;

  FTrocoEdit.Valor := t;
end;

procedure TPagPergForm.CancelarToolButtonClick(Sender: TObject);
begin
  inherited;
  Voltou;
end;

constructor TPagPergForm.Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
  pPDVDBI: IAppPDVDBI;
  pProcedurePagAppend: TVendaPagProcedure;
  pPagFormaTem: TVendaPagTesteForma);
begin
  inherited Create(AOwner);
  AlteracaoTextoLabel.Free;

  FProcedurePagAppend := pProcedurePagAppend;
  FPagFormaTem := pPagFormaTem;

  Caption := 'Inserir Forma de Pagamento...';
  FPDVVenda := pPDVVenda;
  FPDVDBI := pPDVDBI;

  FFalta := FPDVVenda.GetFalta;

  FaltaLabel.Caption := 'Falta: R$ ' + DinhToStr(FFalta);

  FValorEdit := TNumEditBtu.Create(Self);
  FValorEdit.Alignment := taRightJustify;
  FValorEdit.NCasas := 2;
  FValorEdit.NCasasEsq := 7;
  FValorEdit.MascEsq := '######0';
  FValorEdit.Caption := MoldeValorLabeledEdit.EditLabel.Caption;
  FValorEdit.LabelPosition := lpLeft;
  FValorEdit.LabelSpacing := MoldeValorLabeledEdit.LabelSpacing;
  FValorEdit.Valor := FFalta;
  FValorEdit.EditLabel.Font.Assign(FValorEdit.Font);

  PegueFormatoDe(FValorEdit, MoldeValorLabeledEdit);

  FEntregueEdit := TNumEditBtu.Create(Self);
  FEntregueEdit.Alignment := taRightJustify;
  FEntregueEdit.NCasas := 2;
  FEntregueEdit.NCasasEsq := 7;
  FEntregueEdit.MascEsq := '######0';
  FEntregueEdit.Caption := MoldeEntregueLabeledEdit.EditLabel.Caption;
  FEntregueEdit.LabelPosition := lpLeft;
  FEntregueEdit.LabelSpacing := FValorEdit.LabelSpacing;
  FEntregueEdit.Valor := 0;
  FEntregueEdit.EditLabel.Font.Assign(FValorEdit.Font);

  PegueFormatoDe(FEntregueEdit, MoldeEntregueLabeledEdit);

  FTrocoEdit := TNumEditBtu.Create(Self);
  FTrocoEdit.Alignment := taRightJustify;
  FTrocoEdit.NCasas := 2;
  FTrocoEdit.NCasasEsq := 7;
  FTrocoEdit.MascEsq := '######0';
  FTrocoEdit.Caption := MoldeTrocoLabeledEdit.EditLabel.Caption;
  FTrocoEdit.LabelPosition := lpLeft;
  FTrocoEdit.LabelSpacing := FValorEdit.LabelSpacing;
  FTrocoEdit.Valor := 0;
  FTrocoEdit.ReadOnly := True;
  FTrocoEdit.EditLabel.Font.Assign(FValorEdit.Font);

  PegueFormatoDe(FTrocoEdit, MoldeTrocoLabeledEdit);

  FValorEdit.TabOrder := 0;
  FEntregueEdit.TabOrder := 1;
  FTrocoEdit.TabStop := False;

  FValorEdit.OnChange := MoldeValorLabeledEditChange;
  FValorEdit.OnKeyPress := MoldeValorLabeledEditKeyPress;
  FValorEdit.OnExit := ValorLabeledEditExit;

  FEntregueEdit.OnChange := MoldeEntregueLabeledEditChange;
  FEntregueEdit.OnKeyPress := MoldeEntregueLabeledEditKeyPress;
  FEntregueEdit.OnExit := EntregueLabeledEditExit;

  FRecebitoTestar := True;

  PagFormaFDMemTable.AfterScroll := nil;

  FPDVDBI.PagFormaPreencheDataSet(PagFormaFDMemTable);
  PagFormaFDMemTable.AfterScroll := PagFormaFDMemTableAfterScroll;
  DecidaRecebidoVisivel;
end;

procedure TPagPergForm.DecidaRecebidoVisivel;
begin
  if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
  begin
    FEntregueEdit.Valor := 0;
    // FTrocoEdit.Valor := 0;
    EntreguePanel.Visible := True;
  end
  else
  begin
    TrySetFocus(FValorEdit);
    EntreguePanel.Visible := False;
  end;
end;

procedure TPagPergForm.FaltaColar;
begin
  FValorEdit.Valor := FFalta;
end;

procedure TPagPergForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_UP:
      begin
        PagFormaFDMemTable.Prior;
      end;
    VK_DOWN:
      begin
        PagFormaFDMemTable.Next;
      end;
    VK_F3:
      FaltaColar;
  end;
end;

procedure TPagPergForm.MoldeEntregueLabeledEditChange(Sender: TObject);
begin
  inherited;
  AtualizeTroco;
  MensLimpar;
end;

procedure TPagPergForm.MoldeEntregueLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case Key of
    #13:
      begin
        Key := #0;
        PegueValor;
      end;
  end;
end;

procedure TPagPergForm.MoldeValorLabeledEditChange(Sender: TObject);
begin
  inherited;
  AtualizeTroco;
  MensLimpar;
end;

procedure TPagPergForm.MoldeValorLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case Key of
    #13:
      begin
        Key := #0;
        if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
        begin
          FEntregueEdit.SetFocus;
          exit;
        end;
        PegueValor;
      end;
  end;
end;

function TPagPergForm.NovoPagCreate: IVendaPag;
var
  uDevido, uEntregue, uTroco: Currency;
begin
  uDevido := FValorEdit.AsCurrency;
  if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
  begin
    uEntregue := FEntregueEdit.AsCurrency;
    uTroco := FTrocoEdit.AsCurrency;
  end
  else
  begin
    uEntregue := 0;
    uTroco := 0;
  end;

  Result := VendaPagCreate( //
    FPDVVenda.VendaPagList.GetProximaOrdem,
    PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger,
    PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID.AsString,
    PagFormaFDMemTableTIPO_DESCR_RED.AsString,
    PagFormaFDMemTableFORMA_DESCR.AsString, uDevido, uEntregue, uTroco, False);

  {

    AValorDevido, AValorEntregue, ATroco: Currency;
    ACancelado: Boolean)
    : IVendaPag;
    begin
    Result := TVendaPag.Create(AOrdem, APagamentoFormaId, APagamentoFormaTipoId,
    APagamentoFormaTipoDescrRed, APagamentoFormaDescr, AValorDevido,
    AValorEntregue, ATroco, ACancelado);
    end;


    PagFormaFDMemTableVALOR_MINIMO: TCurrencyField;
    PagFormaFDMemTablePROMOCAO_PERMITE: TBooleanField;
    PagFormaFDMemTableTEF_USA: TBooleanField;
    PagFormaFDMemTableAUTORIZACAO_EXIGE: TBooleanField;
    PagFormaFDMemTablePESSOA_EXIGE: TBooleanField;
    PagFormaFDMemTableACEITA_TROCO: TBooleanField;

  }
end;

procedure TPagPergForm.PagFormaDBGridColEnter(Sender: TObject);
begin
  inherited;
  TrySetFocus(FValorEdit);
end;

procedure TPagPergForm.PagFormaFDMemTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  DecidaRecebidoVisivel;
end;

procedure TPagPergForm.PegueValor;
var
  v, r, t: Currency;
  i: integer;
  oPag: IVendaPag;
begin
  inherited;
  if not ValorOk then
    exit;

  v := FValorEdit.AsCurrency;
  r := FEntregueEdit.AsCurrency;
  t := 0;

  if not EntregueOk(v, r) then
    exit;

  if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
  begin
    if r > 0 then
      t := r - v;
  end;

  i := PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger;
  if not PagFormaPodeInserir(i) then
    exit;

  FPDVDBI.PagInserir(i, v, r, t);

  oPag := NovoPagCreate;

  FProcedurePagAppend(oPag);

  ModalResult := mrOk;
end;

procedure TPagPergForm.EntregueLabeledEditExit(Sender: TObject);
var
  v, r, t: Currency;
  i: integer;
begin
  inherited;
  v := FValorEdit.AsCurrency;
  r := FEntregueEdit.AsCurrency;

  EntregueOk(v, r);
end;

function TPagPergForm.EntregueOk(pVal, pRec: Currency): Boolean;
begin
  Result := PagFormaPodeInserir(PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger);
  if not Result then
  begin
    TrySetFocus(FValorEdit);
    exit;
  end;

  Result := not FRecebitoTestar;
  if Result then
    exit;

  Result := not PagFormaFDMemTableACEITA_TROCO.AsBoolean;
  if Result then
    exit;

  Result := (pRec = 0) or (pRec >= pVal);
  if not Result then
  begin
    ErroOutput.Exibir('''Recebido'' deve ser zero ou maior do que o ''Valor''');
    FEntregueEdit.SetFocus;
    exit;
  end;
end;

function TPagPergForm.PagFormaPodeInserir(pPagFormaId: TId): Boolean;
begin
  Result := pPagFormaId > 1;
  if Result then
    exit;

  Result := not FPagFormaTem(1);

  if not Result then
    ErroOutput.Exibir
      ('Só pode haver um pagamento em dinheiro.'#13#10+
        'Cancele o existente para inserir outro');
end;

procedure TPagPergForm.ValorFaltaToolButtonClick(Sender: TObject);
begin
  inherited;
  FaltaColar;
end;

procedure TPagPergForm.ValorLabeledEditExit(Sender: TObject);
begin
  inherited;
  ValorOk;
end;

function TPagPergForm.ValorOk: Boolean;
var
  v: Currency;
begin
  Result := PagFormaPodeInserir(PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger);
  if not Result then
  begin
    TrySetFocus(FValorEdit);
    exit;
  end;

  v := FValorEdit.AsCurrency;

  Result := v > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O valor é obrigatório');
    TrySetFocus(FValorEdit);
    exit;
  end;

  Result := v <= FFalta;
  if Result then
    exit;

  if not PagFormaFDMemTableACEITA_TROCO.AsBoolean then
  begin
    ErroOutput.Exibir('O valor não pode ser maior do que o faltante');
    TrySetFocus(FValorEdit);
    exit;
  end;

  FValorEdit.Valor := FFalta;
  FEntregueEdit.Valor := v;
end;

function TPagPergForm.Voltou: Boolean;
begin
  Result := FEntregueEdit.Focused;
  if Result then
  begin
    FRecebitoTestar := False;
    TrySetFocus(FValorEdit);
    FRecebitoTestar := True;
    exit;
  end;

  Result := inherited Voltou;
end;

end.
