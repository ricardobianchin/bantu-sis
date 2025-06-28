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
  private
    { Private declarations }
    FProdSelectFrame: TProdSelectFrame;
    FEstPromoEnt: IEstPromoEnt;
    FEstPromoDBI: IEstPromoDBI;
    FDummyFormClassNamesSL: TStringList;
    FMudoOutput: IOutput;
    FMudoProcessLog: IProcessLog;
    FIniciaEm: TDateTimeFrame;
    FTerminaEm: TDateTimeFrame;
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
  Sis.UI.IO.Output.ProcessLog.Factory, App.Retag.Est.Factory;

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

function TPromoEdForm.ControlesOk: boolean;
var
  sNome: string;
begin
  Result := FEstPromoEnt.State = dsEdit;
  if Result then
    Exit;

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


  Result := ProdSelectFrame.ProdId > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Produto é obrigatório');
    ProdSelectFrame.ProdLabeledEdit.SetFocus;
    Exit;
  end;

  Result := PrecoPromoNumEditBtu.Valor > 0;
  if not Result then
  begin
    ErroOutput.Exibir('O Preço Promocional é obrigatório');
    PrecoPromoNumEditBtu.SetFocus;
    Exit;
  end;
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

  FIniciaEm := TDateTimeFrame.Create(MasterGroupBox);
  FIniciaEm.Name := 'FIniciaEmDateTimeFrame';
  FIniciaEm.Left := 2;
  FIniciaEm.Top := CodLabeledEdit.Top + CodLabeledEdit.Height + 14;

  FTerminaEm := TDateTimeFrame.Create(MasterGroupBox);
  FTerminaEm.Name := 'FTerminaEmDateTimeFrame';
  FTerminaEm.Left := FIniciaEm.Left + FIniciaEm.Width + 6;
  FTerminaEm.Top := FIniciaEm.Top;

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

end.
