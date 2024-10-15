unit App.UI.Frame.DBGrid.Config.Ambi.Terminal_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Sis.UI.Frame.Bas.DBGrid_u, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Sis.DB.DataSet.Utils, System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Sis.UI.IO.Output;

type
  TTerminaisDBGridFrame = class(TDBGridFrame)
    ToolBar1: TToolBar;
    InsToolButton: TToolButton;
    AltToolButton: TToolButton;
    ExclToolButton: TToolButton;
    ActionList1: TActionList;
    InsAction: TAction;
    AltAction: TAction;
    ExclAction: TAction;
    BalloonHint1: TBalloonHint;
    procedure InsActionExecute(Sender: TObject);
    procedure AltActionExecute(Sender: TObject);
    procedure ExclActionExecute(Sender: TObject);

    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FOutputNotify: IOutput;
    function GetNomeArqTabView: string;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Preparar;
    procedure SimuleIns;
  end;

var
  TerminaisDBGridFrame: TTerminaisDBGridFrame;

implementation

{$R *.dfm}

uses Sis.UI.IO.Files, App.UI.Form.Config.Ambi.Terminal.Ed_u, Sis.UI.IO.Factory;

{ TDBGridFrame1 }

procedure TTerminaisDBGridFrame.AltActionExecute(Sender: TObject);
begin
  inherited;
  if FDMemTable1.IsEmpty then
  begin
    FOutputNotify.Exibir('Não há registro visível a alterar');
    exit;
  end;

  TerminalEdDiagForm := TTerminalEdDiagForm.Create(nil, FDMemTable1, TDataSetState.dsEdit);
  if TerminalEdDiagForm.Perg then
    DBGrid1.Repaint;
end;

constructor TTerminaisDBGridFrame.Create(AOwner: TComponent);
begin
  inherited;
  FOutputNotify := BalloonHintOutputCreate(BalloonHint1);
end;

procedure TTerminaisDBGridFrame.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  AltAction.Execute;
end;

procedure TTerminaisDBGridFrame.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
  begin
    Key := 0;
    ExclAction.Execute;
    exit;
  end;
  inherited;
end;

procedure TTerminaisDBGridFrame.ExclActionExecute(Sender: TObject);
var
  sMens: string;
  Resultado: TModalResult;
  bAceitou: Boolean;
begin
  inherited;
  if FDMemTable1.IsEmpty then
  begin
    FOutputNotify.Exibir('Não há registro visível a excluir');
    exit;
  end;

  sMens := 'Esta ação vai excluir o terminal no sistema.'#13#10 +
    'O Banco de Dados NÃO será excluído. Apenas não será usado pelo sistema até que seja reinserido nesta lista'#13#10 +
    'Deseja excluir?';

  Resultado := MessageDlg(sMens, TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  bAceitou := IsPositiveResult(Resultado);
  if not bAceitou then
    exit;

  FDMemTable1.Delete;
end;

function TTerminaisDBGridFrame.GetNomeArqTabView: string;
var
  sNomeArq: string;
  sExeName: string;
  sPastaBin: string;
  sPasta: string;
  sPastaConsultas: string;
  sPastaConsTabViews: string;
begin
  sExeName := ParamStr(0);
  sPastaBin := GetPastaDoArquivo(sExeName);
  sPasta := PastaAcima(sPastaBin);

  sPastaConsultas := sPasta + 'Cons\';
  sPastaConsTabViews := sPastaConsultas + 'TabViews\';
  ForceDirectories(sPastaConsTabViews);

  sNomeArq := sPastaConsTabViews +
    'App\Config\Ambiente\tabview.config.ambi.terminais.csv';

  Result := sNomeArq;
end;

procedure TTerminaisDBGridFrame.InsActionExecute(Sender: TObject);
begin
  inherited;
  TerminalEdDiagForm := TTerminalEdDiagForm.Create(nil, FDMemTable1, TDataSetState.dsInsert);
  if TerminalEdDiagForm.Perg then
    DBGrid1.Repaint;
end;

procedure TTerminaisDBGridFrame.Preparar;
var
  sNomeArq: string;
begin
  sNomeArq := GetNomeArqTabView;
  Sis.DB.DataSet.Utils.DefCamposArq(sNomeArq, FDMemTable1, DBGrid1);
  DBGrid1.Align := alClient;
end;

procedure TTerminaisDBGridFrame.SimuleIns;
var
  Tab: TDataSet;
begin
  Tab := FDMemTable1;

  while not Tab.IsEmpty do
    Tab.Delete;

  Tab.append;
  Tab.FieldByName('TERMINAL_ID').AsInteger := 1;
  Tab.FieldByName('APELIDO').AsString := 'TECIDOS';
  Tab.FieldByName('NOME_NA_REDE').AsString := 'DELPHI-BTU';
  Tab.FieldByName('IP').AsString := '192.168.1.144';
  Tab.FieldByName('NF_SERIE').AsInteger := 0;
  Tab.FieldByName('LETRA_DO_DRIVE').AsString := 'C:';
  Tab.FieldByName('GAVETA_TEM').AsBoolean := False;
  Tab.FieldByName('BALANCA_MODO_ID').AsInteger := 0;
  Tab.FieldByName('BALANCA_ID').AsInteger := 0;
  Tab.FieldByName('BARRAS_COD_INI').AsInteger := 2;
  Tab.FieldByName('BARRAS_COD_TAM').AsInteger := 6;
  Tab.FieldByName('CUPOM_NLINS_FINAL').AsInteger := 0;
  Tab.FieldByName('SEMPRE_OFFLINE').AsBoolean :=  False;
  Tab.Post;

  {
  Tab.append;
  Tab.FieldByName('TERMINAL_ID').AsInteger := 2;
  Tab.FieldByName('APELIDO').AsString := 'REVESTIMENTO';
  Tab.FieldByName('NOME_NA_REDE').AsString := 'DELPHI-BTU';
  Tab.FieldByName('IP').AsString := '192.168.1.144';
  Tab.FieldByName('NF_SERIE').AsInteger := 3;
  Tab.FieldByName('LETRA_DO_DRIVE').AsString := 'C:';
  Tab.FieldByName('GAVETA_TEM').AsBoolean := True;
  Tab.FieldByName('BALANCA_MODO_ID').AsInteger := 0;
  Tab.FieldByName('BALANCA_ID').AsInteger := 0;
  Tab.FieldByName('BARRAS_COD_INI').AsInteger := 2;
  Tab.FieldByName('BARRAS_COD_TAM').AsInteger := 6;
  Tab.FieldByName('CUPOM_NLINS_FINAL').AsInteger := 0;
  Tab.FieldByName('SEMPRE_OFFLINE').AsBoolean :=  True;
  Tab.Post;
  }
end;

end.
