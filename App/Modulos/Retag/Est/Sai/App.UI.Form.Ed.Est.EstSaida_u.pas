unit App.UI.Form.Ed.Est.EstSaida_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  App.UI.Form.Ed.Est_u, System.Actions, Vcl.ActnList, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, App.Ent.Ed, App.Ent.DBI, App.AppObj,
  App.Retag.Est.EstSaida.Ent, App.Retag.Est.EstSaida.DBI,
  Sis.UI.Controls.ComboBoxManager, Sis.DB.DBTypes, CustomEditBtu,
  CustomNumEditBtu, NumEditBtu, Sis.Entities.Types, Sis.Types;

type
  TEstSaidaEdForm = class(TEstEdBasForm)
    SaidaMotivoComboBox: TComboBox;
    SaidaMotivoLabel: TLabel;
    procedure SaidaMotivoComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure QtdNumEditBtuKeyPress(Sender: TObject; var Key: Char);
    procedure SaidaMotivoComboBoxChange(Sender: TObject);
    procedure QtdNumEditBtuChange(Sender: TObject);
  private
    { Private declarations }
    FEstSaidaEnt: IEstSaidaEnt;
    FEstSaidaDBI: IEstSaidaDBI;
    FSaidaMotivoMan: IComboBoxManager;
    FSaidaMotivoUltimo: TId;
  protected
    procedure AjusteControles; override;
    procedure AjusteTabOrder; override;

    procedure ControlesToEnt; override;
    procedure EntToControles; override;

    function ControlesOk: boolean; override;
    function DadosOk: boolean; override;
    function GravouOk: boolean; override;
    procedure ProdSelectProdLabeledEditKeyPress(Sender: TObject;
      var Key: Char); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; pAppObj: IAppObj; pEntEd: IEntEd;
      pEntDBI: IEntDBI; pDBConnection: IDBConnection); override;
  end;

var
  EstSaidaEdForm: TEstSaidaEdForm;

implementation

{$R *.dfm}

uses App.Retag.Est.Factory, Sis.UI.Controls.Factory, Sis.DB.DataSet.Utils,
  Sis.Types.Floats, App.Retag.Est.EstSaidaItem, Data.DB, Sis.Sis.Constants,
  Sis.Types.strings_u;

{ TEstSaidaEdForm }

procedure TEstSaidaEdForm.AjusteControles;
var
  sFormat: string;
  sCaption: string;
  sNom, sDes: string;
begin
  inherited;
  case EntEd.State of
    dsInactive:
      ;
    dsBrowse:
      ;
    dsEdit:
      begin
        sNom := FEstSaidaEnt.NomeEnt;
        sDes := FEstSaidaEnt.GetCod;

        sFormat := 'Alterando %s: %s';
        sCaption := Format(sFormat, [sNom, sDes]);
        ItemGroupBox.Visible := False;
        Self.Height := Self.Height - ItemGroupBox.Height;
      end;

    dsInsert:
      ;
  end;
  SaidaMotivoComboBox.SetFocus;
end;

procedure TEstSaidaEdForm.AjusteTabOrder;
begin
  CodLabeledEdit.TabOrder := 0;
  SaidaMotivoComboBox.TabOrder := 1;
  ProdSelectFrame.TabOrder := 2;
  QtdNumEditBtu.TabOrder := 3;
  // inherited;
end;

function TEstSaidaEdForm.ControlesOk: boolean;
begin
  // Result := FSaidaMotivoMan.Id > 0;
  // if not Result then
  // begin
  // ErroOutput.Exibir('O Motivo da Saída é obrigatório');
  // SaidaMotivoComboBox.SetFocus;
  // exit;
  // end;

  Result := FEstSaidaEnt.State = dsEdit;

  if Result then
    exit;

  Result := ProdSelectFrame.ProdId > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Produto é obrigatório');
    ProdSelectFrame.ProdLabeledEdit.SetFocus;
    exit;
  end;

  Result := QtdNumEditBtu.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir('A Quantidade é obrigatória');
    QtdNumEditBtu.SetFocus;
    exit;
  end;

  Result := ProdSelectFrame.ProdBalancaExige;
  if Result then
    exit;

  Result := CurrencyEhInteiro(QtdNumEditBtu.Valor);
  if not Result then
  begin
    ErroOutput.Exibir
      ('Produto não é de balança. A quantidade deve ser inteira');
    QtdNumEditBtu.SetFocus;
    exit;
  end;
end;

procedure TEstSaidaEdForm.ControlesToEnt;
var
  oItem: IRetagEstSaidaItem;
  iOrdem: SmallInt;
  i: integer;
begin
  inherited;
  if EntEd.State = dsInsert then
  begin
    iOrdem := FEstSaidaEnt.Items.Count;
    i := iOrdem - 1;

    oItem := RetagEstSaidaItemCreate(iOrdem, ProdSelectFrame.ProdId,
      ProdSelectFrame.ProdDescrRed, ProdSelectFrame.ProdFabrNome, '' { unid } ,
      QtdNumEditBtu.Valor, DATA_ZERADA { criadoem } );

    FEstSaidaEnt.Items.Add(oItem);
  end;

  FEstSaidaEnt.SaidaMotivoId := FSaidaMotivoMan.Id;
  FEstSaidaEnt.SaidaMotivoDescr := StrAntes(FSaidaMotivoMan.Text, ' -');
end;

constructor TEstSaidaEdForm.Create(AOwner: TComponent; pAppObj: IAppObj;
  pEntEd: IEntEd; pEntDBI: IEntDBI; pDBConnection: IDBConnection);
begin
  inherited;
  FEstSaidaEnt := pEntEd as IEstSaidaEnt; //EntEdCastToEstSaidaEnt(pEntEd);
  FEstSaidaDBI := EntDBICastToEstSaidaDBI(pEntDBI);
  FSaidaMotivoMan := ComboBoxManagerCreate(SaidaMotivoComboBox);
  FEstSaidaDBI.SaidaMotivoPrepareLista(SaidaMotivoComboBox.Items);
  FSaidaMotivoUltimo := FEstSaidaEnt.SaidaMotivoId;
  // if FEstSaidaEnt.EditandoItem then
  // begin
  //
  // end;
    end;

  function TEstSaidaEdForm.DadosOk: boolean;
  begin
    Result := True;
  end;

  procedure TEstSaidaEdForm.EntToControles;
  var
    s: string;
  begin
    s := '';
    if FEstSaidaEnt.EstSaidaId > 0 then
    begin
      s := FEstSaidaEnt.GetCod;
    end;

    CodLabeledEdit.Text := s;
    if FEstSaidaEnt.SaidaMotivoId > 0 then
      FSaidaMotivoMan.Id := FEstSaidaEnt.SaidaMotivoId
    else
      SaidaMotivoComboBox.ItemIndex := 0;

    // if FEstSaidaEnt.ItemIndex > -1 then
    // begin
    // FEstSaidaEnt.Items[FEstSaidaEnt.ItemIndex];
    // end;
  end;

  function TEstSaidaEdForm.GravouOk: boolean;
  begin
    Result := FEstSaidaDBI.Gravar;
  end;

  procedure TEstSaidaEdForm.ProdSelectProdLabeledEditKeyPress(Sender: TObject;
    var Key: Char);
  begin
    // inherited;
    if Key = #13 then
    begin
      Key := #0;
      ProdSelectFrame.Selecionar;
      QtdNumEditBtu.SetFocus
    end;
  end;

  procedure TEstSaidaEdForm.QtdNumEditBtuChange(Sender: TObject);
  begin
    inherited;
    MensLimpar;
  end;

  procedure TEstSaidaEdForm.QtdNumEditBtuKeyPress(Sender: TObject;
    var Key: Char);
  begin
    inherited;
    if Key = #13 then
    begin
      Key := #0;
      OkAct_Diag.Execute;
    end;
  end;

  procedure TEstSaidaEdForm.SaidaMotivoComboBoxChange(Sender: TObject);
  begin
    inherited;
    MensLimpar;
  end;

  procedure TEstSaidaEdForm.SaidaMotivoComboBoxKeyPress(Sender: TObject;
    var Key: Char);
  begin
    inherited;
    if Key = #13 then
    begin
      Key := #0;
      if EntEd.State = dsInsert then
      begin
        ProdSelectFrame.ProdLabeledEdit.SetFocus;
      end
      else
      begin
        OkAct_Diag.Execute;
      end;
    end;
  end;

  end.
