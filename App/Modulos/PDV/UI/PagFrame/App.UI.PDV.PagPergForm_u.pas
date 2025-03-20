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
  App.PDV.Factory_u, App.PDV.VendaPag, CustomEditBtu, CustomNumEditBtu;

type
  TPagPergForm = class(TDiagBasForm)
    FaltaLabel: TLabel;
    PagFormaDataSource: TDataSource;
    PagFormaDBGrid: TDBGrid;
    ToolBar1: TToolBar;
    CancelarToolButton: TToolButton;
    FormaPagObsLabel: TLabel;
    OkToolButton: TToolButton;
    EntreguePanel: TPanel;

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

    ValorEdit: TNumEditBtu;
    EntregueEdit: TNumEditBtu;
    TrocoEdit: TNumEditBtu;
    Label1: TLabel;

    procedure FormShow(Sender: TObject);

    procedure PagFormaFDMemTableAfterScroll(DataSet: TDataSet);
    procedure PagFormaDBGridColEnter(Sender: TObject);

    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CancelarToolButtonClick(Sender: TObject);

    procedure OkAct_DiagExecute(Sender: TObject);

    procedure ValorEditChange(Sender: TObject);
    procedure EntregueEditChange(Sender: TObject);

    procedure ValorEditKeyPress(Sender: TObject; var Key: Char);
    procedure EntregueEditKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    FPDVVenda: IPDVVenda;
    FPDVDBI: IAppPDVDBI;
    FFalta: Currency;
    FEntregueTestar: Boolean;

    FProcedurePagAppend: TVendaPagProcedure;
    FPagFormaTem: TVendaPagTesteForma;

    procedure AtualizeTroco;

    function ValorOk: Boolean;
    function ValorOk_NaoAceitaTroco: Boolean;
    function ValorOk_AceitaTroco: Boolean;

    function EntregueOk: Boolean;
    function PagFormaOk: Boolean;

    procedure DecidaEntregueVisivel;
    function PagFormaPodeInserir(pPagFormaId: TId): Boolean;
  protected
    procedure AjusteControles; override;
    function Voltou: Boolean; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
      pPDVDBI: IAppPDVDBI; pProcedurePagAppend: TVendaPagProcedure;
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
  try
    if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
    begin
      EntregueEdit.Valor := FFalta;
      EntreguePanel.Visible := True;
      TrySetFocus(EntregueEdit);
    end
    else
    begin
      TrySetFocus(ValorEdit);
      EntreguePanel.Visible := False;
    end;
  finally
    FEntregueTestar := True;
  end;
end;

procedure TPagPergForm.AtualizeTroco;
var
  v, r, t: Currency;
begin
  inherited;
  if not PagFormaFDMemTableACEITA_TROCO.AsBoolean then
    exit;

  v := ValorEdit.AsCurrency;
  r := EntregueEdit.AsCurrency;

  if (r = 0) or (r < v) then
    t := 0
  else
    t := r - v;

  TrocoEdit.Valor := t;
end;

procedure TPagPergForm.CancelarToolButtonClick(Sender: TObject);
begin
  inherited;
  Voltou;
end;

constructor TPagPergForm.Create(AOwner: TComponent; pPDVVenda: IPDVVenda;
  pPDVDBI: IAppPDVDBI; pProcedurePagAppend: TVendaPagProcedure;
  pPagFormaTem: TVendaPagTesteForma);
begin
  inherited Create(AOwner);
  AlteracaoTextoLabel.Free;

  FProcedurePagAppend := pProcedurePagAppend;
  FPagFormaTem := pPagFormaTem;

  Caption := 'Inserir Forma de Pagamento...';
  FPDVVenda := pPDVVenda;
  FPDVDBI := pPDVDBI;

  ValorEdit.TabOrder := 0;
  EntregueEdit.TabOrder := 1;
  TrocoEdit.TabStop := False;

  FEntregueTestar := True;
end;

procedure TPagPergForm.DecidaEntregueVisivel;
begin
  FEntregueTestar := False;
  try
    ValorEdit.Valor := FFalta;
    if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
    begin
      EntreguePanel.Visible := True;
      EntregueEdit.Valor := FFalta;
      TrySetFocus(EntregueEdit);
      ValorEdit.ReadOnly := True;
    end
    else
    begin
      EntregueEdit.Valor := 0;
      EntreguePanel.Visible := False;
      TrySetFocus(ValorEdit);
      ValorEdit.ReadOnly := False;
    end;
  finally
    FEntregueTestar := True;
  end;
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
  end;
end;

procedure TPagPergForm.FormShow(Sender: TObject);
begin
  inherited;
  FFalta := FPDVVenda.GetFalta;
  FaltaLabel.Caption := 'Falta: R$ ' + DinhToStr(FFalta);

  PagFormaFDMemTable.AfterScroll := nil;
  try
    FPDVDBI.PagFormaPreencheDataSet(PagFormaFDMemTable);
  finally
    PagFormaFDMemTable.AfterScroll := PagFormaFDMemTableAfterScroll;
  end;
  DecidaEntregueVisivel;

  MensLimpar;
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
  if not EntregueOk then
    exit;

  at := PagFormaFDMemTableACEITA_TROCO.AsBoolean;
  i := PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger;
//  r := EntregueEdit.AsCurrency;
//  t := TrocoEdit.AsCurrency;

  if at then
  begin
    v := EntregueEdit.ascurrency;

    if v >= FFalta then
    begin
      r := v;
      v := FFalta;
      t := r - v;
      if t < 0 then
        t := 0;
    end
    else
    begin
      r := EntregueEdit.ascurrency;
      t := 0;
    end;
  end
  else
  begin
    v := ValorEdit.AsCurrency;
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
  TrySetFocus(ValorEdit);
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

procedure TPagPergForm.EntregueEditChange(Sender: TObject);
begin
  inherited;
  AtualizeTroco;
  MensLimpar;
end;

procedure TPagPergForm.EntregueEditKeyPress(Sender: TObject; var Key: Char);
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

function TPagPergForm.EntregueOk: Boolean;
var
  v, r, t: Currency;
begin
  Result := not FEntregueTestar;
  if Result then
    exit;

  Result := not PagFormaFDMemTableACEITA_TROCO.AsBoolean;
  if Result then
    exit;

  v := EntregueEdit.AsCurrency;

  if v = 0 then
  begin
    V := FFalta;
    EntregueEdit.Valor := FFalta;
  end;

  Result := PagFormaOk;
  if not Result then
  begin
    FEntregueTestar := False;
    TrySetFocus(EntregueEdit);
    FEntregueTestar := True;
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
    ErroOutput.Exibir('Só pode haver um pagamento em dinheiro.'#13#10 +
      'Cancele o existente para inserir outro');
end;

procedure TPagPergForm.ValorEditChange(Sender: TObject);
begin
  inherited;
  AtualizeTroco;
  MensLimpar;
end;

procedure TPagPergForm.ValorEditKeyPress(Sender: TObject; var Key: Char);
var
  at: Boolean;
  v: Currency;
begin
  inherited;
  case Key of
    #13:
      begin
        Key := #0;
        if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
        begin
          TrySetFocus(EntregueEdit);
        end
        else
        begin
          OkAct_Diag.Execute
        end;
      end;
  end;
end;

function TPagPergForm.ValorOk: Boolean;
begin
  if PagFormaFDMemTableACEITA_TROCO.AsBoolean then
    Result := ValorOk_AceitaTroco
  else
    Result := ValorOk_NaoAceitaTroco;

//  v := ValorEdit.AsCurrency;
//
//  if not PagFormaFDMemTableACEITA_TROCO.AsBoolean then
//  begin
//    Result := v <= FFalta;
//    if not Result then
//    begin
//      ErroOutput.Exibir('Esta forma de pagamento não aceita troco');
//      FEntregueTestar := False;
//      TrySetFocus(ValorEdit);
//      FEntregueTestar := True;
//      exit;
//    end;
//  end;
//
//  Result := PagFormaOk;
//  if not Result then
//  begin
//    FEntregueTestar := False;
//    TrySetFocus(ValorEdit);
//    FEntregueTestar := True;
//    exit;
//  end;
//
//  Result := v > 0;
//  if not Result then
//  begin
//    ErroOutput.Exibir('O valor é obrigatório');
//    FEntregueTestar := False;
//    TrySetFocus(ValorEdit);
//    FEntregueTestar := True;
//    exit;
//  end;
end;

function TPagPergForm.ValorOk_AceitaTroco: Boolean;
begin
  Result := True;
  exit;
end;

function TPagPergForm.ValorOk_NaoAceitaTroco: Boolean;
var
  v: Currency;
begin
  v := ValorEdit.AsCurrency;

  Result := v = 0;
  if Result then
  begin
    v := FFalta;
    ValorEdit.Valor := v;
    Exit;
  end;

  Result := v <= FFalta;
  if not Result then
  begin
    ErroOutput.Exibir('Esta forma de pagamento não aceita troco');
    FEntregueTestar := False;
    TrySetFocus(ValorEdit);
    FEntregueTestar := True;
    exit;
  end;

  Result := PagFormaOk;
  if not Result then
  begin
    FEntregueTestar := False;
    TrySetFocus(ValorEdit);
    FEntregueTestar := True;
    exit;
  end;
end;

function TPagPergForm.Voltou: Boolean;
begin
  Result := inherited Voltou;
end;

end.
