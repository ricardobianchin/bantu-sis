unit App.PDV.PDVSessForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Sis.UI.Form.Bas_u, Vcl.ExtCtrls, App.Est.Venda.CaixaSessao.DBI,
  Data.DB, Vcl.Grids, Vcl.DBGrids, App.AppObj, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, System.Actions, Vcl.ActnList, Vcl.ToolWin,
  Vcl.StdCtrls, Sis.UI.IO.Output, Sis.UI.Form.Bas.Diag_u, Sis.UI.Impressao,
  Sis.Terminal, Sis.Usuario, App.Est.Venda.Caixa.CaixaSessao,
  Sis.UI.Controls.Utils, App.Est.Venda.CaixaSessaoDM_u,
  Sis.UI.Frame.Bas.Filtro_u;

type
  TPDVSessForm = class(TDiagBasForm)
    BasePanel: TPanel;
    ToolBar1: TToolBar;
    RelatToolButton: TToolButton;
    MeioPanel: TPanel;
    DBGrid1Splitter: TSplitter;
    DBGrid1: TDBGrid;
    SubPanel: TPanel;
    Splitter2: TSplitter;
    ItemPanel: TPanel;
    ItemDBGrid: TDBGrid;
    PagPanel: TPanel;
    PagDBGrid: TDBGrid;
    ToolBarActionList: TActionList;
    RelatAction: TAction;
    SessFDMemTable: TFDMemTable;
    ItemFDMemTable: TFDMemTable;
    PagFDMemTable: TFDMemTable;
    ItemDataSource: TDataSource;
    PagDataSource: TDataSource;
    SessDataSource: TDataSource;
    TitleBarPanel: TPanel;
    TitleBarCaptionLabel: TLabel;
    ToolBar2: TToolBar;
    FecharToolButton: TToolButton;
    CancelAction: TAction;
    SuprAction: TAction;
    SangrAction: TAction;
    FechAction: TAction;
    CancelToolButton: TToolButton;
    SuprToolButton: TToolButton;
    SangrToolButton: TToolButton;
    FechToolButton: TToolButton;
    DespToolButton: TToolButton;
    DespAction: TAction;
    ItemFDMemTableORDEM: TSmallintField;
    ItemFDMemTableITEM: TSmallintField;
    ItemFDMemTablePROD_ID: TIntegerField;
    ItemFDMemTableDESCR_RED: TStringField;
    ItemFDMemTableQTD: TCurrencyField;
    ItemFDMemTablePRECO_UNIT: TCurrencyField;
    ItemFDMemTableDESCONTO: TCurrencyField;
    ItemFDMemTablePRECO: TCurrencyField;
    ItemFDMemTableCANCELADO: TBooleanField;
    PagFDMemTableORDEM: TSmallintField;
    PagFDMemTablePAGAMENTO_FORMA_ID: TIntegerField;
    PagFDMemTableVALOR_DEVIDO: TCurrencyField;
    PagFDMemTableDESCR: TStringField;
    PagFDMemTableVALOR_ENTREGUE: TCurrencyField;
    PagFDMemTableTROCO: TCurrencyField;
    PagFDMemTableCANCELADO: TBooleanField;
    CarregaDetailTimer: TTimer;
    ItensTitPanel: TPanel;
    TitItensLabel: TLabel;
    PagTitPanel: TPanel;
    PagTitLabel: TLabel;
    SessTitPanel: TPanel;
    SessTitLabel: TLabel;
    procedure RelatActionExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SuprActionExecute(Sender: TObject);
    procedure SangrActionExecute(Sender: TObject);
    procedure FechActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);

    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure DespActionExecute(Sender: TObject);
    procedure SessFDMemTableAfterOpen(DataSet: TDataSet);
    procedure SessFDMemTableAfterScroll(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure CarregaDetailTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FCaixaSessao: ICaixaSessao;
    FCaixaSessaoDM: TCaixaSessaoDM;
    FImpressao: IImpressao;
    FFiltroFrame: TFiltroFrame;

    procedure SessStatusExiba;
    procedure BuscarRecente;

    procedure Atualizar(Sender: TObject);
    procedure AtualizarDetail;

    procedure RetiraEventos;
    procedure RecolocaEventos;
    procedure DisparaCarregaDetailTimer;

  protected
    procedure AjusteControles; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pImpressoraNome: string;
      pCaixaSessaoDM: TCaixaSessaoDM); reintroduce;
  end;

  {
    quando fizer abertura de caixa, pegará a action q tenta abrir
    que receberá via parametro
    ela fica no modu pdv
    apos execuala, faz BuscarRecente
  }
procedure Exibir(AOwner: TComponent; pImpressoraNome: string;
  pCaixaSessaoDM: TCaixaSessaoDM);

var
  PDVSessForm: TPDVSessForm;

implementation

{$R *.dfm}

uses Sis.UI.ImgDM, System.Math, Sis.DB.DataSet.Utils, Sis.UI.IO.Factory,
  App.PDV.Factory_u, Sis.UI.IO.Input.Perg, Sis.UI.Controls.TDBGrid,
  App.PDV.ImpressaoTextoCxSessRelat_u, App.Est.Venda.CaixaSessao.Factory_u,
  Sis.UI.Constants, App.Est.Venda.Caixa.CaixaSessao.Utils_u;

procedure Exibir(AOwner: TComponent; pImpressoraNome: string;
  pCaixaSessaoDM: TCaixaSessaoDM);
begin
  PDVSessForm := TPDVSessForm.Create(AOwner, pImpressoraNome, pCaixaSessaoDM);
  try
    PDVSessForm.ShowModal;
  finally
    FreeAndNil(PDVSessForm);
  end;
end;

{ TPDVSessForm }

procedure TPDVSessForm.AjusteControles;
begin
  inherited;
  BuscarRecente;

  TitleBarCaptionLabel.Caption := 'Rotinas de Caixa';
  TitleBarCaptionLabel.StyleElements := [];
  TitleBarCaptionLabel.Font.Color := clWhite;
  // AlteracaoTextoLabel.Parent := FundoPanel;

  ControlAlignToCenter(TitleBarCaptionLabel);
  // ControlAlignToRect(Self, Screen.WorkAreaRect);
  // ControlAlignToCenter(FFiltroFrame);

  ToolBar2.Left := Width - ToolBar2.Width;

  FFiltroFrame.Top := 0;
  FFiltroFrame.Left := 0;
  FFiltroFrame.Width := BasePanel.Width;

  ToolBar1.Top := FFiltroFrame.Top + FFiltroFrame.Height;
  ToolBar1.Left := 15;
  ToolBar1.Height := 21;
  ToolBar1.Realign;

  BasePanel.Height := FFiltroFrame.Height + ToolBar1.Height;
end;

procedure TPDVSessForm.Atualizar(Sender: TObject);
const
  CARREGA_DATASETS_DETAIL = False;
begin
  RetiraEventos;
  try
    FCaixaSessaoDM.CaixaSessaoDBI.PDVSessFormCarregarDataSet(SessFDMemTable,
      ItemFDMemTable, PagFDMemTable, FCaixaSessaoDM.CaixaSessao,
      FFiltroFrame.Values, CARREGA_DATASETS_DETAIL);
    AtualizarDetail;
  finally
    RecolocaEventos;
  end;
end;

procedure TPDVSessForm.AtualizarDetail;
var
  eCxOpTipo: TCxOpTipo;
begin
  eCxOpTipo.FromString(SessFDMemTable.Fields[6].AsString);
  ItemDBGrid.Visible := eCxOpTipo = TCxOpTipo.cxopVenda;

  FCaixaSessaoDM.CaixaSessaoDBI.PDVSessFormCarregarDataSetDetail(SessFDMemTable,
    ItemFDMemTable, PagFDMemTable);
end;

procedure TPDVSessForm.BuscarRecente;
begin
  FCaixaSessaoDM.CaixaSessaoDBI.CaixaSessaoUltimoGet(FCaixaSessao);
  SessStatusExiba;
  Atualizar(nil);
end;

procedure TPDVSessForm.CancelActionExecute(Sender: TObject);
begin
  inherited;
  Atualizar(nil);
end;

procedure TPDVSessForm.CarregaDetailTimerTimer(Sender: TObject);
begin
  inherited;
  CarregaDetailTimer.Enabled := False;
  AtualizarDetail;
end;

constructor TPDVSessForm.Create(AOwner: TComponent; pImpressoraNome: string;
  pCaixaSessaoDM: TCaixaSessaoDM);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  ErroOutput := ShowMessageOutputCreate;
  FCaixaSessaoDM := pCaixaSessaoDM;
  FFiltroFrame := SessFormFiltroFrameCreate(BasePanel, Atualizar, FCaixaSessaoDM.CaixaSessaoDBI);

  FCaixaSessao := CaixaSessaoCreate(FCaixaSessaoDM.LogUsuario //
    , FCaixaSessaoDM.AppObj.SisConfig.LocalMachineId.IdentId //
    , FCaixaSessaoDM.AppObj.Loja.Id //
    , FCaixaSessaoDM.Terminal.TerminalId //
    );

  FImpressao := ImpressaoTextoCxSessRelatCreate(pImpressoraNome,
    FCaixaSessaoDM.LogUsuario.Id, FCaixaSessaoDM.LogUsuario.NomeExib,
    FCaixaSessaoDM.AppObj, FCaixaSessaoDM.Terminal,
    FCaixaSessaoDM.CaixaSessaoDBI, FCaixaSessao);

  // Height := Min(600, Screen.WorkAreaRect.Height - 10);
  // Width := 800;

  sNomeArq := FCaixaSessaoDM.AppObj.AppInfo.PastaConsTabViews +
    'App\PDV\tabview.pdv.sessform.csv';

  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, SessFDMemTable, DBGrid1);

  BorderStyle := bsNone;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // DisparaShowTimer := True;
  // MakeRounded(Self, 30);
  Canvas.Brush.Style := bsClear;
  WindowState := TWindowState.wsMaximized;
end;

procedure TPDVSessForm.DespActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopDespesa).Execute;
  Atualizar(nil);
end;

procedure TPDVSessForm.DisparaCarregaDetailTimer;
begin
  CarregaDetailTimer.Enabled := False;
  CarregaDetailTimer.Enabled := True;
end;

procedure TPDVSessForm.FechActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopFechamento).Execute;
  Close;
end;

procedure TPDVSessForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, ['r', 'R']) then
  begin
    RelatAction.Execute;
    exit;
  end
  else if CharInSet(Key, ['u', 'U']) then
  begin
    SuprAction.Execute;
    exit;
  end
  else if CharInSet(Key, ['a', 'A']) then
  begin
    SangrAction.Execute;
    exit;
  end
  else if CharInSet(Key, ['d', 'D']) then
  begin
    DespAction.Execute;
    exit;
  end
  else if CharInSet(Key, ['f', 'F']) then
  begin
    FechAction.Execute;
    exit;
  end;
  inherited;
end;

procedure TPDVSessForm.FormResize(Sender: TObject);
var
  iPagGridLarg: integer;
begin
  inherited;
  DBGrid1.Height := (MeioPanel.Height - DBGrid1Splitter.Height) div 2;
  iPagGridLarg := DBGridColumnWidthsGet(PagDBGrid);
  iPagGridLarg := (iPagGridLarg * 115) div 100;
  ItemPanel.Width := MeioPanel.Width - iPagGridLarg;
end;

procedure TPDVSessForm.RecolocaEventos;
begin
  SessFDMemTable.AfterOpen := SessFDMemTableAfterOpen;
  SessFDMemTable.AfterScroll := SessFDMemTableAfterScroll;
end;

procedure TPDVSessForm.RelatActionExecute(Sender: TObject);
var
  bResultado: Boolean;
begin
  inherited;
  if FCaixaSessao.Id = 0 then
  begin
    ErroOutput.Exibir('Não há Caixa Aberto');
    exit;
  end;
  if SessFDMemTable.IsEmpty then
  begin
    bResultado :=
      PergBool('Ainda não há registros nesta Abertura de Caixa. Deseja imprimir mesmo assim?');
    if not bResultado then
      exit;
  end;
  FImpressao.Imprima;
end;

procedure TPDVSessForm.RetiraEventos;
begin
  SessFDMemTable.AfterOpen := nil;
  SessFDMemTable.AfterScroll := nil;
end;

procedure TPDVSessForm.SangrActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopSangria).Execute;
  Atualizar(nil);
end;

procedure TPDVSessForm.SessFDMemTableAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DisparaCarregaDetailTimer;
end;

procedure TPDVSessForm.SessFDMemTableAfterScroll(DataSet: TDataSet);
begin
  inherited;
  DisparaCarregaDetailTimer;
end;

procedure TPDVSessForm.SessStatusExiba;
var
  s: string;
  c: ICaixaSessao;
begin
  c := FCaixaSessao;

  try
    if c.Id = 0 then
    begin
      s := 'Sem registros de caixa';
      exit;
    end;
    s := 'Abertura: ' + c.getcod //
      + ' - Operador: ' + c.LogUsuario.NomeExib //
      + ' - Aberto em: ' + FormatDateTime('dd/mm/yy hh:nn:ss', c.AbertoEm) //
      ;
  finally
    SessTitLabel.Caption := s;
  end;
end;

procedure TPDVSessForm.ShowTimer_BasFormTimer(Sender: TObject);
var
  iPagGridLarg: integer;
begin
  inherited;
  DBGrid1.Height := (MeioPanel.Height - DBGrid1Splitter.Height) div 2;
  iPagGridLarg := DBGridColumnWidthsGet(PagDBGrid);
  iPagGridLarg := (iPagGridLarg * 115) div 100;
  ItemPanel.Width := MeioPanel.Width - iPagGridLarg;
  DBGrid1.SetFocus;
end;

procedure TPDVSessForm.SuprActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopSuprimento).Execute;
  Atualizar(nil);
end;

end.
