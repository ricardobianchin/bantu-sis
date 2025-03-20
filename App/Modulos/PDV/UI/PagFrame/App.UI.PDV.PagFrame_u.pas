unit App.UI.PDV.PagFrame_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.PDV.VendaBasFrame_u, Vcl.ExtCtrls, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.StorageBin,
  Vcl.ToolWin, Vcl.ComCtrls, App.PDV.VendaPag, Sis.Types;

type
  TPagPDVFrame = class(TVendaBasPDVFrame)
    TotPanel: TPanel;
    PagoLabel: TLabel;
    TotLabel: TLabel;
    FaltaLabel: TLabel;
    TrocoLabel: TLabel;
    DBGrid1: TDBGrid;
    VendaPagDataSource: TDataSource;
    BasePanel: TPanel;
    ToolBar1: TToolBar;
    PagPergToolButton: TToolButton;
    VendaPagFDMemTable: TFDMemTable;
    VendaPagFDMemTableOrdem: TSmallintField;
    VendaPagFDMemTablePagamentoFormaTipoDescrRed: TStringField;
    VendaPagFDMemTableDescr: TStringField;
    VendaPagFDMemTableDevido: TCurrencyField;
    VendaPagFDMemTableCancelado: TBooleanField;
    VoltarToolButton: TToolButton;
    CancelarToolButton: TToolButton;
    MensLabel: TLabel;
    FinalizarToolButton: TToolButton;
    procedure VoltarToolButtonClick(Sender: TObject);
    procedure PagPergToolButtonClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CancelarToolButtonClick(Sender: TObject);
    procedure VendaPagFDMemTableAfterScroll(DataSet: TDataSet);
    procedure FinalizarToolButtonClick(Sender: TObject);
  private
    { Private declarations }

    uTotalLiquido: Currency;
    uTotalDevido: Currency;
    uTotalEntregue: Currency;
    uFalta: Currency;
    uTroco: Currency;

    procedure ExibaErro(pFrase: string);

    procedure PreenchaTotais;
    procedure PreenchaVendaPagFDMemTable;
    procedure PagInsiraReg(pPag: IVendaPag);
    function PagFormaTem(pPagFormaId: TId): Boolean;
    procedure PagCancelar;

    // TECLADO KEYDOWN
    procedure ExecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); override;

    // TECLADO PRESS
    procedure ExecKeyPress(Sender: TObject; var Key: Char); override;
    procedure ExibaControles; override;
  public
    { Public declarations }
    procedure PagSomenteDinheiro;
    procedure DimensioneControles; override;
    procedure PagPerg;
    property Falta: Currency read uFalta;

  end;

var
  PagPDVFrame: TPagPDVFrame;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, App.UI.PDV.PagPergForm_u, Sis.Types.Floats,
  Sis.UI.IO.Input.Perg, App.PDV.Factory_u;

{ TPagPDVFrame }

procedure TPagPDVFrame.CancelarToolButtonClick(Sender: TObject);
begin
  inherited;
  PagCancelar;
end;

procedure TPagPDVFrame.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_INSERT:
      PagPerg;
    VK_DELETE:
      PagCancelar;
  end;
end;

procedure TPagPDVFrame.DimensioneControles;
begin
  inherited;
  MeioPanel.Width := 800;
  MeioPanel.Height := 550;
  MeioPanel.BevelOuter := bvNone;
  TotPanel.BevelOuter := bvNone;

  ControlAlignToRect(MeioPanel, Self.ClientRect);

  PreenchaTotais;

  DBGrid1.SetFocus;

  PreenchaVendaPagFDMemTable;

  Application.ProcessMessages;
end;

procedure TPagPDVFrame.ExecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  // case Key of
  // vk_delete:
  // PagCancelar;
  // end;
end;

procedure TPagPDVFrame.ExecKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  case Key of
    #27:
      begin
        Key := #0;
        PDVControlador.VaParaVenda;
      end;
    #13:
      begin
        Key := #0;
        if uFalta > 0 then
          PagPerg
        else
          PDVControlador.VaParaFinaliza;
      end;
  end;
end;

procedure TPagPDVFrame.ExibaControles;
begin
  PreenchaTotais;
  inherited;

end;

procedure TPagPDVFrame.ExibaErro(pFrase: string);
begin
  if pFrase = '' then
  begin
    MensLabel.Visible := False;
    exit;
  end;
  MensLabel.Visible := True;
  MensLabel.Caption := pFrase;
end;

procedure TPagPDVFrame.FinalizarToolButtonClick(Sender: TObject);
begin
  inherited;
  if uFalta > 0 then
    PagPerg
  else
    PDVControlador.VaParaFinaliza;
end;

procedure TPagPDVFrame.PagSomenteDinheiro;
var
  oPag: IVendaPag;
  V, r, t: Currency;
begin
  V := PDVVenda.GetItensPrecoTot;
  r := V;
  t := 0;

  oPag := VendaPagCreate( //
    PDVVenda.VendaPagList.GetProximaOrdem, 1,
    // PagFormaFDMemTablePAGAMENTO_FORMA_ID.AsInteger,
    #33, // PagFormaFDMemTablePAGAMENTO_FORMA_TIPO_ID.AsString,
    'DIN', // PagFormaFDMemTableTIPO_DESCR_RED.AsString,
    'DINHEIRO', // PagFormaFDMemTableFORMA_DESCR.AsString
    V, r, t, False);

  PDVVenda.VendaPagList.Add(oPag);

  PDVDBI.PagSomenteDinheiro;
  // PDVVenda.Finalizado := True; // evita que tente salvar de novo
  // PDVControlador.VaParaFinaliza;
end;

procedure TPagPDVFrame.PagCancelar;
var
  Resultado: Boolean;
  iOrdem: SmallInt;
begin
  ExibaErro('');
  if VendaPagFDMemTable.IsEmpty then
  begin
    ExibaErro('Não há pagamento a cancelar');
    exit;
  end;

  if VendaPagFDMemTableCancelado.AsBoolean then
  begin
    ExibaErro('Pagamento já cancelado');
    exit;
  end;

  Resultado := PergBool('Deseja cancelar o pagamento?');
  if not Resultado then
    exit;

  iOrdem := VendaPagFDMemTableOrdem.AsInteger - 1;
  PDVDBI.PagCancelar(iOrdem);

  PDVVenda.VendaPagList[iOrdem].Cancelado := True;

  VendaPagFDMemTable.Edit;
  VendaPagFDMemTableCancelado.AsBoolean := True;
  VendaPagFDMemTable.Post;

  PreenchaTotais;
end;

function TPagPDVFrame.PagFormaTem(pPagFormaId: TId): Boolean;
begin
  Result := PDVVenda.VendaPagList.PagFormaTem(pPagFormaId);
end;

procedure TPagPDVFrame.PagInsiraReg(pPag: IVendaPag);
var
  // i: integer;
  // oPag: IVendaPag;
  sDescr: string;
begin
  VendaPagFDMemTable.Append;
  VendaPagFDMemTableOrdem.AsInteger := pPag.Ordem + 1;
  VendaPagFDMemTablePagamentoFormaTipoDescrRed.AsString :=
    pPag.PagamentoFormaTipoDescrRed;

  sDescr := pPag.PagamentoFormaDescr;
  if pPag.PagamentoFormaId = 1 then
  begin
    if pPag.Troco > 0 then
    begin
      sDescr := sDescr + ' - Recebido: ' + DinhToStr(pPag.ValorEntregue) +
        ' - Troco: ' + DinhToStr(pPag.Troco);
    end;
  end;

  VendaPagFDMemTableDescr.AsString := sDescr;
  VendaPagFDMemTableDevido.AsCurrency := pPag.ValorDevido;
  VendaPagFDMemTableCancelado.AsBoolean := pPag.Cancelado;

  VendaPagFDMemTable.Post;
end;

procedure TPagPDVFrame.PagPerg;
var
  bResultado: Boolean;
begin
  if uFalta = 0 then
  begin
    ExibaErro(
      'Valor da venda já foi recebido. Se deseja inserir outra forma de pagamento, cancele uma das já registradas');
    exit;
  end;

  ExibaErro('');
  PagPergForm := TPagPergForm.Create(Nil, PDVVenda, PDVDBI, PagInsiraReg,
    PagFormaTem);
  try
    repeat
      bResultado := PagPergForm.Perg;
      if not bResultado then
        break;

      PreenchaTotais;
      if uFalta = 0 then
        break;
      // PreenchaVendaPagFDMemTable;
      VendaPagFDMemTable.Last;
      Application.ProcessMessages;
      // s l e e p(10);
    until False;
  finally
    PagPergForm.Free;
  end;
end;

procedure TPagPDVFrame.PreenchaTotais;
begin
  PDVVenda.ItensPegarTots(uTotalLiquido, uTotalDevido, uTotalEntregue,
    uFalta, uTroco);

  TotLabel.Caption := 'Total: R$ ' + DinhToStr(uTotalLiquido);
  PagoLabel.Caption := 'Recebido: R$ ' + DinhToStr(uTotalEntregue);
  FaltaLabel.Caption := 'Falta: R$ ' + DinhToStr(uFalta);
  TrocoLabel.Caption := 'Troco: R$ ' + DinhToStr(uTroco);
end;

procedure TPagPDVFrame.PreenchaVendaPagFDMemTable;
var
  i: integer;
  oPag: IVendaPag;
  sDescr: string;
begin
  VendaPagFDMemTable.EmptyDataSet;
  for i := 0 to PDVVenda.VendaPagList.Count - 1 do
  begin
    oPag := PDVVenda.VendaPagList[i];
    PagInsiraReg(oPag);
  end;
end;

procedure TPagPDVFrame.PagPergToolButtonClick(Sender: TObject);
begin
  inherited;
  PagPerg;
end;

procedure TPagPDVFrame.VendaPagFDMemTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  ExibaErro('');
end;

procedure TPagPDVFrame.VoltarToolButtonClick(Sender: TObject);
begin
  inherited;
  ExibaErro('');
  PDVControlador.VaParaVenda;
end;

end.
