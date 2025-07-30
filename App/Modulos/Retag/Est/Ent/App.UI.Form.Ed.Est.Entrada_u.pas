unit App.UI.Form.Ed.Est.Entrada_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.Est_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.Entrada.Ent, App.Retag.Est.Entrada.DBI,
  Sis.UI.Controls.ComboBoxManager, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Sis.Entities.Types, Sis.Types, Sis.UI.IO.Output,
  Sis.UI.IO.Output.ProcessLog, Sis.Usuario, Sis.UI.FormCreator,
  App.UI.Controls.ComboBox.Select.DB.Frame_u, App.Pess.Fornecedor.DBI,
  App.UI.Form.DataSet.Pess.Fornecedor_u, Data.FmtBcd,
  App.Pess.Fornecedor.Ent;

type
  TEntradaEdForm = class(TEstEdBasForm)
    CustoNumEditBtu: TNumEditBtu;
    CustoUnitNumEditBtu: TNumEditBtu;
    ProdIdDelesLabeledEdit: TLabeledEdit;
    CustoUltimoNumEditBtu: TNumEditBtu;
    MargemNumEditBtu: TNumEditBtu;
    PrecoSugeridoNumEditBtu: TNumEditBtu;
    PrecoAtualNumEditBtu: TNumEditBtu;
    PrecoNovoNumEditBtu: TNumEditBtu;
    ObsLabel: TLabel;
    SerieNumEditBtu: TNumEditBtu;
    NDocNumEditBtu: TNumEditBtu;
    NItemNumEditBtu: TNumEditBtu;
    procedure CustoNumEditBtuChange(Sender: TObject);
    procedure QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure QtdNumEditBtuChange(Sender: TObject);
    procedure FornecedorComboBoxChange(Sender: TObject);
    procedure CustoNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure NDocNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure SerieNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure ProdIdDelesLabeledEditKeyPress(Sender: TObject; var Key: Char);
    procedure MargemNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure MargemNumEditBtuChange(Sender: TObject);
    procedure CustoUnitNumEditBtuChange(Sender: TObject);
    procedure PrecoNovoNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure ShowTimer_BasFormTimer(Sender: TObject);
    procedure CustoUnitNumEditBtuMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private declarations }
    FEntradaEnt: IEntradaEnt;
    FEntradaDBI: IEntradaDBI;
    FPessFornecedorEnt: IPessFornecedorEnt;
    FPessFornecedorDBI: IPessFornecedorDBI;
    FornecedorSelectFrame: TComboBoxSelectDBFrame;
    FFornecedorIdUltimo: TId;
    FFornecedorDataSetFormCreator: IFormCreator;

    FCriando: Boolean;

    procedure CalculeCustoUnit;
    procedure CalculePreco;

    procedure FornecedorComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FornecedorComboBox1Exit(Sender: TObject);
    procedure FornecedorComboBox1Change(Sender: TObject);

    function FornecedorOk: Boolean;

    procedure Preencher;
  protected
    procedure AjusteControles; override;
    procedure AjusteTabOrder; override;

    procedure EntToControles; override;
    procedure ControlesToEnt; override;

    function ControlesOk: Boolean; override;
    function GravouOk: boolean; override;
    procedure ProdSelectSelect(Sender: TObject); override;

    procedure MensLimpar; override;

  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection; pUsuarioLog: IUsuario;
      pDBMS: IDBMS; pOutput: IOutput = nil; pProcessLog: IProcessLog = nil;
      pOutputNotify: IOutput = nil); override;
  end;

var
  EntradaEdForm: TEntradaEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.Controls.Factory, Sis.DB.DataSet.Utils,
  Sis.Types.Floats, App.Retag.Est.EntradaItem, Data.DB, Sis.Sis.Constants,
  Sis.Types.strings_u, Sis.UI.Controls.Utils, App.Types, System.Math,
  App.Retag.Est.ProdSelectFrame_u, App.Pess.Fornecedor.Ent.Factory_u,
  App.Acesso.Fornecedor.UI.Factory_u;

procedure TEntradaEdForm.AjusteControles;
begin
  inherited;
  ReadOnlySet(NItemNumEditBtu);
  ReadOnlySet(CustoUnitNumEditBtu);
  ReadOnlySet(CustoUltimoNumEditBtu);
  ReadOnlySet(PrecoSugeridoNumEditBtu);
  ReadOnlySet(PrecoAtualNumEditBtu);

  NDocNumEditBtu.Left := FornecedorSelectFrame.Left +
    FornecedorSelectFrame.Width + 5 + NDocNumEditBtu.EditLabel.Width +
    NDocNumEditBtu.LabelSpacing;
  NDocNumEditBtu.Top := FornecedorSelectFrame.Top;

  SerieNumEditBtu.Left := NDocNumEditBtu.Left + NDocNumEditBtu.Width + 5 +
    SerieNumEditBtu.EditLabel.Width + SerieNumEditBtu.LabelSpacing;
  SerieNumEditBtu.Top := NDocNumEditBtu.Top;

  ProdSelectFrame.Left := ProdIdDelesLabeledEdit.Left +
    ProdIdDelesLabeledEdit.Width + 5;

  QtdNumEditBtu.Left := 72;
  QtdNumEditBtu.Top := 53;

  FCriando := False;

  CalculeCustoUnit;
  CalculePreco;

  if (FEntradaEnt.EditandoItem) then
  begin
    ProdIdDelesLabeledEdit.SetFocus;
    exit;
  end;

  FornecedorSelectFrame.ComboBox1.SetFocus;

  // exit;

  // ProdIdDelesLabeledEdit.Top := ProdSelectFrame.Top;

  // ProdSelectFrame.Width := ItemGroupBox.Width - ProdSelectFrame.Left - 2;
end;

procedure TEntradaEdForm.AjusteTabOrder;
begin
  inherited;
  TabOrderInicie;
  TabOrderSet(CodLabeledEdit);
  TabOrderSet(FornecedorSelectFrame);
  TabOrderSet(NDocNumEditBtu);
  TabOrderSet(SerieNumEditBtu);

  TabOrderInicie;
  TabOrderSet(NItemNumEditBtu);
  TabOrderSet(ProdIdDelesLabeledEdit);
  TabOrderSet(ProdSelectFrame);
  TabOrderSet(QtdNumEditBtu);
  TabOrderSet(CustoNumEditBtu);
  TabOrderSet(CustoUnitNumEditBtu);
  TabOrderSet(CustoUltimoNumEditBtu);
  TabOrderSet(MargemNumEditBtu);
  TabOrderSet(PrecoSugeridoNumEditBtu);
  TabOrderSet(PrecoAtualNumEditBtu);
  TabOrderSet(PrecoNovoNumEditBtu);
end;

procedure TEntradaEdForm.CalculeCustoUnit;
begin
  if FCriando then
    exit;
  CustoUnitNumEditBtu.Valor := CustoToCustoUnit(CustoNumEditBtu.Valor,
    QtdNumEditBtu.Valor);
end;

procedure TEntradaEdForm.CalculePreco;
begin
  if FCriando then
    exit;
  PrecoSugeridoNumEditBtu.Valor := PrecoSugeridoCalc(CustoUnitNumEditBtu.Valor,
    MargemNumEditBtu.Valor);
end;

function TEntradaEdForm.ControlesOk: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := FornecedorOk;
  if not Result then
    exit;

  Result := not ItemGroupBox.Visible;
  if Result then
    exit;

  Result := (EntEd.State = dsEdit) and (not FEntradaEnt.EditandoItem);
  if Result then
    exit;

  Result := CustoNumEditBtu.Valor > 0;
  if not Result then
  begin
    CustoNumEditBtu.SetFocus;
    errooutput.exibir('Custo é obrigatório');
  end;
end;

procedure TEntradaEdForm.ControlesToEnt;
var
  oItem: IRetagEntradaItem;
  iOrdem: SmallInt;
  iNItem: Integer;
begin
  inherited;
  FEntradaEnt.FornecedorId := FornecedorSelectFrame.Id;
  FEntradaEnt.FornecedorApelido := FornecedorSelectFrame.Text;
  FEntradaEnt.NDoc := NDocNumEditBtu.AsInteger;
  FEntradaEnt.Serie := SerieNumEditBtu.AsInteger;

  if EntEd.State = dsEdit then
  begin
    oItem := FEntradaEnt.Items[FEntradaEnt.ItemIndex];
    oItem.ProdIdDeles := ProdIdDelesLabeledEdit.Text;
    oItem.Custo := CustoNumEditBtu.AsCurrency;
    oItem.Margem := MargemNumEditBtu.AsCurrency;
    oItem.Preco := PrecoNovoNumEditBtu.AsCurrency;
    oItem.Qtd := QtdNumEditBtu.Valor;
    exit;
  end;

  iOrdem := FEntradaEnt.Items.Count;
  iNItem := FEntradaEnt.GetNextNItem;

  ProdIdDelesLabeledEdit.Text := Trim(ProdIdDelesLabeledEdit.Text);

  oItem := RetagEntradaItemCreate( //
    iOrdem, //
    ProdSelectFrame.ProdId, //

    ProdSelectFrame.ProdDescrRed, //
    ProdSelectFrame.ProdFabrNome, //
    '' { UnidSigla } , //

    iNItem, //
    ProdIdDelesLabeledEdit.Text, //

    QtdNumEditBtu.Valor, //
    CustoNumEditBtu.AsCurrency, //
    MargemNumEditBtu.AsCurrency, //
    PrecoNovoNumEditBtu.AsCurrency, //

    DATA_ZERADA { criadoem } //
    );

  FEntradaEnt.Items.Add(oItem);
end;

constructor TEntradaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection;
  pUsuarioLog: IUsuario; pDBMS: IDBMS; pOutput: IOutput;
  pProcessLog: IProcessLog; pOutputNotify: IOutput);
var
  iLojaId: TLojaId;
  iMachId: SmallInt;

begin
  FCriando := True;
  inherited;
  ProdSelectFrame.OnSelect := ProdSelectSelect;
  // MensLimpar;

  iLojaId := pAppObj.Loja.Id;
  iMachId := pAppObj.SisConfig.LocalMachineId.IdentId;

  FPessFornecedorEnt := PessFornecedorEntCreate(iLojaId,
    pUsuarioLog.Id, iMachId);
  FPessFornecedorDBI := PessFornecedorDBICreate(pDBConnection,
    FPessFornecedorEnt);

  FFornecedorDataSetFormCreator := FornecedorDataSetFormCreatorCreate
    (DummyFormClassNamesSL, pUsuarioLog, pDBMS, pOutput, pProcessLog,
    pOutputNotify, AppObj);

  FornecedorSelectFrame := TComboBoxSelectDBFrame.Create(NotaGroupBox,
    FPessFornecedorEnt, FPessFornecedorDBI, pOutput,
    FFornecedorDataSetFormCreator);

  FornecedorSelectFrame.Left := 192;
  FornecedorSelectFrame.Top := 18;

  FornecedorSelectFrame.Preencha;
  FornecedorSelectFrame.ComboBox1.DropDownCount := 16;
  FornecedorSelectFrame.ComboBox1.onkeypress := FornecedorComboBox1KeyPress;
  FornecedorSelectFrame.ComboBox1.OnExit := FornecedorComboBox1Exit;
  FornecedorSelectFrame.ComboBox1.OnChange := FornecedorComboBox1Change;

  FEntradaEnt := EntEdCastToEntradaEnt(pEntEd);
  // FEstSaidaEnt := pEntEd as IEstSaidaEnt;
  FEntradaDBI := EntDBICastToEntradaDBI(pEntDBI);

  // FEntradaDBI.FornecedorPrepareLista(FornecedorComboBox.Items);
  FFornecedorIdUltimo := FEntradaEnt.FornecedorId;
end;

procedure TEntradaEdForm.CustoNumEditBtuChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
  CalculeCustoUnit;
end;

procedure TEntradaEdForm.CustoNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    MargemNumEditBtu.SetFocus;
    // OkAct_Diag.Execute;
  end;
end;

procedure TEntradaEdForm.CustoUnitNumEditBtuChange(Sender: TObject);
begin
  inherited;
  CalculePreco;
end;

procedure TEntradaEdForm.CustoUnitNumEditBtuMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Preencher;
end;

procedure TEntradaEdForm.EntToControles;
var
  s: string;
  oItem: IRetagEntradaItem;
  u: Currency;
begin
  inherited;
  s := '';
  if FEntradaEnt.EntradaId > 0 then
  begin
    s := FEntradaEnt.GetCod;
  end;

  CodLabeledEdit.Text := s;

  FornecedorSelectFrame.Id := FEntradaEnt.FornecedorId;
  NDocNumEditBtu.Valor := FEntradaEnt.NDoc;
  SerieNumEditBtu.Valor := FEntradaEnt.Serie;

  if not ItemGroupBox.Visible then
    exit;

  if not FEntradaEnt.EditandoItem then
  begin
    NItemNumEditBtu.Valor := 1;
    exit;
  end;

  if EntEd.State = dsEdit then
  begin
    oItem := FEntradaEnt.GetItems[FEntradaEnt.ItemIndex];
    NItemNumEditBtu.Valor := oItem.NItem;
    ProdIdDelesLabeledEdit.Text := oItem.ProdIdDeles;
    ProdSelectFrame.PegarProdId(oItem.Prod.Id);

    QtdNumEditBtu.Valor := oItem.Qtd;
    Bcdtocurr(ProdSelectFrame.Preco, u);
    PrecoAtualNumEditBtu.Valor := u;

    Bcdtocurr(ProdSelectFrame.Custo, u);
    CustoUltimoNumEditBtu.Valor := u;

    Bcdtocurr(oItem.Custo, u);
    CustoNumEditBtu.Valor := u;

    MargemNumEditBtu.Valor := oItem.Margem;

    Bcdtocurr(oItem.Preco, u);
    PrecoNovoNumEditBtu.Valor := u;

    exit;
  end;

  NItemNumEditBtu.Valor := FEntradaEnt.GetNextNItem;
  // FEntradaEnt.Custo := CustoNumEditBtu.Valor;

  // CalculeCustoUnit;

  // if FEstSaidaEnt.ItemIndex > -1 then
  // begin
  // FEstSaidaEnt.Items[FEstSaidaEnt.ItemIndex];
  // end;
end;

procedure TEntradaEdForm.FornecedorComboBox1Change(Sender: TObject);
begin
  MensLimpar;
end;

procedure TEntradaEdForm.FornecedorComboBox1Exit(Sender: TObject);
begin
  FornecedorOk;
end;

procedure TEntradaEdForm.FornecedorComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    if FornecedorSelectFrame.Id < 1 then
      FornecedorSelectFrame.ComboBox1.DroppedDown := True
    else
      NDocNumEditBtu.SetFocus;

    // ProdSelectFrame.ProdLabeledEdit.SetFocus;
  end;
end;

procedure TEntradaEdForm.FornecedorComboBoxChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
end;

function TEntradaEdForm.FornecedorOk: Boolean;
var
  i: integer;
begin
  Result := ActiveControl = CancelBitBtn_DiagBtn;
  if Result then
    exit;

  i := FornecedorSelectFrame.Id;
  Result := i > 0;
  if not Result then
  begin
    FornecedorSelectFrame.ComboBox1.SetFocus;
    errooutput.exibir('Fornecedor é obrigatório');
    FornecedorSelectFrame.ExibaMens('Fornecedor é obrigatório');
    exit;
  end;
end;

function TEntradaEdForm.GravouOk: boolean;
begin
  Result := inherited GravouOk;
  if not Result then
    exit;

  if (EntEd.State = dsEdit) and (FEntradaEnt.EditandoItem) then
  begin
    FEntradaDBI.UpdateItem;
  end;
end;

procedure TEntradaEdForm.MargemNumEditBtuChange(Sender: TObject);
begin
  inherited;
  CalculePreco;
end;

procedure TEntradaEdForm.MargemNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    PrecoNovoNumEditBtu.SetFocus;
  end;
end;

procedure TEntradaEdForm.MensLimpar;
begin
  inherited;

  if FCriando then
    exit;

  FornecedorSelectFrame.EscondaMens;
end;

procedure TEntradaEdForm.NDocNumEditBtuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    SerieNumEditBtu.SetFocus;
  end;
end;

procedure TEntradaEdForm.PrecoNovoNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    OkAct_Diag.Execute;
  end;
end;

procedure TEntradaEdForm.Preencher;
begin
  exit;
  FornecedorSelectFrame.Id := 3;
  CustoNumEditBtu.Valor := 2;
  ProdIdDelesLabeledEdit.Text := '1A';
  MargemNumEditBtu.Valor := 2;
  PrecoNovoNumEditBtu.Valor := 7;
  SerieNumEditBtu.Valor := 1;
  NDocNumEditBtu.Valor := 10;
end;

procedure TEntradaEdForm.ProdIdDelesLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    // consulta
    ProdIdDelesLabeledEdit.Text := Trim(ProdIdDelesLabeledEdit.Text);
    if ProdIdDelesLabeledEdit.Text = '' then
    begin
      if ProdSelectFrame.ProdId < 1 then
        ProdSelectFrame.Selecionar('')
      else
        QtdNumEditBtu.SetFocus;
    end
    else
    begin
      ProdSelectFrame.ProdLabeledEdit.SetFocus;
      // QtdNumEditBtu.SetFocus;
    end;
    exit;
  end;
  EditKeyPress(Sender, Key);
end;

procedure TEntradaEdForm.ProdSelectSelect(Sender: TObject);
begin
  inherited;
  CustoUltimoNumEditBtu.Valor := ProdSelectFrame.Custo;
  // MargemNumEditBtu.Valor := ProdSelectFrame.Margem;
  PrecoAtualNumEditBtu.Valor := ProdSelectFrame.Preco;
end;

procedure TEntradaEdForm.QtdNumEditBtuChange(Sender: TObject);
begin
  inherited;
  MensLimpar;
  CalculeCustoUnit;
end;

procedure TEntradaEdForm.QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    CustoNumEditBtu.SetFocus;
  end;
end;

procedure TEntradaEdForm.SerieNumEditBtuKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    if ItemGroupBox.Visible then
      ProdIdDelesLabeledEdit.SetFocus
    else
      OkAct_Diag.Execute;
  end;
end;

procedure TEntradaEdForm.ShowTimer_BasFormTimer(Sender: TObject);
begin
  inherited;
  Preencher;
end;

end.
