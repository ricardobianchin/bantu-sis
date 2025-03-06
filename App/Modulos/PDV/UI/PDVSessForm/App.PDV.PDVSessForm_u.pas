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
  Sis.UI.Controls.Utils, App.Est.Venda.CaixaSessaoDM_u;

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
    SessDescrLabel: TLabel;
    CancelAction: TAction;
    SuprAction: TAction;
    SangrAction: TAction;
    FechAction: TAction;
    CancelToolButton: TToolButton;
    SuprToolButton: TToolButton;
    SangrToolButton: TToolButton;
    FechToolButton: TToolButton;
    procedure RelatActionExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure SuprActionExecute(Sender: TObject);
    procedure SangrActionExecute(Sender: TObject);
    procedure FechActionExecute(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);

    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FCaixaSessao: ICaixaSessao;
    FCaixaSessaoDM: TCaixaSessaoDM;
    FImpressao: IImpressao;

    procedure SessStatusExiba;
    procedure Atualizar;
    procedure BuscarRecente;
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
  App.PDV.Factory_u, Sis.UI.IO.Input.Perg,
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

  TitleBarCaptionLabel.Caption := 'SESSÃO DE CAIXA';
  TitleBarCaptionLabel.StyleElements := [];
  TitleBarCaptionLabel.Font.Color := clWhite;
  // AlteracaoTextoLabel.Parent := FundoPanel;

  ControlAlignToCenter(TitleBarCaptionLabel);
  // ControlAlignToRect(Self, Screen.WorkAreaRect);
  // ControlAlignToCenter(FFiltroFrame);

  ToolBar2.Left := Width - ToolBar2.Width;
  ToolBar1.Left := 15;
end;

procedure TPDVSessForm.Atualizar;
begin
  FCaixaSessaoDM.CaixaSessaoDBI.PDVCarregarDataSet(SessFDMemTable,
    FCaixaSessaoDM.CaixaSessao);
end;

procedure TPDVSessForm.BuscarRecente;
begin
  FCaixaSessaoDM.CaixaSessaoDBI.CaixaSessaoUltimoGet(FCaixaSessao);
  SessStatusExiba;
  Atualizar;
end;

procedure TPDVSessForm.CancelActionExecute(Sender: TObject);
begin
  inherited;
  Atualizar;
end;

constructor TPDVSessForm.Create(AOwner: TComponent; pImpressoraNome: string;
  pCaixaSessaoDM: TCaixaSessaoDM);
var
  sNomeArq: string;
begin
  inherited Create(AOwner);
  ErroOutput := ShowMessageOutputCreate;
  FCaixaSessaoDM := pCaixaSessaoDM;

  FCaixaSessao := CaixaSessaoCreate(FCaixaSessaoDM.LogUsuario //
    , FCaixaSessaoDM.AppObj.SisConfig.LocalMachineId.IdentId //
    , FCaixaSessaoDM.AppObj.Loja.Id //
    , FCaixaSessaoDM.Terminal.TerminalId //
    );

  FImpressao := ImpressaoTextoCxSessRelatCreate(pImpressoraNome,
    FCaixaSessaoDM.LogUsuario, FCaixaSessaoDM.AppObj, FCaixaSessaoDM.Terminal,
    FCaixaSessaoDM.CaixaSessaoDBI, FCaixaSessao);

  Height := Min(600, Screen.WorkAreaRect.Height - 10);
  Width := 800;
  DBGrid1.Height := (MeioPanel.Height - DBGrid1Splitter.Height) div 2;

  ItemDBGrid.Width := (MeioPanel.Width * 2) div 3;

  sNomeArq := FCaixaSessaoDM.AppObj.AppInfo.PastaConsTabViews +
    'App\PDV\tabview.pdv.sessform.csv';

  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, SessFDMemTable, DBGrid1);

  BorderStyle := bsNone;
  TitleBarPanel.Color := COR_AZUL_TITLEBAR;
  ToolBar1.Color := COR_AZUL_TITLEBAR;
  // DisparaShowTimer := True;
  MakeRounded(Self, 30);
  Canvas.Brush.Style := bsClear;
end;

procedure TPDVSessForm.FechActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopFechamento).Execute;
  Atualizar;
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
  else if CharInSet(Key, ['f', 'F']) then
  begin
    FechAction.Execute;
    exit;
  end;
  inherited;
end;

procedure TPDVSessForm.RelatActionExecute(Sender: TObject);
var
  bResultado: Boolean;
begin
  inherited;
  if FCaixaSessao.Id = 0 then
  begin
    ErroOutput.Exibir('Não há Sessão de Caixa iniciada');
    exit;
  end;
  if SessFDMemTable.IsEmpty then
  begin
    bResultado :=
      PergBool('Ainda não há registros nesta Sessão. Deseja imprimir mesmo assim?');
    if not bResultado then
      exit;
  end;
  FImpressao.Imprima;
end;

procedure TPDVSessForm.SangrActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopSangria).Execute;
  Atualizar;
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
    s := 'Sessão: ' + c.getcod //
      + ' - Operador: ' + c.LogUsuario.NomeExib //
      + ' - Aberto em: ' + FormatDateTime('dd/mm/yy hh:nn:ss', c.AbertoEm) //
      ;
  finally
    SessDescrLabel.Caption := s;
  end;
end;

procedure TPDVSessForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  //RelatAction.Execute;
end;

procedure TPDVSessForm.SuprActionExecute(Sender: TObject);
begin
  inherited;
  FCaixaSessaoDM.GetAction(TCxOpTipo.cxopSuprimento).Execute;
  Atualizar;
end;

end.
