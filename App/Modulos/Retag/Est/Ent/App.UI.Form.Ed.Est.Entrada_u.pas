unit App.UI.Form.Ed.Est.Entrada_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.Est_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.Entrada.Ent, App.Retag.Est.Entrada.DBI,
  Sis.UI.Controls.ComboBoxManager, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Sis.Entities.Types, Sis.Types;

type
  TEntradaEdForm = class(TEstEdBasForm)
    FornecedorLabel: TLabel;
    FornecedorComboBox: TComboBox;
    CustoNumEditBtu: TNumEditBtu;
    CustoUnitNumEditBtu: TNumEditBtu;
    procedure CustoNumEditBtuChange(Sender: TObject);
    procedure FornecedorComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure QtdNumEditBtuChange(Sender: TObject);
    procedure FornecedorComboBoxChange(Sender: TObject);
    procedure CustoNumEditBtuKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FEntradaEnt: IEntradaEnt;
    FEntradaDBI: IEntradaDBI;
    FFornecedorMan: IComboBoxManager;
    FFornecedorIdUltimo: TId;
    procedure CalculeCustoUnit;
  protected
    procedure AjusteControles; override;
    procedure AjusteTabOrder; override;

    procedure EntToControles; override;
    procedure ControlesToEnt; override;

    function ControlesOk: Boolean; override;
    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject;
      var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection); override;
  end;

var
  EntradaEdForm: TEntradaEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.Controls.Factory, Sis.DB.DataSet.Utils,
  Sis.Types.Floats, App.Retag.Est.EntradaItem, Data.DB, Sis.Sis.Constants,
  Sis.Types.strings_u, Sis.UI.Controls.Utils, App.Types,
  App.Retag.Est.ProdSelectFrame_u;

procedure TEntradaEdForm.AjusteControles;
begin
  inherited;
  FornecedorComboBox.setFocus;
  ReadOnlySet(CustoUnitNumEditBtu);
end;

procedure TEntradaEdForm.AjusteTabOrder;
begin
  inherited;
  CodLabeledEdit.TabOrder := 0;
  FornecedorComboBox.TabOrder := 1;
  ProdSelectFrame.TabOrder := 2;
  QtdNumEditBtu.TabOrder := 3;
  CustoNumEditBtu.TabOrder := 4;
end;

procedure TEntradaEdForm.CalculeCustoUnit;
begin
  CustoUnitNumEditBtu.Valor := CustoToCustoUnit(CustoNumEditBtu.Valor,
    QtdNumEditBtu.Valor);
end;

function TEntradaEdForm.ControlesOk: Boolean;
begin
  Result := inherited;
  if not Result then
    exit;

  Result := CustoNumEditBtu.Valor > 0;
  if not Result then
  begin
    CustoNumEditBtu.setFocus;
    errooutput.exibir('Custo é obrigatório');
  end;
end;

procedure TEntradaEdForm.ControlesToEnt;
var
  oItem: IRetagEntradaItem;
  iOrdem: SmallInt;
  i: integer;
begin
  inherited;
  if EntEd.State = dsInsert then
  begin
    iOrdem := FEntradaEnt.Items.Count;
    i := iOrdem - 1;

    oItem := RetagEntradaItemCreate(iOrdem, ProdSelectFrame.ProdId,
      ProdSelectFrame.ProdDescrRed, ProdSelectFrame.ProdFabrNome, '' { unid } ,
      QtdNumEditBtu.Valor, CustoNumEditBtu.Valor, DATA_ZERADA { criadoem } );

    FEntradaEnt.Items.Add(oItem);
  end;

  FEntradaEnt.FornecedorId := FFornecedorMan.Id;
  FEntradaEnt.FornecedorApelido := StrAntes(FFornecedorMan.Text, ' -');
end;

constructor TEntradaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection);
begin
  inherited;
  FEntradaEnt := EntEdCastToEntradaEnt(pEntEd);
  // FEstSaidaEnt := pEntEd as IEstSaidaEnt;
  FEntradaDBI := EntDBICastToEntradaDBI(pEntDBI);
  FFornecedorMan := ComboBoxManagerCreate(FornecedorComboBox);
  FEntradaDBI.FornecedorPrepareLista(FornecedorComboBox.Items);
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
    OkAct_Diag.Execute;
  end;
end;

procedure TEntradaEdForm.EntToControles;
var
  s: string;
begin
  inherited;
  s := '';
  if FEntradaEnt.EntradaId > 0 then
  begin
    s := FEntradaEnt.GetCod;
  end;

  CodLabeledEdit.Text := s;
  if FEntradaEnt.FornecedorId > 0 then
    FFornecedorMan.Id := FEntradaEnt.FornecedorId
  else
    FornecedorComboBox.ItemIndex := 0;

  // FEntradaEnt.Custo := CustoNumEditBtu.Valor;

  // CalculeCustoUnit;

  // if FEstSaidaEnt.ItemIndex > -1 then
  // begin
  // FEstSaidaEnt.Items[FEstSaidaEnt.ItemIndex];
  // end;
end;

procedure TEntradaEdForm.FornecedorComboBoxChange(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TEntradaEdForm.FornecedorComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    ProdSelectFrame.ProdLabeledEdit.setFocus;
  end;
end;

procedure TEntradaEdForm.ProdSelectProdLabeledEditKeyPress(Sender: TObject;
  var Key: Char);
begin
  // inherited;
  if Key >= #32 then
  begin
    Key := #0;
    ProdSelectFrame.Selecionar;
    // QtdNumEditBtu.setFocus
  end;

end;

procedure TEntradaEdForm.QtdNumEditBtuChange(Sender: TObject);
begin
  inherited;
  MensLimpar;

end;

procedure TEntradaEdForm.QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Key := #0;
    CustoNumEditBtu.setFocus;
  end;
end;

end.
