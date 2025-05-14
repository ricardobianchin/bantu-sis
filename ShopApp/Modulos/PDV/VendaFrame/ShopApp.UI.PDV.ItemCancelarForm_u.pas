unit ShopApp.UI.PDV.ItemCancelarForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Form.Bas.Diag_u, System.Actions,
  Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, ShopApp.PDV.Venda,
  ShopApp.PDV.VendaItem, ShopApp.PDV.DBI;

type
  TItemCancelarForm_ShopApp = class(TDiagBasForm)
    InstrucoesLabel: TLabel;
    BotaoCancelarLabel: TLabel;
    BotaoOkLabel: TLabel;
    Label3: TLabel;
    ItemPanel: TPanel;
    ItemLabel: TLabel;
    CancelarStatusLabel: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BotaoOkLabelClick(Sender: TObject);
    procedure BotaoCancelarLabelClick(Sender: TObject);
    procedure OkAct_DiagExecute(Sender: TObject);
  private
    { Private declarations }
    FitaStringGrid: TStringGrid;
    FShopPdvVenda: IShopPdvVenda;
    FShopAppPDVDBI: IShopAppPDVDBI;
    FItem: IShopPDVVendaItem;
    procedure ExibaItem;
  public
    { Public declarations }
    constructor Create(pStringGrid: TStringGrid; pShopPdvVenda: IShopPdvVenda;
      pShopAppPDVDBI: IShopAppPDVDBI); reintroduce;
  end;

var
  ItemCancelarForm_ShopApp: TItemCancelarForm_ShopApp;

implementation

{$R *.dfm}
{ TItemCancelarForm_ShopApp }

procedure TItemCancelarForm_ShopApp.BotaoCancelarLabelClick(Sender: TObject);
begin
  inherited;
  CancelAct_Diag.Execute;
end;

constructor TItemCancelarForm_ShopApp.Create(pStringGrid: TStringGrid;
  pShopPdvVenda: IShopPdvVenda; pShopAppPDVDBI: IShopAppPDVDBI);
begin
  inherited Create(nil);
  FitaStringGrid := pStringGrid;
  FShopPdvVenda := pShopPdvVenda;
  FShopAppPDVDBI := pShopAppPDVDBI;

  Caption := 'Excluir item...';

  ItemPanel.Color := RGB(153, 209, 255);

  ItemLabel.Font.Assign(FitaStringGrid.Font);
  ItemLabel.Width := FitaStringGrid.Canvas.TextWidth('W') * 41;
  ItemLabel.Color := RGB(153, 209, 255);

  CancelarStatusLabel.Caption := '';
  ExibaItem;
end;

procedure TItemCancelarForm_ShopApp.ExibaItem;
begin
  if FitaStringGrid.Row = 0 then
    FitaStringGrid.Row := FitaStringGrid.RowCount - 1;
  FItem := FShopPdvVenda[FitaStringGrid.Row - 1];
  ItemLabel.Caption := FItem.AsStringFita;
  CancelarStatusLabel.Caption := '';
  MensLabel.Caption := '';
end;

procedure TItemCancelarForm_ShopApp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_UP:
      begin
        if FitaStringGrid.Row > 1 then
        begin
          FitaStringGrid.Row := FitaStringGrid.Row - 1;
          ExibaItem;
        end;
      end;
    VK_DOWN:
      begin
        if FitaStringGrid.Row < FitaStringGrid.RowCount - 1 then
        begin
          FitaStringGrid.Row := FitaStringGrid.Row + 1;
          ExibaItem;
        end;
      end;
    VK_RETURN, VK_DELETE:
      OkAct_Diag.Execute;
  end;
end;

procedure TItemCancelarForm_ShopApp.BotaoOkLabelClick(Sender: TObject);
begin
  inherited;
  OkAct_Diag.Execute;
end;

procedure TItemCancelarForm_ShopApp.OkAct_DiagExecute(Sender: TObject);
var
  bExecutouOk: Boolean;
  sMensagem: string;
begin
  if FItem.Cancelado then
  begin
    CancelarStatusLabel.Caption := '';
    ErroOutput.Exibir('Item já Cancelado');
    exit;
  end;

  CancelarStatusLabel.Caption := 'Cancelando...';
  CancelarStatusLabel.Repaint;

  FShopAppPDVDBI.EstMovItemCancele(FItem, bExecutouOk, sMensagem);

  if not bExecutouOk then
  begin
    ErroOutput.Exibir(sMensagem);
    exit;
  end;
  FItem.Cancelado := True;
  inherited;
  CancelarStatusLabel.Caption := '';
end;

end.
