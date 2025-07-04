unit App.UI.Form.Ed.Est.Promo_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Bas.Ed_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.ProdSelectFrame_u, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Data.DB,
  Sis.Usuario, Sis.UI.IO.Output, Sis.UI.IO.Output.ProcessLog,
  Sis.UI.IO.Files.FileI_u, App.Est.Promo.DBI, App.Est.Promo.Ent,
  Sis.UI.Frame.Control.DateTime_u;

type
  TPromoEdForm = class(TEdBasForm)
    MasterGroupBox: TGroupBox;
    CodLabeledEdit: TLabeledEdit;
    ItemGroupBox: TGroupBox;
    NomeLabeledEdit: TLabeledEdit;
    AtivoCheckBox: TCheckBox;
    PrecoPromoNumEditBtu: TNumEditBtu;
    ItemAtivoCheckBox: TCheckBox;
    Label1: TLabel;

    procedure NomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ItemAtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
  private
    { Private declarations }
    FProdSelectFrame: TProdSelectFrame;
    FEstPromoEnt: IEstPromoEnt;
    FEstPromoDBI: IEstPromoDBI;
    FDummyFormClassNamesSL: TStringList;
    FMudoOutput: IOutput;
    FMudoProcessLog: IProcessLog;

    FIniciaEmFrame: TDateTimeFrame;
    FTerminaEmFrame: TDateTimeFrame;

    procedure IniciaEmHoraKeyPress(Sender: TObject; var Key: Char);
    procedure TerminaEmHoraKeyPress(Sender: TObject; var Key: Char);

    function NomeOk: boolean;
    function IniciaEmOk: boolean;
    function TerminaEmOk: boolean;

    function ProdOk: boolean;
    function PrecoPromoOk: boolean;
  protected
    function ControlesOk: boolean; override;

    procedure AjusteControles; override;
    procedure AjusteTabOrder; virtual;

    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject;
      var Key: Char); virtual;
    procedure ProdSelectSelect(Sender: TObject); virtual;

    function GetObjetivoStr: string; override;
    property ProdSelectFrame: TProdSelectFrame read FProdSelectFrame;
    function GravouOk: boolean; override;
    property DummyFormClassNamesSL: TStringList read FDummyFormClassNamesSL;
    property MudoOutput: IOutput read FMudoOutput;
    property MudoProcessLog: IProcessLog read FMudoProcessLog;

    procedure EntToControles; override;
    procedure ControlesToEnt; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pOutputNotify: IOutput = nil); reintroduce; virtual;
    destructor Destroy; override;
  end;

var
  PromoEdForm: TPromoEdForm;

implementation

{$R *.dfm}

uses Sis.UI.Controls.Utils, Sis.Types.Floats, Sis.UI.IO.Factory,
  Sis.Sis.Constants, Sis.UI.IO.Output.ProcessLog.Factory, App.Retag.Est.Factory;

{ TPromoEdForm }

procedure TPromoEdForm.AjusteControles;
begin
  ReadOnlySet(CodLabeledEdit);
  AjusteTabOrder;
  NomeLabeledEdit.SetFocus;

  // ItemGroupBox.Caption := FEstMovEnt.NomeEnt;
  if (FEstPromoEnt.State = dsEdit) and (not FEstPromoEnt.EditandoItem) then
  begin
    ItemGroupBox.Visible := False;
    Height := Height - ItemGroupBox.Height;
  end;
  inherited;
end;

procedure TPromoEdForm.AjusteTabOrder;
begin

end;

procedure TPromoEdForm.AtivoCheckBoxKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  CheckBoxKeyPress(Sender, Key);
end;

function TPromoEdForm.NomeOk: boolean;
var
  sNome: string;
begin
  NomeLabeledEdit.Text := Trim(NomeLabeledEdit.Text);
  sNome := NomeLabeledEdit.Text;

  Result := sNome <> '';
  if not Result then
  begin
    ErroOutput.Exibir('O Nome é obrigatório');
    NomeLabeledEdit.SetFocus;
    Exit;
  end;

  Result := not FEstPromoDBI.NomeJaExistente(sNome, FEstPromoEnt.PromoId);
  if not Result then
  begin
    ErroOutput.Exibir('O Nome já existente');
    NomeLabeledEdit.SetFocus;
    Exit;
  end;
end;

function TPromoEdForm.ControlesOk: boolean;
var
  sNome: string;
begin
  Result := FEstPromoEnt.State = dsEdit;
  if Result then
    Exit;

  Result := NomeOk;
  if not Result then
    Exit;

  Result := IniciaEmOk;
  if not Result then
    Exit;

  Result := TerminaEmOk;
  if not Result then
    Exit;

  Result := ProdOk;
  if not Result then
    Exit;

  Result := PrecoPromoOk;
  if not Result then
    Exit;
end;

procedure TPromoEdForm.ControlesToEnt;
begin
  inherited;

end;

constructor TPromoEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput);
begin
  inherited Create(AOwner, pAppObj, pEntEd, pEntDBI);
  FMudoOutput := MudoOutputCreate;
  FMudoProcessLog := MudoProcessLogCreate;
  FDummyFormClassNamesSL := TStringList.Create;

  FEstPromoEnt := EntEdCastToEstPromoEnt(pEntEd);
  FEstPromoDBI := EntDBICastToEstPromoDBI(pEntDBI);

  FIniciaEmFrame := TDateTimeFrame.Create(MasterGroupBox);
  FIniciaEmFrame.Name := 'FIniciaEmDateTimeFrame';
  FIniciaEmFrame.Left := 4;
  FIniciaEmFrame.Top := CodLabeledEdit.Top + CodLabeledEdit.Height + 14;
  FIniciaEmFrame.HoraMaskEdit.OnKeyPress := IniciaEmHoraKeyPress;
  FIniciaEmFrame.Obrigatorio := True;
  FIniciaEmFrame.PegarNome('Inicia em');

  FTerminaEmFrame := TDateTimeFrame.Create(MasterGroupBox);
  FTerminaEmFrame.Name := 'FTerminaEmDateTimeFrame';
  FTerminaEmFrame.Left := FIniciaEmFrame.Left + FIniciaEmFrame.Width + 6;
  FTerminaEmFrame.Top := FIniciaEmFrame.Top;
  FTerminaEmFrame.HoraMaskEdit.OnKeyPress := TerminaEmHoraKeyPress;
  FTerminaEmFrame.PegarNome('Termina em');

  FProdSelectFrame := TProdSelectFrame.Create(ItemGroupBox, pDBConnection,
    pAppObj, pUsuarioLog, pDBMS, pOutput, pProcessLog, pOutputNotify);

  FProdSelectFrame.ProdLabeledEdit.OnKeyPress :=
    ProdSelectProdLabeledEditKeyPress;
  FProdSelectFrame.OnSelect := ProdSelectSelect;

  FProdSelectFrame.Left := 10;
  FProdSelectFrame.Top := 20;
  PrecoPromoNumEditBtu.Left := FProdSelectFrame.Left + FProdSelectFrame.Width +
    4 + PrecoPromoNumEditBtu.EditLabel.Width +
    PrecoPromoNumEditBtu.LabelSpacing;
  PrecoPromoNumEditBtu.Top := FProdSelectFrame.Top;

  ItemAtivoCheckBox.Top := PrecoPromoNumEditBtu.Top + 3;
  ItemAtivoCheckBox.Left := PrecoPromoNumEditBtu.Left +
    PrecoPromoNumEditBtu.Width + 8;

  CodLabeledEdit.TabStop := False;
  Sis.UI.Controls.Utils.ReadOnlySet(CodLabeledEdit, True);
end;

destructor TPromoEdForm.Destroy;
begin

  inherited;
end;

procedure TPromoEdForm.EntToControles;
begin
  inherited;

end;

function TPromoEdForm.GetObjetivoStr: string;
begin
  if FEstPromoEnt.EditandoItem then
  begin
    Result := 'Novo item de ' + FEstPromoEnt.NomeEnt;
  end
  else
  begin
    Result := 'Nova ' + FEstPromoEnt.NomeEnt;
  end;
end;

function TPromoEdForm.GravouOk: boolean;
begin
  Result := FEstPromoDBI.Gravar;
end;

procedure TPromoEdForm.IniciaEmHoraKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    FTerminaEmFrame.DataMaskEdit.SetFocus;
  end;
end;

function TPromoEdForm.IniciaEmOk: boolean;
var
  dthValue: TDateTime;
  sMens: string;
begin
  FIniciaEmFrame.PreencheDtH(dthValue, sMens);
  Result := sMens = '';
  if not Result then
    FIniciaEmFrame.DataMaskEdit.SetFocus;
end;

procedure TPromoEdForm.ItemAtivoCheckBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
  end;
end;

procedure TPromoEdForm.NomeLabeledEditKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  EditKeyPress(Sender, Key);

end;

function TPromoEdForm.PrecoPromoOk: boolean;
begin
  Result := PrecoPromoNumEditBtu.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Preço Promocional é obrigatório');
    PrecoPromoNumEditBtu.SetFocus;
    Exit;
  end;
end;

function TPromoEdForm.ProdOk: boolean;
begin
  Result := ProdSelectFrame.ProdId > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Produto é obrigatório');
    ProdSelectFrame.ProdLabeledEdit.SetFocus;
    Exit;
  end;
end;

procedure TPromoEdForm.ProdSelectProdLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    Key := #0;
    if ProdSelectFrame.ProdId > 0 then
    begin
      ProdSelectSelect(ProdSelectFrame);
      Exit;
    end;
    ProdSelectFrame.Selecionar;
  end;

  if (Key >= #32) then
  begin
    Key := #0;
    ProdSelectFrame.Selecionar;
  end;
end;

procedure TPromoEdForm.ProdSelectSelect(Sender: TObject);
begin
  MensLimpar;
  PrecoPromoNumEditBtu.SetFocus;
end;

procedure TPromoEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  NomeLabeledEdit.Text := 'DIA DAS MAES';
  OkAct_Diag.Execute;
end;

procedure TPromoEdForm.TerminaEmHoraKeyPress(Sender: TObject; var Key: Char);
begin
  FProdSelectFrame.ProdLabeledEdit.SetFocus;
end;

function TPromoEdForm.TerminaEmOk: boolean;
var
  dthIni, dthFin: TDateTime;
  sMens: string;
begin
  FIniciaEmFrame.PreencheDtH(dthIni, sMens);
  Result := sMens = '';
  if not Result then
  begin
    FIniciaEmFrame.DataMaskEdit.SetFocus;
    Exit;
  end;

  FTerminaEmFrame.PreencheDtH(dthFin, sMens);
  Result := sMens = '';
  if not Result then
  begin
    FTerminaEmFrame.DataMaskEdit.SetFocus;
    Exit;
  end;

  Result := dthFin = DATA_ZERADA;
  if Result then
    Exit;

  Result := dthIni < dthFin;
  if not Result then
  begin
    ErroOutput.Exibir('A data de término deve ser maior do que a de início');
    FTerminaEmFrame.DataMaskEdit.SetFocus;
    Exit;
  end;
end;

end.
