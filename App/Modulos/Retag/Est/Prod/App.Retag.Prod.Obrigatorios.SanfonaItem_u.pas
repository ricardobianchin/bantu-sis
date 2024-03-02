unit App.Retag.Prod.Obrigatorios.SanfonaItem_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, NumEditBtu, App.Retag.Prod.SanfonaItem.Bas_u,
  App.Retag.Est.Prod.Ent, Vcl.Mask, Sis.UI.IO.Output,
  App.Retag.Est.Prod.Natu.ComboBoxManager_u;         instanciar combom manager e preencher combo

type
  TObrigatoriosProdEdFrame = class(TProdEdSanfonaItemFrame)
    DescrLabeledEdit: TLabeledEdit;
    DescrRedLabeledEdit: TLabeledEdit;
    FabrIdLabeledEdit: TLabeledEdit;
    ComboBox1: TComboBox;
    NatuLabel: TLabel;
    procedure DescrLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure DescrLabeledEditChange(Sender: TObject);
    procedure DescrRedLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure DescrRedLabeledEditChange(Sender: TObject);
  private
    { Private declarations }
    FIdNumEdit: TNumEditBtu;
    FCustoAtualNumEdit: TNumEditBtu;
    FPrecoAtualNumEdit: TNumEditBtu;
    // FFabrSelectEditFrame: TFabrSelectEditFrame;

    function GetControlProdFabrId: integer;
    procedure IdCrie;
    procedure CustoCrie;
    procedure PrecoCrie;
    procedure FabrSelectCrie;

    function GetId: integer;
    procedure SetId(Value: integer);

    function GetDescr: string;
    procedure SetDescr(Value: string);

    function GetDescrRed: string;
    procedure SetDescrRed(Value: string);

    function GetFabrId: integer;
    procedure SetFabrId(Value: integer);

    function GetFabrNome: string;
    procedure SetFabrNome(Value: string);

  protected
    function GetNome: string; override;
  public
    { Public declarations }
    property Id: integer read GetId write SetId;
    property Descr: string read GetDescr write SetDescr;
    property DescrRed: string read GetDescrRed write SetDescrRed;
    property FabrId: integer read GetFabrId write SetFabrId;
    property FabrNome: string read GetFabrNome write SetFabrNome;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;
    function ControlesOk: boolean; override;

    function GetUniqueValues: variant;

    procedure SimuleDig;

    constructor Create(AOwner: TComponent; pProdEnt: IProdEnt;
      pErroOutput: IOutput); reintroduce;
  end;

  // var
  // ObrigatoriosProdEdFrame: TObrigatoriosProdEdFrame;

implementation

{$R *.dfm}

uses Sis.Types.Integers, Sis.UI.Controls.TLabeledEdit;

{ TObrigatoriosProdEdSanfonaItemFrame }

function TObrigatoriosProdEdFrame.ControlesOk: boolean;
begin
  Result := TesteLabeledEditVazio(DescrLabeledEdit, ErroOutput);
  if not Result then
    exit;

  Result := TesteLabeledEditVazio(DescrRedLabeledEdit, ErroOutput);
  if not Result then
    exit;

  Result := FabrId > 0;
  if not Result then
  begin
    ErroOutput.Exibir('Campo Fabricante é obrigatório');
  end;
end;

procedure TObrigatoriosProdEdFrame.ControlesToEnt;
begin
  // inherited;
  ProdEnt.Id := Id;
  ProdEnt.Descr := Descr;
  ProdEnt.DescrRed := DescrRed;
  ProdEnt.ProdFabrEnt.Id := FabrId;
  ProdEnt.ProdFabrEnt.Descr := FabrNome;

end;

constructor TObrigatoriosProdEdFrame.Create(AOwner: TComponent;
  pProdEnt: IProdEnt; pErroOutput: IOutput);
begin
  inherited Create(AOwner, pProdEnt, pErroOutput);
  IdCrie;
  // CustoCrie;
  // PrecoCrie;
  FabrSelectCrie;

  FIdNumEdit.LabelPosition := lpLeft;
  FIdNumEdit.LabelSpacing := 4;
  FIdNumEdit.Left := 45;
  FIdNumEdit.Top := 1;
  FIdNumEdit.Width := 60;

  // FFabrSelectEditFrame.Left := 2;
  // FFabrSelectEditFrame.Top := 30;

  // FCustoAtualNumEdit.Left := ObjetivoLabel.Left;
  // FCustoAtualNumEdit.Top := 144;
  // FCustoAtualNumEdit.Width := 70;
  //
  // FPrecoAtualNumEdit.Left := ObjetivoLabel.Left;;
  // FPrecoAtualNumEdit.Top := 70;
  // FPrecoAtualNumEdit.Width := 70;
end;

procedure TObrigatoriosProdEdFrame.CustoCrie;
begin
  exit;
  FCustoAtualNumEdit := TNumEditBtu.Create(Self);
  FCustoAtualNumEdit.Parent := Self;
  FCustoAtualNumEdit.Alignment := taRightJustify;
  FCustoAtualNumEdit.NCasas := 2;
  FCustoAtualNumEdit.NCasasEsq := 7;
  FCustoAtualNumEdit.MascEsq := '';
  FCustoAtualNumEdit.Caption := 'Custo atual';
end;

procedure TObrigatoriosProdEdFrame.DescrLabeledEditChange(Sender: TObject);
begin
  inherited;
  ErroOutput.Exibir('');
end;

procedure TObrigatoriosProdEdFrame.DescrLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key, '');
end;

procedure TObrigatoriosProdEdFrame.DescrRedLabeledEditChange(Sender: TObject);
begin
  inherited;
  ErroOutput.Exibir('');
end;

procedure TObrigatoriosProdEdFrame.DescrRedLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key, '');
end;

procedure TObrigatoriosProdEdFrame.EntToControles;
begin
  // inherited;
  Id := ProdEnt.Id;
  Descr := ProdEnt.Descr;
  DescrRed := ProdEnt.DescrRed;
  FabrId := ProdEnt.ProdFabrEnt.Id;
  FabrNome := ProdEnt.ProdFabrEnt.Descr;

  // FIdNumEdit.Valor := ProdEnt.Id;
  // DescrLabeledEdit.Text := ProdEnt.Descr;
  // DescrRedLabeledEdit.Text := ProdEnt.DescrRed;

end;

procedure TObrigatoriosProdEdFrame.FabrSelectCrie;
begin
  // FFabrSelectEditFrame := TFabrSelectEditFrame.Create(MeioPanel, ProdEnt.ProdFabrEnt, nil, nil);
end;

function TObrigatoriosProdEdFrame.GetControlProdFabrId: integer;
begin
  Result := StrToInteger(FabrIdLabeledEdit.Text);
end;

function TObrigatoriosProdEdFrame.GetDescr: string;
begin
  Result := DescrLabeledEdit.Text;
end;

function TObrigatoriosProdEdFrame.GetDescrRed: string;
begin
  Result := DescrRedLabeledEdit.Text;
end;

function TObrigatoriosProdEdFrame.GetFabrId: integer;
begin
  Result := FabrIdLabeledEdit.Tag;
end;

function TObrigatoriosProdEdFrame.GetFabrNome: string;
begin
  Result := FabrIdLabeledEdit.Text;
end;

function TObrigatoriosProdEdFrame.GetId: integer;
begin
  Result := FIdNumEdit.AsInteger;
end;

function TObrigatoriosProdEdFrame.GetNome: string;
begin
  Result := 'Campos Obrigatórios'
end;

function TObrigatoriosProdEdFrame.GetUniqueValues: variant;
begin
  Result := VarArrayCreate([0, 3], varOleStr);
  Result[0] := Id;
  Result[1] := Descr;
  Result[2] := DescrRed;
  Result[3] := FabrId;

end;

procedure TObrigatoriosProdEdFrame.IdCrie;
begin
  FIdNumEdit := TNumEditBtu.Create(MeioPanel);
  FIdNumEdit.Parent := MeioPanel;
  FIdNumEdit.Alignment := taCenter;
  FIdNumEdit.NCasas := 0;
  FIdNumEdit.NCasasEsq := 7;
  FIdNumEdit.MascEsq := '0000000';
  FIdNumEdit.Caption := 'Código';
end;

procedure TObrigatoriosProdEdFrame.PrecoCrie;
begin
  exit;
  FPrecoAtualNumEdit := TNumEditBtu.Create(Self);
  FPrecoAtualNumEdit.Parent := Self;
  FPrecoAtualNumEdit.Alignment := taRightJustify;
  FPrecoAtualNumEdit.NCasas := 2;
  FPrecoAtualNumEdit.NCasasEsq := 7;
  FPrecoAtualNumEdit.MascEsq := '';
  FPrecoAtualNumEdit.Caption := 'Preço Atual';
end;

procedure TObrigatoriosProdEdFrame.SetDescr(Value: string);
begin
  DescrLabeledEdit.Text := Value;
end;

procedure TObrigatoriosProdEdFrame.SetDescrRed(Value: string);
begin
  DescrRedLabeledEdit.Text := Value;
end;

procedure TObrigatoriosProdEdFrame.SetFabrId(Value: integer);
begin
  FabrIdLabeledEdit.Tag := Value;

end;

procedure TObrigatoriosProdEdFrame.SetFabrNome(Value: string);
begin
  FabrIdLabeledEdit.Text := Value;
end;

procedure TObrigatoriosProdEdFrame.SetId(Value: integer);
begin
  FIdNumEdit.Valor := Value;
end;

procedure TObrigatoriosProdEdFrame.SimuleDig;
begin
  DescrLabeledEdit.Text := 'CANETA DE CD';
  DescrRedLabeledEdit.Text := 'CANETA DE CD';
  FabrIdLabeledEdit.Text := 'PILOT';
  FabrIdLabeledEdit.Tag := 2;
end;

end.
