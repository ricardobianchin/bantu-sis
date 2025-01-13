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

    procedure FormShow(Sender: TObject);

    procedure PagFormaFDMemTableAfterScroll(DataSet: TDataSet);
    procedure PagFormaDBGridColEnter(Sender: TObject);

    procedure MoldeValorLabeledEditChange(Sender: TObject);
    procedure MoldeValorLabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure MoldeEntregueLabeledEditChange(Sender: TObject);
    procedure MoldeEntregueLabeledEditKeyPress(Sender: TObject; var Key: Char);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    procedure ValorFaltaToolButtonClick(Sender: TObject);
    procedure CancelarToolButtonClick(Sender: TObject);
    procedure OkAct_DiagExecute(Sender: TObject);

  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
    FPDVDBI: IAppPDVDBI;
    FValorEdit: TNumEditBtu;
    FEntregueEdit: TNumEditBtu;
    FTrocoEdit: TNumEditBtu;
    FFalta: Currency;
    FEntregueTestar: Boolean;

    FProcedurePagAppend: TVendaPagProcedure;
    FPagFormaTem: TVendaPagTesteForma;

    procedure AtualizeTroco;
    procedure FaltaColar;

    function ValorOk: Boolean;
    function EntregueOk: Boolean;
    function PagFormaOk: Boolean;

    procedure ValorLabeledEditExit(Sender: TObject);
    procedure EntregueLabeledEditExit(Sender: TObject);

    procedure DecidaEntregueVisivel;
    function PagFormaPodeInserir(pPagFormaId: TId): Boolean;
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
  FEntregueTestar := False;
  TrySetFocus(FValorEdit);
  FEntregueTestar := True;
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

  FValorEdit := TNumEditBtu.Create(Self);
  FValorEdit.Alignment := taRightJustify;
  FValorEdit.NCasas := 2;
  FValorEdit.NCasasEsq := 7;
  FValorEdit.MascEsq := '######0';
  FValorEdit.Caption := MoldeValorLabeledEdit.EditLabel.Caption;
  FValorEdit.LabelPosition := lpLeft;
  FValorEdit.LabelSpacing := MoldeValorLabeledEdit.LabelSpacing;
  FValorEdit.AutoExit := False;
  FValorEdit.EditLabel.Font.Assign(MoldeValorLabeledEdit.Font);

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
  FEntregueEdit.AutoExit := False;
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

  FEntregueTestar := True;
end;

procedure TPagPergForm.DecidaEntregueVisivel;
begin
  if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
  begin
    FEntregueEdit.Valor := 0;
    // FTrocoEdit.Valor := 0;
    EntreguePanel.Visible := True;
  end
  else
  begin
    FEntregueTestar := False;
    TrySetFocus(FValorEdit);
    FEntregueTestar := True;
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

procedure TPagPergForm.FormShow(Sender: TObject);
begin
  inherited;
  FFalta := FPDVVenda.GetFalta;
  FaltaLabel.Caption := 'Falta: R$ ' + DinhToStr(FFalta);
  FValorEdit.Valor := FFalta;
  FEntregueEdit.Valor := 0;

  FEntregueTestar := False;
  TrySetFocus(FValorEdit);
  FEntregueTestar := True;

  PagFormaFDMemTable.AfterScroll := nil;
  FPDVDBI.PagFormaPreencheDataSet(PagFormaFDMemTable);
  PagFormaFDMemTable.AfterScroll := PagFormaFDMemTableAfterScroll;
  DecidaEntregueVisivel;

  MensLimpar;
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
        OkAct_Diag.Execute
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
var
  at: Boolean;
  v: Currency;
begin
  inherited;
  case Key of
    #13:
      begin
        Key := #0;
        at := PagFormaFDMemTableACEITA_TROCO.AsBoolean;
        if at then
        begin
          V := FValorEdit.AsCurrency;
          if V < FFalta then
          begin
            FEntregueEdit.SetFocus;
            exit;
          end;
        end;

        OkAct_Diag.Execute
      end;
  end;
end;

procedure TPagPergForm.OkAct_DiagExecute(Sender: TObject);
var
  at: Boolean;
  v, r, t: Currency;
  i: integer;
  oPag: IVendaPag;
begin
  if not ValorOk then
    exit;
  if not entregueok then
    exit;

  at := PagFormaFDMemTableACEITA_TROCO.AsBoolean;
  i := PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger;
  v := FValorEdit.AsCurrency;
  r := FEntregueEdit.AsCurrency;
  t := FTrocoEdit.AsCurrency;

  if at then
  begin
    if v >= FFalta then
    begin
      r := v;
      v := FFalta;
      t := r - v;
    end;
  end
  else
  begin
    r := v;
    t := 0;
  end;

  FPDVDBI.PagInserir(i, v, r, t);

  oPag := VendaPagCreate( //
    FPDVVenda.VendaPagList.GetProximaOrdem,
    PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger,
    PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID.AsString,
    PagFormaFDMemTableTIPO_DESCR_RED.AsString,
    PagFormaFDMemTableFORMA_DESCR.AsString, v, r, t, False);

  FPDVVenda.VendaPagList.Add(oPag);

  FProcedurePagAppend(oPag);
  inherited;
end;

procedure TPagPergForm.PagFormaDBGridColEnter(Sender: TObject);
begin
  inherited;
  FEntregueTestar := False;
  TrySetFocus(FValorEdit);
  FEntregueTestar := True;
end;

procedure TPagPergForm.PagFormaFDMemTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  DecidaEntregueVisivel;
end;

function TPagPergForm.PagFormaOk: Boolean;
begin
  Result := PagFormaPodeInserir(PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger);
end;

procedure TPagPergForm.EntregueLabeledEditExit(Sender: TObject);
begin
  inherited;
  EntregueOk;
end;

function TPagPergForm.EntregueOk: Boolean;
var
  v, r, t: Currency;
begin
  Result := not FEntregueTestar;
  if Result then
    exit;

  Result := not IsPositiveResult( ModalResult);
  if Result then
    exit;

  Result := not PagFormaFDMemTableACEITA_TROCO.AsBoolean;
  if Result then
    exit;

  Result := PagFormaOk;
  if not Result then
  begin
    FEntregueTestar := False;
    TrySetFocus(FValorEdit);
    FEntregueTestar := True;
    exit;
  end;

  v := FValorEdit.AsCurrency;
  r := FEntregueEdit.AsCurrency;
  Result := (r = 0) or ( r >= v);
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
  Result := not IsPositiveResult( ModalResult);
  if Result then
    exit;

  Result := PagFormaOk;
  if not Result then
  begin
    FEntregueTestar := False;
    TrySetFocus(FValorEdit);
    FEntregueTestar := True;
    exit;
  end;

  v := FValorEdit.AsCurrency;

  Result := v > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O valor é obrigatório');
    FEntregueTestar := False;
    TrySetFocus(FValorEdit);
    FEntregueTestar := True;
    exit;
  end;
end;

function TPagPergForm.Voltou: Boolean;
begin
  Result := FEntregueEdit.Focused;
  if Result then
  begin
    FEntregueTestar := False;
    TrySetFocus(FValorEdit);
    FEntregueTestar := True;
    exit;
  end;

  Result := inherited Voltou;
end;

end.
